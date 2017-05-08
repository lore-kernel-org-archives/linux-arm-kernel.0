From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 8 May 2017 17:51:26 +0530
Subject: [PATCH v3 2/2] phy: meson: add USB2 PHY support for Meson GXL and
 GXM
In-Reply-To: <CAFBinCCWKeGZ_Eh7=6xAY3gFiaj-OZCG7R9wzoNb46+_NOn89w@mail.gmail.com>
References: <20170318130013.20771-1-martin.blumenstingl@googlemail.com>
 <20170417191142.26099-1-martin.blumenstingl@googlemail.com>
 <20170417191142.26099-3-martin.blumenstingl@googlemail.com>
 <CAFBinCCWKeGZ_Eh7=6xAY3gFiaj-OZCG7R9wzoNb46+_NOn89w@mail.gmail.com>
Message-ID: <4c311c7f-9ffd-00ab-0cc0-8e1c27caa340@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 04 May 2017 11:38 PM, Martin Blumenstingl wrote:
> Hi Kishon,
> 
> On Mon, Apr 17, 2017 at 9:11 PM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> This adds a new driver for the USB2 PHYs found on Meson GXL and GXM SoCs
>> (both SoCs are using the same USB PHY register layout).
>>
>> The USB2 PHY is a simple PHY which only has a few registers to configure
>> the mode (host/device) and a reset register (to enable/disable the PHY).
>>
>> Unfortunately there are no datasheets available for this PHY. The driver
>> was written by reading the code from Amlogic's GPL kernel sources and
>> by analyzing the registers on an actual GXL and GXM device running the
>> kernel that was shipped on the boards I have.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/phy/Kconfig              |  12 ++
>>  drivers/phy/Makefile             |   1 +
>>  drivers/phy/phy-meson-gxl-usb2.c | 261 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 274 insertions(+)
>>  create mode 100644 drivers/phy/phy-meson-gxl-usb2.c
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index 005cadb7a3f8..fada8354c0fe 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -511,4 +511,16 @@ config PHY_MESON8B_USB2
>>           and GXBB SoCs.
>>           If unsure, say N.
>>
>> +config PHY_MESON_GXL_USB
>> +       tristate "Meson GXL and GXM USB2 PHY drivers"
>> +       default ARCH_MESON
>> +       depends on OF && (ARCH_MESON || COMPILE_TEST)
>> +       depends on USB_SUPPORT
>> +       select GENERIC_PHY
>> +       select REGMAP_MMIO
>> +       help
>> +         Enable this to support the Meson USB2 PHYs found in Meson
>> +         GXL and GXM SoCs.
>> +         If unsure, say N.
>> +
>>  endmenu
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index dd8f3b5d2918..4f5ede46b0b9 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> @@ -62,3 +62,4 @@ obj-$(CONFIG_PHY_CYGNUS_PCIE)         += phy-bcm-cygnus-pcie.o
>>  obj-$(CONFIG_ARCH_TEGRA) += tegra/
>>  obj-$(CONFIG_PHY_NS2_PCIE)             += phy-bcm-ns2-pcie.o
>>  obj-$(CONFIG_PHY_MESON8B_USB2)         += phy-meson8b-usb2.o
>> +obj-$(CONFIG_PHY_MESON_GXL_USB)                += phy-meson-gxl-usb2.o
>> diff --git a/drivers/phy/phy-meson-gxl-usb2.c b/drivers/phy/phy-meson-gxl-usb2.c
>> new file mode 100644
>> index 000000000000..f5fbd3c09542
>> --- /dev/null
>> +++ b/drivers/phy/phy-meson-gxl-usb2.c
>> @@ -0,0 +1,261 @@
>> +/*
>> + * Meson GXL and GXM USB2 PHY driver
>> + *
>> + * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +
>> +/* bits [31:27] are read-only */
>> +#define U2P_R0                                                 0x0
>> +       #define U2P_R0_BYPASS_SEL                               BIT(0)
>> +       #define U2P_R0_BYPASS_DM_EN                             BIT(1)
>> +       #define U2P_R0_BYPASS_DP_EN                             BIT(2)
>> +       #define U2P_R0_TXBITSTUFF_ENH                           BIT(3)
>> +       #define U2P_R0_TXBITSTUFF_EN                            BIT(4)
>> +       #define U2P_R0_DM_PULLDOWN                              BIT(5)
>> +       #define U2P_R0_DP_PULLDOWN                              BIT(6)
>> +       #define U2P_R0_DP_VBUS_VLD_EXT_SEL                      BIT(7)
>> +       #define U2P_R0_DP_VBUS_VLD_EXT                          BIT(8)
>> +       #define U2P_R0_ADP_PRB_EN                               BIT(9)
>> +       #define U2P_R0_ADP_DISCHARGE                            BIT(10)
>> +       #define U2P_R0_ADP_CHARGE                               BIT(11)
>> +       #define U2P_R0_DRV_VBUS                                 BIT(12)
>> +       #define U2P_R0_ID_PULLUP                                BIT(13)
>> +       #define U2P_R0_LOOPBACK_EN_B                            BIT(14)
>> +       #define U2P_R0_OTG_DISABLE                              BIT(15)
>> +       #define U2P_R0_COMMON_ONN                               BIT(16)
>> +       #define U2P_R0_FSEL_MASK                                GENMASK(19, 17)
>> +       #define U2P_R0_REF_CLK_SEL_MASK                         GENMASK(21, 20)
>> +       #define U2P_R0_POWER_ON_RESET                           BIT(22)
>> +       #define U2P_R0_V_ATE_TEST_EN_B_MASK                     GENMASK(24, 23)
>> +       #define U2P_R0_ID_SET_ID_DQ                             BIT(25)
>> +       #define U2P_R0_ATE_RESET                                BIT(26)
>> +       #define U2P_R0_FSV_MINUS                                BIT(27)
>> +       #define U2P_R0_FSV_PLUS                                 BIT(28)
>> +       #define U2P_R0_BYPASS_DM_DATA                           BIT(29)
>> +       #define U2P_R0_BYPASS_DP_DATA                           BIT(30)
>> +
>> +#define U2P_R1                                                 0x4
>> +       #define U2P_R1_BURN_IN_TEST                             BIT(0)
>> +       #define U2P_R1_ACA_ENABLE                               BIT(1)
>> +       #define U2P_R1_DCD_ENABLE                               BIT(2)
>> +       #define U2P_R1_VDAT_SRC_EN_B                            BIT(3)
>> +       #define U2P_R1_VDAT_DET_EN_B                            BIT(4)
>> +       #define U2P_R1_CHARGES_SEL                              BIT(5)
>> +       #define U2P_R1_TX_PREEMP_PULSE_TUNE                     BIT(6)
>> +       #define U2P_R1_TX_PREEMP_AMP_TUNE_MASK                  GENMASK(8, 7)
>> +       #define U2P_R1_TX_RES_TUNE_MASK                         GENMASK(10, 9)
>> +       #define U2P_R1_TX_RISE_TUNE_MASK                        GENMASK(12, 11)
>> +       #define U2P_R1_TX_VREF_TUNE_MASK                        GENMASK(16, 13)
>> +       #define U2P_R1_TX_FSLS_TUNE_MASK                        GENMASK(20, 17)
>> +       #define U2P_R1_TX_HSXV_TUNE_MASK                        GENMASK(22, 21)
>> +       #define U2P_R1_OTG_TUNE_MASK                            GENMASK(25, 23)
>> +       #define U2P_R1_SQRX_TUNE_MASK                           GENMASK(28, 26)
>> +       #define U2P_R1_COMP_DIS_TUNE_MASK                       GENMASK(31, 29)
>> +
>> +/* bits [31:14] are read-only */
>> +#define U2P_R2                                                 0x8
>> +       #define U2P_R2_DATA_IN_MASK                             GENMASK(3, 0)
>> +       #define U2P_R2_DATA_IN_EN_MASK                          GENMASK(7, 4)
>> +       #define U2P_R2_ADDR_MASK                                GENMASK(11, 8)
>> +       #define U2P_R2_DATA_OUT_SEL                             BIT(12)
>> +       #define U2P_R2_CLK                                      BIT(13)
>> +       #define U2P_R2_DATA_OUT_MASK                            GENMASK(17, 14)
>> +       #define U2P_R2_ACA_PIN_RANGE_C                          BIT(18)
>> +       #define U2P_R2_ACA_PIN_RANGE_B                          BIT(19)
>> +       #define U2P_R2_ACA_PIN_RANGE_A                          BIT(20)
>> +       #define U2P_R2_ACA_PIN_GND                              BIT(21)
>> +       #define U2P_R2_ACA_PIN_FLOAT                            BIT(22)
>> +       #define U2P_R2_CHARGE_DETECT                            BIT(23)
>> +       #define U2P_R2_DEVICE_SESSION_VALID                     BIT(24)
>> +       #define U2P_R2_ADP_PROBE                                BIT(25)
>> +       #define U2P_R2_ADP_SENSE                                BIT(26)
>> +       #define U2P_R2_SESSION_END                              BIT(27)
>> +       #define U2P_R2_VBUS_VALID                               BIT(28)
>> +       #define U2P_R2_B_VALID                                  BIT(29)
>> +       #define U2P_R2_A_VALID                                  BIT(30)
>> +       #define U2P_R2_ID_DIG                                   BIT(31)
>> +
>> +#define U2P_R3                                                 0xc
>> +
>> +#define RESET_COMPLETE_TIME                            500
>> +
>> +struct phy_meson_gxl_usb2_priv {
>> +       struct regmap           *regmap;
>> +       enum phy_mode           mode;
>> +       int                     is_enabled;
>> +};
>> +
>> +static const struct regmap_config phy_meson_gxl_usb2_regmap_conf = {
>> +       .reg_bits = 8,
>> +       .val_bits = 32,
>> +       .reg_stride = 4,
>> +       .max_register = U2P_R3,
>> +};
>> +
>> +static int phy_meson_gxl_usb2_reset(struct phy *phy)
>> +{
>> +       struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
>> +
>> +       if (!priv->is_enabled)
>> +               return 0;
>> +
>> +       /* reset the PHY and wait until settings are stabilized */
>> +       regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET,
>> +                          U2P_R0_POWER_ON_RESET);
>> +       udelay(RESET_COMPLETE_TIME);
>> +       regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET, 0);
>> +       udelay(RESET_COMPLETE_TIME);
>> +
>> +       return 0;
>> +}
>> +
>> +static int phy_meson_gxl_usb2_set_mode(struct phy *phy, enum phy_mode mode)
>> +{
>> +       struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
>> +
>> +       switch (mode) {
>> +       case PHY_MODE_USB_HOST:
>> +       case PHY_MODE_USB_OTG:
>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DM_PULLDOWN,
>> +                                  U2P_R0_DM_PULLDOWN);
>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DP_PULLDOWN,
>> +                                  U2P_R0_DP_PULLDOWN);
>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP, 0);
>> +               break;
>> +
>> +       case PHY_MODE_USB_DEVICE:
>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DM_PULLDOWN,
>> +                                  0);
>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_DP_PULLDOWN,
>> +                                  0);
>> +               regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_ID_PULLUP,
>> +                                  U2P_R0_ID_PULLUP);
>> +               break;
>> +
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       phy_meson_gxl_usb2_reset(phy);
>> +
>> +       priv->mode = mode;
>> +
>> +       return 0;
>> +}
>> +
>> +static int phy_meson_gxl_usb2_power_off(struct phy *phy)
>> +{
>> +       struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
>> +
>> +       priv->is_enabled = 0;
>> +
>> +       /* power off the PHY by putting it into reset mode */
>> +       regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET,
>> +                          U2P_R0_POWER_ON_RESET);
>> +
>> +       return 0;
>> +}
>> +
>> +static int phy_meson_gxl_usb2_power_on(struct phy *phy)
>> +{
>> +       struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
>> +       int ret;
>> +
>> +       priv->is_enabled = 1;
>> +
>> +       /* power on the PHY by taking it out of reset mode */
>> +       regmap_update_bits(priv->regmap, U2P_R0, U2P_R0_POWER_ON_RESET, 0);
>> +
>> +       ret = phy_meson_gxl_usb2_set_mode(phy, priv->mode);
>> +       if (ret) {
>> +               phy_meson_gxl_usb2_power_off(phy);
>> +
>> +               dev_err(&phy->dev, "Failed to initialize PHY with mode %d\n",
>> +                       priv->mode);
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct phy_ops phy_meson_gxl_usb2_ops = {
>> +       .power_on       = phy_meson_gxl_usb2_power_on,
>> +       .power_off      = phy_meson_gxl_usb2_power_off,
>> +       .set_mode       = phy_meson_gxl_usb2_set_mode,
>> +       .reset          = phy_meson_gxl_usb2_reset,
>> +       .owner          = THIS_MODULE,
>> +};
>> +
>> +static int phy_meson_gxl_usb2_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct phy_provider *phy_provider;
>> +       struct resource *res;
>> +       struct phy_meson_gxl_usb2_priv *priv;
>> +       struct phy *phy;
>> +       void __iomem *base;
>> +
>> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       platform_set_drvdata(pdev, priv);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       base = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(base))
>> +               return PTR_ERR(base);
>> +
>> +       priv->mode = PHY_MODE_USB_HOST;
>> +
>> +       priv->regmap = devm_regmap_init_mmio(dev, base,
>> +                                            &phy_meson_gxl_usb2_regmap_conf);
>> +       if (IS_ERR(priv->regmap))
>> +               return PTR_ERR(priv->regmap);
>> +
>> +       phy = devm_phy_create(dev, NULL, &phy_meson_gxl_usb2_ops);
>> +       if (IS_ERR(phy)) {
>> +               dev_err(dev, "failed to create PHY\n");
>> +               return PTR_ERR(phy);
>> +       }
>> +
>> +       phy_set_drvdata(phy, priv);
>> +
>> +       phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +       return PTR_ERR_OR_ZERO(phy_provider);
>> +}
>> +
>> +static const struct of_device_id phy_meson_gxl_usb2_of_match[] = {
>> +       { .compatible = "amlogic,meson-gxl-usb2-phy", },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, phy_meson_gxl_usb2_of_match);
>> +
>> +static struct platform_driver phy_meson_gxl_usb2_driver = {
>> +       .probe  = phy_meson_gxl_usb2_probe,
>> +       .driver = {
>> +               .name           = "phy-meson-gxl-usb2",
>> +               .of_match_table = phy_meson_gxl_usb2_of_match,
>> +       },
>> +};
>> +module_platform_driver(phy_meson_gxl_usb2_driver);
>> +
>> +MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
>> +MODULE_DESCRIPTION("Meson GXL and GXM USB2 PHY driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.12.2
>>
> the devicetree documentation already got Rob's ACK. is there anything
> that I still need to fix? I would really like to see this getting into
> 4.13

I don't have any further comments. I'll queue this once -rc1 is tagged. Btw
Vivek Gautam has plans to change the directory structure of phy, so you might
have to resend this patch once his patch is merged.

Vivek, since phy tree is already merged to Linus, can you send your
restructuring patch asap based on linus latest?

Thanks
Kishon
