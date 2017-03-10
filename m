From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 10 Mar 2017 18:39:06 +0530
Subject: [PATCH 2/2] phy: meson: add USB2 PHY support for Meson GXL and GXM
In-Reply-To: <CAFBinCCuhMHw3V6vU7Fgb2hEnkfvBPXPFXfqfozrDN1=PnXc2w@mail.gmail.com>
References: <20170304222231.14496-1-martin.blumenstingl@googlemail.com>
 <20170304222231.14496-3-martin.blumenstingl@googlemail.com>
 <58C11204.902@ti.com>
 <CAFBinCCuhMHw3V6vU7Fgb2hEnkfvBPXPFXfqfozrDN1=PnXc2w@mail.gmail.com>
Message-ID: <58C2A572.4020907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 10 March 2017 01:14 AM, Martin Blumenstingl wrote:
> Hi Kishon,
> 
> On Thu, Mar 9, 2017 at 9:27 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Hi,
>>
>> On Sunday 05 March 2017 03:52 AM, Martin Blumenstingl wrote:
>>> This adds a new driver for the USB2 PHYs found on Meson GXL and GXM SoCs
>>> (both SoCs are using the same USB PHY register layout).
>>>
>>> The USB2 PHY is a simple PHY which only has a few registers to configure
>>> the mode (host/device) and a reset register (to enable/disable the PHY).
>>>
>>> Unfortunately there are no datasheets available for any of these PHYs.
>>> Both drivers were written by reading the reference drivers provided by
>>> Amlogic and analyzing the registers on the kernel that was shipped on
>>> the boards I have.
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> ---
>>>  drivers/phy/Kconfig              |  13 ++
>>>  drivers/phy/Makefile             |   1 +
>>>  drivers/phy/phy-meson-gxl-usb2.c | 263 +++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 277 insertions(+)
>>>  create mode 100644 drivers/phy/phy-meson-gxl-usb2.c
>>>
>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>>> index e8eb7f225a88..7d64711a837f 100644
>>> --- a/drivers/phy/Kconfig
>>> +++ b/drivers/phy/Kconfig
>>> @@ -486,4 +486,17 @@ config PHY_MESON8B_USB2
>>>         and GXBB SoCs.
>>>         If unsure, say N.
>>>
>>> +config PHY_MESON_GXL_USB
>>> +     tristate "Meson GXL and GXM USB2 PHY drivers"
>>> +     default ARCH_MESON
>>> +     depends on OF && (ARCH_MESON || COMPILE_TEST)
>>> +     depends on USB_SUPPORT
>>> +     select USB_COMMON
>>> +     select GENERIC_PHY
>>> +     select REGMAP_MMIO
>>> +     help
>>> +       Enable this to support the Meson USB2 PHYs found in Meson
>>> +       GXL and GXM SoCs.
>>> +       If unsure, say N.
>>> +
>>>  endmenu
>>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>>> index 65eb2f436a41..a3a2c7dd5c06 100644
>>> --- a/drivers/phy/Makefile
>>> +++ b/drivers/phy/Makefile
>>> @@ -59,3 +59,4 @@ obj-$(CONFIG_PHY_CYGNUS_PCIE)               += phy-bcm-cygnus-pcie.o
>>>  obj-$(CONFIG_ARCH_TEGRA) += tegra/
>>>  obj-$(CONFIG_PHY_NS2_PCIE)           += phy-bcm-ns2-pcie.o
>>>  obj-$(CONFIG_PHY_MESON8B_USB2)               += phy-meson8b-usb2.o
>>> +obj-$(CONFIG_PHY_MESON_GXL_USB)              += phy-meson-gxl-usb2.o
>>> diff --git a/drivers/phy/phy-meson-gxl-usb2.c b/drivers/phy/phy-meson-gxl-usb2.c
>>> new file mode 100644
>>> index 000000000000..841a6d9722d4
>>> --- /dev/null
>>> +++ b/drivers/phy/phy-meson-gxl-usb2.c
>>> @@ -0,0 +1,263 @@
>>> +/*
>>> + * Meson GXL and GXM USB2 PHY driver
>>> + *
>>> + * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/regmap.h>
>>> +#include <linux/phy/phy.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/usb/of.h>
>>> +
>>> +/* bits [31:27] are read-only */
>>> +#define U2P_R0                                                       0x0
>>> +     #define U2P_R0_BYPASS_SEL                               BIT(0)
>>> +     #define U2P_R0_BYPASS_DM_EN                             BIT(1)
>>> +     #define U2P_R0_BYPASS_DP_EN                             BIT(2)
>>> +     #define U2P_R0_TXBITSTUFF_ENH                           BIT(3)
>>> +     #define U2P_R0_TXBITSTUFF_EN                            BIT(4)
>>> +     #define U2P_R0_DM_PULLDOWN                              BIT(5)
>>> +     #define U2P_R0_DP_PULLDOWN                              BIT(6)
>>> +     #define U2P_R0_DP_VBUS_VLD_EXT_SEL                      BIT(7)
>>> +     #define U2P_R0_DP_VBUS_VLD_EXT                          BIT(8)
>>> +     #define U2P_R0_ADP_PRB_EN                               BIT(9)
>>> +     #define U2P_R0_ADP_DISCHARGE                            BIT(10)
>>> +     #define U2P_R0_ADP_CHARGE                               BIT(11)
>>> +     #define U2P_R0_DRV_VBUS                                 BIT(12)
>>> +     #define U2P_R0_ID_PULLUP                                BIT(13)
>>> +     #define U2P_R0_LOOPBACK_EN_B                            BIT(14)
>>> +     #define U2P_R0_OTG_DISABLE                              BIT(15)
>>> +     #define U2P_R0_COMMON_ONN                               BIT(16)
>>> +     #define U2P_R0_FSEL_MASK                                GENMASK(19, 17)
>>> +     #define U2P_R0_REF_CLK_SEL_MASK                         GENMASK(21, 20)
>>> +     #define U2P_R0_POWER_ON_RESET                           BIT(22)
>>> +     #define U2P_R0_V_ATE_TEST_EN_B_MASK                     GENMASK(24, 23)
>>> +     #define U2P_R0_ID_SET_ID_DQ                             BIT(25)
>>> +     #define U2P_R0_ATE_RESET                                BIT(26)
>>> +     #define U2P_R0_FSV_MINUS                                BIT(27)
>>> +     #define U2P_R0_FSV_PLUS                                 BIT(28)
>>> +     #define U2P_R0_BYPASS_DM_DATA                           BIT(29)
>>> +     #define U2P_R0_BYPASS_DP_DATA                           BIT(30)
>>> +
>>> +#define U2P_R1                                                       0x4
>>> +     #define U2P_R1_BURN_IN_TEST                             BIT(0)
>>> +     #define U2P_R1_ACA_ENABLE                               BIT(1)
>>> +     #define U2P_R1_DCD_ENABLE                               BIT(2)
>>> +     #define U2P_R1_VDAT_SRC_EN_B                            BIT(3)
>>> +     #define U2P_R1_VDAT_DET_EN_B                            BIT(4)
>>> +     #define U2P_R1_CHARGES_SEL                              BIT(5)
>>> +     #define U2P_R1_TX_PREEMP_PULSE_TUNE                     BIT(6)
>>> +     #define U2P_R1_TX_PREEMP_AMP_TUNE_MASK                  GENMASK(8, 7)
>>> +     #define U2P_R1_TX_RES_TUNE_MASK                         GENMASK(10, 9)
>>> +     #define U2P_R1_TX_RISE_TUNE_MASK                        GENMASK(12, 11)
>>> +     #define U2P_R1_TX_VREF_TUNE_MASK                        GENMASK(16, 13)
>>> +     #define U2P_R1_TX_FSLS_TUNE_MASK                        GENMASK(20, 17)
>>> +     #define U2P_R1_TX_HSXV_TUNE_MASK                        GENMASK(22, 21)
>>> +     #define U2P_R1_OTG_TUNE_MASK                            GENMASK(25, 23)
>>> +     #define U2P_R1_SQRX_TUNE_MASK                           GENMASK(28, 26)
>>> +     #define U2P_R1_COMP_DIS_TUNE_MASK                       GENMASK(31, 29)
>>> +
>>> +/* bits [31:14] are read-only */
>>> +#define U2P_R2                                                       0x8
>>> +     #define U2P_R2_DATA_IN_MASK                             GENMASK(3, 0)
>>> +     #define U2P_R2_DATA_IN_EN_MASK                          GENMASK(7, 4)
>>> +     #define U2P_R2_ADDR_MASK                                GENMASK(11, 8)
>>> +     #define U2P_R2_DATA_OUT_SEL                             BIT(12)
>>> +     #define U2P_R2_CLK                                      BIT(13)
>>> +     #define U2P_R2_DATA_OUT_MASK                            GENMASK(17, 14)
>>> +     #define U2P_R2_ACA_PIN_RANGE_C                          BIT(18)
>>> +     #define U2P_R2_ACA_PIN_RANGE_B                          BIT(19)
>>> +     #define U2P_R2_ACA_PIN_RANGE_A                          BIT(20)
>>> +     #define U2P_R2_ACA_PIN_GND                              BIT(21)
>>> +     #define U2P_R2_ACA_PIN_FLOAT                            BIT(22)
>>> +     #define U2P_R2_CHARGE_DETECT                            BIT(23)
>>> +     #define U2P_R2_DEVICE_SESSION_VALID                     BIT(24)
>>> +     #define U2P_R2_ADP_PROBE                                BIT(25)
>>> +     #define U2P_R2_ADP_SENSE                                BIT(26)
>>> +     #define U2P_R2_SESSION_END                              BIT(27)
>>> +     #define U2P_R2_VBUS_VALID                               BIT(28)
>>> +     #define U2P_R2_B_VALID                                  BIT(29)
>>> +     #define U2P_R2_A_VALID                                  BIT(30)
>>> +     #define U2P_R2_ID_DIG                                   BIT(31)
>>> +
>>> +#define U2P_R3                                                       0xc
>>> +
>>> +#define RESET_COMPLETE_TIME                          500
>>> +
>>> +struct phy_meson_gxl_usb2_priv {
>>> +     struct regmap           *regmap;
>>> +     enum phy_mode           mode;
>>> +     int                     is_enabled;
>>> +};
>>> +
>>> +static const struct regmap_config phy_meson_gxl_usb2_regmap_conf = {
>>> +     .reg_bits = 8,
>>> +     .val_bits = 32,
>>> +     .reg_stride = 4,
>>> +     .max_register = U2P_R3,
>>> +};
>>> +
>>> +static int phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode)
>>> +{
>>> +     struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
>>> +
>>> +     switch (mode) {
>>> +     case PHY_MODE_USB_HOST:
>>> +     case PHY_MODE_USB_OTG:
>>> +             regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DM_PULLDOWN,
>>> +                                U2P_R0_DM_PULLDOWN);
>>> +             regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DP_PULLDOWN,
>>> +                                U2P_R0_DP_PULLDOWN);
>>> +             regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP, 0);
>>> +             break;
>>> +
>>> +     case PHY_MODE_USB_DEVICE:
>>> +             regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DM_PULLDOWN,
>>> +                                0);
>>> +             regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DP_PULLDOWN,
>>> +                                0);
>>> +             regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP,
>>> +                                U2P_R0_ID_PULLUP);
>>> +             break;
>>> +
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     if (priv->is_enabled) {
>>
>> Should set_mode be always called after power_on? or reset of phy should be done
>> if set_mode is called after power_on?
>>
>> Either case I think it's better to move this reset in phy reset ops and invoke
>> it from this phys users.
> unfortunately I can only guess (change code -> boot kernel with
> changed code -> human testing) here as there's no public datasheet.
> however, the "consumer" of this PHY will be quite generic: it'll be
> powered on by the xhci-plat driver (or some utility around that). that
> might be a bit of a problem: it would mean that we have to decide when
> to call phy_reset (before or after phy_power_on/phy_set_mode) and
> define this once for all PHYs that are passed to xhci-plat.
> what do you think Kishon?

I would have preferred to call phy_reset. But since it has to be called from
xhci-plat which might affect other platforms too, I would prefer not to cause
any regressions. So that's fine.

Thanks
Kishon
