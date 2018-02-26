From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 26 Feb 2018 16:16:19 +0100
Subject: [PATCHv2 6/8] arm_pmu: explicitly enable/disable SPIs at hotplug
In-Reply-To: <20180205164202.26502-7-mark.rutland@arm.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
 <20180205164202.26502-7-mark.rutland@arm.com>
Message-ID: <CAMuHMdU9UPhKdNGknZDkrzWDE75sKDdbMNu4RFfU25eVEswLkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Feb 5, 2018 at 5:42 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> To support ACPI systems, we need to request IRQs before CPUs are
> hotplugged, and thus we need to request IRQs before we know their
> associated PMU.
>
> This is problematic if a PMU IRQ is pending out of reset, as it may be
> taken before we know the PMU, and thus the IRQ handler won't be able to
> handle it, leaving it screaming.
>
> To avoid such problems, lets request all IRQs in a disabled state, and
> explicitly enable/disable them at hotplug time, when we're sure the PMU
> has been probed.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

This is now commit 6de3f79112cc26bf in v4.16-rc3, and causes a BUG during
CPU offlining (e.g. during system suspend, or during boot with
CONFIG_ARM_PSCI_CHECKER=y).

With CONFIG_ARM_PSCI_CHECKER=y:

psci_checker: PSCI checker started using 6 CPUs
psci_checker: Starting hotplug tests
psci_checker: Trying to turn off and on again all CPUs
BUG: sleeping function called from invalid context at kernel/irq/manage.c:112
in_atomic(): 1, irqs_disabled(): 128, pid: 15, name: migration/1
no locks held by migration/1/15.
irq event stamp: 192
hardirqs last  enabled at (191): [<00000000803c2507>]
_raw_spin_unlock_irq+0x2c/0x4c
hardirqs last disabled at (192): [<000000007f57ad28>] multi_cpu_stop+0x9c/0x140
softirqs last  enabled at (0): [<0000000004ee1b58>]
copy_process.isra.77.part.78+0x43c/0x1504
softirqs last disabled at (0): [<          (null)>]           (null)
CPU: 1 PID: 15 Comm: migration/1 Not tainted 4.16.0-rc3-salvator-x #1651
Hardware name: Renesas Salvator-X board based on r8a7796 (DT)
Call trace:
 dump_backtrace+0x0/0x140
 show_stack+0x14/0x1c
 dump_stack+0xb4/0xf0
 ___might_sleep+0x1fc/0x218
 __might_sleep+0x70/0x80
 synchronize_irq+0x40/0xa8
 disable_irq+0x20/0x2c
 arm_perf_teardown_cpu+0x80/0xac
 cpuhp_invoke_callback+0x5a0/0xd18
 take_cpu_down+0x84/0xc4
 multi_cpu_stop+0xb0/0x140
 cpu_stopper_thread+0xbc/0x128
 smpboot_thread_fn+0x218/0x234
 kthread+0x11c/0x124
 ret_from_fork+0x10/0x18
CPU1: shutdown
psci: CPU1 killed.

Reverting that commit on v4.16-rc3 fixes the issue.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
