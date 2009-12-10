From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 10 Dec 2009 18:14:12 -0500
Subject: GPIO support for HTC Dream
In-Reply-To: <4B2150B7.3040207@bluewatersys.com>
References: <20091208102842.GH12264@elf.ucw.cz><4B1EB57D.6070408@bluewatersys.com><20091208214658.GC4164@elf.ucw.cz><4B1ECEEE.3000209@bluewatersys.com><4B203575.6050407@bluewatersys.com><20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 10, 2009 12:49 PM, Ryan Mallon wrote:
> Pavel Machek wrote:
>> Hi!
>> 
>>>> This is still really screwy. Why are you creating your own version of
>>>> struct gpio_chip in addition to the one in include/asm-generic/gpio.h
>>>> (which you also appear to include in some places). It makes the code
>>>> extremely confusing. Other architectures use wrapper structures. Can you
>>>> have something like this instead:
>>>>
>>>> 	struct dream_gpio_chip {
>>>> 		struct gpio_chip chip;
>>>>
>>>> 		/* Dream specific bits */
>>>> 	};
>>>>
>>>> The name of this function also needs to be changed to something less
>>>> generic since it is being exported globally.
>>>>
>>>> I also think this function is doing way to much work for what it is.
>>>> Does it really need to be this complicated?
>>> Further to this, I think it is worth doing the work to make this gpiolib
>>> now. Most of the other ARM chips now support gpiolib, so it would seem a
>>> bit of a step backwards to start adding new chips which don't. I think
>>> that adding the gpiolib support will also cleanup the mess that is
>>> register_gpio_chip, since this is all already handled by the gpiolib core.
>> 
>> I tried going through drivers/gpio/gpiolib.c and it seems to be a lot
>> of code -- mostly sysrq interface to userland. I'm not sure how much
>> code could be shared... 
>
> Its not much work to go from generic gpio (which you have now) to
> gpiolib, and in the end it will make the code simpler, more extensible,
> you get sysfs access for free, etc. You will need to wrap up your
> gpio_chip struct as I suggested:
>
> struct msm_gpio_chip {
>	struct gpio_chip;
>	
>	/* MSM/Dream/Trout(?) bits */
> };
> #define to_msm_gpio_chip(c, container_of(c, struct msm_gpio_chip, chip)
>
> As an aside, I don't quite understand the naming conventions here. Is
> the gpio stuff generic to the MSM chip, or specific to the Dream/Trout
> board? It would be good if the gpio implementation could be completely
> generic to the chip, and all the board specific bits be kept in the
> board specific files.
>
> You gpio_set, get, direction, etc functions become static:
> 
> static gpio_set_value(struct gpio_chip *chip, unsigned offset, int val)
> {
> 	struct msm_gpio_chip *msm_chip = to_msm_gpio_chip(chip);
>	
>	...
> }
>
> and you have a descriptor for your chip (or an array of these if you
> want multiple banks of gpios):
>
> static struct msm_gpios = {
>	.chip = {
>		.label		= "msm_gpio",
>		.set		= gpio_set_value,
>		...
>	},
>	/* MSM specific bits */
> };
>
> void __init msm_init_gpio(void)
> {
>	gpiochip_add(&msm_gpios);
>
>	/* Other setup, gpio irqs, etc */
> }
>
> Your msm_register_gpio_chip function should disappear and your
> gpio_request and gpio_free functions can either be removed, or at least
> become much simpler since gpiolib already handles most of what those
> functions are doing.
>
> Have a look at the other ARM chips which have gpiolib support for a
> guide. The ep93xx and at91 ones which I did are reasonably simple to
> follow, and also demonstrate how to use the debugfs hooks which you may
> find useful. Also look at Documentation/gpio.txt which has some more
> detailed information on gpiolib.

As Ryan says, using gpiolib will clean this up immensely.

It appears the what you really have for gpio's is 7 8-bit ports that start
with gpio number 128.  Each port appears to only have one control register.
This register is written with a '1' to drive the gpio as a high output and
'0' to drive it as a low output or to use it as an input.  Not really
sure if this is correct since the code is a bit screwy.

Your current code is written so that all of the gpio's are in one "chip".
Because of this you are having to calculate the 'reg' needed to access the
gpio whenever you need to read or write to a gpio.

If you follow the ep93xx implementation you can break the whole thing down
into 'banks' and simplify everything.  Something like:



struct dream_gpio_chip {
	struct gpio_chip	chip;

	void __iomem		*reg;
};

#define to_dream_gpio_chip(c) container_of(c, struct dream_gpio_chip, chip)


#define DREAM_GPIO_BANK(name, reg, base_gpio)			\
	{								\
		.chip = {						\
			.label		  = name,			\
			.direction_input  = dream_gpio_direction_input, \
			.direction_output = dream_gpio_direction_output, \
			.get		  = dream_gpio_get,		\
			.set		  = dream_gpio_set,		\
			.dbg_show	  = dream_gpio_dbg_show,	\
			.base		  = base_gpio,			\
			.ngpio		  = 8,				\
		},							\
		.reg		= DREAM_CPLD_BASE + reg,			\
	}

static struct dream_gpio_chip dream_gpio_banks[] = {
	DREAM_GPIO_BANK("MISC2", 0x00, DREAM_GPIO_MISC2_BASE),
	DREAM_GPIO_BANK("MISC3", 0x02, DREAM_GPIO_MISC3_BASE),
	DREAM_GPIO_BANK("MISC4", 0x04, DREAM_GPIO_MISC4_BASE),
	DREAM_GPIO_BANK("MISC5", 0x06, DREAM_GPIO_MISC5_BASE),
	DREAM_GPIO_BANK("INT2", 0x08, DREAM_GPIO_INT2_BASE),
	DREAM_GPIO_BANK("MISC1", 0x0a, DREAM_GPIO_MISC1_BASE),
	DREAM_GPIO_BANK("VIRTUAL", 0x12, DREAM_GPIO_VIRTUAL_BASE),
};

void __init dream_gpio_init(void)
{
	int i;

	for (i = 0; i < ARRAY_SIZE(dream_gpio_banks); i++)
		gpiochip_add(&dream_gpio_banks[i].chip);
}


With this you can now just access the dream_gpio_chip data in all
the member function using the to_dream_gpio_chip() macro.

I agree with Ryan and think you would be better off in the long
run to re-code this and use gpiolib.  You might also want to break
out all the gpio interrupt stuff and submit it as a seperate patch.

Regards,
Hartley
