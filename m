From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 6 Jan 2015 10:37:06 +0100
Subject: [PATCH RFC] pinctrl: at91
In-Reply-To: <54943933.60102@atmel.com>
References: <CACRpkdbkUUzVVMp14szY+vGNd+d+8bL066STh_XMGud-UsFBqA@mail.gmail.com>
 <1418637470-5839-1-git-send-email-ludovic.desroches@atmel.com>
 <54943933.60102@atmel.com>
Message-ID: <20150106093706.GC26982@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas, Linus,

On Fri, Dec 19, 2014 at 03:41:55PM +0100, Nicolas Ferre wrote:
> Le 15/12/2014 10:57, Ludovic Desroches a ?crit :
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> > 
> > Hi Linus,
> > 
> > I have reworked my patch (of course it will be split for submission) trying to
> > follow your advices.
> > 
> > I have replaced pinctrl_add_gpio_range() with of_gpiochip_add(). I'll do more
> > tests but it seems to work. Maybe I've missed something but I still need to fix
> > the case when there is a gpio controller not used.
> > 
> > A lot of things rely on the gpio controller id (taken from the alias):
> > index for gpio_chips array, pin muxing, naming, etc. I am not sure I can't get
> > rid of this constraint.
> 
> Fair enough, I'm personally okay with those changes. When you rework
> this RFC into real patches and when you correct the little nitpicking
> hereafter, you can add my:
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> On your side Linus, does it sound good?
> 

After testing more these changes, it breaks GPIOs if gpio-ranges
property is not added to all our SOCs (about 10 dtsi to update).

Usage of of_gpiochip_add() only solves my issue about gpio but not about
pinctrl stuff, I still need a patch to manage the case when we have a gap if
a gpio controller is not enabled to not break the pin naming, etc.

Maybe I am missing something, I am still discovering how pinctrl subsystem
works in order to maintain our pinctrl driver. So I would be pleased to
have some advices to find the proper way to fix this issue.


Regards

Ludovic

> 
> BTW, once split, you'll have to add a commit message with explanation to
> each patch ;-)
> 
> Otherwise, see below:
> 
> 
> >  arch/arm/boot/dts/sama5d4.dtsi | 19 ++++++++++++++++++-
> >  drivers/pinctrl/pinctrl-at91.c | 42 +++++++++++++++++++++++-------------------
> >  2 files changed, 41 insertions(+), 20 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> > index 1b0f30c..c1c01a3 100644
> > --- a/arch/arm/boot/dts/sama5d4.dtsi
> > +++ b/arch/arm/boot/dts/sama5d4.dtsi
> > @@ -62,6 +62,7 @@
> >  		gpio0 = &pioA;
> >  		gpio1 = &pioB;
> >  		gpio2 = &pioC;
> > +		gpio3 = &pioD;
> >  		gpio4 = &pioE;
> >  		tcb0 = &tcb0;
> >  		tcb1 = &tcb1;
> > @@ -1063,7 +1064,7 @@
> >  			};
> >  
> >  
> > -			pinctrl at fc06a000 {
> > +			pinctrl: pinctrl at fc06a000 {
> >  				#address-cells = <1>;
> >  				#size-cells = <1>;
> >  				compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
> > @@ -1084,6 +1085,7 @@
> >  					interrupts = <23 IRQ_TYPE_LEVEL_HIGH 1>;
> >  					#gpio-cells = <2>;
> >  					gpio-controller;
> > +					gpio-ranges = <&pinctrl 0 0 32>;
> 
> You may need to modify our pinctrl binding documentation as well.
> 
> 
> >  					interrupt-controller;
> >  					#interrupt-cells = <2>;
> >  					clocks = <&pioA_clk>;
> > @@ -1095,6 +1097,7 @@
> >  					interrupts = <24 IRQ_TYPE_LEVEL_HIGH 1>;
> >  					#gpio-cells = <2>;
> >  					gpio-controller;
> > +					gpio-ranges = <&pinctrl 0 32 32>;
> >  					interrupt-controller;
> >  					#interrupt-cells = <2>;
> >  					clocks = <&pioB_clk>;
> > @@ -1106,17 +1109,31 @@
> >  					interrupts = <25 IRQ_TYPE_LEVEL_HIGH 1>;
> >  					#gpio-cells = <2>;
> >  					gpio-controller;
> > +					gpio-ranges = <&pinctrl 0 64 32>;
> >  					interrupt-controller;
> >  					#interrupt-cells = <2>;
> >  					clocks = <&pioC_clk>;
> >  				};
> >  
> > +				pioD: gpio at fc068000 {
> > +					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> > +					reg = <0xfc068000 0x100>;
> > +					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 1>;
> > +					#gpio-cells = <2>;
> > +					gpio-controller;
> > +					interrupt-controller;
> > +					#interrupt-cells = <2>;
> > +					clocks = <&pioD_clk>;
> > +					status = "disabled";
> > +				};
> > +
> >  				pioE: gpio at fc06d000 {
> >  					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
> >  					reg = <0xfc06d000 0x100>;
> >  					interrupts = <26 IRQ_TYPE_LEVEL_HIGH 1>;
> >  					#gpio-cells = <2>;
> >  					gpio-controller;
> > +					gpio-ranges = <&pinctrl 0 128 32>;
> >  					interrupt-controller;
> >  					#interrupt-cells = <2>;
> >  					clocks = <&pioE_clk>;
> > diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> > index dfd021e..f5d4aea 100644
> > --- a/drivers/pinctrl/pinctrl-at91.c
> > +++ b/drivers/pinctrl/pinctrl-at91.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_address.h>
> > +#include <linux/of_gpio.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/slab.h>
> >  #include <linux/interrupt.h>
> > @@ -35,7 +36,6 @@ struct at91_pinctrl_mux_ops;
> >  
> >  struct at91_gpio_chip {
> >  	struct gpio_chip	chip;
> > -	struct pinctrl_gpio_range range;
> >  	struct at91_gpio_chip	*next;		/* Bank sharing same clock */
> >  	int			pioc_hwirq;	/* PIO bank interrupt identifier on AIC */
> >  	int			pioc_virq;	/* PIO bank Linux virtual interrupt */
> > @@ -178,6 +178,7 @@ struct at91_pinctrl {
> >  	struct pinctrl_dev	*pctl;
> >  
> >  	int			nbanks;
> > +	int			nactive_banks;
> >  
> >  	uint32_t		*mux_mask;
> >  	int			nmux;
> > @@ -982,6 +983,8 @@ static void at91_pinctrl_child_count(struct at91_pinctrl *info,
> >  	for_each_child_of_node(np, child) {
> >  		if (of_device_is_compatible(child, gpio_compat)) {
> >  			info->nbanks++;
> > +			if (of_device_is_available(child))
> > +				info->nactive_banks;
> 
> What is the purpose of the line just above?
> 
> 
> >  		} else {
> >  			info->nfunctions++;
> >  			info->ngroups += of_get_child_count(child);
> > @@ -1145,8 +1148,12 @@ static int at91_pinctrl_probe_dt(struct platform_device *pdev,
> >  	dev_dbg(&pdev->dev, "mux-mask\n");
> >  	tmp = info->mux_mask;
> >  	for (i = 0; i < info->nbanks; i++) {
> > +		if (!gpio_chips[i]) {
> > +			tmp += info->nmux;
> > +			continue;
> > +		}
> >  		for (j = 0; j < info->nmux; j++, tmp++) {
> > -			dev_dbg(&pdev->dev, "%d:%d\t0x%x\n", i, j, tmp[0]);
> > +			dev_dbg(&pdev->dev, "pio%c:periphal %c\t0x%x\n", 'A' + i, 'A' + j, tmp[0]);
> >  		}
> >  	}
> >  
> > @@ -1185,7 +1192,7 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
> >  {
> >  	struct at91_pinctrl *info;
> >  	struct pinctrl_pin_desc *pdesc;
> > -	int ret, i, j, k;
> > +	int ret, i, j, k, ngpio_chips_enabled = 0;
> >  
> >  	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> >  	if (!info)
> > @@ -1201,11 +1208,15 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
> >  	 * need this to proceed.
> >  	 */
> >  	for (i = 0; i < info->nbanks; i++) {
> > -		if (!gpio_chips[i]) {
> > -			dev_warn(&pdev->dev, "GPIO chip %d not registered yet\n", i);
> > -			devm_kfree(&pdev->dev, info);
> > -			return -EPROBE_DEFER;
> > -		}
> > +		if (gpio_chips[i])
> > +			ngpio_chips_enabled++;
> > +	}
> > +	if (ngpio_chips_enabled < info->nactive_banks) {
> > +		dev_warn(&pdev->dev,
> > +			 "All GPIO chips are not registered yet (%d/%d)\n",
> > +			 ngpio_chips_enabled, info->nactive_banks);
> > +		devm_kfree(&pdev->dev, info);
> > +		return -EPROBE_DEFER;
> >  	}
> >  
> >  	at91_pinctrl_desc.name = dev_name(&pdev->dev);
> > @@ -1233,9 +1244,9 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
> >  		goto err;
> >  	}
> >  
> > -	/* We will handle a range of GPIO pins */
> >  	for (i = 0; i < info->nbanks; i++)
> > -		pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
> > +		if (gpio_chips[i])
> > +			of_gpiochip_add(&gpio_chips[i]->chip);
> >  
> >  	dev_info(&pdev->dev, "initialized AT91 pinctrl driver\n");
> >  
> > @@ -1682,6 +1693,8 @@ static void at91_gpio_probe_fixup(void)
> >  
> >  	for (i = 0; i < gpio_banks; i++) {
> >  		at91_gpio = gpio_chips[i];
> > +		if (!at91_gpio)
> > +			continue;
> >  
> >  		/*
> >  		 * GPIO controller are grouped on some SoC:
> > @@ -1705,7 +1718,6 @@ static int at91_gpio_probe(struct platform_device *pdev)
> >  	struct resource *res;
> >  	struct at91_gpio_chip *at91_chip = NULL;
> >  	struct gpio_chip *chip;
> > -	struct pinctrl_gpio_range *range;
> >  	int ret = 0;
> >  	int irq, i;
> >  	int alias_idx = of_alias_get_id(np, "gpio");
> > @@ -1790,14 +1802,6 @@ static int at91_gpio_probe(struct platform_device *pdev)
> >  
> >  	chip->names = (const char *const *)names;
> >  
> > -	range = &at91_chip->range;
> > -	range->name = chip->label;
> > -	range->id = alias_idx;
> > -	range->pin_base = range->base = range->id * MAX_NB_GPIO_PER_BANK;
> > -
> > -	range->npins = chip->ngpio;
> > -	range->gc = chip;
> > -
> >  	ret = gpiochip_add(chip);
> >  	if (ret)
> >  		goto gpiochip_add_err;
> > 
> 
> Thanks Ludovic, bye,
> -- 
> Nicolas Ferre
