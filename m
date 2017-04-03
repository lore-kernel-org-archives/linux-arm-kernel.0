From: jon.mason@broadcom.com (Jon Mason)
Date: Sun, 2 Apr 2017 23:02:53 -0400
Subject: [PATCH] phy: bcm-ns-usb3: split all writes into reg & val pairs
In-Reply-To: <20170402165522.14058-1-zajec5@gmail.com>
References: <20170402165522.14058-1-zajec5@gmail.com>
Message-ID: <CAC3K-4rYH0Fg5HhVVtYEhdn1KdWoMx_JvvzPjJr5LopvVXd_JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 2, 2017 at 12:55 PM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
>
> So far all the PHY initialization was implemented using some totally
> magic values. There was some pattern there but it wasn't clear what is
> it about.
>
> Thanks to the patch submitted by Broadcom:
> [PATCH 5/6] phy: Add USB3 PHY support for Broadcom NSP SoC
> and the upstream "iproc-mdio" driver we now know there is a MDIO bus
> underneath with PHY(s) and their registers.
>
> It allows us to clean the driver a bit by making all these values less
> magical. The next step is switching to using a proper MDIO layer.
>
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Looks much better to me!

Acked-by: Jon Mason <jon.mason@broadcom.com>

> ---
>  drivers/phy/phy-bcm-ns-usb3.c | 69 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/phy/phy-bcm-ns-usb3.c b/drivers/phy/phy-bcm-ns-usb3.c
> index f420fa4bebfc..22b5e7047fa6 100644
> --- a/drivers/phy/phy-bcm-ns-usb3.c
> +++ b/drivers/phy/phy-bcm-ns-usb3.c
> @@ -2,6 +2,7 @@
>   * Broadcom Northstar USB 3.0 PHY Driver
>   *
>   * Copyright (C) 2016 Rafa? Mi?ecki <rafal@milecki.pl>
> + * Copyright (C) 2016 Broadcom
>   *
>   * All magic values used for initialization (and related comments) were obtained
>   * from Broadcom's SDK:
> @@ -23,6 +24,23 @@
>
>  #define BCM_NS_USB3_MII_MNG_TIMEOUT_US 1000    /* usecs */
>
> +#define BCM_NS_USB3_PHY_BASE_ADDR_REG  0x1f
> +#define BCM_NS_USB3_PHY_PLL30_BLOCK    0x8000
> +#define BCM_NS_USB3_PHY_TX_PMD_BLOCK   0x8040
> +#define BCM_NS_USB3_PHY_PIPE_BLOCK     0x8060
> +
> +/* Registers of PLL30 block */
> +#define BCM_NS_USB3_PLL_CONTROL                0x01
> +#define BCM_NS_USB3_PLLA_CONTROL0      0x0a
> +#define BCM_NS_USB3_PLLA_CONTROL1      0x0b
> +
> +/* Registers of TX PMD block */
> +#define BCM_NS_USB3_TX_PMD_CONTROL1    0x01
> +
> +/* Registers of PIPE block */
> +#define BCM_NS_USB3_LFPS_CMP           0x02
> +#define BCM_NS_USB3_LFPS_DEGLITCH      0x03
> +
>  enum bcm_ns_family {
>         BCM_NS_UNKNOWN,
>         BCM_NS_AX,
> @@ -76,8 +94,10 @@ static inline int bcm_ns_usb3_mii_mng_wait_idle(struct bcm_ns_usb3 *usb3)
>                                     usecs_to_jiffies(BCM_NS_USB3_MII_MNG_TIMEOUT_US));
>  }
>
> -static int bcm_ns_usb3_mii_mng_write32(struct bcm_ns_usb3 *usb3, u32 value)
> +static int bcm_ns_usb3_mdio_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
> +                                     u16 value)
>  {
> +       u32 tmp = 0;
>         int err;
>
>         err = bcm_ns_usb3_mii_mng_wait_idle(usb3);
> @@ -86,7 +106,11 @@ static int bcm_ns_usb3_mii_mng_write32(struct bcm_ns_usb3 *usb3, u32 value)
>                 return err;
>         }
>
> -       writel(value, usb3->ccb_mii + BCMA_CCB_MII_MNG_CMD_DATA);
> +       /* TODO: Use a proper MDIO bus layer */
> +       tmp |= 0x58020000; /* Magic value for MDIO PHY write */
> +       tmp |= reg << 18;
> +       tmp |= value;
> +       writel(tmp, usb3->ccb_mii + BCMA_CCB_MII_MNG_CMD_DATA);
>
>         return 0;
>  }
> @@ -102,21 +126,22 @@ static int bcm_ns_usb3_phy_init_ns_bx(struct bcm_ns_usb3 *usb3)
>         udelay(2);
>
>         /* USB3 PLL Block */
> -       err = bcm_ns_usb3_mii_mng_write32(usb3, 0x587e8000);
> +       err = bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PHY_BASE_ADDR_REG,
> +                                        BCM_NS_USB3_PHY_PLL30_BLOCK);
>         if (err < 0)
>                 return err;
>
>         /* Assert Ana_Pllseq start */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x58061000);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PLL_CONTROL, 0x1000);
>
>         /* Assert CML Divider ratio to 26 */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x582a6400);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PLLA_CONTROL0, 0x6400);
>
>         /* Asserting PLL Reset */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x582ec000);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PLLA_CONTROL1, 0xc000);
>
>         /* Deaaserting PLL Reset */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x582e8000);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PLLA_CONTROL1, 0x8000);
>
>         /* Waiting MII Mgt interface idle */
>         bcm_ns_usb3_mii_mng_wait_idle(usb3);
> @@ -125,22 +150,24 @@ static int bcm_ns_usb3_phy_init_ns_bx(struct bcm_ns_usb3 *usb3)
>         writel(0, usb3->dmp + BCMA_RESET_CTL);
>
>         /* PLL frequency monitor enable */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x58069000);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PLL_CONTROL, 0x9000);
>
>         /* PIPE Block */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x587e8060);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PHY_BASE_ADDR_REG,
> +                                  BCM_NS_USB3_PHY_PIPE_BLOCK);
>
>         /* CMPMAX & CMPMINTH setting */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x580af30d);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_LFPS_CMP, 0xf30d);
>
>         /* DEGLITCH MIN & MAX setting */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x580e6302);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_LFPS_DEGLITCH, 0x6302);
>
>         /* TXPMD block */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x587e8040);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PHY_BASE_ADDR_REG,
> +                                  BCM_NS_USB3_PHY_TX_PMD_BLOCK);
>
>         /* Enabling SSC */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x58061003);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_TX_PMD_CONTROL1, 0x1003);
>
>         /* Waiting MII Mgt interface idle */
>         bcm_ns_usb3_mii_mng_wait_idle(usb3);
> @@ -159,22 +186,24 @@ static int bcm_ns_usb3_phy_init_ns_ax(struct bcm_ns_usb3 *usb3)
>         udelay(2);
>
>         /* PLL30 block */
> -       err = bcm_ns_usb3_mii_mng_write32(usb3, 0x587e8000);
> +       err = bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PHY_BASE_ADDR_REG,
> +                                        BCM_NS_USB3_PHY_PLL30_BLOCK);
>         if (err < 0)
>                 return err;
>
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x582a6400);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PLLA_CONTROL0, 0x6400);
>
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x587e80e0);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PHY_BASE_ADDR_REG, 0x80e0);
>
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x580a009c);
> +       bcm_ns_usb3_mdio_phy_write(usb3, 0x02, 0x009c);
>
>         /* Enable SSC */
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x587e8040);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_PHY_BASE_ADDR_REG,
> +                                  BCM_NS_USB3_PHY_TX_PMD_BLOCK);
>
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x580a21d3);
> +       bcm_ns_usb3_mdio_phy_write(usb3, 0x02, 0x21d3);
>
> -       bcm_ns_usb3_mii_mng_write32(usb3, 0x58061003);
> +       bcm_ns_usb3_mdio_phy_write(usb3, BCM_NS_USB3_TX_PMD_CONTROL1, 0x1003);
>
>         /* Waiting MII Mgt interface idle */
>         bcm_ns_usb3_mii_mng_wait_idle(usb3);
> --
> 2.11.0
>
