From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Mar 2011 17:11:04 +0530
Subject: [PATCH 0/6] omap3: pm: Fixes for low power code
In-Reply-To: <87k4ghro9h.fsf@ti.com>
References: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
	<87k4ghro9h.fsf@ti.com>
Message-ID: <b5cdbcef5de05fd6fa85f532e8c29271@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Thursday, March 03, 2011 6:53 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 0/6] omap3: pm: Fixes for low power code
>
> Hi Santosh,
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > The series does below fixes to the omap3 low power code.
> > 	1. Use supported ARMv7 instructions instead of the legacy ones
> > 	2. Fix the MMU on sequence
> > 	3. Fix the cache flush scenario when only L1 lost.
> > 	4. Remove all un-necessary context save registers
> > 	5. Disable C-bit before cache clean
> > 	6. Use set_cr() exported API instead of custom one.
>
> Look like good cleanups, thanks.
>
> > It's generated against mainline and tested with OMAP3630 ZOOM3.
> > 	1. Renetion and off-mode mode in suspend - ok.
> > 	2. Retention in idle - ok
>
> Testing this series along with other PM changes queued up for
> mainline
> (my pm-core branch), this doesn't work for me on 3630/Zoom3 (but
> works
> fine on 3430/n900.)
>
> Here's what I did using omap2plus_defconfig + enabling CPUidle
>
> First tested suspend:
>
> echo 4 > /debug/pm_debug/wakeup_timer_seconds
> echo mem > /sys/power/state
>
> then, setup UART idle/wakeup:
>
> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
> echo enabled >
> /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
>
> then enabled idle:
>
> echo 1 > /debug/pm_debug/sleep_while_idle
>
> As soon as I do this, it hangs.
>
> Without your series, it's working fine for me.  Only after merging
> your series it hangs.
>

I rebased this series against latest pm-core branch which also
has Dave's THUMB2 series merged.

After few trials I managed to reproduce the issue. With
above steps it was still working for me but with off mode
enabled, I saw a lock-up in suspend. Further debugging, I
found that one CP15 register save/restore position was
swapped which lead to this. I fixed that.

I have pushed the rebased series on below branch.

git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
pm-core-omap3-asm

Regards,
Santosh
