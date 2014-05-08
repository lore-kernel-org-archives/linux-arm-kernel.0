From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 08 May 2014 08:31:41 -0700
Subject: omap4-panda-es boot issues with v3.15-rc4
In-Reply-To: <536B7E44.2040303@ti.com> (Roger Quadros's message of "Thu, 8 May
 2014 15:53:24 +0300")
References: <536B7E44.2040303@ti.com>
Message-ID: <7hppjos2w2.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Roger Quadros <rogerq@ti.com> writes:

> Hi,
>
> Nishant pointed me to a booting issue with omap4-panda-es on linux-next but I'm observing
> similar issues, although less frequent, with v3.15-rc4 as well.
>
> Configuration:
>
> - kernel v3.15-rc4 or linux-next (20140507)
> - multi_v7_defconfig with LEDS_TRIGGER_HEARTBEAT and LEDS_GPIO enabled
> - u-boot/master	173d294b94cf
>
> Observations:
>
> - Out of 10 boots a few may not succeed and hang midway without any warnings. Heartbeat LED stops.
> e.g. http://www.hastebin.com/ebumojegoq.vhdl
>
> - Hang more noticeable on linux-next (20140507) than on v3.15-rc4

I've beeen noticing the same thing for awhile with my boot tests.  For
me, next-20140508 is failing most of the time now.

> - Hang more noticeable with USB_EHCI_HCD enabled but hang observed even without USB_EHCI_HCD.
> Maybe related to when high speed interrupts occur in the boot process.
>
> - On successful boots following warning is seen
> [    4.010375] gic_timer_retrigger: lost localtimer interrupt
>
> - On successful boots heartbeat LED stops blinking after boot process and left idle. LED can remain stuck in
> ON state as well. It does blink again when doing activity on console.
>
> Workaround:
>
> - Disabling CPU_IDLE or even just disabling C3 (MPU OSWR) seems to fix all the above issues.
>
> I don't really know what exactly is the issue but it seems to be specific to OMAP4, GIC, MPU OSWR.

I can confirm that disabling CONFIG_CPU_IDLE seems to make the problem
go away.  Hmm....

Kevin
