From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 15 Dec 2009 20:47:25 +0100
Subject: GPIO support for HTC Dream
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE19090200E9E6@mi8nycmail19.Mi8.com>
References: <20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE190901FB10EA@mi8nycmail19.Mi8.com>
	<20091214064545.GK5114@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE19090200E9E6@mi8nycmail19.Mi8.com>
Message-ID: <20091215194725.GH24406@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +int gpio_to_irq(unsigned gpio)
> > +{
> > +	return -EINVAL;
> > +}
> 
> This should probably just be an inline function in
> arch/arm/mach-msm/include/mach/gpio.h

Well, it is not performance critical in any way and it is likely to
change in future. I'd leave it here.

> > diff --git a/arch/arm/mach-msm/board-dream.h b/arch/arm/mach-msm/board-dream.h
> > index 4f345a5..dbd78b9 100644
> > --- a/arch/arm/mach-msm/board-dream.h
> > +++ b/arch/arm/mach-msm/board-dream.h
> > @@ -1,5 +1,58 @@
> >  
> > -#define TROUT_CPLD_BASE   0xE8100000
> > -#define TROUT_CPLD_START  0x98000000
> > -#define TROUT_CPLD_SIZE   SZ_4K
> > +#define MSM_SMI_BASE		0x00000000
> > +#define MSM_SMI_SIZE		0x00800000
...
> > +#define DREAM_CPLD_BASE   0xE8100000
> > +#define DREAM_CPLD_START  0x98000000
> > +#define DREAM_CPLD_SIZE   SZ_4K
> > +
> 
> This header might need to be a separate patch.  The only thing in it
> related to the rest of this is DREAM_CPLD_BASE.

Yep.

> > +#ifndef __ASM_ARCH_MSM_GPIO_H
> > +#define __ASM_ARCH_MSM_GPIO_H
> > +
> > +extern int gpio_to_irq(unsigned gpio);
> 
> This should probably be an inline as mentioned above.
> 
> For completeness you should probably also add:
> 
> static inline int irq_to_gpio(unsigned irq)
> {
> 	return -EINVAL;
> }

I'd say that would be overdoing it.

> And, nitpick, move both of them after the gpio_cansleep below.

I'll do the move.

> > +#define DREAM_GPIO_CABLE_IN1		(83)
> > +#define DREAM_GPIO_CABLE_IN2		(49)
> > +
> > +#define DREAM_GPIO_START (128)
> 
> Nitpick.  Tab align these three with the ones below.

Ok.

> > +#define DREAM_GPIO_SDMC_CD_N                (DREAM_GPIO_VIRTUAL_BASE + 0)
> > +#define DREAM_GPIO_END                      (DREAM_GPIO_SDMC_CD_N)
> > +#define DREAM_GPIO_BANK1_FIRST_INT_SOURCE   (DREAM_GPIO_SDMC_CD_N)
> > +#define DREAM_GPIO_BANK1_LAST_INT_SOURCE    (DREAM_GPIO_SDMC_CD_N)
> > +
> > +#endif
> 
> Otherwise, looks good to me.  Just test it to make sure it works :-).
> 
> Since I have no way of compiling or testing this...
> 
> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

I believe inlining that function would be bad change. Can I still use
reviewed-by tag?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
