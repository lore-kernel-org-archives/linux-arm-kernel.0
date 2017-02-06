From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Feb 2017 09:54:16 +0100
Subject: [PATCH v3 2/3] nvmem: sunxi-sid: add support for H3's SID
 controller
In-Reply-To: <20170202131338.20234-2-icenowy@aosc.xyz>
References: <20170202131338.20234-1-icenowy@aosc.xyz>
 <20170202131338.20234-2-icenowy@aosc.xyz>
Message-ID: <20170206085416.4qtd3wfhtinp42xv@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 09:13:37PM +0800, Icenowy Zheng wrote:
> The H3 SoC have a bigger SID controller, which has its direct read
> address at 0x200 position in the SID block, not 0x0.
> 
> Also, H3 SID controller has some silicon bug that makes the direct read
> value wrong at cold boot, add code to workaround the bug. (This bug has
> already been fixed on A64 and later SoCs)
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> This patch is the part of [PATCH v2 1/1] that adds support for H3 SID
> controller.
> 
>  .../bindings/nvmem/allwinner,sunxi-sid.txt         | 12 +++-
>  drivers/nvmem/sunxi_sid.c                          | 72 +++++++++++++++++++++-
>  2 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> index d543ed3f5363..9ab9e75a6351 100644
> --- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> +++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
> @@ -1,7 +1,11 @@
>  Allwinner sunxi-sid
>  
>  Required properties:
> -- compatible: "allwinner,sun4i-a10-sid" or "allwinner,sun7i-a20-sid"
> +- compatible: Should be one of the following (depending on your SoC):
> +  "allwinner,sun4i-a10-sid"
> +  "allwinner,sun7i-a20-sid"
> +  "allwinner,sun8i-h3-sid"
> +
>  - reg: Should contain registers location and length
>  
>  = Data cells =
> @@ -19,3 +23,9 @@ Example for sun7i:
>  		compatible = "allwinner,sun7i-a20-sid";
>  		reg = <0x01c23800 0x200>
>  	};
> +
> +Example for sun8i-h3:
> +	sid at 01c14000 {
> +		compatible = "allwinner,sun8i-h3-sid";
> +		reg = <0x01c14000 0x400>;
> +	};
> diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> index 69524b67007f..476a161ff23a 100644
> --- a/drivers/nvmem/sunxi_sid.c
> +++ b/drivers/nvmem/sunxi_sid.c
> @@ -25,6 +25,16 @@
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
> @@ -51,7 +64,8 @@ static u8 sunxi_sid_read_byte(const struct sunxi_sid *sid,
>  {
>  	u32 sid_key;
>  
> -	sid_key = ioread32be(sid->base + round_down(offset, 4));
> +	sid_key = ioread32be(sid->base + sid->value_offset +
> +			     round_down(offset, 4));

This would probably be more logical to have this in sunxi_sid_read.

>  	sid_key >>= (offset % 4) * 8;
>  
>  	return sid_key; /* Only return the last byte */
> @@ -69,6 +83,33 @@ static int sunxi_sid_read(void *context, unsigned int offset,
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

You're not using those mask and shifts anywhere else, why not just
define the value / macro you need directly?

> +	reg_val |= SUN8I_SID_READ;
> +	writel(reg_val, sid->base + SUN8I_SID_PRCTL);
> +
> +	do {
> +		reg_val = readl(sid->base + SUN8I_SID_PRCTL);
> +	} while (time_before(jiffies, expire) && (reg_val & SUN8I_SID_READ));

readl_poll_timeout?

> +	if (reg_val & SUN8I_SID_READ)
> +		return -EIO;
> +
> +	if (out)
> +		*out = readl(sid->base + SUN8I_SID_RDKEY);

Why do you need that out parameter?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/2758c6cf/attachment.sig>
