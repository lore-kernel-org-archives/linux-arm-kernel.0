From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 3 Mar 2017 10:18:38 +0000
Subject: [PATCH v5 2/3] nvmem: sunxi-sid: add support for H3's SID
 controller
In-Reply-To: <20170227192715.50198-2-icenowy@aosc.xyz>
References: <20170227192715.50198-1-icenowy@aosc.xyz>
 <20170227192715.50198-2-icenowy@aosc.xyz>
Message-ID: <49ffb57b-d1e8-14b2-627d-f132c676a807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/02/17 19:27, Icenowy Zheng wrote:
> The H3 SoC have a bigger SID controller, which has its direct read
> address at 0x200 position in the SID block, not 0x0.
>
> Also, H3 SID controller has some silicon bug that makes the direct read
> value wrong at cold boot, add code to workaround the bug. (This bug has
> already been fixed on A64 and later SoCs)
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v5:
> - Removed some bits in binding documentation.
> - Removed some default values in cfg struct.
>
> Changes in v4:
> - Use readl_poll_timeout.
> - Do register offset in sunxi_sid_read.
> - Merge SUN8I_SID_OP_LOCK and SUN8I_SID_LOCK_SHIFT into one macro.
> - Drop the result of register-based read operation.
>
>  .../bindings/nvmem/allwinner,sunxi-sid.txt         |  6 ++-
>  drivers/nvmem/sunxi_sid.c                          | 62 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 1 deletion(-)



I will queue this and 1/3 patch for next cycle, but the dts patch has to 
go via arm-soc tree.

Thanks,
srini
>
> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> index d543ed3f5363..ef06d061913c 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> @@ -1,7 +1,11 @@
>  Allwinner sunxi-sid
>
>  Required properties:
> -- compatible: "allwinner,sun4i-a10-sid" or "allwinner,sun7i-a20-sid"
> +- compatible: Should be one of the following:
> +  "allwinner,sun4i-a10-sid"
> +  "allwinner,sun7i-a20-sid"
> +  "allwinner,sun8i-h3-sid"
> +
>  - reg: Should contain registers location and length
>
>  = Data cells =
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index 69524b67007f..0d6648be93b8 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -17,6 +17,7 @@
>
>  #include <linux/device.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/nvmem-provider.h>
>  #include <linux/of.h>
> @@ -25,6 +26,15 @@
>  #include <linux/slab.h>
>  #include <linux/random.h>
>
> +/* Registers and special values for doing register-based SID readout on H3 */
> +#define SUN8I_SID_PRCTL		0x40
> +#define SUN8I_SID_RDKEY		0x60
> +
> +#define SUN8I_SID_OFFSET_MASK	0x1FF
> +#define SUN8I_SID_OFFSET_SHIFT	16
> +#define SUN8I_SID_OP_LOCK	(0xAC << 8)
> +#define SUN8I_SID_READ		BIT(1)
> +
>  static struct nvmem_config econfig = {
>  	.name = "sunxi-sid",
>  	.read_only = true,
> @@ -34,11 +44,14 @@ static struct nvmem_config econfig = {
>  };
>
>  struct sunxi_sid_cfg {
> +	u32	value_offset;
>  	u32	size;
> +	bool	need_register_readout;
>  };
>
>  struct sunxi_sid {
>  	void __iomem		*base;
> +	u32			value_offset;
>  };
>
>  /* We read the entire key, due to a 32 bit read alignment requirement. Since we
> @@ -63,12 +76,36 @@ static int sunxi_sid_read(void *context, unsigned int offset,
>  	struct sunxi_sid *sid = context;
>  	u8 *buf = val;
>
> +	/* Offset the read operation to the real position of SID */
> +	offset += sid->value_offset;
> +
>  	while (bytes--)
>  		*buf++ = sunxi_sid_read_byte(sid, offset++);
>
>  	return 0;
>  }
>
> +static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
> +				      const unsigned int word)
> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	/* Set word, lock access, and set read command */
> +	reg_val = (word & SUN8I_SID_OFFSET_MASK)
> +		  << SUN8I_SID_OFFSET_SHIFT;
> +	reg_val |= SUN8I_SID_OP_LOCK | SUN8I_SID_READ;
> +	writel(reg_val, sid->base + SUN8I_SID_PRCTL);
> +
> +	ret = readl_poll_timeout(sid->base + SUN8I_SID_PRCTL, reg_val,
> +				 !(reg_val & SUN8I_SID_READ), 100, 250000);
> +	if (ret)
> +		return ret;
> +
> +	writel(0, sid->base + SUN8I_SID_PRCTL);
> +	return 0;
> +}
> +
>  static int sunxi_sid_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -86,6 +123,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
>  	cfg = of_device_get_match_data(dev);
>  	if (!cfg)
>  		return -EINVAL;
> +	sid->value_offset = cfg->value_offset;
>
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sid->base = devm_ioremap_resource(dev, res);
> @@ -94,6 +132,23 @@ static int sunxi_sid_probe(struct platform_device *pdev)
>
>  	size = cfg->size;
>
> +	if (cfg->need_register_readout) {
> +		/*
> +		 * H3's SID controller have a bug that the value at 0x200
> +		 * offset is not the correct value when the hardware is reseted.
> +		 * However, after doing a register-based read operation, the
> +		 * value become right.
> +		 * Do a full read operation here, but ignore its value
> +		 * (as it's more fast to read by direct MMIO value than
> +		 * with registers)
> +		 */
> +		for (i = 0; i < (size >> 2); i++) {
> +			ret = sun8i_sid_register_readout(sid, i);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
>  	econfig.size = size;
>  	econfig.dev = dev;
>  	econfig.reg_read = sunxi_sid_read;
> @@ -138,9 +193,16 @@ static const struct sunxi_sid_cfg sun7i_a20_cfg = {
>  	.size = 0x200,
>  };
>
> +static const struct sunxi_sid_cfg sun8i_h3_cfg = {
> +	.value_offset = 0x200,
> +	.size = 0x100,
> +	.need_register_readout = true,
> +};
> +
>  static const struct of_device_id sunxi_sid_of_match[] = {
>  	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
>  	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
> +	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
>  	{/* sentinel */},
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
>
