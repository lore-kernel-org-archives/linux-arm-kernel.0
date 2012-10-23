From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 23 Oct 2012 07:14:48 -0700
Subject: [PATCH v2] arm: sched: stop sched_clock() during suspend
In-Reply-To: <1350971854-9161-1-git-send-email-balbi@ti.com> (Felipe Balbi's
 message of "Tue, 23 Oct 2012 08:57:34 +0300")
References: <873916h1yi.fsf@deeprootsystems.com>
 <1350971854-9161-1-git-send-email-balbi@ti.com>
Message-ID: <87mwzdcm1z.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> The scheduler imposes a requirement to sched_clock()
> which is to stop the clock during suspend, if we don't
> do that any RT thread will be rescheduled in the future
> which might cause any sort of problems.
>
> This became an issue on OMAP when we converted omap-i2c.c
> to use threaded IRQs, it turned out that depending on how
> much time we spent on suspend, the I2C IRQ thread would
> end up being rescheduled so far in the future that I2C
> transfers would timeout and, because omap_hsmmc depends
> on an I2C-connected device to detect if an MMC card is
> inserted in the slot, our rootfs would just vanish.
>
> arch/arm/kernel/sched_clock.c already had an optional
> implementation (sched_clock_needs_suspend()) which would
> handle scheduler's requirement properly, what this patch
> does is simply to make that implementation non-optional.
>
> Note that this has the side-effect that printk timings
> won't reflect the actual time spent on suspend so other
> methods to measure that will have to be used.
>
> This has been tested with beagleboard XM (OMAP3630) and
> pandaboard rev A3 (OMAP4430). Suspend to RAM is now working
> after this patch.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Acked-by: Kevin Hilman <khilman@ti.com>
