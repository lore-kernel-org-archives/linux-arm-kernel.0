From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 15:03:14 -0800
Subject: Incomplete DM814x support in 4.3
In-Reply-To: <564C7AF5.9070209@linutronix.de>
References: <564C7AF5.9070209@linutronix.de>
Message-ID: <20151130230314.GM23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Adding linux-omap to Cc.

* Philipp Rosenberger <ilu@linutronix.de> [151118 05:20]:
> Hi,
> 
> I have seen with pleasure that some support for DM814x was integrated to the kernel. But it seems incomplete I get various errors when I try to boot the kernel on a DM814x/AM387x based board.

Sorry for the delay in replying. Current dm8148 support is based on the
bootloader clocks right now so YMMW. I fixed up the basic support for
dm8148 on hp t410 and that is bootable to NFSroot with mainline.

I'll try to post some patches soon for adding the clock driver and more devices.
So far I have GPIOs, Ethernet, USB and MMC working.. Also on dm8148-evm.

I still need to clean up things a bit, hoping to be able to post this week at
some point.

> End in the end it panics with this:
> [    0.379442] platform ocp: Cannot lookup hwmod 'l3_main'
> [    0.387920] platform 48032000.gpio: Cannot lookup hwmod 'gpio1'
> [    0.394638] omap_gpio 48032000.gpio: Could not get gpio dbck. Disable debounce
> [    0.402220] omap_gpio 48032000.gpio: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
> [    0.411448] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa032034

Yup this is what I'm seeing too on dm8148-evm after I got one. It's because of
the missing clocks.

> I searched for 'l3_main' in the hwmods for dm814x but it is not defined in there.

I think I have fixed up that one too.. Need to check :)

> I didn't find a driver in the tree which is compatible with "ti,dm814-pllss" so no driver for pll handling.

I have an initial driver coming up for that.. Heh it also works as a loadable
module on hp t410 :)

> Is there some work in progress to bring the missing parts into the kernel?

Yes, best to coordinate the effort on linux-omap and linux-arm-kernel lists.

FYI, I have these pieces coming up this week:

- Few fixes for for the clock muxes for system timers

- Basic clock driver for dm8148 ADPLLs, still in read-only mode for the PLLs

- DTS + hwmod support for GPIOs, MMC and MUSB

- Minimal board support for j5eco-evm

Then the PWM support done for dm816x should also work on others, and I belive
people are working on getting the DSP supported but don't know the current
status. Maybe somebody can reply on that?

Regards,

Tony
