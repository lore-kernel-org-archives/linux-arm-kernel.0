From: horms@verge.net.au (Simon Horman)
Date: Fri, 5 Apr 2013 09:43:00 +0900
Subject: [PATCH 4/8] rcar-phy: remove EHCI internal buffer setup
In-Reply-To: <201304050303.56515.sergei.shtylyov@cogentembedded.com>
References: <201304050303.56515.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130405004300.GO29203@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 03:03:55AM +0400, Sergei Shtylyov wrote:
> Now that the EHCI internal buffer setup is done by the platform code, we  can
> remove  such code from this driver as it never really belonged here.  We also
> no longer need the 2nd memory region now (2nd EHCI controller is simply missing
> in e.g. R8A7778 SoC).

I wonder if this patch could be split into a driver patch
followed by an SoC patch. Or vice versa.

> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
>  arch/arm/mach-shmobile/setup-r8a7779.c |    5 -----
>  drivers/usb/phy/rcar-phy.c             |   28 ++++------------------------
>  2 files changed, 4 insertions(+), 29 deletions(-)
> 
> Index: renesas/arch/arm/mach-shmobile/setup-r8a7779.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ renesas/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -405,11 +405,6 @@ static struct resource usb_phy_resources
>  		.end		= 0xffe70900 - 1,
>  		.flags		= IORESOURCE_MEM,
>  	},
> -	[1] = {
> -		.start		= 0xfff70000,
> -		.end		= 0xfff70900 - 1,
> -		.flags		= IORESOURCE_MEM,
> -	},
>  };
>  
>  static struct platform_device usb_phy_device = {
> Index: renesas/drivers/usb/phy/rcar-phy.c
> ===================================================================
> --- renesas.orig/drivers/usb/phy/rcar-phy.c
> +++ renesas/drivers/usb/phy/rcar-phy.c
> @@ -23,8 +23,6 @@
>  #define USBEH0		0x080C
>  #define USBOH0		0x081C
>  #define USBCTL0		0x0858
> -#define EIIBC1		0x0094
> -#define EIIBC2		0x009C
>  
>  /* USBPCTRL1 */
>  #define PHY_RST		(1 << 2)
> @@ -40,7 +38,6 @@ struct rcar_usb_phy_priv {
>  	spinlock_t lock;
>  
>  	void __iomem *reg0;
> -	void __iomem *reg1;
>  	int counter;
>  };
>  
> @@ -59,7 +56,6 @@ static int rcar_usb_phy_init(struct usb_
>  	struct rcar_usb_phy_priv *priv = usb_phy_to_priv(phy);
>  	struct device *dev = phy->dev;
>  	void __iomem *reg0 = priv->reg0;
> -	void __iomem *reg1 = priv->reg1;
>  	int i;
>  	u32 val;
>  	unsigned long flags;
> @@ -97,19 +93,6 @@ static int rcar_usb_phy_init(struct usb_
>  		iowrite32(0x00000000, (reg0 + USBPCTRL0));
>  
>  		/*
> -		 * EHCI IP internal buffer setting
> -		 * EHCI IP internal buffer enable
> -		 *
> -		 * These are recommended value of a datasheet
> -		 * see [USB :: EHCI internal buffer setting]
> -		 */
> -		iowrite32(0x00ff0040, (reg0 + EIIBC1));
> -		iowrite32(0x00ff0040, (reg1 + EIIBC1));
> -
> -		iowrite32(0x00000001, (reg0 + EIIBC2));
> -		iowrite32(0x00000001, (reg1 + EIIBC2));
> -
> -		/*
>  		 * Bus alignment settings
>  		 */
>  
> @@ -145,14 +128,13 @@ static void rcar_usb_phy_shutdown(struct
>  static int rcar_usb_phy_probe(struct platform_device *pdev)
>  {
>  	struct rcar_usb_phy_priv *priv;
> -	struct resource *res0, *res1;
> +	struct resource *res0;
>  	struct device *dev = &pdev->dev;
> -	void __iomem *reg0, *reg1;
> +	void __iomem *reg0;
>  	int ret;
>  
>  	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	if (!res0 || !res1) {
> +	if (!res0) {
>  		dev_err(dev, "Not enough platform resources\n");
>  		return -EINVAL;
>  	}
> @@ -164,8 +146,7 @@ static int rcar_usb_phy_probe(struct pla
>  	 * this driver can't use devm_request_and_ioremap(dev, res) here
>  	 */
>  	reg0 = devm_ioremap_nocache(dev, res0->start, resource_size(res0));
> -	reg1 = devm_ioremap_nocache(dev, res1->start, resource_size(res1));
> -	if (!reg0 || !reg1) {
> +	if (!reg0) {
>  		dev_err(dev, "ioremap error\n");
>  		return -ENOMEM;
>  	}
> @@ -177,7 +158,6 @@ static int rcar_usb_phy_probe(struct pla
>  	}
>  
>  	priv->reg0		= reg0;
> -	priv->reg1		= reg1;
>  	priv->counter		= 0;
>  	priv->phy.dev		= dev;
>  	priv->phy.label		= dev_name(dev);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
