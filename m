From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 10 Dec 2009 17:26:45 +0100
Subject: GPIO support for HTC Dream
In-Reply-To: <4B1ECAC2.5090009@bluewatersys.com>
References: <20091208102842.GH12264@elf.ucw.cz>
	<4B1EB57D.6070408@bluewatersys.com>
	<20091208213727.GA4164@elf.ucw.cz>
	<4B1ECAC2.5090009@bluewatersys.com>
Message-ID: <20091210162645.GG19454@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>> +#define DREAM_INT_TO_BANK(n) ((n - DREAM_INT_START) / DREAM_INT_BANK0_COUNT)
> >>> +#define DREAM_INT_TO_MASK(n) (1U << ((n - DREAM_INT_START) & 7))
> >>> +#define DREAM_BANK_TO_MASK_REG(bank) \
> >>> +	(bank ? DREAM_GPIO_INT_MASK1_REG : DREAM_GPIO_INT_MASK0_REG)
> >>> +#define DREAM_BANK_TO_STAT_REG(bank) \
> >>> +	(bank ? DREAM_GPIO_INT_STAT1_REG : DREAM_GPIO_INT_STAT0_REG)
> >> Are these needed outside of the gpiolib code? If not, they should be
> >> moved there. I also think they should have lower case names since they
> >> act like a function, and make the code where they are used nicer to
> >> read.
> > 
> > I guess these logically belong here.
> > 
> > No, macros are macros, that means upcase.
> 
> container_of, min, swap, etc are macros too. It is easier to read this
> if they are lower case because they are typically used for initialising
> variables, ie:
> 
> 	int bank = dream_int_to_bank(irq);
> 
> Is easier (IMHO) to read than:
> 	
> 	int bank = DREAM_INT_TO_BANK(irq);

I disagree here. I could convert it to inline function, but I guess it
is okay as it is.

> >  static void __init dream_init(void)
> >  {
> > +	gpio_set_value(DREAM_GPIO_UI_LED_EN, 1);
> > +        mdelay(300);
> > +	gpio_set_value(DREAM_GPIO_UI_LED_EN, 0);
> > +        mdelay(300);
> > +        gpio_set_value(DREAM_GPIO_UI_LED_EN, 1);
> > +	mdelay(300);
> > +        gpio_set_value(DREAM_GPIO_UI_LED_EN, 0);
> > +	mdelay(300);
> > +        gpio_set_value(DREAM_GPIO_UI_LED_EN, 1);
> > +        mdelay(300);
> > +        gpio_set_value(DREAM_GPIO_UI_LED_EN, 0);
> > +        mdelay(300);
> > +	gpio_set_value(DREAM_GPIO_UI_LED_EN, 1);
> > +        mdelay(300);
> > +	gpio_set_value(DREAM_GPIO_UI_LED_EN, 0);
> > +        mdelay(300);
> > +
> 
> Indentation looks screwy here. Also, is this meant to blink the leds?
> There is a 2.4 second hard delay here, which is horrible.

Yep, that was my debugging code, not meant for upstream. And yes, its
blinking.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
