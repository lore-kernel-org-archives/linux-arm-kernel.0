From: balbi@ti.com (Felipe Balbi)
Date: Fri, 2 Nov 2012 13:06:04 +0200
Subject: [PATCH 1/2] i2c: omap: Fix the revision register read
In-Reply-To: <1351852785-16961-2-git-send-email-shubhrajyoti@ti.com>
References: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
 <1351852785-16961-2-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20121102110604.GB19493@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 02, 2012 at 04:09:44PM +0530, Shubhrajyoti D wrote:
> The revision register on OMAP4 is a 16-bit lo and a 16-bit
> hi. Currently the driver reads only the lower 8-bits.
> Fix the same by preventing the truncating of the rev register
> for OMAP4.
> 
> Also use the scheme bit ie bit-14 of the hi register to know if it
> is OMAP_I2C_IP_VERSION_2.
> 
> On platforms previous to OMAP4 the offset 0x04 is IE register whose
> bit-14 reset value is 0, the code uses the same to its advantage.
> 
> Also since the omap_i2c_read_reg uses reg_map_ip_* a raw_readw is done
> to fetch the revision register.
> 
> The dev->regs is populated after reading the rev_hi. A NULL check
> has been added in the resume handler to prevent the access before
> the setting of the regs.

tested on which platforms ?

> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   59 ++++++++++++++++++++++++++++++++---------
>  1 files changed, 46 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..d8e7709 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -49,9 +49,10 @@
>  #define OMAP_I2C_OMAP1_REV_2		0x20
>  
>  /* I2C controller revisions present on specific hardware */
> -#define OMAP_I2C_REV_ON_2430		0x36
> -#define OMAP_I2C_REV_ON_3430_3530	0x3C
> -#define OMAP_I2C_REV_ON_3630_4430	0x40
> +#define OMAP_I2C_REV_ON_2430		0x00000036

are you sure this are the contents on 2430 ? Have you actually ran this
code on that platform ?

> +#define OMAP_I2C_REV_ON_3430_3530	0x0000003C
> +#define OMAP_I2C_REV_ON_3630		0x00000040

likewise for these two.

> +#define OMAP_I2C_REV_ON_4430_PLUS	0x50400002

what about 4460, 4470, 3530, etc etc etc ?

> @@ -490,7 +491,7 @@ static void omap_i2c_resize_fifo(struct omap_i2c_dev *dev, u8 size, bool is_rx)
>  
>  	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, buf);
>  
> -	if (dev->rev < OMAP_I2C_REV_ON_3630_4430)
> +	if (dev->rev < OMAP_I2C_REV_ON_3630)
>  		dev->b_hw = 1; /* Enable hardware fixes */
>  
>  	/* calculate wakeup latency constraint for MPU */
> @@ -1052,6 +1053,14 @@ static const struct of_device_id omap_i2c_of_match[] = {
>  MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
>  #endif
>  
> +#define OMAP_I2C_SCHEME(rev)		(rev & 0xc000) >> 14

you miss () there to make sure no other operations will take higher
precedence when using this macro.

> @@ -1130,7 +1136,31 @@ omap_i2c_probe(struct platform_device *pdev)
>  	if (IS_ERR_VALUE(r))
>  		goto err_free_mem;
>  
> -	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> +	/*
> +	 * Read the Rev hi bit-[15:14] ie scheme this is 1 indicates ver2.
> +	 * On omap3 Offset 4 is IE Reg the bit [15:14] is XDR_IE which is 0
> +	 * at reset. Also since the omap_i2c_read_reg uses reg_map_ip_* a
> +	 * raw_readw is done.
> +	 */
> +	rev = __raw_readw(dev->base + 0x04);
> +
> +	switch (OMAP_I2C_SCHEME(rev)) {
> +	case 0:

define macros for these two cases.

> +		dev->regs = (u8 *)reg_map_ip_v1;
> +		dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> +		minor = OMAP_I2C_REV_SCHEME_0_MAJOR(dev->rev);
> +		major = OMAP_I2C_REV_SCHEME_0_MAJOR(dev->rev);
> +	break;

wrong indentation.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121102/37133f7c/attachment.sig>
