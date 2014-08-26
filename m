From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 26 Aug 2014 16:30:08 -0700
Subject: [PATCH v7 3/8] cpufreq: kirkwood: Remove use of the clk provider
 API
In-Reply-To: <20140826223637.GA5324@lunn.ch>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
 <1408375833-10703-4-git-send-email-tomeu.vizoso@collabora.com>
 <20140820225513.5251.284@quantum> <53F5A587.9030200@collabora.com>
 <20140821133825.GH8608@lunn.ch> <20140822192933.5251.53733@quantum>
 <20140822201112.GH17277@lunn.ch> <20140826214631.5251.66177@quantum>
 <20140826223637.GA5324@lunn.ch>
Message-ID: <20140826233008.5251.50447@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Andrew Lunn (2014-08-26 15:36:37)
> > > Not quite true. u-boot might of touch the clock. Weird things happen
> > > with some kirkwood boards. Some don't have the ability to control
> > > there power supplies. So some boards implement "power off" by
> > > rebooting, and letting u-boot spin until a button is pressed. I hope
> > > such a u-boot powers off as much as possible, and e.g. drops the CPU
> > > clock to the lower frequency. One would also hope it puts it back to
> > > high speed before calling the kernel.
> > 
> > I have a doubt about this.
> > 
> > The powersave clock in drivers/clk/mvebu/kirkwood.c does not set
> > CLK_IGNORE_UNUSED, nor do any of the clocks in kirkwood_gating_desc[].
> > 
> > So regardless of what U-boot does, if no driver has called clk_enable() on
> > powersave_clk by late_initcall-time then clk_disable_unused() will
> > disable it as a power-saving mechanism.
> > 
> > So are kirkwood systems that use cpufreq simply getting lucky and not
> > hanging?
> 
> Hi Mike
> 
> Its a good question.
> 
> However, the reset value of the clock is off. off means the CPU is
> running at its high speed. Turning this clock on, actually reduces the
> clock speed! So for 99% of the time, the late_initcall does nothing.
> 
> It gets more interesting when uboot, or a previous kernel has turned
> the clock on. I admit, i don't expect this to happen very often, but
> if it does, and there is no cpufreq driver, interesting things could
> happen. The cpufreq driver can only be builtin, not a module. So if it
> is available, it should be guaranteed to claim the clock before the
> late_initcall could turn it off. And since it reads the hardware
> state, it will do the right thing.

Hi Andrew,

Thanks for the response. That all makes sense. I still think my solution
is OK for both of your cases:

1) for the U-boot-enables-powersave-clk case, if we do not have driver
that claims the clock and does something with it then that is out of
scope of our concerns

2) for the kexec-kernel-case, the responsibility is on the first kernel
to set things up in a good state for the second kernel, with the
exception of using kexec to debug/examime/recover from a kernel crash,
in which case you likely don't care about this stuff as much

But anyways I do understand the case you are trying to prevent.

One final thought I have had is that it might be a good idea to have a
mux clock which represents the clock signal that feeds into the cpu. It
seems that a mux is exactly what is going on here with cpuclk rate and
ddrclk rate.

I even wonder if it is even appropriate to model this transition with a
clock enable operation? Maybe it is only a multiplex operation, or
perhaps a combination of enabling the powersave clock and changing the
parent input to the cpu?

My idea is instead of relying on a cpufreq driver to parse the state of
your clocks and understand the multiplexing, you can use the clock
framework for that. In fact that might help you get one step closer to
using the cpufreq-cpu0.c/cpufreq-generic.c implementation.

Regards,
Mike

> 
>        Andrew
