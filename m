From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 4 Apr 2017 18:50:17 +0530
Subject: [PATCH v2 2/2] phy: meson: add USB2 PHY support for Meson GXL and
 GXM
In-Reply-To: <CAFBinCAfO9_JfbCgHT3GmsKqoYhW-KqiT2s1f3WXRMO2LN4u_g@mail.gmail.com>
References: <20170304222231.14496-1-martin.blumenstingl@googlemail.com>
 <20170318130013.20771-1-martin.blumenstingl@googlemail.com>
 <20170318130013.20771-3-martin.blumenstingl@googlemail.com>
 <CAFBinCCBkdADVX_9g54Lz2K3oPux2TnjPuotf1pz0mu6h6phTA@mail.gmail.com>
 <82edc36e-80ae-3aa2-cd45-664b26a21e4a@ti.com>
 <CAFBinCAfO9_JfbCgHT3GmsKqoYhW-KqiT2s1f3WXRMO2LN4u_g@mail.gmail.com>
Message-ID: <1e0ab675-5d53-a56b-b12a-7f284307201f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 01 April 2017 03:07 PM, Martin Blumenstingl wrote:
> Hi Kishon,
> 
> On Wed, Mar 29, 2017 at 12:56 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Hi,
>>
>> On Wednesday 29 March 2017 03:03 AM, Martin Blumenstingl wrote:
>>> Hi Kishon,
>>>
>>> On Sat, Mar 18, 2017 at 2:00 PM, Martin Blumenstingl
>>> <martin.blumenstingl@googlemail.com> wrote:
>>>> This adds a new driver for the USB2 PHYs found on Meson GXL and GXM SoCs
>>>> (both SoCs are using the same USB PHY register layout).
>>>>
>>>> The USB2 PHY is a simple PHY which only has a few registers to configure
>>>> the mode (host/device) and a reset register (to enable/disable the PHY).
>>>>
>>>> Unfortunately there are no datasheets available for this PHY. The driver
>>>> was written by reading the code from Amlogic's GPL kernel sources and
>>>> by analyzing the registers on an actual GXL and GXM device running the
>>>> kernel that was shipped on the boards I have.
>>> gentle ping - did you have time to review this patch in v2 yet?
>>
>> Have a few comments, see below..
> thanks for taking the time to review this!
> 
>>>
>>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>> ---
>>>>  drivers/phy/Kconfig              |  14 ++
>>>>  drivers/phy/Makefile             |   1 +
>>>>  drivers/phy/phy-meson-gxl-usb2.c | 273 +++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 288 insertions(+)
>>>>  create mode 100644 drivers/phy/phy-meson-gxl-usb2.c
>>>>
>>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>>>> index dc5277ad1b5a..2573e139fd17 100644
>>>> --- a/drivers/phy/Kconfig
>>>> +++ b/drivers/phy/Kconfig
>>>> @@ -510,6 +510,19 @@ config PHY_MESON8B_USB2
>>>>           and GXBB SoCs.
>>>>           If unsure, say N.
>>>>
>>>> +config PHY_MESON_GXL_USB
>>>> +       tristate "Meson GXL and GXM USB2 PHY drivers"
>>>> +       default ARCH_MESON
>>>> +       depends on OF && (ARCH_MESON || COMPILE_TEST)
>>>> +       depends on USB_SUPPORT
>>>> +       select USB_COMMON
>>>> +       select GENERIC_PHY
>>>> +       select REGMAP_MMIO
>>>> +       help
>>>> +         Enable this to support the Meson USB2 PHYs found in Meson
>>>> +         GXL and GXM SoCs.
>>>> +         If unsure, say N.
>>>> +
>>>>  config PHY_NSP_USB3
>>>>         tristate "Broadcom NorthStar plus USB3 PHY driver"
>>>>         depends on OF && (ARCH_BCM_NSP || COMPILE_TEST)
>>>> @@ -518,4 +531,5 @@ config PHY_NSP_USB3
>>>>         help
>>>>           Enable this to support the Broadcom Northstar plus USB3 PHY.
>>>>           If unsure, say N.
>>>> +
>>
>> spurious space..
> you're right, this shouldn't be here. I'll fix this in the next version
> 
>>>>  endmenu
>>>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>>>> index e7b0feb1e125..e680b856e38e 100644
>>>> --- a/drivers/phy/Makefile
>>>> +++ b/drivers/phy/Makefile
>>>> @@ -62,4 +62,5 @@ obj-$(CONFIG_PHY_CYGNUS_PCIE)         += phy-bcm-cygnus-pcie.o
>>>>  obj-$(CONFIG_ARCH_TEGRA) += tegra/
>>>>  obj-$(CONFIG_PHY_NS2_PCIE)             += phy-bcm-ns2-pcie.o
>>>>  obj-$(CONFIG_PHY_MESON8B_USB2)         += phy-meson8b-usb2.o
>>>> +obj-$(CONFIG_PHY_MESON_GXL_USB)                += phy-meson-gxl-usb2.o
>>>>  obj-$(CONFIG_PHY_NSP_USB3)             += phy-bcm-nsp-usb3.o
>>>> diff --git a/drivers/phy/phy-meson-gxl-usb2.c b/drivers/phy/phy-meson-gxl-usb2.c
>>>> new file mode 100644
>>>> index 000000000000..4bf646a52c45
>>>> --- /dev/null
>>>> +++ b/drivers/phy/phy-meson-gxl-usb2.c
>>>> @@ -0,0 +1,273 @@
>>>> +/*
>>>> + * Meson GXL and GXM USB2 PHY driver
>>>> + *
>>>> + * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + *
>>>> + * You should have received a copy of the GNU General Public License
>>>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>>>> + */
>>>> +
>>>> +#include <linux/delay.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of_device.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/phy/phy.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/usb/of.h>
>>>> +
>>>> +/* bits [31:27] are read-only */
>>>> +#define U2P_R0                                                 0x0
>>>> +       #define U2P_R0_BYPASS_SEL                               BIT(0)
>>>> +       #define U2P_R0_BYPASS_DM_EN                             BIT(1)
>>>> +       #define U2P_R0_BYPASS_DP_EN                             BIT(2)
>>>> +       #define U2P_R0_TXBITSTUFF_ENH                           BIT(3)
>>>> +       #define U2P_R0_TXBITSTUFF_EN                            BIT(4)
>>>> +       #define U2P_R0_DM_PULLDOWN                              BIT(5)
>>>> +       #define U2P_R0_DP_PULLDOWN                              BIT(6)
>>>> +       #define U2P_R0_DP_VBUS_VLD_EXT_SEL                      BIT(7)
>>>> +       #define U2P_R0_DP_VBUS_VLD_EXT                          BIT(8)
>>>> +       #define U2P_R0_ADP_PRB_EN                               BIT(9)
>>>> +       #define U2P_R0_ADP_DISCHARGE                            BIT(10)
>>>> +       #define U2P_R0_ADP_CHARGE                               BIT(11)
>>>> +       #define U2P_R0_DRV_VBUS                                 BIT(12)
>>>> +       #define U2P_R0_ID_PULLUP                                BIT(13)
>>>> +       #define U2P_R0_LOOPBACK_EN_B                            BIT(14)
>>>> +       #define U2P_R0_OTG_DISABLE                              BIT(15)
>>>> +       #define U2P_R0_COMMON_ONN                               BIT(16)
>>>> +       #define U2P_R0_FSEL_MASK                                GENMASK(19, 17)
>>>> +       #define U2P_R0_REF_CLK_SEL_MASK                         GENMASK(21, 20)
>>>> +       #define U2P_R0_POWER_ON_RESET                           BIT(22)
>>>> +       #define U2P_R0_V_ATE_TEST_EN_B_MASK                     GENMASK(24, 23)
>>>> +       #define U2P_R0_ID_SET_ID_DQ                             BIT(25)
>>>> +       #define U2P_R0_ATE_RESET                                BIT(26)
>>>> +       #define U2P_R0_FSV_MINUS                                BIT(27)
>>>> +       #define U2P_R0_FSV_PLUS                                 BIT(28)
>>>> +       #define U2P_R0_BYPASS_DM_DATA                           BIT(29)
>>>> +       #define U2P_R0_BYPASS_DP_DATA                           BIT(30)
>>>> +
>>>> +#define U2P_R1                                                 0x4
>>>> +       #define U2P_R1_BURN_IN_TEST                             BIT(0)
>>>> +       #define U2P_R1_ACA_ENABLE                               BIT(1)
>>>> +       #define U2P_R1_DCD_ENABLE                               BIT(2)
>>>> +       #define U2P_R1_VDAT_SRC_EN_B                            BIT(3)
>>>> +       #define U2P_R1_VDAT_DET_EN_B                            BIT(4)
>>>> +       #define U2P_R1_CHARGES_SEL                              BIT(5)
>>>> +       #define U2P_R1_TX_PREEMP_PULSE_TUNE                     BIT(6)
>>>> +       #define U2P_R1_TX_PREEMP_AMP_TUNE_MASK                  GENMASK(8, 7)
>>>> +       #define U2P_R1_TX_RES_TUNE_MASK                         GENMASK(10, 9)
>>>> +       #define U2P_R1_TX_RISE_TUNE_MASK                        GENMASK(12, 11)
>>>> +       #define U2P_R1_TX_VREF_TUNE_MASK                        GENMASK(16, 13)
>>>> +       #define U2P_R1_TX_FSLS_TUNE_MASK                        GENMASK(20, 17)
>>>> +       #define U2P_R1_TX_HSXV_TUNE_MASK                        GENMASK(22, 21)
>>>> +       #define U2P_R1_OTG_TUNE_MASK                            GENMASK(25, 23)
>>>> +       #define U2P_R1_SQRX_TUNE_MASK                           GENMASK(28, 26)
>>>> +       #define U2P_R1_COMP_DIS_TUNE_MASK                       GENMASK(31, 29)
>>>> +
>>>> +/* bits [31:14] are read-only */
>>>> +#define U2P_R2                                                 0x8
>>>> +       #define U2P_R2_DATA_IN_MASK                             GENMASK(3, 0)
>>>> +       #define U2P_R2_DATA_IN_EN_MASK                          GENMASK(7, 4)
>>>> +       #define U2P_R2_ADDR_MASK                                GENMASK(11, 8)
>>>> +       #define U2P_R2_DATA_OUT_SEL                             BIT(12)
>>>> +       #define U2P_R2_CLK                                      BIT(13)
>>>> +       #define U2P_R2_DATA_OUT_MASK                            GENMASK(17, 14)
>>>> +       #define U2P_R2_ACA_PIN_RANGE_C                          BIT(18)
>>>> +       #define U2P_R2_ACA_PIN_RANGE_B                          BIT(19)
>>>> +       #define U2P_R2_ACA_PIN_RANGE_A                          BIT(20)
>>>> +       #define U2P_R2_ACA_PIN_GND                              BIT(21)
>>>> +       #define U2P_R2_ACA_PIN_FLOAT                            BIT(22)
>>>> +       #define U2P_R2_CHARGE_DETECT                            BIT(23)
>>>> +       #define U2P_R2_DEVICE_SESSION_VALID                     BIT(24)
>>>> +       #define U2P_R2_ADP_PROBE                                BIT(25)
>>>> +       #define U2P_R2_ADP_SENSE                                BIT(26)
>>>> +       #define U2P_R2_SESSION_END                              BIT(27)
>>>> +       #define U2P_R2_VBUS_VALID                               BIT(28)
>>>> +       #define U2P_R2_B_VALID                                  BIT(29)
>>>> +       #define U2P_R2_A_VALID                                  BIT(30)
>>>> +       #define U2P_R2_ID_DIG                                   BIT(31)
>>>> +
>>>> +#define U2P_R3                                                 0xc
>>>> +
>>>> +#define RESET_COMPLETE_TIME                            500
>>>> +
>>>> +struct phy_meson_gxl_usb2_priv {
>>>> +       struct regmap           *regmap;
>>>> +       enum phy_mode           mode;
>>>> +       int                     is_enabled;
>>>> +};
>>>> +
>>>> +static const struct regmap_config phy_meson_gxl_usb2_regmap_conf = {
>>>> +       .reg_bits = 8,
>>>> +       .val_bits = 32,
>>>> +       .reg_stride = 4,
>>>> +       .max_register = U2P_R3,
>>>> +};
>>>> +
>>>> +static int phy_meson_gxl_usb2_reset(struct phy *phy)
>>>> +{
>>>> +       struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
>>>> +
>>>> +       if (priv->is_enabled) {
>>>> +               /* reset the PHY and wait until settings are stabilized */
>>>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET,
>>>> +                               U2P_R0_POWER_ON_RESET);
>>>> +               udelay(RESET_COMPLETE_TIME);
>>>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET,
>>>> +                                  0);
>>>> +               udelay(RESET_COMPLETE_TIME);
>>>> +       }
>>
>> Instead of having big if condition blocks, it could be
>>         if (!priv->is_enabled)
>>                 return 0
>>
>>         the configuration when priv->is_enabled is true should go here.
> makes sense (and the code easier to read) in this case - I'll fix it
> in the next version
> 
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode)
>>>> +{
>>>> +       struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
>>>> +
>>>> +       switch (mode) {
>>>> +       case PHY_MODE_USB_HOST:
>>>> +       case PHY_MODE_USB_OTG:
>>>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DM_PULLDOWN,
>>>> +                                  U2P_R0_DM_PULLDOWN);
>>>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DP_PULLDOWN,
>>>> +                                  U2P_R0_DP_PULLDOWN);
>>>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP, 0);
>>>> +               break;
>>>> +
>>>> +       case PHY_MODE_USB_DEVICE:
>>>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DM_PULLDOWN,
>>>> +                                  0);
>>>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DP_PULLDOWN,
>>>> +                                  0);
>>>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP,
>>>> +                                  U2P_R0_ID_PULLUP);
>>>> +               break;
>>>> +
>>>> +       default:
>>>> +               return -EINVAL;
>>>> +       }
>>>> +
>>>> +       phy_meson_gxl_usb2_reset(phy);
>>>> +
>>>> +       priv->mode = mode;
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int phy_meson_gxl_usb2_power_off(struct phy *phy)
>>>> +{
>>>> +       struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
>>>> +
>>>> +       priv->is_enabled = 0;
>>>> +
>>>> +       /* power off the PHY by putting it into reset mode */
>>>> +       regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET,
>>>> +                          U2P_R0_POWER_ON_RESET);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int phy_meson_gxl_usb2_power_on(struct phy *phy)
>>>> +{
>>>> +       struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
>>>> +       int ret;
>>>> +
>>>> +       priv->is_enabled = 1;
>>>> +
>>>> +       /* power on the PHY by taking it out of reset mode */
>>>> +       regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET, 0);
>>>> +
>>>> +       ret = phy_meson_gxl_usb2_set_mode(phy, priv->mode);
>>
>> Since this is already part of phy_ops, the consumer of this phy will take care
>> of setting the mode right?
> many USB PHYs are configured through of_usb_get_dr_mode_by_phy()
> (which fetches the USB controller DT node and looks up the dr_mode
> property). this means that the driver will even work for controller
> which did not call phy_set_mode() (currently dwc2 and dwc3 are an
> example where phy_set_mode() is not called, and this driver is
> probably going to be used by both). are you fine with keeping this or
> should we instead investigate why dwc2 and dwc3 are not calling
> phy_set_mode yet?

If the driver want to set_mode of the phy, then it should be fine. But let's
remove .set_mode from phy_ops. Either the driver should set the mode by itself
or allow the consumers to set the mode but not both.
> 
>>>> +       if (ret) {
>>>> +               phy_meson_gxl_usb2_power_off(phy);
>>
>> This would mess up the reference count in phy_core, since this function is also
>> part of the phy_ops. The consumer should be responsible for powering off the phy.
> actually it shouldn't. it would cause issues if I used
> phy_power_off(phy) here, but I'm using the driver-internal callback
> here.

I didn't mean you should use phy_power_off(). I meant powering on the phy or
powering off the phy should be controlled by the consumer.
> if phy_meson_gxl_usb2_power_on() fails then phy_power_on() (from
> phy-core) prints a warnings and does not increment the internal
> ref-counter (++phy->power_count).
> so in my opinion there shouldn't be a problem

That makes sense.

Thanks
Kishon
