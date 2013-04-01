From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 02 Apr 2013 10:36:43 +1100
Subject: [PATCH 2/6] rtc: rtc-m48t86: add hooks to support driver side
 memory mapping
In-Reply-To: <1364858565-17192-3-git-send-email-alex@digriz.org.uk>
References: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
 <1364858565-17192-3-git-send-email-alex@digriz.org.uk>
Message-ID: <515A1A0B.8040803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/13 10:22, Alexander Clouter wrote:
> If platform_data is not defined (as before), then named memory io
> ranges need to be defined ("rtc_index" and "rtc_data").  The driver
> then maps those regions and uses them as the RTC index and data
> addresses.
> 
> Does compile with the following warnings, I cannot see the codepath
> affected myself:
> ----
> drivers/rtc/rtc-m48t86.c: In function ?m48t86_rtc_probe?:
> drivers/rtc/rtc-m48t86.c:180: warning: ?res_index? may be used uninitialized in this function
> drivers/rtc/rtc-m48t86.c:180: warning: ?res_data? may be used uninitialized in this function

It is caused by the exit paths. If pdev->dev.platform_data is set, the
res_index and res_data are never initialised, but in the error case you
still for rtc_device_register you jump to out_io_data, which will then
dereference res_index/res_data. You need to make the exit paths
conditional on pdev->dev.platform_data (or init res_index/data to NULL
and make the release_mem_regions conditional on that).

~Ryan

> ----
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  drivers/rtc/rtc-m48t86.c |  230 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 173 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
> index 25e0116..6f99e64 100644
> --- a/drivers/rtc/rtc-m48t86.c
> +++ b/drivers/rtc/rtc-m48t86.c
> @@ -18,6 +18,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/rtc-m48t86.h>
>  #include <linux/bcd.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
>  
>  #define M48T86_REG_SEC		0x00
>  #define M48T86_REG_SECALRM	0x01
> @@ -41,40 +43,71 @@
>  
>  #define DRV_VERSION "0.1"
>  
> +struct m48t86_rtc_private_data {
> +	void __iomem		*io_index;
> +	void __iomem		*io_data;
> +
> +	struct rtc_device	*rtc;
> +	struct m48t86_ops	*ops;
> +};
> +
> +static void m48t86_rtc_writebyte(struct device *dev,
> +			unsigned char value, unsigned long addr)
> +{
> +	struct m48t86_rtc_private_data *priv = dev_get_drvdata(dev);
> +
> +	if (priv->ops) {
> +		priv->ops->writebyte(value, addr);
> +		return;
> +	}
> +
> +	writeb(addr, priv->io_index);
> +	writeb(value, priv->io_data);
> +}
> +
> +static unsigned char m48t86_rtc_readbyte(struct device *dev,
> +			unsigned long addr)
> +{
> +	struct m48t86_rtc_private_data *priv = dev_get_drvdata(dev);
> +
> +	if (priv->ops)
> +		return priv->ops->readbyte(addr);
> +
> +	writeb(addr, priv->io_index);
> +	return readb(priv->io_data);
> +}
>  
>  static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	unsigned char reg;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct m48t86_ops *ops = pdev->dev.platform_data;
>  
> -	reg = ops->readbyte(M48T86_REG_B);
> +	reg = m48t86_rtc_readbyte(dev, M48T86_REG_B);
>  
>  	if (reg & M48T86_REG_B_DM) {
>  		/* data (binary) mode */
> -		tm->tm_sec	= ops->readbyte(M48T86_REG_SEC);
> -		tm->tm_min	= ops->readbyte(M48T86_REG_MIN);
> -		tm->tm_hour	= ops->readbyte(M48T86_REG_HOUR) & 0x3F;
> -		tm->tm_mday	= ops->readbyte(M48T86_REG_DOM);
> +		tm->tm_sec	= m48t86_rtc_readbyte(dev, M48T86_REG_SEC);
> +		tm->tm_min	= m48t86_rtc_readbyte(dev, M48T86_REG_MIN);
> +		tm->tm_hour	= m48t86_rtc_readbyte(dev, M48T86_REG_HOUR) & 0x3F;
> +		tm->tm_mday	= m48t86_rtc_readbyte(dev, M48T86_REG_DOM);
>  		/* tm_mon is 0-11 */
> -		tm->tm_mon	= ops->readbyte(M48T86_REG_MONTH) - 1;
> -		tm->tm_year	= ops->readbyte(M48T86_REG_YEAR) + 100;
> -		tm->tm_wday	= ops->readbyte(M48T86_REG_DOW);
> +		tm->tm_mon	= m48t86_rtc_readbyte(dev, M48T86_REG_MONTH) - 1;
> +		tm->tm_year	= m48t86_rtc_readbyte(dev, M48T86_REG_YEAR) + 100;
> +		tm->tm_wday	= m48t86_rtc_readbyte(dev, M48T86_REG_DOW);
>  	} else {
>  		/* bcd mode */
> -		tm->tm_sec	= bcd2bin(ops->readbyte(M48T86_REG_SEC));
> -		tm->tm_min	= bcd2bin(ops->readbyte(M48T86_REG_MIN));
> -		tm->tm_hour	= bcd2bin(ops->readbyte(M48T86_REG_HOUR) & 0x3F);
> -		tm->tm_mday	= bcd2bin(ops->readbyte(M48T86_REG_DOM));
> +		tm->tm_sec	= bcd2bin(m48t86_rtc_readbyte(dev, M48T86_REG_SEC));
> +		tm->tm_min	= bcd2bin(m48t86_rtc_readbyte(dev, M48T86_REG_MIN));
> +		tm->tm_hour	= bcd2bin(m48t86_rtc_readbyte(dev, M48T86_REG_HOUR) & 0x3F);
> +		tm->tm_mday	= bcd2bin(m48t86_rtc_readbyte(dev, M48T86_REG_DOM));
>  		/* tm_mon is 0-11 */
> -		tm->tm_mon	= bcd2bin(ops->readbyte(M48T86_REG_MONTH)) - 1;
> -		tm->tm_year	= bcd2bin(ops->readbyte(M48T86_REG_YEAR)) + 100;
> -		tm->tm_wday	= bcd2bin(ops->readbyte(M48T86_REG_DOW));
> +		tm->tm_mon	= bcd2bin(m48t86_rtc_readbyte(dev, M48T86_REG_MONTH)) - 1;
> +		tm->tm_year	= bcd2bin(m48t86_rtc_readbyte(dev, M48T86_REG_YEAR)) + 100;
> +		tm->tm_wday	= bcd2bin(m48t86_rtc_readbyte(dev, M48T86_REG_DOW));
>  	}
>  
>  	/* correct the hour if the clock is in 12h mode */
>  	if (!(reg & M48T86_REG_B_H24))
> -		if (ops->readbyte(M48T86_REG_HOUR) & 0x80)
> +		if (m48t86_rtc_readbyte(dev, M48T86_REG_HOUR) & 0x80)
>  			tm->tm_hour += 12;
>  
>  	return rtc_valid_tm(tm);
> @@ -83,38 +116,36 @@ static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int m48t86_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	unsigned char reg;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct m48t86_ops *ops = pdev->dev.platform_data;
>  
> -	reg = ops->readbyte(M48T86_REG_B);
> +	reg = m48t86_rtc_readbyte(dev, M48T86_REG_B);
>  
>  	/* update flag and 24h mode */
>  	reg |= M48T86_REG_B_SET | M48T86_REG_B_H24;
> -	ops->writebyte(reg, M48T86_REG_B);
> +	m48t86_rtc_writebyte(dev, reg, M48T86_REG_B);
>  
>  	if (reg & M48T86_REG_B_DM) {
>  		/* data (binary) mode */
> -		ops->writebyte(tm->tm_sec, M48T86_REG_SEC);
> -		ops->writebyte(tm->tm_min, M48T86_REG_MIN);
> -		ops->writebyte(tm->tm_hour, M48T86_REG_HOUR);
> -		ops->writebyte(tm->tm_mday, M48T86_REG_DOM);
> -		ops->writebyte(tm->tm_mon + 1, M48T86_REG_MONTH);
> -		ops->writebyte(tm->tm_year % 100, M48T86_REG_YEAR);
> -		ops->writebyte(tm->tm_wday, M48T86_REG_DOW);
> +		m48t86_rtc_writebyte(dev, tm->tm_sec, M48T86_REG_SEC);
> +		m48t86_rtc_writebyte(dev, tm->tm_min, M48T86_REG_MIN);
> +		m48t86_rtc_writebyte(dev, tm->tm_hour, M48T86_REG_HOUR);
> +		m48t86_rtc_writebyte(dev, tm->tm_mday, M48T86_REG_DOM);
> +		m48t86_rtc_writebyte(dev, tm->tm_mon + 1, M48T86_REG_MONTH);
> +		m48t86_rtc_writebyte(dev, tm->tm_year % 100, M48T86_REG_YEAR);
> +		m48t86_rtc_writebyte(dev, tm->tm_wday, M48T86_REG_DOW);
>  	} else {
>  		/* bcd mode */
> -		ops->writebyte(bin2bcd(tm->tm_sec), M48T86_REG_SEC);
> -		ops->writebyte(bin2bcd(tm->tm_min), M48T86_REG_MIN);
> -		ops->writebyte(bin2bcd(tm->tm_hour), M48T86_REG_HOUR);
> -		ops->writebyte(bin2bcd(tm->tm_mday), M48T86_REG_DOM);
> -		ops->writebyte(bin2bcd(tm->tm_mon + 1), M48T86_REG_MONTH);
> -		ops->writebyte(bin2bcd(tm->tm_year % 100), M48T86_REG_YEAR);
> -		ops->writebyte(bin2bcd(tm->tm_wday), M48T86_REG_DOW);
> +		m48t86_rtc_writebyte(dev, bin2bcd(tm->tm_sec), M48T86_REG_SEC);
> +		m48t86_rtc_writebyte(dev, bin2bcd(tm->tm_min), M48T86_REG_MIN);
> +		m48t86_rtc_writebyte(dev, bin2bcd(tm->tm_hour), M48T86_REG_HOUR);
> +		m48t86_rtc_writebyte(dev, bin2bcd(tm->tm_mday), M48T86_REG_DOM);
> +		m48t86_rtc_writebyte(dev, bin2bcd(tm->tm_mon + 1), M48T86_REG_MONTH);
> +		m48t86_rtc_writebyte(dev, bin2bcd(tm->tm_year % 100), M48T86_REG_YEAR);
> +		m48t86_rtc_writebyte(dev, bin2bcd(tm->tm_wday), M48T86_REG_DOW);
>  	}
>  
>  	/* update ended */
>  	reg &= ~M48T86_REG_B_SET;
> -	ops->writebyte(reg, M48T86_REG_B);
> +	m48t86_rtc_writebyte(dev, reg, M48T86_REG_B);
>  
>  	return 0;
>  }
> @@ -122,15 +153,13 @@ static int m48t86_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  static int m48t86_rtc_proc(struct device *dev, struct seq_file *seq)
>  {
>  	unsigned char reg;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct m48t86_ops *ops = pdev->dev.platform_data;
>  
> -	reg = ops->readbyte(M48T86_REG_B);
> +	reg = m48t86_rtc_readbyte(dev, M48T86_REG_B);
>  
>  	seq_printf(seq, "mode\t\t: %s\n",
>  		 (reg & M48T86_REG_B_DM) ? "binary" : "bcd");
>  
> -	reg = ops->readbyte(M48T86_REG_D);
> +	reg = m48t86_rtc_readbyte(dev, M48T86_REG_D);
>  
>  	seq_printf(seq, "battery\t\t: %s\n",
>  		 (reg & M48T86_REG_D_VRT) ? "ok" : "exhausted");
> @@ -144,34 +173,121 @@ static const struct rtc_class_ops m48t86_rtc_ops = {
>  	.proc		= m48t86_rtc_proc,
>  };
>  
> -static int m48t86_rtc_probe(struct platform_device *dev)
> +static int m48t86_rtc_probe(struct platform_device *pdev)
>  {
>  	unsigned char reg;
> -	struct m48t86_ops *ops = dev->dev.platform_data;
> -	struct rtc_device *rtc = rtc_device_register("m48t86",
> -				&dev->dev, &m48t86_rtc_ops, THIS_MODULE);
> -
> -	if (IS_ERR(rtc))
> -		return PTR_ERR(rtc);
> -
> -	platform_set_drvdata(dev, rtc);
> +	int err;
> +	struct resource *res_index, *res_data;
> +	struct m48t86_rtc_private_data *priv;
> +
> +	/* Allocate memory for the device structure (and zero it) */
> +	priv = kzalloc(sizeof(struct m48t86_rtc_private_data), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	if (!pdev->dev.platform_data) {
> +		res_index = platform_get_resource_byname(
> +					pdev, IORESOURCE_MEM, "rtc_index");
> +		if (!res_index) {
> +			err = -ENXIO;
> +			goto out_free;
> +		}
> +
> +		res_data = platform_get_resource_byname(
> +					pdev, IORESOURCE_MEM, "rtc_data");
> +		if (!res_data) {
> +			err = -ENXIO;
> +			goto out_free;
> +		}
> +
> +		if (!request_mem_region(res_index->start,
> +					resource_size(res_index),
> +					dev_name(&pdev->dev))) {
> +			err = -EBUSY;
> +			goto out_free;
> +		}
> +
> +		if (!request_mem_region(res_data->start,
> +					resource_size(res_data),
> +					dev_name(&pdev->dev))) {
> +			err = -EBUSY;
> +			goto out_release_index;
> +		}
> +
> +		priv->io_index = ioremap(res_index->start,
> +					resource_size(res_index));
> +		if (!priv->io_index) {
> +			err = -EIO;
> +			goto out_release_data;
> +		}
> +
> +		priv->io_data = ioremap(res_data->start,
> +					resource_size(res_data));
> +		if (!priv->io_data) {
> +			err = -EIO;
> +			goto out_io_index;
> +		}
> +	} else
> +		priv->ops = pdev->dev.platform_data;
> +
> +	priv->rtc = rtc_device_register("m48t86",
> +				&pdev->dev, &m48t86_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(priv->rtc)) {
> +		err = PTR_ERR(priv->rtc);
> +		if (!pdev->dev.platform_data)
> +			goto out_io_data;
> +		else
> +			goto out_free;
> +	}
>  
>  	/* read battery status */
> -	reg = ops->readbyte(M48T86_REG_D);
> -	dev_info(&dev->dev, "battery %s\n",
> +	reg = m48t86_rtc_readbyte(&pdev->dev, M48T86_REG_D);
> +	dev_info(&pdev->dev, "battery %s\n",
>  		(reg & M48T86_REG_D_VRT) ? "ok" : "exhausted");
>  
>  	return 0;
> +
> +out_io_data:
> +	iounmap(priv->io_data);
> +out_io_index:
> +	iounmap(priv->io_index);
> +out_release_data:
> +	release_mem_region(res_data->start, resource_size(res_data));
> +out_release_index:
> +	release_mem_region(res_index->start, resource_size(res_index));
> +out_free:
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(priv);
> +	return err;
>  }
>  
> -static int m48t86_rtc_remove(struct platform_device *dev)
> +static int m48t86_rtc_remove(struct platform_device *pdev)
>  {
> -	struct rtc_device *rtc = platform_get_drvdata(dev);
> +	struct resource *res;
> +	struct m48t86_rtc_private_data *priv = platform_get_drvdata(pdev);
> +
> +	if (priv->rtc)
> +		rtc_device_unregister(priv->rtc);
> +
> +	if (priv->io_data) {
> +		iounmap(priv->io_data);
> +		res = platform_get_resource_byname(
> +					pdev, IORESOURCE_MEM, "rtc_data");
> +		release_mem_region(res->start, resource_size(res));
> +	}
> +
> +	if (priv->io_index) {
> +		iounmap(priv->io_index);
> +		res = platform_get_resource_byname(
> +					pdev, IORESOURCE_MEM, "rtc_index");
> +		release_mem_region(res->start, resource_size(res));
> +	}
>  
> - 	if (rtc)
> -		rtc_device_unregister(rtc);
> +	platform_set_drvdata(pdev, NULL);
>  
> -	platform_set_drvdata(dev, NULL);
> +	kfree(priv);
>  
>  	return 0;
>  }
> 
