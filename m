From: julian.calaby@gmail.com (Julian Calaby)
Date: Wed, 18 May 2016 09:15:42 +1000
Subject: [linux-sunxi] Re: PATH[1/3] ARM: axp20x_usb_power.c add device
 tree configuration options for REG 30H: VBUS-IPSOUT
In-Reply-To: <671c7471-b63a-40cc-989f-6b20f00571ee@googlegroups.com>
References: <0f58d2b3-f3d3-45a3-a307-e54df26c1ab1@googlegroups.com>
 <671c7471-b63a-40cc-989f-6b20f00571ee@googlegroups.com>
Message-ID: <CAGRGNgXgfBGi6-kCQMQ4pYQ9jW-06babG2oQar8GnOmcej2Lkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ene,

On Wed, May 18, 2016 at 3:47 AM, Ene Alexandru <ene.alexandru@gmail.com> wrote:
> axp20x_usb_power.c is modified to read those parameters from the device tree
> configuration.
> if a configuration value is not found then the corresponding register value
> is not changed.
>
> also, debug messages are added, controlled by "CONFIG_POWER_SUPPLY_DEBUG" :
>
> Signed-off-by: Ene Alexandru <ene.alexandru@gmail.com>
>
>
> ---
> diff -uprN -X linux-sunxi-original/Documentation/dontdiff
> linux-sunxi-original/drivers/power/axp20x_usb_power.c
> linux-sunxi/drivers/power/axp20x_usb_power.c
> --- linux-sunxi-original/drivers/power/axp20x_usb_power.c  2016-05-09
> 16:51:44.000000000 +0200
> +++ linux-sunxi/drivers/power/axp20x_usb_power.c          2016-05-11
> 13:26:24.444681579 +0200
> @@ -41,6 +41,19 @@
>  #define AXP20X_VBUS_MON_VBUS_VALID       BIT(3)
> +/* bit defines for REG 30H: VBUS-IPSOUT Power Path Management */
> +/* VBUS VHOLD voltage limiting control  */
> +#define AXP20X_VBUS_IPSOUT_MGMT_VHOLD                       BIT(6)
> +#define AXP20X_VBUS_IPSOUT_MGMT_VHOLD_ENA  BIT(6)
> +#define AXP20X_VBUS_IPSOUT_MGMT_VHOLD_DIS    BIT(0)
> +/* VHOLD Set voltage */
> +#define AXP20X_VBUS_IPSOUT_MGMT_VHOLD_SET_MASK (BIT(5)|BIT(4)|BIT(3))
> +#define AXP20X_VBUS_IPSOUT_MGMT_VHOLD_SET_SHIFT (3)
> +/* VBUS current-limit selection */
> +#define AXP20X_VBUS_IPSOUT_MGMT_IBUS_MASK (BIT(1) | BIT(0))
> +
> +
> +

Drop the two extra empty lines here.

> struct axp20x_usb_power {
>            struct regmap *regmap;
>            struct power_supply *supply;
> @@ -164,6 +177,93 @@ static const struct power_supply_desc ax
>            .get_property = axp20x_usb_power_get_property,
> };
> +
> +static int axp20x_usb_power_read_params(const struct device_node *node,
> +                      struct axp20x_usb_power *power, struct
> platform_device *pdev)
> +{
> +          const u32 *prop;
> +          int ret;
> +
> +          /*
> +          * configurable parameters are:
> +          * register VBUS-IPSOUT
> +          * bit 6: VBUS VHOLD voltage limiting control
> +          *           0: No voltage drop limit
> +          *           1: Limit the voltage drop
> +          * bit 5-3 VHOLD Set VHOLD = [4.0+ (Bit5-3) * 0.1] V
> +          * bit 1-0 VBUS current-limit selection
> +          *           00:900mA
> +          *           01:500mA
> +          *           10:100mA
> +          *           11:no limit
> +          */
> +
> +          prop = of_get_property(node, "vhold-enable", NULL);
> +          if (prop) {
> +                      /* either 1 or 0 */
> +#ifdef DEBUG
> +                      dev_info(&pdev->dev, "set vhold-enable property to
> %d",
> +                                  !!(*prop));
> +#endif

Use dev_dbg() instead of wrapping the dev_info() calls in #ifdefs.

> +                      if (!!(*prop)) {
> +                                  ret = regmap_update_bits(power->regmap,
> +
> AXP20X_VBUS_IPSOUT_MGMT,
> +
> AXP20X_VBUS_IPSOUT_MGMT_VHOLD,
> +
> AXP20X_VBUS_IPSOUT_MGMT_VHOLD_ENA);
> +                      } else {
> +                                  ret = regmap_update_bits(power->regmap,
> +
> AXP20X_VBUS_IPSOUT_MGMT,
> +
> AXP20X_VBUS_IPSOUT_MGMT_VHOLD,
> +
> AXP20X_VBUS_IPSOUT_MGMT_VHOLD_DIS);
> +                      }
> +                      if (ret)
> +                                  return ret;
> +          } else {
> +#ifdef DEBUG
> +                      dev_info(&pdev->dev, "no vhold-enable property
> found");
> +#endif

Ditto.

> +          }
> +
> +          prop = of_get_property(node, "vhold-set", NULL);
> +          if (prop) {
> +                      /* from 0b000 to 0b111 */
> +#ifdef DEBUG
> +                      dev_info(&pdev->dev, "set vhold-set property to
> %02X",
> +                                  ((*prop)>>24));
> +#endif

Ditto.

> +                      ret = regmap_update_bits(power->regmap,
> +                                              AXP20X_VBUS_IPSOUT_MGMT,
> +
> AXP20X_VBUS_IPSOUT_MGMT_VHOLD_SET_MASK,
> +                                              ((*prop)>>24) <<
> AXP20X_VBUS_IPSOUT_MGMT_VHOLD_SET_SHIFT);
> +                      if (ret)
> +                                  return ret;
> +          } else {
> +#ifdef DEBUG
> +                      dev_info(&pdev->dev, "no vhold-set property found");
> +#endif

Ditto.

> +          }
> +
> +          prop = of_get_property(node, "ibus-limit", NULL);
> +          if (prop) {
> +                      /* from 0b0 to 0b11 */
> +#ifdef DEBUG
> +                      dev_info(&pdev->dev, "set ibus-limit property to
> %02X",
> +                                  ((*prop)>>24));
> +#endif

Ditto.

> +                      ret = regmap_update_bits(power->regmap,
> AXP20X_VBUS_IPSOUT_MGMT,
> +
> AXP20X_VBUS_IPSOUT_MGMT_IBUS_MASK,
> +                                                          ((*prop)>>24));
> +                      if (ret)
> +                                  return ret;
> +          } else {
> +#ifdef DEBUG
> +                      dev_info(&pdev->dev, "no ibus-limit property found");
> +#endif

Ditto.

> +          }
> +
> +          return 0;
> +}
> +
> static int axp20x_usb_power_probe(struct platform_device *pdev)
> {
>            struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> @@ -172,6 +272,7 @@ static int axp20x_usb_power_probe(struct
>            static const char * const irq_names[] = { "VBUS_PLUGIN",
>                        "VBUS_REMOVAL", "VBUS_VALID", "VBUS_NOT_VALID" };
>            int i, irq, ret;
> +          struct device_node *node;
>             if (!of_device_is_available(pdev->dev.of_node))
>                        return -ENODEV;
> @@ -208,6 +309,11 @@ static int axp20x_usb_power_probe(struct
>            if (IS_ERR(power->supply))
>                        return PTR_ERR(power->supply);
> +
> +          /* read DT configurations parameters, if available */
> +          for_each_compatible_node(node, NULL,
> "x-powers,axp202-usb-power-supply")
> +                                  axp20x_usb_power_read_params(node, power,
> pdev);
> +
>            /* Request irqs after registering, as irqs may trigger
> immediately */
>            for (i = 0; i < ARRAY_SIZE(irq_names); i++) {
>                        irq = platform_get_irq_byname(pdev, irq_names[i]);
> ---

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
