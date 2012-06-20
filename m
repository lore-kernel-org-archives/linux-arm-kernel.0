From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 20 Jun 2012 15:41:11 +0100
Subject: [RFC PATCH] ARM: Make a compile trustzone conditionally
In-Reply-To: <201206201114.17033.arnd@arndb.de>
References: <20120611051502.GA24030@july> <201206181410.39267.arnd@arndb.de>
 <CAH9JG2UwwvZTK+RptKQ+fmfAMHeqyXG=eo9bJN+JogGBDTgqNQ@mail.gmail.com>
 <201206201114.17033.arnd@arndb.de>
Message-ID: <20120620144111.GC2179@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 11:14:16AM +0000, Arnd Bergmann wrote:
> On Tuesday 19 June 2012, Kyungmin Park wrote:
> > > Would it help to have a trustzone_ops structure with pointers to
> > > functions if needed, similar to but separate from smp_ops?
> > Here's real usages. I'm not sure it's possible since smc call is
> > vendor specific.
> 
> I would hope that there is at last some overlap, as well as only a
> limited number of things that you might want to do with smc.
> 
> > static int exynos4_cpu_suspend(unsigned long arg)
> > {
> >         outer_flush_all();
> > 
> >         /* issue the standby signal into the pm unit. */
> >         if (trustzone_enabled())

For purely cosmetic reasons, I don't think we should use a name like
"trustzone_enabled" -- actually we sort of have the opposite: the
trustzone architectural features are blocked from Linux by the
presence of Secure World firmware in this case.

If we need a function at all, a name like secure_firmware_present()
might be better.  But I agree that it's probably better to just have
some alternative structs of function pointers, and install one at
boot time depending on whether the firmware is there or not.


> >                 exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
> >         else
> >                 cpu_do_idle();
> > 
> >         /* we should never get past here */
> >         panic("sleep resumed to originator?");
> > }
> 
> This looks straightforward to implement as an indirect call just for
> cpu_do_idle. We already have an indirection layer for cpu-specific
> do_idle functions. It would be ideal to have only one level of
> indirection, but the extra level would work as well.
> 
> > static int exynos4_cpu_suspend(unsigned long arg)
> > {
> >         outer_flush_all();
> > 
> >         /* issue the standby signal into the pm unit. */
> >         cpu_do_idle();
> > 
> >         /* we should never get past here */
> >         panic("sleep resumed to originator?");
> > }
> > 
> > static int exynos4_cpu_smc_suspend(unsigned long arg)
> > {
> >         outer_flush_all();
> > 
> >         exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
> > 
> >         /* we should never get past here */
> >         panic("sleep resumed to originator?");
> > }
> > 
> > but still we should check it's trustzone is enabled or not to assign
> > proper function into pm_cpu_suspend
> > 
> > I think it's different from smp_ops.
> 
> This is a different method from what I had in mind, but it would
> work too. It's not platform independent though.
> 
> What I was thinking of is something along the lines of
> 
> static void nosmc_cpu_do_idle(void)
> {
> 	cpu_do_idle();
> }
> 
> struct smc_ops {
> 	void (*do_idle)(void);
> 	...
> };
> 
> struct smc_ops default_smc_ops = {
> 	.do_idle = nosmc_cpu_do_idle,
> 	...
> };

This would my preferred model.

>From my point of view, the name "smc ops" is a bit bogus.  Really these are
platform-specific hooks which may need to be handled by firmware depending
on the configuration, and the fact that they may be implemented by calling
SMC is more of an implementation detail of _one_ of the alternative
implementations of those hooks.

So your struct might instead be called struct exynos4_firmware_ops, and
your two instances might be called exynos4_native_firmware_ops and
exynos4_smc_firmware_ops, or similar.  This is purely cosmetic, though.

As discussed in previous mails, the best way to choose which struct
exynos4_firmware_ops to use may be to scan for something in the device
tree, rather than using some scary probing hack.


If we have standard DT bindings for this stuff, we could have generic DT
support code for selecting the correct exynos4_firmware_ops structure
based on the DT.  Only the definition and contents of the platform-
specific firmware_ops structs would need to vary.

Whether we could end up with a common firmware_ops structure across all
platforms is less certain (?)

Cheers
---Dave
