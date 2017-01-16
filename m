From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 16 Jan 2017 14:41:18 +0530
Subject: [PATCH] drivers: phy: constify phy_ops structures
In-Reply-To: <1483871756-19008-1-git-send-email-bhumirks@gmail.com>
References: <1483871756-19008-1-git-send-email-bhumirks@gmail.com>
Message-ID: <587C8E36.6050703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sunday 08 January 2017 04:05 PM, Bhumika Goyal wrote:
> Declare phy_ops structures as const as they are only passed as an
> argument to the function devm_phy_create. This argument is of type const
> struct phy_ops *, so phy_ops structures having this property can be
> declared as const.
> Done using Coccinelle:

removed the rest of commit message and merged.

Thanks
Kishon

> 
> @r1 disable optional_qualifier @
> identifier i;
> position p;
> @@
> static struct phy_ops i at p = {...};
> 
> @ok1@
> identifier r1.i;
> position p;
> @@
> devm_phy_create(...,&i at p)
> 
> @bad@
> position p!={r1.p,ok1.p};
> identifier r1.i;
> @@
> i at p
> 
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct phy_ops i;
> 
> File size details:
> 
>    text	   data	    bss	    dec	    hex	filename
>    1504	    264	      0	   1768	    6e8	phy/phy-bcm-cygnus-pcie.o
>    1576	    192	      0	   1768	    6e8	phy/phy-bcm-cygnus-pcie.o
> 
>    1083	    264	      0	   1347	    543	phy/phy-hi6220-usb.o
>    1155	    192	      0	   1347	    543	phy/phy-hi6220-usb.o
> 
>    2767	    264	      0	   3031	    bd7	phy/phy-mt65xx-usb3.o
>    2829	    192	      0	   3021	    bcd	phy/phy-mt65xx-usb3.o
> 
>    2710	    304	      0	   3014	    bc6	phy/phy-rcar-gen3-usb2.o
>    2766	    240	      0	   3006	    bbe	phy/phy-rcar-gen3-usb2.o
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/phy/phy-bcm-cygnus-pcie.c | 2 +-
>  drivers/phy/phy-hi6220-usb.c      | 2 +-
>  drivers/phy/phy-mt65xx-usb3.c     | 2 +-
>  drivers/phy/phy-rcar-gen3-usb2.c  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/phy/phy-bcm-cygnus-pcie.c b/drivers/phy/phy-bcm-cygnus-pcie.c
> index 082c03f..0f4ac5d 100644
> --- a/drivers/phy/phy-bcm-cygnus-pcie.c
> +++ b/drivers/phy/phy-bcm-cygnus-pcie.c
> @@ -114,7 +114,7 @@ static int cygnus_pcie_phy_power_off(struct phy *p)
>  	return cygnus_pcie_power_config(phy, false);
>  }
>  
> -static struct phy_ops cygnus_pcie_phy_ops = {
> +static const struct phy_ops cygnus_pcie_phy_ops = {
>  	.power_on = cygnus_pcie_phy_power_on,
>  	.power_off = cygnus_pcie_phy_power_off,
>  	.owner = THIS_MODULE,
> diff --git a/drivers/phy/phy-hi6220-usb.c b/drivers/phy/phy-hi6220-usb.c
> index b2141cb..398c102 100644
> --- a/drivers/phy/phy-hi6220-usb.c
> +++ b/drivers/phy/phy-hi6220-usb.c
> @@ -112,7 +112,7 @@ static int hi6220_phy_exit(struct phy *phy)
>  	return hi6220_phy_setup(priv, false);
>  }
>  
> -static struct phy_ops hi6220_phy_ops = {
> +static const struct phy_ops hi6220_phy_ops = {
>  	.init		= hi6220_phy_start,
>  	.exit		= hi6220_phy_exit,
>  	.owner		= THIS_MODULE,
> diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
> index 4d85e73..d972067 100644
> --- a/drivers/phy/phy-mt65xx-usb3.c
> +++ b/drivers/phy/phy-mt65xx-usb3.c
> @@ -506,7 +506,7 @@ static struct phy *mt65xx_phy_xlate(struct device *dev,
>  	return instance->phy;
>  }
>  
> -static struct phy_ops mt65xx_u3phy_ops = {
> +static const struct phy_ops mt65xx_u3phy_ops = {
>  	.init		= mt65xx_phy_init,
>  	.exit		= mt65xx_phy_exit,
>  	.power_on	= mt65xx_phy_power_on,
> diff --git a/drivers/phy/phy-rcar-gen3-usb2.c b/drivers/phy/phy-rcar-gen3-usb2.c
> index c63da1b..17be045 100644
> --- a/drivers/phy/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/phy-rcar-gen3-usb2.c
> @@ -350,7 +350,7 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
>  	return ret;
>  }
>  
> -static struct phy_ops rcar_gen3_phy_usb2_ops = {
> +static const struct phy_ops rcar_gen3_phy_usb2_ops = {
>  	.init		= rcar_gen3_phy_usb2_init,
>  	.exit		= rcar_gen3_phy_usb2_exit,
>  	.power_on	= rcar_gen3_phy_usb2_power_on,
> 
