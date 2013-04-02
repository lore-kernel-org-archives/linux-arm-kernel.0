From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 02 Apr 2013 16:34:07 +1100
Subject: [PATCH 2/6] rtc: rtc-m48t86: add hooks to support driver side
 memory mapping
In-Reply-To: <1364858565-17192-3-git-send-email-alex@digriz.org.uk>
References: <1364858565-17192-1-git-send-email-alex@digriz.org.uk>
 <1364858565-17192-3-git-send-email-alex@digriz.org.uk>
Message-ID: <515A6DCF.1080902@gmail.com>
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

The read/writebyte functions should return a u8 and take a u8 for the
address (since you are using readb/writeb). For the temporary step which
still has the ops structure, you can explicitly cast addr to unsigned
long if you want to make it obvious that the old api was silly.

~Ryan
