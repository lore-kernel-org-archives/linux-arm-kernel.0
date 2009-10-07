From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 7 Oct 2009 16:42:52 +0400
Subject: [PATCH 2/9] collie: prepare for gpiolib use
In-Reply-To: <20091007112552.GC6246@n2100.arm.linux.org.uk>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-2-git-send-email-thommycheck@gmx.de>
	<1254778533-3529-3-git-send-email-thommycheck@gmx.de>
	<20091007110805.GA7656@rainbow>
	<20091007112552.GC6246@n2100.arm.linux.org.uk>
Message-ID: <20091007124251.GB7656@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:25 Wed 07 Oct     , Russell King - ARM Linux wrote:
> On Wed, Oct 07, 2009 at 03:08:05PM +0400, Dmitry Artamonow wrote:
> > On 23:35 Mon 05 Oct     , Thomas Kunze wrote:
> > > prefix gpio definitions for direct register access with '_' so we
> > > can use the other names for gpio_request & co
> > 
> > Familiar problem - numeric vs bit-shifted gpio defines.
> > I'm facing it here too while converting h3[16]00 to gpiolib,
> > and I'm thinking about dropping bit-shifted defines completely
> > and using GPIO_GPIO(SOME_NUMERIC_GPIO) instead.
> 
> What we did with PXA was to decide not to use definitions for the built-in
> GPIOs - what's the point of:
> 
> #define GPIO0	0
> #define GPIO1	1
> #define GPIO2	2
> ...
> 
> It's a bit like:
> 
> #define NUMBER0	0
> #define NUMBER1	1
> etc.
> 
> Yes, there's a reason to if the number spaces are different, but for
> the built-in GPIOs, they aren't.

Perhaps I wasn't exactly clear in explaining my thoughts. Sorry.
I meant following - currently in mach/h3600_gpio.h we have gpios declared
like that:
#define GPIO_H3100_IR_ON                GPIO_GPIO (8)
which effectively means:
#define GPIO_H3100_IR_ON                (1 << 8)
i.e. bit-shifted value. 

But gpiolibs needs numeric gpio definitions, something like that:
#define NGPIO_H3100_IR_ON		8

That's all well, but not all direct operations with GPIO registers on
SA1100 can be converted to gpiolib. Operations with GAFR (GPIO alternate
function register), for example (PXA have MFD API for that, but
StrongArm doesn't)

So for constructions like these:
	GAFR &= ~GPIO_H3100_IR_ON;
we either need to keep both variants of GPIO definitions in header, or
keep only "numeric" and change code to:
	GAFR &= ~GPIO_GPIO(NGPIO_H3100_IR_ON);


-- 
Best regards,
Dmitry "MAD" Artamonow
