From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Jan 2015 02:38:15 +0100
Subject: [PATCH 2/2] leds: tlc59116: Driver for the TI 16 Channel i2c LED
 driver
In-Reply-To: <CAK5ve-KLkP9kF4vEC655zyR1za8xYyLjT5pO67qxr2YAdk58cg@mail.gmail.com>
References: <1420763178-10115-1-git-send-email-andrew@lunn.ch>
 <1420763178-10115-3-git-send-email-andrew@lunn.ch>
 <CAK5ve-KLkP9kF4vEC655zyR1za8xYyLjT5pO67qxr2YAdk58cg@mail.gmail.com>
Message-ID: <20150109013815.GB10191@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +static int
> > +tlc59116_set_mode(struct regmap *regmap, uint8_t mode)
> 
> Why not just us u8 instead of uint8_t?

It is what the Belkin driver did. I can change this.

> 
> > +{
> > +       uint8_t val = 0;
> > +
> > +       if ((mode != MODE2_DIM) && (mode != MODE2_BLINK))
> > +               mode = MODE2_DIM;
> > +
> > +       /* Configure MODE1 register */
> > +       val &= 0x0;
> You don't need this, since val = 0 from beginning.
> 
> > +       val &= MODE1_RESPON_ADDR_MASK;
> > +       val |= MODE1_NORMAL_MODE;
> > +       regmap_write(regmap, TLC59116_REG_MODE1, val);
> > +
> Need we check the return status of regmap_write()?

I will do that.

Thanks for the feedback

       Andrew

> > +       /* Configure MODE2 Reg */
> > +       val &= 0x00;
> > +       val |= MODE2_OCH_STOP;
> > +
> > +       val |= mode;
> > +
> > +       regmap_write(regmap, TLC59116_REG_MODE2, val);
> > +
> > +       return 0;
> > +}
> > +
> > +static int
> > +tlc59116_set_led(struct tlc59116_led *led, uint8_t val)
> > +{
> > +       struct regmap *regmap = led->regmap;
> > +       int i = (led->led_no % 4) * 2;
> > +       char addr = TLC59116_REG_LEDOUT(led->led_no);
> > +       unsigned int mask = LED_MASK << i;
> > +
> > +       val = val << i;
> > +
> > +       return regmap_update_bits(regmap, addr, mask, val);
> > +}
> > +
> > +static void
> > +tlc59116_led_work(struct work_struct *work)
> > +{
> > +       struct tlc59116_led *led = work_to_led(work);
> > +       struct regmap *regmap = led->regmap;
> > +       uint8_t pwm;
> > +
> > +       pwm = TLC59116_REG_PWM(led->led_no);
> > +       regmap_write(regmap, pwm, led->ldev.brightness);
> > +}
> > +
> > +static void
> > +tlc59116_led_set(struct led_classdev *led_cdev, enum led_brightness value)
> > +{
> > +       struct tlc59116_led *led = ldev_to_led(led_cdev);
> > +
> > +       led->ldev.brightness = value;
> > +       schedule_work(&led->work);
> > +}
> > +
> > +static void
> > +tlc59116_destroy_devices(struct tlc59116_priv *priv, int i)
> > +{
> > +       while (--i >= 0) {
> > +               if (priv->leds[i].active) {
> > +                       led_classdev_unregister(&priv->leds[i].ldev);
> > +                       cancel_work_sync(&priv->leds[i].work);
> > +               }
> > +       }
> > +}
> > +
> > +static int
> > +tlc59116_configure(struct device *dev,
> > +                  struct tlc59116_priv *priv,
> > +                  struct regmap *regmap)
> > +{
> > +       int i, err = 0;
> > +
> > +       tlc59116_set_mode(regmap, MODE2_DIM);
> > +       for (i = 0; i < TLC59116_LEDS; i++) {
> > +               struct tlc59116_led *led = &priv->leds[i];
> > +
> > +               if (!led->active)
> > +                       continue;
> > +
> > +               led->regmap = regmap;
> > +               led->led_no = i;
> > +               led->ldev.brightness_set = tlc59116_led_set;
> > +               led->ldev.max_brightness = LED_FULL;
> > +               INIT_WORK(&led->work, tlc59116_led_work);
> > +               err = led_classdev_register(dev, &led->ldev);
> > +               if (err < 0) {
> > +                       dev_err(dev, "couldn't register LED %s\n",
> > +                               led->ldev.name);
> > +                       goto exit;
> > +               }
> > +               tlc59116_set_led(led, TLC59116_DIM);
> > +       }
> > +
> > +       return 0;
> > +
> > +exit:
> > +       tlc59116_destroy_devices(priv, i);
> > +       return err;
> > +}
> > +
> > +static const struct regmap_config tlc59116_regmap = {
> > +       .reg_bits = 8,
> > +       .val_bits = 8,
> > +       .max_register = 0x1e,
> > +};
> > +
> > +static int
> > +tlc59116_probe(struct i2c_client *client,
> > +              const struct i2c_device_id *id)
> > +{
> > +       struct tlc59116_priv *priv = i2c_get_clientdata(client);
> > +       struct device *dev = &client->dev;
> > +       struct device_node *np = client->dev.of_node, *child;
> > +       struct regmap *regmap;
> > +       int err, count, reg;
> > +
> > +       count = of_get_child_count(np);
> > +       if (!count || count > TLC59116_LEDS)
> > +               return -EINVAL;
> > +
> > +       if (!i2c_check_functionality(client->adapter,
> > +               I2C_FUNC_SMBUS_BYTE_DATA))
> > +               return -EIO;
> > +
> > +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +       if (!priv)
> > +               return -ENOMEM;
> > +
> > +       regmap = devm_regmap_init_i2c(client, &tlc59116_regmap);
> > +       if (IS_ERR(regmap)) {
> > +               err = PTR_ERR(regmap);
> > +               dev_err(dev, "Failed to allocate register map: %d\n", err);
> > +               return err;
> > +       }
> > +
> > +       i2c_set_clientdata(client, priv);
> > +
> > +       for_each_child_of_node(np, child) {
> > +               err = of_property_read_u32(child, "reg", &reg);
> > +               if (err)
> > +                       return err;
> > +               if (reg < 0 || reg >= TLC59116_LEDS)
> > +                       return -EINVAL;
> > +               if (priv->leds[reg].active)
> > +                       return -EINVAL;
> > +               priv->leds[reg].active = true;
> > +               priv->leds[reg].ldev.name =
> > +                       of_get_property(child, "label", NULL) ? : child->name;
> > +               priv->leds[reg].ldev.default_trigger =
> > +                       of_get_property(child, "linux,default-trigger", NULL);
> > +       }
> > +       return tlc59116_configure(dev, priv, regmap);
> > +}
> > +
> > +static int
> > +tlc59116_remove(struct i2c_client *client)
> > +{
> > +       struct tlc59116_priv *priv = i2c_get_clientdata(client);
> > +
> > +       tlc59116_destroy_devices(priv, TLC59116_LEDS);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct of_device_id of_tlc59116_leds_match[] = {
> > +       { .compatible = "ti,tlc59116", },
> > +       {},
> > +};
> > +
> > +static const struct i2c_device_id tlc59116_id[] = {
> > +       { "tlc59116" },
> > +       {},
> > +};
> > +MODULE_DEVICE_TABLE(i2c, tlc59116_id);
> > +
> > +static struct i2c_driver tlc59116_driver = {
> > +       .driver = {
> > +               .name = "tlc59116",
> > +               .of_match_table = of_match_ptr(of_tlc59116_leds_match),
> > +
> > +       },
> > +       .probe = tlc59116_probe,
> > +       .remove = tlc59116_remove,
> > +       .id_table = tlc59116_id,
> > +};
> > +
> > +module_i2c_driver(tlc59116_driver);
> > +
> > +MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("TLC59116 LED driver");
> > --
> > 2.1.3
> >
