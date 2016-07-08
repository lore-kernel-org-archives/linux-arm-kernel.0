From: mturquette@baylibre.com (Michael Turquette)
Date: Thu, 07 Jul 2016 19:50:56 -0700
Subject: [PATCH v2] xen/arm: register clocks used by the hypervisor
In-Reply-To: <dad950db-4c02-e5a2-0ce9-682a40cd12d7@de.bosch.com>
References: <1467282752-14053-1-git-send-email-dirk.behme@de.bosch.com>
 <146776885213.35356.11565744417822933094@resonance>
 <577D035C.7090504@arm.com> <146783774807.35356.6362595927321996311@resonance>
 <dad950db-4c02-e5a2-0ce9-682a40cd12d7@de.bosch.com>
Message-ID: <146794625655.73491.13497001485518368066@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Dirk Behme (2016-07-07 00:32:34)
> Hi Michael,
> 
> On 06.07.2016 22:42, Michael Turquette wrote:
> > Hi Julien,
> >
> > Quoting Julien Grall (2016-07-06 06:10:52)
> >> On 06/07/16 02:34, Michael Turquette wrote:
> >>> Hi!
> >>
> >> Hello Michael,
> >>
> >>> Quoting Dirk Behme (2016-06-30 03:32:32)
> >>>> Some clocks might be used by the Xen hypervisor and not by the Linux
> >>>> kernel. If these are not registered by the Linux kernel, they might be
> >>>> disabled by clk_disable_unused() as the kernel doesn't know that they
> >>>> are used. The clock of the serial console handled by Xen is one
> >>>> example for this. It might be disabled by clk_disable_unused() which
> >>>> stops the whole serial output, even from Xen, then.
> >>>
> >>> This whole thread had me confused until I realized that it all boiled
> >>> down to some nomenclature issues (for me).
> >>>
> >>> This code does not _register_ any clocks. It simply gets them and
> >>> enables them, which is what every other clk consumer in the Linux kernel
> >>> does. More details below.
> >>>
> >>>>
> >>>> Up to now, the workaround for this has been to use the Linux kernel
> >>>> command line parameter 'clk_ignore_unused'. See Xen bug
> >>>>
> >>>> http://bugs.xenproject.org/xen/bug/45
> >>>
> >>> clk_ignore_unused is a band-aid, not a proper medical solution. Setting
> >>> that flag will not turn clocks on for you, nor will it guarantee that
> >>> those clocks are never turned off in the future. It looks like you
> >>> figured this out correctly in the patch below but it is worth repeating.
> >>>
> >>> Also the new CLK_IS_CRITICAL flag might be of interest to you, but that
> >>> flag only exists as a way to enable clocks that must be enabled for the
> >>> system to function (hence, "critical") AND when those same clocks do not
> >>> have an accompanying Linux driver to consume them and enable them.
> >>
> >> I don't think we want the kernel to enable the clock for the hypervisor.
> >> We want to tell the kernel "don't touch at all to this clock, it does
> >> not belong to you".
> >
> > But the patch *does* touch the clock from the kernel. It enables the
> > clock via a call clk_prepare_enable. I'm utterly confused.
> 
> 
> Maybe we need some advice here :)

Sure!

> 
> 
> I've used clk_prepare_enable() 'just' to get the enable count incremented

clk_prepare_enabled will *enable* the clock signal if it currently
disabled or gated. In other words, if the physical line is not toggling
before the call, it will be after the call returns.

> 
> http://lxr.free-electrons.com/source/drivers/clk/clk.c#L751
> 
> Because it's my understanding that enable_count is needed to prevent 
> clk_disable_unused() from disabling the clock.

Having a positive enable_count will prevent the clock from being
disabled by both clk_disable_unused AND from the Sneaky Sibling
Attack(tm).

The Sneaky Sibling Attack(tm) occurs when clock A and clock B are
siblings and share the same parent, clock C. If clock A is enabled in
hardware (by bootloader, firmware or hypervisor), but does NOT have a
positive enable_count (in Linux), then it is possible that a driver
might call clk_enable(clk_B) then clk_disable(clk_B), which will result
in the disable action propagating up the parent chain and disabling
clk_C, the shared parent. This will of course gate clk_A, which is
clocked by clk_C, breaking things for you.

So you need to be worried about more than just clk_disable_unused.

The simple fact is is that if a piece of software knows that it needs
for its clock to be enabled, it should actively enable it with
clk_prepare_enable.

Doing some weird stuff with CLK_IGNORE_UNUSED or anything else is just
hoping that your clock will not be disabled, and that is the wrong
strategy.

> 
> 
> If there is an other / better / correct way to achieve that, please let 
> us know.

Well, you should not "try to prevent a clock from being disabled", you
should "enable the clock that you need to use".

> 
> 
> I've had a look to use the CLK_IGNORE_UNUSED flag, too. But couldn't 
> find a function exported by the clock framework to set that flag (?)

Right, the flags are immutable and must be set by the clock provider
driver before registering the clock. Toggling flags at run-time is a
misuse of the flags, and clock consumer drivers should never care about
the flags. They are internal to the clock framework.

In conclusion, I think that your patch does the right thing. The Xen
node consumes the clocks that it needs to manage and it calls
clk_prepare_enable on them. The two issues to resolve are:

1) does consuming these hardware resources from the Linux kernel fit
correctly with the Xen model?
2) the language of the binding description makes this way more confusing
than it needs to be. Just claim the resources you need and enable them,
which is an OS-agnostic action.

Regards,
Mike

> 
> 
> Best regards
> 
> Dirk
