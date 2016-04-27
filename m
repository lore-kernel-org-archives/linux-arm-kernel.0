From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Wed, 27 Apr 2016 11:06:00 +0530
Subject: [PATCH 05/12] nvmem: vif610-ocotp: remove nvmem regmap dependency
In-Reply-To: <1461526096-29584-6-git-send-email-srinivas.kandagatla@linaro.org>
References: <1461526096-29584-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1461526096-29584-6-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160427053600.GB2048@Sanchayan-Arch.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Srinivas,

On 16-04-24 20:28:09, Srinivas Kandagatla wrote:
> This patch moves to nvmem support in the driver to use callback
> instead of regmap.

Minor nit, it says "vif610-octop" it should have been vf610-ocotp.

For what it's worth, I tested this on Colibri Vybrid VF61 for a while and
all seems to work fine.

So with the testing for vf610-ocotp driver other than the minor nit

Acked-by: Sanchayan Maity <maitysanchayan@gmail.com>

Regards,
Sanchayan.

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/vf610-ocotp.c | 44 ++++++++++----------------------------------
>  1 file changed, 10 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
> index 8641319..72e4faa 100644
> --- a/drivers/nvmem/vf610-ocotp.c
> +++ b/drivers/nvmem/vf610-ocotp.c
> @@ -25,7 +25,6 @@
>  #include <linux/nvmem-provider.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/regmap.h>
>  #include <linux/slab.h>
>  
>  /* OCOTP Register Offsets */
> @@ -152,23 +151,16 @@ static int vf610_get_fuse_address(int base_addr_offset)
>  	return -EINVAL;
>  }
>  
> -static int vf610_ocotp_write(void *context, const void *data, size_t count)
> -{
> -	return 0;
> -}
> -
> -static int vf610_ocotp_read(void *context,
> -			const void *off, size_t reg_size,
> -			void *val, size_t val_size)
> +static int vf610_ocotp_read(void *context, unsigned int offset,
> +			void *val, size_t bytes)
>  {
>  	struct vf610_ocotp *ocotp = context;
>  	void __iomem *base = ocotp->base;
> -	unsigned int offset = *(u32 *)off;
>  	u32 reg, *buf = val;
>  	int fuse_addr;
>  	int ret;
>  
> -	while (val_size > 0) {
> +	while (bytes > 0) {
>  		fuse_addr = vf610_get_fuse_address(offset);
>  		if (fuse_addr > 0) {
>  			writel(ocotp->timing, base + OCOTP_TIMING);
> @@ -205,29 +197,19 @@ static int vf610_ocotp_read(void *context,
>  		}
>  
>  		buf++;
> -		val_size--;
> -		offset += reg_size;
> +		bytes -= 4;
> +		offset += 4;
>  	}
>  
>  	return 0;
>  }
>  
> -static struct regmap_bus vf610_ocotp_bus = {
> -	.read = vf610_ocotp_read,
> -	.write = vf610_ocotp_write,
> -	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
> -	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
> -};
> -
> -static struct regmap_config ocotp_regmap_config = {
> -	.reg_bits = 32,
> -	.val_bits = 32,
> -	.reg_stride = 4,
> -};
> -
>  static struct nvmem_config ocotp_config = {
>  	.name = "ocotp",
>  	.owner = THIS_MODULE,
> +	.stride = 4,
> +	.word_size = 4,
> +	.reg_read = vf610_ocotp_read,
>  };
>  
>  static const struct of_device_id ocotp_of_match[] = {
> @@ -247,7 +229,6 @@ static int vf610_ocotp_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
> -	struct regmap *regmap;
>  	struct vf610_ocotp *ocotp_dev;
>  
>  	ocotp_dev = devm_kzalloc(&pdev->dev,
> @@ -267,13 +248,8 @@ static int vf610_ocotp_probe(struct platform_device *pdev)
>  		return PTR_ERR(ocotp_dev->clk);
>  	}
>  
> -	ocotp_regmap_config.max_register = resource_size(res);
> -	regmap = devm_regmap_init(dev,
> -		&vf610_ocotp_bus, ocotp_dev, &ocotp_regmap_config);
> -	if (IS_ERR(regmap)) {
> -		dev_err(dev, "regmap init failed\n");
> -		return PTR_ERR(regmap);
> -	}
> +	ocotp_config.size = resource_size(res);
> +	ocotp_config.priv = ocotp_dev;
>  	ocotp_config.dev = dev;
>  
>  	ocotp_dev->nvmem = nvmem_register(&ocotp_config);
> -- 
> 2.5.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
