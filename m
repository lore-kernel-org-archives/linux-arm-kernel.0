From: dianders@chromium.org (Doug Anderson)
Date: Tue, 31 May 2016 14:35:39 -0700
Subject: [PATCH 1/6] phy: Add USB Type-C PHY driver for rk3399
In-Reply-To: <1464328939-8073-2-git-send-email-zyw@rock-chips.com>
References: <1464328939-8073-1-git-send-email-zyw@rock-chips.com>
 <1464328939-8073-2-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=V1qX_YTTygsz=v+p6BdG8VZcu8np2nDvm1NiJHDnf==g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Thu, May 26, 2016 at 11:02 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> Add a PHY provider driver for the rk3399 SoC Type-c PHY. The USB
> Type-C PHY is designed to support the USB3 and DP applications. The
> PHY basically has two main components: USB3 and DisplyPort. USB3
> operates in SuperSpeed mode and the DP can operate at RBR, HBR and
> HBR2 data rates.
>
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
>
>  drivers/phy/Kconfig              |   7 +
>  drivers/phy/Makefile             |   1 +
>  drivers/phy/phy-rockchip-typec.c | 823 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 831 insertions(+)

This is a bit of a superficial review.  Hopefully we can find someone
to do something more thorough.


>  create mode 100644 drivers/phy/phy-rockchip-typec.c
>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 26566db..dc388a3d 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -351,6 +351,13 @@ config PHY_ROCKCHIP_DP
>         help
>           Enable this to support the Rockchip Display Port PHY.
>
> +config PHY_ROCKCHIP_TYPEC
> +       tristate "Rockchip TYPEC PHY Driver"
> +       depends on ARCH_ROCKCHIP && OF
> +       select GENERIC_PHY
> +       help
> +         Enable this to support the Rockchip USB TYPEC PHY.
> +
>  config PHY_ST_SPEAR1310_MIPHY
>         tristate "ST SPEAR1310-MIPHY driver"
>         select GENERIC_PHY
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 24596a9..91fa413 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -39,6 +39,7 @@ obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)   += phy-qcom-apq8064-sata.o
>  obj-$(CONFIG_PHY_ROCKCHIP_USB) += phy-rockchip-usb.o
>  obj-$(CONFIG_PHY_ROCKCHIP_EMMC) += phy-rockchip-emmc.o
>  obj-$(CONFIG_PHY_ROCKCHIP_DP)          += phy-rockchip-dp.o
> +obj-$(CONFIG_PHY_ROCKCHIP_TYPEC) += phy-rockchip-typec.o
>  obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)    += phy-qcom-ipq806x-sata.o
>  obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)   += phy-spear1310-miphy.o
>  obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)   += phy-spear1340-miphy.o
> diff --git a/drivers/phy/phy-rockchip-typec.c b/drivers/phy/phy-rockchip-typec.c
> new file mode 100644
> index 0000000..6609cfb
> --- /dev/null
> +++ b/drivers/phy/phy-rockchip-typec.c
> @@ -0,0 +1,823 @@
> +/*
> + * Rockchip usb3 PHY driver
> + *
> + * Copyright (C) 2016 Kever Yang <kever.yang@rock-chips.com>
> + *                    Chris Zhong <zyw@rock-chips.com>
> + * Copyright (C) 2016 ROCKCHIP, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>p
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/delay.h>
> +#include <linux/phy/phy-rockchip-typec.h>
> +
> +#define ADDR_ADJ                       2
> +#define CMN_SSM_BANDGAP                        (0x21 << ADDR_ADJ)
> +#define CMN_SSM_BIAS                   (0x22 << ADDR_ADJ)
> +#define CMN_PLLSM0_PLLEN               (0x29 << ADDR_ADJ)
> +#define CMN_PLLSM0_PLLPRE              (0x2a << ADDR_ADJ)
> +#define CMN_PLLSM0_PLLVREF             (0x2b << ADDR_ADJ)
> +#define CMN_PLLSM0_PLLLOCK             (0x2c << ADDR_ADJ)
> +#define CMN_PLLSM1_PLLEN               (0x31 << ADDR_ADJ)
> +#define CMN_PLLSM1_PLLPRE              (0x32 << ADDR_ADJ)
> +#define CMN_PLLSM1_PLLVREF             (0x33 << ADDR_ADJ)
> +#define CMN_PLLSM1_PLLLOCK             (0x34 << ADDR_ADJ)
> +#define CMN_PLLSM1_USER_DEF_CTRL       (0x37 << ADDR_ADJ)
> +#define CMN_ICAL_OVRD                  (0xc1 << ADDR_ADJ)
> +#define CMN_PLL0_VCOCAL_OVRD           (0x83 << ADDR_ADJ)
> +#define CMN_PLL0_VCOCAL_INIT           (0x84 << ADDR_ADJ)
> +#define CMN_PLL0_VCOCAL_ITER           (0x85 << ADDR_ADJ)
> +#define CMN_PLL0_LOCK_REFCNT_START     (0x90 << ADDR_ADJ)
> +#define CMN_PLL0_LOCK_PLLCNT_START     (0x92 << ADDR_ADJ)
> +#define CMN_PLL0_LOCK_PLLCNT_THR       (0x93 << ADDR_ADJ)
> +#define CMN_PLL0_INTDIV                        (0x94 << ADDR_ADJ)
> +#define CMN_PLL0_FRACDIV               (0x95 << ADDR_ADJ)
> +#define CMN_PLL0_HIGH_THR              (0x96 << ADDR_ADJ)
> +#define CMN_PLL0_DSM_DIAG              (0x97 << ADDR_ADJ)
> +#define CMN_PLL0_SS_CTRL1              (0x98 << ADDR_ADJ)
> +#define CMN_PLL0_SS_CTRL2              (0x99 << ADDR_ADJ)
> +#define CMN_PLL1_VCOCAL_START          (0xa1 << ADDR_ADJ)
> +#define CMN_PLL1_VCOCAL_OVRD           (0xa3 << ADDR_ADJ)
> +#define CMN_PLL1_VCOCAL_INIT           (0xa4 << ADDR_ADJ)
> +#define CMN_PLL1_VCOCAL_ITER           (0xa5 << ADDR_ADJ)
> +#define CMN_PLL1_LOCK_REFCNT_START     (0xb0 << ADDR_ADJ)
> +#define CMN_PLL1_LOCK_PLLCNT_START     (0xb2 << ADDR_ADJ)
> +#define CMN_PLL1_LOCK_PLLCNT_THR       (0xb3 << ADDR_ADJ)
> +#define CMN_PLL1_INTDIV                        (0xb4 << ADDR_ADJ)
> +#define CMN_PLL1_FRACDIV               (0xb5 << ADDR_ADJ)
> +#define CMN_PLL1_HIGH_THR              (0xb6 << ADDR_ADJ)
> +#define CMN_PLL1_DSM_DIAG              (0xb7 << ADDR_ADJ)
> +#define CMN_PLL1_SS_CTRL1              (0xb8 << ADDR_ADJ)
> +#define CMN_PLL1_SS_CTRL2              (0xb9 << ADDR_ADJ)
> +#define CMN_RXCAL_OVRD                 (0xd1 << ADDR_ADJ)
> +#define CMN_TXPUCAL_CTRL               (0xe0 << ADDR_ADJ)
> +#define CMN_TXPUCAL_OVRD               (0xe1 << ADDR_ADJ)
> +#define CMN_TXPDCAL_OVRD               (0xf1 << ADDR_ADJ)
> +#define CMN_DIAG_PLL0_FBH_OVRD         (0x1c0 << ADDR_ADJ)
> +#define CMN_DIAG_PLL0_FBL_OVRD         (0x1c1 << ADDR_ADJ)
> +#define CMN_DIAG_PLL0_OVRD             (0x1c2 << ADDR_ADJ)
> +#define CMN_DIAG_PLL0_V2I_TUNE         (0x1c5 << ADDR_ADJ)
> +#define CMN_DIAG_PLL0_CP_TUNE          (0x1c6 << ADDR_ADJ)
> +#define CMN_DIAG_PLL0_LF_PROG          (0x1c7 << ADDR_ADJ)
> +#define CMN_DIAG_PLL1_FBH_OVRD         (0x1d0 << ADDR_ADJ)
> +#define CMN_DIAG_PLL1_FBL_OVRD         (0x1d1 << ADDR_ADJ)
> +#define CMN_DIAG_PLL1_OVRD             (0x1d2 << ADDR_ADJ)
> +#define CMN_DIAG_PLL1_V2I_TUNE         (0x1d5 << ADDR_ADJ)
> +#define CMN_DIAG_PLL1_CP_TUNE          (0x1d6 << ADDR_ADJ)
> +#define CMN_DIAG_PLL1_LF_PROG          (0x1d7 << ADDR_ADJ)
> +#define CMN_DIAG_PLL1_PTATIS_TUNE1     (0x1d8 << ADDR_ADJ)
> +#define CMN_DIAG_PLL1_PTATIS_TUNE2     (0x1d9 << ADDR_ADJ)
> +#define CMN_DIAG_PLL1_INCLK_CTRL       (0x1da << ADDR_ADJ)
> +#define CMN_DIAG_HSCLK_SEL             (0x1e0 << ADDR_ADJ)
> +
> +#define XCVR_PSM_RCTRL(n)              ((0x4001 | (n << 9)) << ADDR_ADJ)
> +#define XCVR_PSM_CAL_TMR(n)            ((0x4002 | (n << 9)) << ADDR_ADJ)
> +#define XCVR_PSM_A0IN_TMR(n)           ((0x4003 | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_CAL_SCLR_MULT(n)       ((0x4047 | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_CPOST_MULT_00(n)       ((0x404c | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_CPOST_MULT_01(n)       ((0x404d | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_CPOST_MULT_10(n)       ((0x404e | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_CPOST_MULT_11(n)       ((0x404f | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_MGNFS_MULT_000(n)      ((0x4050 | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_MGNFS_MULT_001(n)      ((0x4051 | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_MGNFS_MULT_010(n)      ((0x4052 | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_MGNFS_MULT_011(n)      ((0x4053 | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_MGNFS_MULT_100(n)      ((0x4054 | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_MGNFS_MULT_101(n)      ((0x4055 | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_MGNFS_MULT_110(n)      ((0x4056 | (n << 9)) << ADDR_ADJ)
> +#define TX_TXCC_MGNFS_MULT_111(n)      ((0x4057 | (n << 9)) << ADDR_ADJ)
> +#define XCVR_DIAG_PLLDRC_CTRL(n)       ((0x40e0 | (n << 9)) << ADDR_ADJ)
> +#define XCVR_DIAG_BIDI_CTRL(n)         ((0x40e8 | (n << 9)) << ADDR_ADJ)
> +#define XCVR_DIAG_LANE_FCM_EN_MGN(n)   ((0x40f2 | (n << 9)) << ADDR_ADJ)
> +#define TX_PSC_A0(n)                   ((0x4100 | (n << 9)) << ADDR_ADJ)
> +#define TX_PSC_A1(n)                   ((0x4101 | (n << 9)) << ADDR_ADJ)
> +#define TX_PSC_A2(n)                   ((0x4102 | (n << 9)) << ADDR_ADJ)
> +#define TX_PSC_A3(n)                   ((0x4103 | (n << 9)) << ADDR_ADJ)
> +#define TX_RCVDET_CTRL(n)              ((0x4120 | (n << 9)) << ADDR_ADJ)
> +#define TX_RCVDET_EN_TMR(n)            ((0x4122 | (n << 9)) << ADDR_ADJ)
> +#define TX_RCVDET_ST_TMR(n)            ((0x4123 | (n << 9)) << ADDR_ADJ)
> +#define TX_DIAG_TX_DRV(n)              ((0x41e1 | (n << 9)) << ADDR_ADJ)
> +#define TX_DIAG_BGREF_PREDRV_DELAY     (0x41e7 << ADDR_ADJ)
> +#define TX_ANA_CTRL_REG_1              (0x5020 << ADDR_ADJ)
> +#define TX_ANA_CTRL_REG_2              (0x5021 << ADDR_ADJ)
> +#define TXDA_COEFF_CALC_CTRL           (0x5022 << ADDR_ADJ)
> +#define TX_DIG_CTRL_REG_2              (0x5024 << ADDR_ADJ)
> +#define TXDA_CYA_AUXDA_CYA             (0x5025 << ADDR_ADJ)
> +#define TX_ANA_CTRL_REG_3              (0x5026 << ADDR_ADJ)
> +#define TX_ANA_CTRL_REG_4              (0x5027 << ADDR_ADJ)
> +#define TX_ANA_CTRL_REG_5              (0x5029 << ADDR_ADJ)
> +
> +#define RX_PSC_A0(n)                   ((0x8000 | (n << 9)) << ADDR_ADJ)
> +#define RX_PSC_A1(n)                   ((0x8001 | (n << 9)) << ADDR_ADJ)
> +#define RX_PSC_A2(n)                   ((0x8002 | (n << 9)) << ADDR_ADJ)
> +#define RX_PSC_A3(n)                   ((0x8003 | (n << 9)) << ADDR_ADJ)
> +#define RX_PSC_CAL(n)                  ((0x8006 | (n << 9)) << ADDR_ADJ)
> +#define RX_PSC_RDY(n)                  ((0x8007 | (n << 9)) << ADDR_ADJ)
> +#define RX_IQPI_ILL_CAL_OVRD           (0x8023 << ADDR_ADJ)
> +#define RX_EPI_ILL_CAL_OVRD            (0x8033 << ADDR_ADJ)
> +#define RX_SDCAL0_OVRD                 (0x8041 << ADDR_ADJ)
> +#define RX_SDCAL1_OVRD                 (0x8049 << ADDR_ADJ)
> +#define RX_SLC_INIT                    (0x806d << ADDR_ADJ)
> +#define RX_SLC_RUN                     (0x806e << ADDR_ADJ)
> +#define RX_CDRLF_CNFG2                 (0x8081 << ADDR_ADJ)
> +#define RX_SIGDET_HL_FILT_TMR(n)       ((0x8090 | (n << 9)) << ADDR_ADJ)
> +#define RX_SLC_IOP0_OVRD               (0x8101 << ADDR_ADJ)
> +#define RX_SLC_IOP1_OVRD               (0x8105 << ADDR_ADJ)
> +#define RX_SLC_QOP0_OVRD               (0x8109 << ADDR_ADJ)
> +#define RX_SLC_QOP1_OVRD               (0x810d << ADDR_ADJ)
> +#define RX_SLC_EOP0_OVRD               (0x8111 << ADDR_ADJ)
> +#define RX_SLC_EOP1_OVRD               (0x8115 << ADDR_ADJ)
> +#define RX_SLC_ION0_OVRD               (0x8119 << ADDR_ADJ)
> +#define RX_SLC_ION1_OVRD               (0x811d << ADDR_ADJ)
> +#define RX_SLC_QON0_OVRD               (0x8121 << ADDR_ADJ)
> +#define RX_SLC_QON1_OVRD               (0x8125 << ADDR_ADJ)
> +#define RX_SLC_EON0_OVRD               (0x8129 << ADDR_ADJ)
> +#define RX_SLC_EON1_OVRD               (0x812d << ADDR_ADJ)
> +#define RX_SLC_IEP0_OVRD               (0x8131 << ADDR_ADJ)
> +#define RX_SLC_IEP1_OVRD               (0x8135 << ADDR_ADJ)
> +#define RX_SLC_QEP0_OVRD               (0x8139 << ADDR_ADJ)
> +#define RX_SLC_QEP1_OVRD               (0x813d << ADDR_ADJ)
> +#define RX_SLC_EEP0_OVRD               (0x8141 << ADDR_ADJ)
> +#define RX_SLC_EEP1_OVRD               (0x8145 << ADDR_ADJ)
> +#define RX_SLC_IEN0_OVRD               (0x8149 << ADDR_ADJ)
> +#define RX_SLC_IEN1_OVRD               (0x814d << ADDR_ADJ)
> +#define RX_SLC_QEN0_OVRD               (0x8151 << ADDR_ADJ)
> +#define RX_SLC_QEN1_OVRD               (0x8155 << ADDR_ADJ)
> +#define RX_SLC_EEN0_OVRD               (0x8159 << ADDR_ADJ)
> +#define RX_SLC_EEN1_OVRD               (0x815d << ADDR_ADJ)
> +#define RX_DIAG_SIGDET_TUNE(n)         ((0x81dc | (n << 9)) << ADDR_ADJ)
> +#define RX_DIAG_SC2C_DELAY             (0x81e1 << ADDR_ADJ)
> +
> +#define PMA_LANE_CFG                   (0xc000 << ADDR_ADJ)
> +#define PIPE_CMN_CTRL1                 (0xc001 << ADDR_ADJ)
> +#define PIPE_CMN_CTRL2                 (0xc002 << ADDR_ADJ)
> +#define PIPE_COM_LOCK_CFG1             (0xc003 << ADDR_ADJ)
> +#define PIPE_COM_LOCK_CFG2             (0xc004 << ADDR_ADJ)
> +#define PIPE_RCV_DET_INH               (0xc005 << ADDR_ADJ)
> +#define DP_MODE_CTL                    (0xc008 << ADDR_ADJ)
> +#define DP_CLK_CTL                     (0xc009 << ADDR_ADJ)
> +#define STS                            (0xc00F << ADDR_ADJ)
> +#define PHY_ISO_CMN_CTRL               (0xc010 << ADDR_ADJ)
> +#define PHY_DP_TX_CTL                  (0xc408 << ADDR_ADJ)
> +#define PMA_CMN_CTRL1                  (0xc800 << ADDR_ADJ)
> +#define PHY_PMA_ISO_CMN_CTRL           (0xc810 << ADDR_ADJ)
> +#define PHY_ISOLATION_CTRL             (0xc81f << ADDR_ADJ)
> +#define PHY_PMA_ISO_XCVR_CTRL(n)       ((0xcc11 | (n << 6)) << ADDR_ADJ)
> +#define PHY_PMA_ISO_LINK_MODE(n)       ((0xcc12 | (n << 6)) << ADDR_ADJ)
> +#define PHY_PMA_ISO_PWRST_CTRL(n)      ((0xcc13 | (n << 6)) << ADDR_ADJ)
> +#define PHY_PMA_ISO_TX_DATA_LO(n)      ((0xcc14 | (n << 6)) << ADDR_ADJ)
> +#define PHY_PMA_ISO_TX_DATA_HI(n)      ((0xcc15 | (n << 6)) << ADDR_ADJ)
> +#define PHY_PMA_ISO_RX_DATA_LO(n)      ((0xcc16 | (n << 6)) << ADDR_ADJ)
> +#define PHY_PMA_ISO_RX_DATA_HI(n)      ((0xcc17 | (n << 6)) << ADDR_ADJ)
> +#define TX_BIST_CTRL(n)                        ((0x4140 | (n << 9)) << ADDR_ADJ)
> +#define TX_BIST_UDDWR(n)               ((0x4141 | (n << 9)) << ADDR_ADJ)
> +
> +#define GRF_SOC_CON26                  0x6268
> +#define UPHY_DP_SEL                    BIT(3)
> +#define UPHY_DP_SEL_MASK               BIT(19)
> +#define DPTX_HDP_SEL                   (3 << 12)
> +#define DPTX_HDP_SEL_MASK              (3 << 28)
> +
> +#define PHY_MODE_SET_TIMEOUT           1000000
> +
> +#define        MODE_DISCONNECT                 1
> +#define        MODE_UFP                        2
> +#define        MODE_DFP_USBONLY                3
> +#define        MODE_DFP_DPONLY                 4
> +#define        MODE_DFP_USB3DP                 5
> +#define        MODE_DFP_USB2DP                 6
> +
> +#define PARSE_GRF_REG(TYPE) { \
> +       if (of_find_property(np, "rockchip,usb3phy_"#TYPE, &len)) { \
> +               len /= sizeof(u32);\
> +               ret = of_property_read_u32_array(np, "rockchip,usb3phy_" #TYPE,\
> +                                                array, len); \
> +               exregs->usb3phy_##TYPE = array[0]; \
> +               exregs->usb3phy_##TYPE##_shift = array[1]; \
> +               exregs->usb3phy_##TYPE##_mask = array[2]; \
> +               pr_info("%s property found %s, %x, %d, %d\n", __func__, \
> +                       "rockchip,usb3phy_"#TYPE, \
> +                       array[0], array[1], array[2]); \
> +       } else { \
> +               pr_info("%s property not found %s\n", __func__, \
> +                       "rockchip,usb3phy_" #TYPE); \
> +       } \
> +}
> +
> +struct rockchip_typec_phy *rockchip_tcphy;

Unused global?

> +
> +static void tcphy_cfg_24m(struct rockchip_typec_phy *tcphy,
> +                         unsigned int num_lanes)
> +{
> +       unsigned int i;()?
> +
> +       writel(0x830, tcphy->base + PMA_CMN_CTRL1);
> +       for (i = 0; i < num_lanes; i++) {
> +               writel(0x90, tcphy->base + XCVR_DIAG_LANE_FCM_EN_MGN(i));
> +               writel(0x960, tcphy->base + TX_RCVDET_EN_TMR(i));
> +               writel(0x30, tcphy->base + TX_RCVDET_ST_TMR(i));

Would it be too much to ask to get more details about all these magic values?

> +       }
> +}
> +
> +static void tcphy_cfg_usb_pll(struct rockchip_typec_phy *tcphy)
> +{
> +       unsigned int rdata;
> +
> +       rdata = readl(tcphy->base + CMN_DIAG_HSCLK_SEL);
> +       writel(rdata & 0xfffc, tcphy->base + CMN_DIAG_HSCLK_SEL);
> +       writel(0xf0, tcphy->base + CMN_PLL0_VCOCAL_INIT);
> +       writel(0x18, tcphy->base + CMN_PLL0_VCOCAL_ITER);
> +       writel(0xd0, tcphy->base + CMN_PLL0_INTDIV);
> +       writel(0x4a4a, tcphy->base + CMN_PLL0_FRACDIV);
> +       writel(0x34, tcphy->base + CMN_PLL0_HIGH_THR);
> +       writel(0x1ee, tcphy->base + CMN_PLL0_SS_CTRL1);
> +       writel(0x7f03, tcphy->base + CMN_PLL0_SS_CTRL2);
> +       writel(0x20, tcphy->base + CMN_PLL0_DSM_DIAG);
> +       writel(0, tcphy->base + CMN_DIAG_PLL0_OVRD);
> +       writel(0, tcphy->base + CMN_DIAG_PLL0_FBH_OVRD);
> +       writel(0, tcphy->base + CMN_DIAG_PLL0_FBL_OVRD);
> +       writel(0x7, tcphy->base + CMN_DIAG_PLL0_V2I_TUNE);
> +       writel(0x45, tcphy->base + CMN_DIAG_PLL0_CP_TUNE);
> +       writel(0x8, tcphy->base + CMN_DIAG_PLL0_LF_PROG);
> +}
> +
> +static void tcphy_cfg_dp_pll(struct rockchip_typec_phy *tcphy)
> +{
> +       unsigned int rdata;
> +
> +       writel(0x2405, tcphy->base + DP_CLK_CTL);
> +
> +       rdata = readl(tcphy->base + CMN_DIAG_HSCLK_SEL);
> +       rdata = (rdata & 0xffcf) | 0x30;
> +       writel(rdata, tcphy->base + CMN_DIAG_HSCLK_SEL);
> +       writel(0xf0, tcphy->base + CMN_PLL1_VCOCAL_INIT);
> +       writel(0x18, tcphy->base + CMN_PLL1_VCOCAL_ITER);
> +       writel(0x30b9, tcphy->base + CMN_PLL1_VCOCAL_START);
> +       writel(0x21c, tcphy->base + CMN_PLL1_INTDIV);
> +       writel(0, tcphy->base + CMN_PLL1_FRACDIV);
> +       writel(0x5, tcphy->base + CMN_PLL1_HIGH_THR);
> +       writel(0x35, tcphy->base + CMN_PLL1_SS_CTRL1);
> +       writel(0x7f1e, tcphy->base + CMN_PLL1_SS_CTRL2);
> +       writel(0x20, tcphy->base + CMN_PLL1_DSM_DIAG);
> +       writel(0, tcphy->base + CMN_PLLSM1_USER_DEF_CTRL);
> +       writel(0, tcphy->base + CMN_DIAG_PLL1_OVRD);
> +       writel(0, tcphy->base + CMN_DIAG_PLL1_FBH_OVRD);
> +       writel(0, tcphy->base + CMN_DIAG_PLL1_FBL_OVRD);
> +       writel(0x6, tcphy->base + CMN_DIAG_PLL1_V2I_TUNE);
> +       writel(0x45, tcphy->base + CMN_DIAG_PLL1_CP_TUNE);
> +       writel(0x8, tcphy->base + CMN_DIAG_PLL1_LF_PROG);
> +       writel(0x100, tcphy->base + CMN_DIAG_PLL1_PTATIS_TUNE1);
> +       writel(0x7, tcphy->base + CMN_DIAG_PLL1_PTATIS_TUNE2);
> +       writel(0x4, tcphy->base + CMN_DIAG_PLL1_INCLK_CTRL);
> +}
> +
> +static void tcphy_tx_usb_cfg_lane(struct rockchip_typec_phy *tcphy,
> +                                 unsigned int lane)
> +{
> +       writel(0x7799, tcphy->base + TX_PSC_A0(lane));
> +       writel(0x7798, tcphy->base + TX_PSC_A1(lane));
> +       writel(0x5098, tcphy->base + TX_PSC_A2(lane));
> +       writel(0x5098, tcphy->base + TX_PSC_A3(lane));
> +       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_000(lane));
> +       writel(0xbf, tcphy->base + XCVR_DIAG_BIDI_CTRL(lane));
> +}
> +
> +static void tcphy_rx_usb_cfg_lane(struct rockchip_typec_phy *tcphy,
> +                                 unsigned int lane)
> +{
> +       writel(0xa6fd, tcphy->base + RX_PSC_A0(lane));
> +       writel(0xa6fd, tcphy->base + RX_PSC_A1(lane));
> +       writel(0xa410, tcphy->base + RX_PSC_A2(lane));
> +       writel(0x2410, tcphy->base + RX_PSC_A3(lane));
> +       writel(0x23ff, tcphy->base + RX_PSC_CAL(lane));
> +       writel(0x13, tcphy->base + RX_SIGDET_HL_FILT_TMR(lane));
> +       writel(0x1004, tcphy->base + RX_DIAG_SIGDET_TUNE(lane));
> +       writel(0x2010, tcphy->base + RX_PSC_RDY(lane));
> +       writel(0xfb, tcphy->base + XCVR_DIAG_BIDI_CTRL(lane));
> +}
> +
> +static void tcphy_dp_cfg_lane(struct rockchip_typec_phy *tcphy,
> +                             unsigned int lane)
> +{
> +       unsigned int rdata;
> +
> +       writel(0xbefc, tcphy->base + XCVR_PSM_RCTRL(lane));
> +       writel(0x6799, tcphy->base + TX_PSC_A0(lane));
> +       writel(0x6798, tcphy->base + TX_PSC_A1(lane));
> +       writel(0x98, tcphy->base + TX_PSC_A2(lane));
> +       writel(0x98, tcphy->base + TX_PSC_A3(lane));
> +       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_000(lane));
> +       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_001(lane));
> +       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_010(lane));
> +       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_011(lane));
> +       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_100(lane));
> +       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_101(lane));
> +       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_110(lane));
> +       writel(0, tcphy->base + TX_TXCC_MGNFS_MULT_111(lane));
> +
> +       writel(0, tcphy->base + TX_TXCC_CPOST_MULT_10(lane));
> +       writel(0, tcphy->base + TX_TXCC_CPOST_MULT_01(lane));
> +       writel(0, tcphy->base + TX_TXCC_CPOST_MULT_00(lane));
> +       writel(0, tcphy->base + TX_TXCC_CPOST_MULT_11(lane));
> +
> +       writel(0x128, tcphy->base + TX_TXCC_CAL_SCLR_MULT(lane));
> +       writel(0x700, tcphy->base + TX_DIAG_TX_DRV(lane));
> +
> +       rdata = readl(tcphy->base + XCVR_DIAG_PLLDRC_CTRL(lane));
> +       rdata = (rdata & 0x8fff) | 0x6000;
> +       writel(rdata, tcphy->base + XCVR_DIAG_PLLDRC_CTRL(lane));
> +}
> +
> +static void tcphy_cfg_pin_assign(struct rockchip_typec_phy *tcphy)
> +{
> +       switch (tcphy->map) {
> +       case PIN_MAP_A:
> +               writel(0x19d5, tcphy->base + PMA_LANE_CFG);
> +               break;
> +       case PIN_MAP_B:
> +               writel(0x1500, tcphy->base + PMA_LANE_CFG);
> +               break;
> +       case PIN_MAP_C:
> +       case PIN_MAP_E:
> +               writel(0x51d9, tcphy->base + PMA_LANE_CFG);
> +               break;
> +       case PIN_MAP_D:
> +       case PIN_MAP_F:
> +               writel(0x5100, tcphy->base + PMA_LANE_CFG);
> +               break;
> +       };
> +}
> +
> +static void tcphy_cfg_lanes(struct rockchip_typec_phy *tcphy,
> +                           unsigned int link_cfg)
> +{
> +       unsigned int i;
> +
> +       /* PMA lane configuration DP or USB3 */
> +       for (i = 0; i < 4; i++) {
> +               if ((link_cfg >> i) & 0x1) {
> +                       tcphy_dp_cfg_lane(tcphy, i);
> +               } else {
> +                       /*
> +                        * lan0 TX and lan1 RX for USB3 Normal direction
> +                        * lan3 TX and lan2 RX for USB3 Flip direction
> +                        */
> +                       if ((i == 0) | (i == 3))
> +                               tcphy_tx_usb_cfg_lane(tcphy, i);
> +                       else
> +                               tcphy_rx_usb_cfg_lane(tcphy, i);
> +               }
> +       }
> +}
> +
> +static void tcphy_cfg_flip_set(struct rockchip_typec_phy *tcphy)
> +{
> +       regmap_write(tcphy->grf_regs,
> +                    tcphy->exregs.usb3phy_con0,
> +                    tcphy->flip | BIT(16));
> +
> +       tcphy_cfg_24m(tcphy, 0x4);
> +
> +       if (tcphy->mode == MODE_UFP ||
> +           tcphy->mode == MODE_DFP_USBONLY ||
> +           tcphy->mode == MODE_DFP_USB3DP)
> +               tcphy_cfg_usb_pll(tcphy);
> +
> +       if (tcphy->mode == MODE_DFP_DPONLY ||
> +           tcphy->mode == MODE_DFP_USB2DP ||
> +           tcphy->mode == MODE_DFP_USB3DP)
> +               tcphy_cfg_dp_pll(tcphy);
> +
> +       if (tcphy->mode == MODE_DFP_DPONLY || tcphy->mode == MODE_DFP_USB2DP)
> +               tcphy_cfg_lanes(tcphy, 0xf);
> +       else if (tcphy->flip)
> +               tcphy_cfg_lanes(tcphy, 0x3);
> +       else
> +               tcphy_cfg_lanes(tcphy, 0xc);
> +}
> +
> +static void tcphy_dp_aux_calibration(struct rockchip_typec_phy *tcphy)
> +{
> +       int rdata, rdata2, val;
> +
> +       rdata = readl(tcphy->base + TX_ANA_CTRL_REG_1);
> +       rdata2 = readl(tcphy->base + CMN_TXPUCAL_CTRL);
> +
> +       rdata = rdata & 0xdfff;
> +       writel(rdata, tcphy->base + TX_ANA_CTRL_REG_1);
> +
> +       rdata = readl(tcphy->base + TX_DIG_CTRL_REG_2);
> +       rdata = rdata & 0xffc0;
> +       rdata2 = rdata2 & 0x3f;
> +       rdata  = rdata | rdata2;
> +       writel(rdata, tcphy->base + TX_DIG_CTRL_REG_2);
> +       usleep_range(1000, 2000);

nit: this is at init time and will be run once.  Power savings of
trying to group wakeups will be minimal or none.  Last I looked
usleep_range() nearly always takes the longer of the two times unless
it happens to wake up anyway.  Make the range smaller and boot time
will be 1ms faster.  Try usleep_range(1000, 1050).

> +
> +       rdata = readl(tcphy->base + TX_ANA_CTRL_REG_1);
> +       rdata = rdata | 0x2000;
> +       writel(rdata, tcphy->base + TX_ANA_CTRL_REG_1);
> +
> +       usleep_range(150, 200);
> +
> +       writel(0, tcphy->base + PHY_DP_TX_CTL);
> +       writel(0x100, tcphy->base + TX_ANA_CTRL_REG_2);
> +       writel(0x300, tcphy->base + TX_ANA_CTRL_REG_2);
> +       writel(0, tcphy->base + TX_ANA_CTRL_REG_3);
> +       writel(0x2008, tcphy->base + TX_ANA_CTRL_REG_1);
> +       writel(0x2018, tcphy->base + TX_ANA_CTRL_REG_1);
> +       writel(0x30C, tcphy->base + TX_ANA_CTRL_REG_2);
> +       writel(0, tcphy->base + TX_ANA_CTRL_REG_5);
> +       writel(0x1001, tcphy->base + TX_ANA_CTRL_REG_4);
> +       writel(0x2098, tcphy->base + TX_ANA_CTRL_REG_1);
> +       writel(0x2198, tcphy->base + TX_ANA_CTRL_REG_1);
> +       writel(0x30d, tcphy->base + TX_ANA_CTRL_REG_2);
> +       writel(0x30f, tcphy->base + TX_ANA_CTRL_REG_2);
> +
> +       if (tcphy->flip)
> +               writel(0xa078, tcphy->base + TX_ANA_CTRL_REG_1);
> +       else
> +               writel(0xb078, tcphy->base + TX_ANA_CTRL_REG_1);
> +
> +       writel(0x303, tcphy->base + TX_ANA_CTRL_REG_2);
> +       writel(0, tcphy->base + TX_ANA_CTRL_REG_3);
> +       writel(0, tcphy->base + TX_ANA_CTRL_REG_4);
> +       writel(0, tcphy->base + TX_ANA_CTRL_REG_5);
> +       writel(4, tcphy->base + TXDA_COEFF_CALC_CTRL);
> +       writel(0, tcphy->base + TXDA_CYA_AUXDA_CYA);
> +
> +       val = readl(tcphy->base + TX_DIG_CTRL_REG_2);
> +       val |= BIT(15);
> +       writel(val, tcphy->base + TX_DIG_CTRL_REG_2);
> +}
> +
> +static void tcphy_dp_hpd(struct rockchip_typec_phy *tcphy,
> +                        u8 mode)
> +{
> +       /* force hpd */
> +       if (mode)
> +               regmap_write(tcphy->grf_regs, GRF_SOC_CON26,
> +                            DPTX_HDP_SEL_MASK | DPTX_HDP_SEL);
> +       else
> +               regmap_write(tcphy->grf_regs, GRF_SOC_CON26,
> +                            DPTX_HDP_SEL_MASK);
> +}
> +
> +static int tcphy_usb3_init(struct rockchip_typec_phy *tcphy)
> +{
> +       int timeout = 0;
> +       int ret, val;
> +
> +       /*wait TCPHY for pipe ready */
> +       while (1) {
> +               ret = regmap_read(tcphy->grf_regs,
> +                                 tcphy->exregs.usb3phy_status0, &val);
> +               val >>= tcphy->exregs.usb3phy_status0_shift;
> +               if ((val & 0x1) == 0)
> +                       break;
> +
> +               timeout++;
> +               if (timeout > 1000) {
> +                       pr_warn("%s wait pipe ready timerout!\n", __func__);
> +                       break;
> +               }
> +               usleep_range(10, 20);
> +       }
> +
> +       return 0;
> +}
> +
> +static int tcphy_dp_init(struct rockchip_typec_phy *tcphy)
> +{
> +       int ret, val;
> +
> +       ret = readx_poll_timeout(readl, tcphy->base + DP_MODE_CTL,
> +                                val, val & BIT(6), 1000, PHY_MODE_SET_TIMEOUT);
> +       if (ret < 0) {
> +               dev_err(tcphy->dev, "failed to wait TCPHY for DP ready\n");
> +               return -EBUSY;
> +       }
> +
> +       tcphy_dp_aux_calibration(tcphy);
> +
> +       if (tcphy->mode == MODE_DFP_USB3DP)
> +               writel(0xc101, tcphy->base + DP_MODE_CTL);
> +       else
> +               writel(0x0101, tcphy->base + DP_MODE_CTL);
> +
> +       ret = readx_poll_timeout(readl, tcphy->base + DP_MODE_CTL,
> +                                val, val & BIT(4), 1000, PHY_MODE_SET_TIMEOUT);
> +       if (ret < 0) {
> +               dev_err(tcphy->dev, "failed to wait TCPHY enter A0\n");
> +               return -EBUSY;
> +       }
> +
> +       return 0;
> +}
> +
> +static int tcphy_phy_init(struct rockchip_typec_phy *tcphy)
> +{
> +       int ret;
> +       int timeout = 0;
> +
> +       ret = clk_prepare_enable(tcphy->clk_core);
> +       if (ret) {
> +               dev_err(tcphy->dev, "Failed to prepare_enable core clock\n");
> +               return ret;
> +       }
> +
> +       ret = clk_prepare_enable(tcphy->clk_ref);
> +       if (ret) {
> +               dev_err(tcphy->dev, "Failed to prepare_enable ref clock\n");
> +               return ret;
> +       }
> +
> +       /* select external psm clock */
> +       regmap_write(tcphy->grf_regs, tcphy->exregs.usb3phy_con2,
> +                    BIT(14) | BIT(30));
> +       regmap_write(tcphy->grf_regs, tcphy->exregs.usb3phy_con0, BIT(19));
> +
> +       reset_control_assert(tcphy->phy_rst);
> +       reset_control_assert(tcphy->pipe_rst);
> +       reset_control_assert(tcphy->uphy_rst);
> +
> +       if (tcphy->num == TYPEC_PHY0)
> +               regmap_write(tcphy->grf_regs, GRF_SOC_CON26,
> +                            UPHY_DP_SEL_MASK);
> +       else
> +               regmap_write(tcphy->grf_regs, GRF_SOC_CON26,
> +                            UPHY_DP_SEL_MASK | UPHY_DP_SEL);
> +
> +       reset_control_deassert(tcphy->uphy_rst);
> +
> +       tcphy_cfg_flip_set(tcphy);
> +
> +       tcphy_cfg_pin_assign(tcphy);
> +
> +       if (tcphy->mode == MODE_DFP_USB3DP)
> +               writel(0xc104, tcphy->base + DP_MODE_CTL);
> +       else if ((tcphy->mode == MODE_DFP_DPONLY) ||
> +                (tcphy->mode == MODE_DFP_USB2DP))
> +               writel(0x0104, tcphy->base + DP_MODE_CTL);
> +
> +       reset_control_deassert(tcphy->phy_rst);
> +
> +       while (!(readl(tcphy->base + PMA_CMN_CTRL1) & 1)) {
> +               timeout++;
> +               if (timeout > 1000)
> +                       break;
> +               usleep_range(10, 20);
> +       }
> +
> +       reset_control_deassert(tcphy->pipe_rst);
> +
> +       return 0;
> +}
> +
> +static int tcphy_phy_deinit(struct rockchip_typec_phy *tcphy)
> +{
> +       clk_disable_unprepare(tcphy->clk_core);
> +       clk_disable_unprepare(tcphy->clk_ref);
> +
> +       return 0;
> +}
> +
> +int tcphy_register_notifier(struct phy *_phy, struct notifier_block *nb)

Is there a reason this isn't static?

> +{
> +       struct rockchip_typec_phy *tcphy = phy_get_drvdata(_phy);
> +
> +       return atomic_notifier_chain_register(&tcphy->notifier, nb);
> +}
> +
> +void tcphy_unregister_notifier(struct phy *_phy,
> +                              struct notifier_block *nb)

Is there a reason this isn't static?

> +{
> +       struct rockchip_typec_phy *tcphy = phy_get_drvdata(_phy);
> +
> +       atomic_notifier_chain_unregister(&tcphy->notifier, nb);
> +}
> +
> +void tcphy_notifier_call_chain(struct rockchip_typec_phy *x,
> +                              unsigned long val, void *v)
> +{
> +       atomic_notifier_call_chain(&x->notifier, val, v);
> +}
> +EXPORT_SYMBOL_GPL(tcphy_notifier_call_chain);
> +
> +static int tcphy_pd_event(struct notifier_block *nb,
> +                         unsigned long event, void *priv)
> +{
> +       struct rockchip_typec_phy *tcphy;
> +       int value = *(int *)priv;
> +       u8 is_dp, dfp;
> +
> +       tcphy = container_of(nb, struct rockchip_typec_phy, event_nb);
> +       if (IS_ERR_OR_NULL(tcphy)) {
> +               pr_err("initialization issue");
> +               return -1;
> +       }
> +
> +       tcphy->flip = GET_FLIP(value);
> +       dfp = GET_DFP(value);
> +       is_dp = GET_DP(value);
> +       tcphy->map = GET_PIN_MAP(value);
> +
> +       if (event == 0) {
> +               if (tcphy->mode == MODE_DISCONNECT)
> +                       return 0;
> +               tcphy->mode = MODE_DISCONNECT;
> +       } else if (is_dp) {
> +               if (tcphy->map & (PIN_MAP_B | PIN_MAP_D | PIN_MAP_F))
> +                       tcphy->mode = MODE_DFP_USB3DP;
> +               else
> +                       tcphy->mode = MODE_DFP_DPONLY;
> +       } else if (dfp) {
> +               tcphy->mode = MODE_DFP_USBONLY;
> +       } else {
> +               tcphy->mode = MODE_UFP;
> +       }
> +
> +       schedule_delayed_work_on(0, &tcphy->event_wq, 0);
> +
> +       return 0;
> +}
> +
> +static void tcphy_event_wq(struct work_struct *work)
> +{
> +       struct rockchip_typec_phy *tcphy;
> +
> +       tcphy = container_of(work, struct rockchip_typec_phy, event_wq.work);
> +       if (IS_ERR_OR_NULL(tcphy)) {
> +               pr_err("initialization issue");
> +               return;
> +       }
> +
> +       switch (tcphy->mode) {
> +       case MODE_DISCONNECT:
> +               /* phy enter low power mode */
> +               tcphy_phy_deinit(tcphy);
> +               tcphy_dp_hpd(tcphy, 0);
> +               break;
> +       case MODE_UFP:
> +               tcphy_phy_init(tcphy);
> +               tcphy_usb3_init(tcphy);
> +               tcphy_dp_hpd(tcphy, 0);
> +               break;
> +       case MODE_DFP_USBONLY:
> +               tcphy_phy_init(tcphy);
> +               tcphy_usb3_init(tcphy);
> +               tcphy_dp_hpd(tcphy, 0);
> +               break;
> +       case MODE_DFP_DPONLY:
> +       case MODE_DFP_USB2DP:
> +               tcphy_phy_init(tcphy);
> +               tcphy_dp_init(tcphy);
> +               tcphy_dp_hpd(tcphy, 1);
> +               break;
> +       case MODE_DFP_USB3DP:
> +               tcphy_phy_init(tcphy);
> +               tcphy_usb3_init(tcphy);
> +               tcphy_dp_init(tcphy);
> +               tcphy_dp_hpd(tcphy, 1);
> +               break;
> +       }
> +}
> +
> +int tcphy_parse_reg(struct rockchip_typec_phy *tcphy, struct device *dev)
> +{
> +       struct tcphy_grf_reg *exregs = &tcphy->exregs;
> +       struct device_node *np = dev->of_node;
> +       u32 len = 0, array[3];
> +       int ret = 0;
> +
> +       PARSE_GRF_REG(con0);
> +       PARSE_GRF_REG(con1);
> +       PARSE_GRF_REG(con2);
> +       PARSE_GRF_REG(status0);
> +       PARSE_GRF_REG(status1);
> +       return ret;
> +}
> +
> +static int rockchip_typec_phy_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct rockchip_typec_phy *tcphy;
> +       struct resource *res;
> +       struct phy_provider *phy_provider;
> +
> +       tcphy = devm_kzalloc(dev, sizeof(*tcphy), GFP_KERNEL);
> +       if (!tcphy)
> +               return -ENOMEM;
> +
> +       tcphy->dev = dev;
> +       platform_set_drvdata(pdev, tcphy);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       tcphy->base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(tcphy->base)) {
> +               dev_err(dev, "failed to remap phy regs\n");
> +               return PTR_ERR(tcphy->base);
> +       }
> +       tcphy->grf_regs = syscon_regmap_lookup_by_phandle(dev->of_node,
> +                                                       "rockchip,grf");
> +       if (IS_ERR(tcphy->grf_regs)) {
> +               dev_err(dev, "%s: could not find grf dt node\n", __func__);
> +               return PTR_ERR(tcphy->grf_regs);
> +       }
> +
> +       tcphy->clk_core = of_clk_get_by_name(dev->of_node, "tcpdcore");
> +       if (IS_ERR(tcphy->clk_core)) {
> +               dev_err(dev, "%s: could not get uphy core clock\n", __func__);

nit: No real need for __func__.  That's useful to add in when you
don't have a "dev" pointer and need a "pr_err" to show something that
will help the user find the right line of code.

> +               tcphy->clk_core = NULL;

So is tcpdcore optional or required?  Bindings doc says "required" and
the "dev_err" above implies required.  ...but then you don't return an
error code.  That makes it optional.  ...but then you use it
unconditional elsewhere in this file.  That makes it required.

Summary: return an error here, don't just set to NULL.

> +       }
> +
> +       tcphy->clk_ref = of_clk_get_by_name(dev->of_node, "tcpdphy_ref");
> +       if (IS_ERR(tcphy->clk_core)) {
> +               dev_err(dev, "%s: could not get uphy ref clock\n", __func__);
> +               tcphy->clk_core = NULL;

"if" test and NULL assignment are for wrong variables.

> +       }
> +
> +       tcphy->phy_rst = devm_reset_control_get(dev, "tcphy_rst");
> +       if (IS_ERR(tcphy->phy_rst)) {
> +               dev_err(dev, "no phy_rst reset control found\n");
> +               return PTR_ERR(tcphy->phy_rst);
> +       }
> +
> +       tcphy->pipe_rst = devm_reset_control_get(dev, "tcphy_pipe_rst");
> +       if (IS_ERR(tcphy->pipe_rst)) {
> +               dev_err(dev, "no pipe_rst reset control found\n");
> +               return PTR_ERR(tcphy->pipe_rst);
> +       }
> +
> +       tcphy->uphy_rst = devm_reset_control_get(dev, "uphy_tcphy_rst");
> +       if (IS_ERR(tcphy->uphy_rst)) {
> +               dev_err(dev, "no uphy_rst reset control found\n");
> +               return PTR_ERR(tcphy->uphy_rst);
> +       }
> +
> +       tcphy_parse_reg(tcphy, dev);
> +       tcphy->mode = MODE_DISCONNECT;
> +
> +       tcphy->phy = devm_phy_create(dev, NULL, NULL);
> +
> +       phy_set_drvdata(tcphy->phy, tcphy);
> +
> +       phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +       /* register notifier for PD event */
> +       ATOMIC_INIT_NOTIFIER_HEAD(&tcphy->notifier);
> +       tcphy->event_nb.notifier_call = tcphy_pd_event;
> +       INIT_DELAYED_WORK(&tcphy->event_wq, tcphy_event_wq);
> +       tcphy_register_notifier(tcphy->phy, &tcphy->event_nb);
> +
> +       return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static int rockchip_typec_phy_remove(struct platform_device *pdev)
> +{
> +       return 0;
> +}

I believe that if you've got an empty remove function you can just remove it.

...but doesn't remove need to call tcphy_unregister_notifier?


> +
> +static const struct of_device_id rockchip_typec_phy_dt_ids[] = {
> +       { .compatible = "rockchip,rk3399-typec-phy", },
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(of, rockchip_typec_phy_dt_ids);
> +
> +static struct platform_driver rockchip_typec_phy_driver = {
> +       .probe          = rockchip_typec_phy_probe,
> +       .remove         = rockchip_typec_phy_remove,
> +       .driver         = {
> +               .name   = "rockchip-typec-phy",
> +               .of_match_table = rockchip_typec_phy_dt_ids,
> +       },
> +};
> +
> +module_platform_driver(rockchip_typec_phy_driver);
> +
> +MODULE_AUTHOR("Kever Yang<kever.yang@rock-chips.com>");

nit: space before "<"

> +MODULE_AUTHOR("Chris Zhong<zyw@rock-chips.com>");
> +MODULE_DESCRIPTION("Rockchip USB TYPE-C PHY driver");
> +MODULE_LICENSE("GPL v2");
> --
> 2.6.3
>
