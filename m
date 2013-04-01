From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 02 Apr 2013 09:06:47 +1100
Subject: [PATCH 1/3] rtc: rtc-m48t86: add devicetree bindings
In-Reply-To: <1364766971-5914-2-git-send-email-alex@digriz.org.uk>
References: <1364766971-5914-1-git-send-email-alex@digriz.org.uk>
 <1364766971-5914-2-git-send-email-alex@digriz.org.uk>
Message-ID: <515A04F7.8000904@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/13 08:56, Alexander Clouter wrote:
> This patch allows rtc-m48t86 to be used via devicetree.
> 
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  .../devicetree/bindings/rtc/rtc-m48t86.txt         |   17 ++
>  drivers/rtc/rtc-m48t86.c                           |  254 +++++++++++++++-----
>  include/linux/m48t86.h                             |   16 --
>  3 files changed, 213 insertions(+), 74 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-m48t86.txt
>  delete mode 100644 include/linux/m48t86.h

Some comments below.

> diff --git a/Documentation/devicetree/bindings/rtc/rtc-m48t86.txt b/Documentation/devicetree/bindings/rtc/rtc-m48t86.txt
> new file mode 100644
> index 0000000..1336c98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-m48t86.txt
> @@ -0,0 +1,17 @@
> +ST M48T86 / Dallas DS12887 RTC driver
> +
> +Required properties:
> +- compatible: "rtc-m48t86"
> +- reg: array of two address ranges of the RTC index and data registers
> +- reg-names: must have "rtc_index" and "rtc_data" present
> +
> +Example:
> +
> +rtc at 808 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "rtc-m48t86";
> +	reg =   <0x808 0x04>,
> +		<0x80c 0x04>;
> +	reg-names = "rtc_index", "rtc_data";
> +};
> diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
> index 2ffbcac..47e9fd1 100644
> --- a/drivers/rtc/rtc-m48t86.c
> +++ b/drivers/rtc/rtc-m48t86.c
> @@ -16,8 +16,10 @@
>  #include <linux/module.h>
>  #include <linux/rtc.h>
>  #include <linux/platform_device.h>
> -#include <linux/m48t86.h>
>  #include <linux/bcd.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
>  
>  #define M48T86_REG_SEC		0x00
>  #define M48T86_REG_SECALRM	0x01
> @@ -41,40 +43,61 @@
>  
>  #define DRV_VERSION "0.1"
>  
> +struct m48t86_rtc_private_data {
> +	void __iomem		*io_index;
> +	void __iomem		*io_data;
> +
> +	struct rtc_device	*rtc;
> +};
> +
> +static unsigned char m48t86_rtc_readbyte(
> +			struct m48t86_rtc_private_data *priv,
> +			unsigned long addr)

Line breaks like this are a bit ugly. Breaking after the return type
would be better. You can shorten this by changing 'unsigned char' to
'u8', and 'm48t86_rtc_private_data' to something like 'm48t86_priv'. Why
is addr unsigned long if you are passing it to writeb?

> +{
> +	writeb(addr, priv->io_index);
> +	return readb(priv->io_data);
> +}
> +
> +static void m48t86_rtc_writebyte(
> +			struct m48t86_rtc_private_data *priv,
> +			unsigned char value, unsigned long addr)
> +{
> +	writeb(addr, priv->io_index);
> +	writeb(value, priv->io_data);
> +}
>  
>  static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  {
>  	unsigned char reg;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct m48t86_ops *ops = pdev->dev.platform_data;
> +	struct m48t86_rtc_private_data *priv = dev_get_drvdata(dev);
>  
> -	reg = ops->readbyte(M48T86_REG_B);
> +	reg = m48t86_rtc_readbyte(priv, M48T86_REG_B);
>  
>  	if (reg & M48T86_REG_B_DM) {
>  		/* data (binary) mode */
> -		tm->tm_sec	= ops->readbyte(M48T86_REG_SEC);
> -		tm->tm_min	= ops->readbyte(M48T86_REG_MIN);
> -		tm->tm_hour	= ops->readbyte(M48T86_REG_HOUR) & 0x3F;
> -		tm->tm_mday	= ops->readbyte(M48T86_REG_DOM);
> +		tm->tm_sec	= m48t86_rtc_readbyte(priv, M48T86_REG_SEC);
> +		tm->tm_min	= m48t86_rtc_readbyte(priv, M48T86_REG_MIN);
> +		tm->tm_hour	= m48t86_rtc_readbyte(priv, M48T86_REG_HOUR) & 0x3F;
> +		tm->tm_mday	= m48t86_rtc_readbyte(priv, M48T86_REG_DOM);
>  		/* tm_mon is 0-11 */
> -		tm->tm_mon	= ops->readbyte(M48T86_REG_MONTH) - 1;
> -		tm->tm_year	= ops->readbyte(M48T86_REG_YEAR) + 100;
> -		tm->tm_wday	= ops->readbyte(M48T86_REG_DOW);
> +		tm->tm_mon	= m48t86_rtc_readbyte(priv, M48T86_REG_MONTH) - 1;
> +		tm->tm_year	= m48t86_rtc_readbyte(priv, M48T86_REG_YEAR) + 100;
> +		tm->tm_wday	= m48t86_rtc_readbyte(priv, M48T86_REG_DOW);
>  	} else {
>  		/* bcd mode */
> -		tm->tm_sec	= bcd2bin(ops->readbyte(M48T86_REG_SEC));
> -		tm->tm_min	= bcd2bin(ops->readbyte(M48T86_REG_MIN));
> -		tm->tm_hour	= bcd2bin(ops->readbyte(M48T86_REG_HOUR) & 0x3F);
> -		tm->tm_mday	= bcd2bin(ops->readbyte(M48T86_REG_DOM));
> +		tm->tm_sec	= bcd2bin(m48t86_rtc_readbyte(priv, M48T86_REG_SEC));
> +		tm->tm_min	= bcd2bin(m48t86_rtc_readbyte(priv, M48T86_REG_MIN));
> +		tm->tm_hour	= bcd2bin(m48t86_rtc_readbyte(priv, M48T86_REG_HOUR) & 0x3F);
> +		tm->tm_mday	= bcd2bin(m48t86_rtc_readbyte(priv, M48T86_REG_DOM));
>  		/* tm_mon is 0-11 */
> -		tm->tm_mon	= bcd2bin(ops->readbyte(M48T86_REG_MONTH)) - 1;
> -		tm->tm_year	= bcd2bin(ops->readbyte(M48T86_REG_YEAR)) + 100;
> -		tm->tm_wday	= bcd2bin(ops->readbyte(M48T86_REG_DOW));
> +		tm->tm_mon	= bcd2bin(m48t86_rtc_readbyte(priv, M48T86_REG_MONTH)) - 1;
> +		tm->tm_year	= bcd2bin(m48t86_rtc_readbyte(priv, M48T86_REG_YEAR)) + 100;
> +		tm->tm_wday	= bcd2bin(m48t86_rtc_readbyte(priv, M48T86_REG_DOW));
>  	}
>  
>  	/* correct the hour if the clock is in 12h mode */
>  	if (!(reg & M48T86_REG_B_H24))
> -		if (ops->readbyte(M48T86_REG_HOUR) & 0x80)
> +		if (m48t86_rtc_readbyte(priv, M48T86_REG_HOUR) & 0x80)
>  			tm->tm_hour += 12;
>  
>  	return rtc_valid_tm(tm);
> @@ -83,38 +106,37 @@ static int m48t86_rtc_read_time(struct device *dev, struct rtc_time *tm)
>  static int m48t86_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	unsigned char reg;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct m48t86_ops *ops = pdev->dev.platform_data;
> +	struct m48t86_rtc_private_data *priv = dev_get_drvdata(dev);
>  
> -	reg = ops->readbyte(M48T86_REG_B);
> +	reg = m48t86_rtc_readbyte(priv, M48T86_REG_B);
>  
>  	/* update flag and 24h mode */
>  	reg |= M48T86_REG_B_SET | M48T86_REG_B_H24;
> -	ops->writebyte(reg, M48T86_REG_B);
> +	m48t86_rtc_writebyte(priv, reg, M48T86_REG_B);
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
> +		m48t86_rtc_writebyte(priv, tm->tm_sec, M48T86_REG_SEC);
> +		m48t86_rtc_writebyte(priv, tm->tm_min, M48T86_REG_MIN);
> +		m48t86_rtc_writebyte(priv, tm->tm_hour, M48T86_REG_HOUR);
> +		m48t86_rtc_writebyte(priv, tm->tm_mday, M48T86_REG_DOM);
> +		m48t86_rtc_writebyte(priv, tm->tm_mon + 1, M48T86_REG_MONTH);
> +		m48t86_rtc_writebyte(priv, tm->tm_year % 100, M48T86_REG_YEAR);
> +		m48t86_rtc_writebyte(priv, tm->tm_wday, M48T86_REG_DOW);
>  	} else {
>  		/* bcd mode */
> -		ops->writebyte(bin2bcd(tm->tm_sec), M48T86_REG_SEC);
> -		ops->writebyte(bin2bcd(tm->tm_min), M48T86_REG_MIN);
> -		ops->writebyte(bin2bcd(tm->tm_hour), M48T86_REG_HOUR);
> -		ops->writebyte(bin2bcd(tm->tm_mday), M48T86_REG_DOM);
> -		ops->writebyte(bin2bcd(tm->tm_mon + 1), M48T86_REG_MONTH);
> -		ops->writebyte(bin2bcd(tm->tm_year % 100), M48T86_REG_YEAR);
> -		ops->writebyte(bin2bcd(tm->tm_wday), M48T86_REG_DOW);
> +		m48t86_rtc_writebyte(priv, bin2bcd(tm->tm_sec), M48T86_REG_SEC);
> +		m48t86_rtc_writebyte(priv, bin2bcd(tm->tm_min), M48T86_REG_MIN);
> +		m48t86_rtc_writebyte(priv, bin2bcd(tm->tm_hour), M48T86_REG_HOUR);
> +		m48t86_rtc_writebyte(priv, bin2bcd(tm->tm_mday), M48T86_REG_DOM);
> +		m48t86_rtc_writebyte(priv, bin2bcd(tm->tm_mon + 1), M48T86_REG_MONTH);
> +		m48t86_rtc_writebyte(priv, bin2bcd(tm->tm_year % 100), M48T86_REG_YEAR);
> +		m48t86_rtc_writebyte(priv, bin2bcd(tm->tm_wday), M48T86_REG_DOW);
>  	}
>  
>  	/* update ended */
>  	reg &= ~M48T86_REG_B_SET;
> -	ops->writebyte(reg, M48T86_REG_B);
> +	m48t86_rtc_writebyte(priv, reg, M48T86_REG_B);
>  
>  	return 0;
>  }
> @@ -122,15 +144,14 @@ static int m48t86_rtc_set_time(struct device *dev, struct rtc_time *tm)
>  static int m48t86_rtc_proc(struct device *dev, struct seq_file *seq)
>  {
>  	unsigned char reg;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct m48t86_ops *ops = pdev->dev.platform_data;
> +	struct m48t86_rtc_private_data *priv = dev_get_drvdata(dev);
>  
> -	reg = ops->readbyte(M48T86_REG_B);
> +	reg = m48t86_rtc_readbyte(priv, M48T86_REG_B);
>  
>  	seq_printf(seq, "mode\t\t: %s\n",
>  		 (reg & M48T86_REG_B_DM) ? "binary" : "bcd");
>  
> -	reg = ops->readbyte(M48T86_REG_D);
> +	reg = m48t86_rtc_readbyte(priv, M48T86_REG_D);
>  
>  	seq_printf(seq, "battery\t\t: %s\n",
>  		 (reg & M48T86_REG_D_VRT) ? "ok" : "exhausted");
> @@ -144,42 +165,159 @@ static const struct rtc_class_ops m48t86_rtc_ops = {
>  	.proc		= m48t86_rtc_proc,
>  };
>  
> -static int m48t86_rtc_probe(struct platform_device *dev)
> +/*
> + * The RTC chip has 114 bytes upper bytes that can be used as user storage
> + * space which we can use to test if the chip is present; for example it is
> + * an optional feature and not all boards will have it present.
> + *
> + * I've used the method Technologic Systems use in their rtc7800.c example
> + * for the detection.
> + *
> + * TODO: track down a guinea pig without an RTC to see if we can work out a
> + *		better RTC detection routine
> + */
> +static int m48t86_rtc_detect(struct device *dev)
> +{
> +	struct m48t86_rtc_private_data *priv = dev_get_drvdata(dev);
> +
> +	unsigned char tmp_rtc0, tmp_rtc1;
> +
> +	tmp_rtc0 = m48t86_rtc_readbyte(priv, 126);
> +	tmp_rtc1 = m48t86_rtc_readbyte(priv, 127);

These should probably have #defines, even if it is just something like:

  #define REG_SCRATCH_1 126
  #define REG_SCRATCH_2 127

> +
> +	m48t86_rtc_writebyte(priv, 0x00, 126);
> +	m48t86_rtc_writebyte(priv, 0x55, 127);
> +	if (m48t86_rtc_readbyte(priv, 127) == 0x55) {
> +		m48t86_rtc_writebyte(priv, 0xaa, 127);
> +		if (m48t86_rtc_readbyte(priv, 127) == 0xaa
> +				&& m48t86_rtc_readbyte(priv, 126) == 0x00) {
> +			m48t86_rtc_writebyte(priv, tmp_rtc0, 126);
> +			m48t86_rtc_writebyte(priv, tmp_rtc1, 127);
> +
> +			return 0;
> +		}
> +	}
> +
> +	dev_info(dev, "RTC not found\n");

Don't spam the log with stuff like this.

> +	return -ENODEV;
> +}
> +
> +static int m48t86_rtc_probe(struct platform_device *pdev)
>  {
> +	struct m48t86_rtc_private_data *priv;
> +	struct resource *res_index, *res_data;
>  	unsigned char reg;
> -	struct m48t86_ops *ops = dev->dev.platform_data;
> -	struct rtc_device *rtc = rtc_device_register("m48t86",
> -				&dev->dev, &m48t86_rtc_ops, THIS_MODULE);
> +	int err;
> +
> +	res_index = platform_get_resource_byname(
> +				pdev, IORESOURCE_MEM, "rtc_index");

Nitpick - please break lines like this:

	res_index = platform_get_resource_byname(pdev,
						 IO_RESOURCE_MEM,
                                                 "rtc_index");

You can use the double tab stop indent if you want, but please try to
fill the 80 columns before wrapping arguments onto the next line.


> +	if (!res_index)
> +		return -ENXIO;
> +	res_data = platform_get_resource_byname(
> +				pdev, IORESOURCE_MEM, "rtc_data");
> +	if (!res_data)
> +		return -ENXIO;
> +
> +	/* Allocate memory for the device structure (and zero it) */
> +	priv = kzalloc(sizeof(struct m48t86_rtc_private_data), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(&pdev->dev, "failed to allocate device structure.\n");

Don't need the warning. kalloc failures will automatically print a
warning and stacktrace.

> +		return -ENOMEM;
> +	}
> +
> +	if (!request_mem_region(res_index->start, resource_size(res_index),
> +				dev_name(&pdev->dev))) {
> +		dev_err(&pdev->dev, "request_mem_region failed\n");
> +		err = -EBUSY;
> +		goto out_free;
> +	}
> +	if (!request_mem_region(res_data->start, resource_size(res_data),
> +				dev_name(&pdev->dev))) {
> +		dev_err(&pdev->dev, "request_mem_region failed\n");
> +		err = -EBUSY;
> +		goto out_release_io_index;
> +	}
> +
> +	priv->io_index = ioremap(res_index->start, resource_size(res_index));
> +	if (priv->io_index == NULL) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		err = -EIO;
> +		goto out_release_io_data;
> +	}
> +	priv->io_data = ioremap(res_data->start, resource_size(res_data));
> +	if (priv->io_data == NULL) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		err = -EIO;
> +		goto out_ctrl;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
>  
> -	if (IS_ERR(rtc))
> -		return PTR_ERR(rtc);
> +	err = m48t86_rtc_detect(&pdev->dev);
> +	if (err)
> +		goto out;
>  
> -	platform_set_drvdata(dev, rtc);
> +	priv->rtc = rtc_device_register("m48t86",
> +				&pdev->dev, &m48t86_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(priv->rtc)) {
> +		err = PTR_ERR(priv->rtc);
> +		goto out;
> +	}
>  
>  	/* read battery status */
> -	reg = ops->readbyte(M48T86_REG_D);
> -	dev_info(&dev->dev, "battery %s\n",
> +	reg = m48t86_rtc_readbyte(priv, M48T86_REG_D);
> +	dev_info(&pdev->dev, "battery %s\n",
>  		(reg & M48T86_REG_D_VRT) ? "ok" : "exhausted");
>  
>  	return 0;
> +
> +out:
> +	platform_set_drvdata(pdev, NULL);

I don't think this is needed.

> +	iounmap(priv->io_data);
> +out_ctrl:
> +	iounmap(priv->io_index);
> +out_release_io_data:
> +	release_mem_region(res_data->start, resource_size(res_data));
> +out_release_io_index:
> +	release_mem_region(res_index->start, resource_size(res_index));
> +out_free:
> +	kfree(priv);
> +	return err;
>  }
>  
> -static int m48t86_rtc_remove(struct platform_device *dev)
> +static int m48t86_rtc_remove(struct platform_device *pdev)
>  {
> -	struct rtc_device *rtc = platform_get_drvdata(dev);
> +	struct m48t86_rtc_private_data *priv = platform_get_drvdata(pdev);
> +	struct resource *res;
> +
> +	rtc_device_unregister(priv->rtc);
>  
> - 	if (rtc)
> -		rtc_device_unregister(rtc);
> +	platform_set_drvdata(pdev, NULL);
>  
> -	platform_set_drvdata(dev, NULL);
> +	iounmap(priv->io_data);
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rtc_data");
> +	release_mem_region(res->start, resource_size(res));
> +
> +	iounmap(priv->io_index);
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rtc_index");
> +	release_mem_region(res->start, resource_size(res));
> +
> +	kfree(priv);
>  
>  	return 0;
>  }
>  
> +static const struct of_device_id m48t86_rtc_match[] = {
> +	{ .compatible = "rtc-m48t86" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, m48t86_rtc_match);
> +
>  static struct platform_driver m48t86_rtc_platform_driver = {
>  	.driver		= {
> -		.name	= "rtc-m48t86",
> -		.owner	= THIS_MODULE,
> +		.name		= "rtc-m48t86",
> +		.owner		= THIS_MODULE,
> +		.of_match_table = m48t86_rtc_match,
>  	},
>  	.probe		= m48t86_rtc_probe,
>  	.remove		= m48t86_rtc_remove,
> diff --git a/include/linux/m48t86.h b/include/linux/m48t86.h
> deleted file mode 100644
> index 915d6b4..0000000
> --- a/include/linux/m48t86.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/*
> - * ST M48T86 / Dallas DS12887 RTC driver
> - * Copyright (c) 2006 Tower Technologies
> - *
> - * Author: Alessandro Zummo <a.zummo@towertech.it>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -struct m48t86_ops
> -{
> -	void (*writebyte)(unsigned char value, unsigned long addr);
> -	unsigned char (*readbyte)(unsigned long addr);
> -};
> 
