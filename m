From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jun 2012 11:14:16 +0000
Subject: [RFC PATCH] ARM: Make a compile trustzone conditionally
In-Reply-To: <CAH9JG2UwwvZTK+RptKQ+fmfAMHeqyXG=eo9bJN+JogGBDTgqNQ@mail.gmail.com>
References: <20120611051502.GA24030@july> <201206181410.39267.arnd@arndb.de>
 <CAH9JG2UwwvZTK+RptKQ+fmfAMHeqyXG=eo9bJN+JogGBDTgqNQ@mail.gmail.com>
Message-ID: <201206201114.17033.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 June 2012, Kyungmin Park wrote:
> > Would it help to have a trustzone_ops structure with pointers to
> > functions if needed, similar to but separate from smp_ops?
> Here's real usages. I'm not sure it's possible since smc call is
> vendor specific.

I would hope that there is at last some overlap, as well as only a
limited number of things that you might want to do with smc.

> static int exynos4_cpu_suspend(unsigned long arg)
> {
>         outer_flush_all();
> 
>         /* issue the standby signal into the pm unit. */
>         if (trustzone_enabled())
>                 exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
>         else
>                 cpu_do_idle();
> 
>         /* we should never get past here */
>         panic("sleep resumed to originator?");
> }

This looks straightforward to implement as an indirect call just for
cpu_do_idle. We already have an indirection layer for cpu-specific
do_idle functions. It would be ideal to have only one level of
indirection, but the extra level would work as well.

> static int exynos4_cpu_suspend(unsigned long arg)
> {
>         outer_flush_all();
> 
>         /* issue the standby signal into the pm unit. */
>         cpu_do_idle();
> 
>         /* we should never get past here */
>         panic("sleep resumed to originator?");
> }
> 
> static int exynos4_cpu_smc_suspend(unsigned long arg)
> {
>         outer_flush_all();
> 
>         exynos_smc(SMC_CMD_SLEEP, 0, 0, 0);
> 
>         /* we should never get past here */
>         panic("sleep resumed to originator?");
> }
> 
> but still we should check it's trustzone is enabled or not to assign
> proper function into pm_cpu_suspend
> 
> I think it's different from smp_ops.

This is a different method from what I had in mind, but it would
work too. It's not platform independent though.

What I was thinking of is something along the lines of

static void nosmc_cpu_do_idle(void)
{
	cpu_do_idle();
}

struct smc_ops {
	void (*do_idle)(void);
	...
};

struct smc_ops default_smc_ops = {
	.do_idle = nosmc_cpu_do_idle,
	...
};

So the exynos4_cpu_suspend() function would just do an indirect call to
smc->do_idle(), which is either nosmc_cpu_do_idle or a function specific
to the smc firmware.

	Arnd
