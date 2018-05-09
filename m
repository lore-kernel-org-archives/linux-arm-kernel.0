From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Wed, 9 May 2018 09:13:26 +0000
Subject: [PATCH 2/5] pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
In-Reply-To: <CACRpkdb-=QU74-MZxMdB6QPqMLZr97WxN80iyOoTFqXPicL75w@mail.gmail.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
 <1523440025-18077-3-git-send-email-amelie.delaunay@st.com>
 <CACRpkdb-=QU74-MZxMdB6QPqMLZr97WxN80iyOoTFqXPicL75w@mail.gmail.com>
Message-ID: <97d688a0-c0b7-dfe4-04c7-1668a08e911a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2018 02:48 PM, Linus Walleij wrote:
> On Wed, Apr 11, 2018 at 11:47 AM, Amelie Delaunay
> <amelie.delaunay@st.com> wrote:
> 
> Hi Amelie, thanks for your patch!
> 

Hi Linus, thanks for reviewing!

>> This patch adds pinctrl/GPIO driver for STMicroelectronics
>> Multi-Function eXpander (STMFX) GPIO expander.
>> STMFX is an I2C slave controller, offering up to 24 GPIOs.
>> The driver relies on generic pin config interface to configure the GPIOs.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
> This is looking very good.
> 
> The overall architecture of this patch set is excellent.
> 
> I have only one major question about whether this should be
> a MFD parent and GPIO-pinctrl-child split driver, see below.
> 
>> +config PINCTRL_STMFX
>> +       tristate "STMicroelectronics STMFX I2C GPIO expander pinctrl driver"
>> +       depends on GPIOLIB && I2C=y
>> +       select GENERIC_PINCONF
>> +       select GPIOLIB_IRQCHIP
>> +       select REGMAP_I2C
> 
> Thanks for using all the helpers, it makes the code very small and
> consistent and easy to review and maintain.
> 
>> +#include <linux/bitfield.h>
>> +#include <linux/gpio.h>
> 
> Please just use:
>   #include <linux/gpio/driver.h>
> 

OK, I'll fix it.

>> +static void stmfx_gpio_irq_toggle_trigger(struct stmfx_pinctrl *pctl,
>> +                                         unsigned int offset)
>> +{
>> +       u32 reg = get_reg(offset);
>> +       u32 mask = get_mask(offset);
>> +       int val;
>> +
>> +       if (!(pctl->irq_toggle_edge[reg] & mask))
>> +               return;
>> +
>> +       val = stmfx_gpio_get(&pctl->gpio_chip, offset);
>> +       if (val < 0)
>> +               return;
>> +
>> +       if (val) {
>> +               pctl->irq_gpi_type[reg] &= mask;
>> +               regmap_write_bits(pctl->regmap, STMFX_REG_IRQ_GPI_TYPE + reg,
>> +                                 get_mask(offset), 0);
>> +
>> +       } else {
>> +               pctl->irq_gpi_type[reg] |= mask;
>> +               regmap_write_bits(pctl->regmap, STMFX_REG_IRQ_GPI_TYPE + reg,
>> +                                 get_mask(offset), get_mask(offset));
>> +       }
>> +}
> 
> We had a bit of discussion about edge trigger emulation on the
> mailing list. Strange that these HW engineers didn't think of this,
> I thought it was widely known that double-edge trigger (not just one
> or the other) is needed in contemporary GPIO HW.
> 

Yes! Supported by the STM32L152 on which stmfx is based but not by the 
FW abstraction. So, maybe, in a future stmfx FW version...

>> +       if (!of_find_property(np, "gpio-ranges", NULL)) {
>> +               ret = gpiochip_add_pin_range(&pctl->gpio_chip,
>> +                                            dev_name(pctl->dev),
>> +                                            0, 0, pctl->pctl_desc.npins);
>> +               if (ret)
>> +                       return ret;
> 
> Do you really need to support DTBs without gpio-ranges?
> 
> I.e. can't you just print an error and exit if there is no range?
> 
> I think other drivers has this handling because of older
> DT bindings and trees drifting around.
> 

You're right, no need to support DTBs without gpio-ranges. I'll add 
gpio-ranges property under required section of stmfx bindings.

>> +static const struct regmap_config stmfx_regmap_config = {
>> +       .reg_bits = 8,
>> +       .val_bits = 8,
>> +};
> 
> This can probably be improved in the future.
> Or are there really exactly 255 registers?
> 

OK, I'll have a look to improve it.

>> +static int stmfx_probe(struct i2c_client *client,
>> +                      const struct i2c_device_id *id)
>> +{
>> +       struct device_node *np = client->dev.of_node, *child;
>> +       struct stmfx *stmfx;
>> +       int ret;
>> +
>> +       stmfx = devm_kzalloc(&client->dev, sizeof(*stmfx), GFP_KERNEL);
>> +       if (!stmfx)
>> +               return -ENOMEM;
>> +
>> +       i2c_set_clientdata(client, stmfx);
>> +
>> +       stmfx->dev = &client->dev;
>> +
>> +       stmfx->regmap = devm_regmap_init_i2c(client, &stmfx_regmap_config);
>> +       if (IS_ERR(stmfx->regmap)) {
>> +               ret = PTR_ERR(stmfx->regmap);
>> +               dev_err(stmfx->dev,
>> +                       "Failed to allocate register map: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = stmfx_chip_init(stmfx, client);
>> +       if (ret) {
>> +               if (ret == -ETIMEDOUT)
>> +                       return -EPROBE_DEFER;
>> +               return ret;
>> +       }
>> +
>> +       stmfx->irq = client->irq;
>> +       ret = stmfx_irq_init(stmfx);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for_each_available_child_of_node(np, child) {
>> +               if (of_property_read_bool(child, "gpio-controller")) {
>> +                       ret = stmfx_gpio_init(stmfx, child);
>> +                       if (ret)
>> +                               goto err;
>> +               }
>> +       }
> 
> Hm so you do not use a MFD driver for the core of the driver?
> 
> Instead this driver becomes the core driver?
> 
> I guess it is fine as long as the chip is only doing GPIO
> and pin control. If the chip has more abilities (such as PWM,
> LED...) then the core should be an MFD driver that spawns
> GPIO/pinctrl driver as a child, then this child looks up the
> regmap from the parent MFD driver.

Yes, this resumes the binding patch concerns.
stmfx chip on boards supported by Linux is only doing GPIO and pin 
control. The other abilities (IDD measurement and TouchScreen 
controller) are not used and cannot be tested with Linux for the time 
being. But if these function are used, then the core part of this driver 
(all not stmfx_gpio_/stmfx_pinctrl_/stmfx_pinconf_ prefixed functions) 
will become an MFD driver.

> 
> See for example how the simple STw481x driver does things:
> drivers/mfd/stw481x.c
> drivers/regulator/stw481x-vmmc.c
> 
> This MFD has no GPIO/pin control but it illustrates a simple
> parent/child instantiation with an MFD core driver.
> 
> It has this DTS entry:
> 
>                  stw4811 at 2d {
>                          compatible = "st,stw4811";
>                          reg = <0x2d>;
>                          vmmc_regulator: vmmc {
>                                  compatible = "st,stw481x-vmmc";
>                                  regulator-name = "VMMC";
>                                  regulator-min-microvolt = <1800000>;
>                                  regulator-max-microvolt = <3300000>;
>                          };
>                  };
> 
> The MFD driver matches and spawns the VMMC child
> then that driver mathes to the vmmc node.
> 
> Yours,
> Linus Walleij
> 

Thanks,
Amelie
