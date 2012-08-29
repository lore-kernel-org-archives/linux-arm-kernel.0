From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 29 Aug 2012 09:41:31 +0200
Subject: [PATCH v2] gpio: samsung: add devicetree init for s3c24xx arches
In-Reply-To: <503D4FB1.1020206@samsung.com>
References: <201208282355.44268.heiko@sntech.de> <503D4FB1.1020206@samsung.com>
Message-ID: <201208290941.32071.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 29. August 2012, 01:09:37 schrieb Kukjin Kim:
> On 08/28/12 14:55, Heiko St?bner wrote:
> > Until now the Exynos-SoC was the only Samsung-SoC supporting the GPIOs
> > via the device tree. This patch implements dt-support for the
> > s3c24xx arches.
> > 
> > The controllers contain only 3 cells, as the underlying gpio controller
> > does not support controlling the drive strength on a gpio level.
> > 
> > Tested with the gpio-keys driver on a s3c2416 based machine.
> > 
> > Signed-off-by: Heiko Stuebner<heiko@sntech.de>
> > Reviewed-by: Thomas Abraham<thomas.abraham@linaro.org>
> 
> Yeah, looks good to me...
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> BTW, I'm not sure when we can support device tree for S3C24XX :-)

As you might've guessed, I'm working on it :-) .

Thanks to some engineers of yours at least the s3c2416/s3c2450 SoCs share a 
lot of components with all the newer ones and their drivers already contain 
the dt bindings - mostly thanks to Thomas I think.

So the only real hard part I need to figure out for now is, how to implement 
the interrupt bindings. Then I'll already have sdhci, rtc, watchdog, serial 
and i2c available.

And if I also manage to get the dma into dt, I'll also have the s3c64xx-spi 
available.

So, all in all, this does sound solvable :-)


Heiko


> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> > ---
> > changes since v1:
> > update bindings documentation to address SoC specific issues
> > 
> >   .../devicetree/bindings/gpio/gpio-samsung.txt      |   43 +++++++++++++
> >   drivers/gpio/gpio-samsung.c                        |   63
> >   ++++++++++++++++++++ 2 files changed, 106 insertions(+), 0
> >   deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
> > b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt index
> > 5375625..f1e5dfe 100644
> > --- a/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-samsung.txt
> > 
> > @@ -39,3 +39,46 @@ Example:
> >   		#gpio-cells =<4>;
> >   		gpio-controller;
> >   	
> >   	};
> > 
> > +
> > +
> > +Samsung S3C24XX GPIO Controller
> > +
> > +Required properties:
> > +- compatible: Compatible property value should be
> > "samsung,s3c24xx-gpio". +
> > +- reg: Physical base address of the controller and length of memory
> > mapped +  region.
> > +
> > +- #gpio-cells: Should be 3. The syntax of the gpio specifier used by
> > client nodes +  should be the following with values derived from the SoC
> > user manual. +<[phandle of the gpio controller node]
> > +      [pin number within the gpio controller]
> > +      [mux function]
> > +      [flags and pull up/down]
> > +
> > +  Values for gpio specifier:
> > +  - Pin number: depending on the controller a number from 0 up to 15.
> > +  - Mux function: Depending on the SoC and the gpio bank the gpio can be
> > set +                  as input, output or a special function
> > +  - Flags and Pull Up/Down: the values to use differ for the individual
> > SoCs +                    example S3C2416/S3C2450:
> > +                            0 - Pull Up/Down Disabled.
> > +                            1 - Pull Down Enabled.
> > +                            2 - Pull Up Enabled.
> > +          Bit 16 (0x00010000) - Input is active low.
> > +  Consult the user manual for the correct values of Mux and Pull
> > Up/Down. +
> > +- gpio-controller: Specifies that the node is a gpio controller.
> > +- #address-cells: should be 1.
> > +- #size-cells: should be 1.
> > +
> > +Example:
> > +
> > +	gpa: gpio-controller at 56000000 {
> > +		#address-cells =<1>;
> > +		#size-cells =<1>;
> > +		compatible = "samsung,s3c24xx-gpio";
> > +		reg =<0x56000000 0x10>;
> > +		#gpio-cells =<3>;
> > +		gpio-controller;
> > +	};
> > diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
> > index ba126cc..54f6663 100644
> > --- a/drivers/gpio/gpio-samsung.c
> > +++ b/drivers/gpio/gpio-samsung.c
> > @@ -938,6 +938,67 @@ static void __init samsung_gpiolib_add(struct
> > samsung_gpio_chip *chip)
> > 
> >   		s3c_gpiolib_track(chip);
> >   
> >   }
> > 
> > +#if defined(CONFIG_PLAT_S3C24XX)&&  defined(CONFIG_OF)
> > +static int s3c24xx_gpio_xlate(struct gpio_chip *gc,
> > +			const struct of_phandle_args *gpiospec, u32 *flags)
> > +{
> > +	unsigned int pin;
> > +
> > +	if (WARN_ON(gc->of_gpio_n_cells<  3))
> > +		return -EINVAL;
> > +
> > +	if (WARN_ON(gpiospec->args_count<  gc->of_gpio_n_cells))
> > +		return -EINVAL;
> > +
> > +	if (gpiospec->args[0]>  gc->ngpio)
> > +		return -EINVAL;
> > +
> > +	pin = gc->base + gpiospec->args[0];
> > +
> > +	if (s3c_gpio_cfgpin(pin, S3C_GPIO_SFN(gpiospec->args[1])))
> > +		pr_warn("gpio_xlate: failed to set pin function\n");
> > +	if (s3c_gpio_setpull(pin, gpiospec->args[2]&  0xffff))
> > +		pr_warn("gpio_xlate: failed to set pin pull up/down\n");
> > +
> > +	if (flags)
> > +		*flags = gpiospec->args[2]>>  16;
> > +
> > +	return gpiospec->args[0];
> > +}
> > +
> > +static const struct of_device_id s3c24xx_gpio_dt_match[] __initdata = {
> > +	{ .compatible = "samsung,s3c24xx-gpio", },
> > +	{}
> > +};
> > +
> > +static __init void s3c24xx_gpiolib_attach_ofnode(struct
> > samsung_gpio_chip *chip, +						 u64 base, u64 offset)
> > +{
> > +	struct gpio_chip *gc =&chip->chip;
> > +	u64 address;
> > +
> > +	if (!of_have_populated_dt())
> > +		return;
> > +
> > +	address = chip->base ? base + ((u32)chip->base&  0xfff) : base +
> > offset; +	gc->of_node = of_find_matching_node_by_address(NULL,
> > +			s3c24xx_gpio_dt_match, address);
> > +	if (!gc->of_node) {
> > +		pr_info("gpio: device tree node not found for gpio controller"
> > +			" with base address %08llx\n", address);
> > +		return;
> > +	}
> > +	gc->of_gpio_n_cells = 3;
> > +	gc->of_xlate = s3c24xx_gpio_xlate;
> > +}
> > +#elif defined(CONFIG_PLAT_S3C24XX)
> > +static __init void s3c24xx_gpiolib_attach_ofnode(struct
> > samsung_gpio_chip *chip, +						 u64 base, u64 offset)
> > +{
> > +	return;
> > +}
> > +#endif /* defined(CONFIG_PLAT_S3C24XX)&&  defined(CONFIG_OF) */
> > +
> > 
> >   static void __init s3c24xx_gpiolib_add_chips(struct samsung_gpio_chip
> >   *chip,
> >   
> >   					     int nr_chips, void __iomem *base)
> >   
> >   {
> > 
> > @@ -962,6 +1023,8 @@ static void __init s3c24xx_gpiolib_add_chips(struct
> > samsung_gpio_chip *chip,
> > 
> >   			gc->direction_output = samsung_gpiolib_2bit_output;
> >   		
> >   		samsung_gpiolib_add(chip);
> > 
> > +
> > +		s3c24xx_gpiolib_attach_ofnode(chip, S3C24XX_PA_GPIO, i * 0x10);
> > 
> >   	}
> >   
> >   }
