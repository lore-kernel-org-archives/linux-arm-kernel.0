From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 09:17:12 +0100
Subject: [PATCH 1/2] nvmem: sunxi-sid: add support for H3 and A64's SID
 controller
In-Reply-To: <20170126113345.33686-1-icenowy@aosc.xyz>
References: <20170126113345.33686-1-icenowy@aosc.xyz>
Message-ID: <20170127081712.x2hprtpo2aolungc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 26, 2017 at 07:33:44PM +0800, Icenowy Zheng wrote:
> H3 and A64 SoCs have a bigger SID controller, which has its direct read
> address at 0x200 position in the SID block, not 0x0.
> 
> Also, H3 SID controller has some silicon bug that makes the direct read
> value wrong at first, add code to workaround the bug. (This bug has
> already been fixed on A64 and later SoCs)
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
>  .../bindings/nvmem/allwinner,sunxi-sid.txt         |  22 +++-
>  drivers/nvmem/sunxi_sid.c                          | 112 +++++++++++++++++++--
>  2 files changed, 123 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> index d543ed3f5363..d7400c415338 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> @@ -1,8 +1,16 @@
>  Allwinner sunxi-sid
>  
>  Required properties:
> -- compatible: "allwinner,sun4i-a10-sid" or "allwinner,sun7i-a20-sid"
> -- reg: Should contain registers location and length
> +- compatible: Should be one of the following (depending on your SoC):
> +  "allwinner,sun4i-a10-sid"
> +  "allwinner,sun7i-a20-sid"
> +  "allwinner,sun8i-h3-sid"
> +  "allwinner,sun50i-a64-sid"
> +
> +- reg: Should contain registers location and registers length, for A10 and A20
> +  SoCs the length is directly the length of SID; for H3, A64 and newer SoCs
> +  the length should be the sum of the length of SID and the offset of the value
> +  (0x200).
>  
>  = Data cells =
>  Are child nodes of qfprom, bindings of which as described in
> @@ -19,3 +27,13 @@ Example for sun7i:
>  		compatible = "allwinner,sun7i-a20-sid";
>  		reg = <0x01c23800 0x200>
>  	};
> +
> +Example for sun8i-h3:
> +	sid at 01c14000 {
> +		compatible = "allwinner,sun8i-h3-sid";
> +		/*
> +		 * The length of SID on H3 is 0x100 bytes, add the value offset
> +		 * 0x200, so the total length should be 0x300.
> +		 */
> +		reg = <0x01c14000 0x300>;

No, it should be the size of the memory region used and documented for
that device, ie 1kB (0x400) in the H3 case, just like any other reg
property.

> +	};
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index 1567ccca8de3..2e327a66a938 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -20,10 +20,28 @@
>  #include <linux/module.h>
>  #include <linux/nvmem-provider.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/random.h>
>  
> +/* Registers and special values for doing register-based SID readout on H3 */
> +#define SUN8I_SID_PRCTL		0x40
> +#define SUN8I_SID_RDKEY		0x60
> +
> +#define SUN8I_SID_OP_LOCK	0xAC
> +#define SUN8I_SID_OFFSET_MASK	0x1FF
> +#define SUN8I_SID_OFFSET_SHIFT	16
> +#define SUN8I_SID_LOCK_SHIFT	8
> +#define SUN8I_SID_READ		BIT(1)
> +
> +/*
> + * For newer SoCs with a larger eFUSE, the bytes beyond the first 16 bytes are
> + * sparse, which makes it not suitable for adding randomness; legacy SoCs' SID
> + * have only 16 bytes, so we choose to use at most 16 bytes to add randomness.
> + */
> +#define SUNXI_SID_MAX_RANDOMNESS_SIZE	16
> +
>  static struct nvmem_config econfig = {
>  	.name = "sunxi-sid",
>  	.read_only = true,
> @@ -32,8 +50,14 @@ static struct nvmem_config econfig = {
>  	.owner = THIS_MODULE,
>  };
>  
> +struct sunxi_sid_cfg {
> +	u32	value_offset;
> +	bool	need_register_readout;
> +};
> +
>  struct sunxi_sid {
>  	void __iomem		*base;
> +	u32			value_offset;
>  };
>  
>  /* We read the entire key, due to a 32 bit read alignment requirement. Since we
> @@ -46,7 +70,8 @@ static u8 sunxi_sid_read_byte(const struct sunxi_sid *sid,
>  {
>  	u32 sid_key;
>  
> -	sid_key = ioread32be(sid->base + round_down(offset, 4));
> +	sid_key = ioread32be(sid->base + sid->value_offset +
> +			     round_down(offset, 4));
>  	sid_key >>= (offset % 4) * 8;
>  
>  	return sid_key; /* Only return the last byte */
> @@ -64,26 +89,77 @@ static int sunxi_sid_read(void *context, unsigned int offset,
>  	return 0;
>  }
>  
> +static int sun8i_sid_register_readout(const struct sunxi_sid *sid,
> +				      const unsigned int word,
> +				      u32 *out)
> +{
> +	u32 reg_val;
> +	unsigned long expire = jiffies + msecs_to_jiffies(250);
> +
> +	/* Set word, lock access, and set read command */
> +	reg_val = (word & SUN8I_SID_OFFSET_MASK)
> +		  << SUN8I_SID_OFFSET_SHIFT;
> +	reg_val |= SUN8I_SID_OP_LOCK << SUN8I_SID_LOCK_SHIFT;
> +	reg_val |= SUN8I_SID_READ;
> +	writel(reg_val, sid->base + SUN8I_SID_PRCTL);
> +
> +	do {
> +		reg_val = readl(sid->base + SUN8I_SID_PRCTL);
> +	} while (time_before(jiffies, expire) && (reg_val & SUN8I_SID_READ));
> +
> +	if (reg_val & SUN8I_SID_READ)
> +		return -EIO;
> +
> +	if (out)
> +		*out = readl(sid->base + SUN8I_SID_RDKEY);
> +	writel(0, sid->base + SUN8I_SID_PRCTL);
> +	return 0;
> +}
> +
>  static int sunxi_sid_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
>  	struct nvmem_device *nvmem;
>  	struct sunxi_sid *sid;
> -	int ret, i, size;
> +	int ret, i, size, randomness_size;
>  	char *randomness;
> +	const struct sunxi_sid_cfg *cfg;
>  
>  	sid = devm_kzalloc(dev, sizeof(*sid), GFP_KERNEL);
>  	if (!sid)
>  		return -ENOMEM;
>  
> +	cfg = of_device_get_match_data(dev);
> +	if (!cfg)
> +		return -EINVAL;
> +	sid->value_offset = cfg->value_offset;
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	sid->base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(sid->base))
>  		return PTR_ERR(sid->base);
>  
> -	size = resource_size(res) - 1;
> -	econfig.size = resource_size(res);
> +	size = resource_size(res) - cfg->value_offset;
> +
> +	if (cfg->need_register_readout) {
> +		/*
> +		 * H3's SID controller have a bug that the value at 0x200
> +		 * offset is not the correct value when the hardware is reset.
> +		 * However, after doing a register-based read operation, the
> +		 * value become right.
> +		 * Do a full read operation here, but ignore its value
> +		 * (as it's more fast to read by direct MMIO value than
> +		 * with registers)
> +		 */
> +		for (i = 0; i < (size >> 2); i++) {
> +			ret = sun8i_sid_register_readout(sid, i, NULL);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	econfig.size = size;
>  	econfig.dev = dev;
>  	econfig.reg_read = sunxi_sid_read;
>  	econfig.priv = sid;
> @@ -91,16 +167,17 @@ static int sunxi_sid_probe(struct platform_device *pdev)
>  	if (IS_ERR(nvmem))
>  		return PTR_ERR(nvmem);
>  
> -	randomness = kzalloc(sizeof(u8) * (size), GFP_KERNEL);
> +	randomness_size = max(size, SUNXI_SID_MAX_RANDOMNESS_SIZE);
> +	randomness = kzalloc(sizeof(u8) * (randomness_size), GFP_KERNEL);

Why is that change needed?

Thanks,
Maxime


-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/93c2de6c/attachment-0001.sig>
