From: balbi@ti.com (Felipe Balbi)
Date: Fri, 28 Jun 2013 12:35:00 +0300
Subject: [PATCH V2 3/3] video: exynos_dp: Use the generic PHY driver
In-Reply-To: <002101ce73cf$ac989b70$05c9d250$@samsung.com>
References: <002101ce73cf$ac989b70$05c9d250$@samsung.com>
Message-ID: <20130628093459.GD11297@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 04:18:23PM +0900, Jingoo Han wrote:
> Use the generic PHY API instead of the platform callback to control
> the DP PHY. The 'phy_label' field is added to the platform data
> structure to allow PHY lookup on non-dt platforms.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  .../devicetree/bindings/video/exynos_dp.txt        |   17 ---
>  drivers/video/exynos/exynos_dp_core.c              |  118 ++------------------
>  drivers/video/exynos/exynos_dp_core.h              |    2 +
>  include/video/exynos_dp.h                          |    6 +-
>  4 files changed, 15 insertions(+), 128 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
> index 84f10c1..a8320e3 100644
> --- a/Documentation/devicetree/bindings/video/exynos_dp.txt
> +++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
> @@ -1,17 +1,6 @@
>  The Exynos display port interface should be configured based on
>  the type of panel connected to it.
>  
> -We use two nodes:
> -	-dp-controller node
> -	-dptx-phy node(defined inside dp-controller node)
> -
> -For the DP-PHY initialization, we use the dptx-phy node.
> -Required properties for dptx-phy:
> -	-reg:
> -		Base address of DP PHY register.
> -	-samsung,enable-mask:
> -		The bit-mask used to enable/disable DP PHY.
> -
>  For the Panel initialization, we read data from dp-controller node.
>  Required properties for dp-controller:
>  	-compatible:
> @@ -67,12 +56,6 @@ SOC specific portion:
>  		interrupt-parent = <&combiner>;
>  		clocks = <&clock 342>;
>  		clock-names = "dp";
> -
> -		dptx-phy {
> -			reg = <0x10040720>;
> -			samsung,enable-mask = <1>;
> -		};
> -
>  	};
>  
>  Board Specific portion:
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index 12bbede..bac515b 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -19,6 +19,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/of.h>
> +#include <linux/phy/phy.h>
>  
>  #include <video/exynos_dp.h>
>  
> @@ -960,84 +961,15 @@ static struct exynos_dp_platdata *exynos_dp_dt_parse_pdata(struct device *dev)
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	return pd;
> -}
> -
> -static int exynos_dp_dt_parse_phydata(struct exynos_dp_device *dp)
> -{
> -	struct device_node *dp_phy_node = of_node_get(dp->dev->of_node);
> -	u32 phy_base;
> -	int ret = 0;
> -
> -	dp_phy_node = of_find_node_by_name(dp_phy_node, "dptx-phy");
> -	if (!dp_phy_node) {
> -		dev_err(dp->dev, "could not find dptx-phy node\n");
> -		return -ENODEV;
> -	}
> -
> -	if (of_property_read_u32(dp_phy_node, "reg", &phy_base)) {
> -		dev_err(dp->dev, "failed to get reg for dptx-phy\n");
> -		ret = -EINVAL;
> -		goto err;
> -	}
> -
> -	if (of_property_read_u32(dp_phy_node, "samsung,enable-mask",
> -				&dp->enable_mask)) {
> -		dev_err(dp->dev, "failed to get enable-mask for dptx-phy\n");
> -		ret = -EINVAL;
> -		goto err;
> -	}
> -
> -	dp->phy_addr = ioremap(phy_base, SZ_4);
> -	if (!dp->phy_addr) {
> -		dev_err(dp->dev, "failed to ioremap dp-phy\n");
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -
> -err:
> -	of_node_put(dp_phy_node);
> -
> -	return ret;
> -}
> -
> -static void exynos_dp_phy_init(struct exynos_dp_device *dp)
> -{
> -	u32 reg;
> -
> -	reg = __raw_readl(dp->phy_addr);
> -	reg |= dp->enable_mask;
> -	__raw_writel(reg, dp->phy_addr);
> -}
> -
> -static void exynos_dp_phy_exit(struct exynos_dp_device *dp)
> -{
> -	u32 reg;
> +	pd->phy_label = "dp";

only the label, which I would use 'display-port'. Other than that:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130628/149b1753/attachment.sig>
