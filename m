From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Jan 2015 14:14:08 -0800
Subject: Regression with legacy IRQ numbers caused by 9a1091ef0017
Message-ID: <20150114221407.GS2419@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Looks like the legacy IRQ numbers are now all wrong at least for omap4
since commit 9a1091ef0017 ("irqchip: gic: Support hierarchy irq domain.").

Instead of this:

# cat /proc/interrupts 
            CPU0       CPU1       
 29:       1124        981       GIC  29  twd
 39:          0          0       GIC  39  TWL6030-PIH
 41:          0          0       GIC  41  l3-dbg-irq
 42:          0          0       GIC  42  l3-app-irq
 44:          0          0       GIC  44  DMA
 45:       7854          0       GIC  45  omap-dma-engine
 52:          0          0       GIC  52  gpmc
...


We now have:

# cat /proc/interrupts 
            CPU0       CPU1       
 16:        343          0       GIC  69  gp_timer
 17:       1160       1017       GIC  29  twd
 18:          0          0       GIC  41  l3-dbg-irq
 19:          1          0       GIC  42  l3-app-irq
 22:       7850          0       GIC  45  omap-dma-engine
 44:          0          0  4a310000.gpio  18  DMA
 61:       2730          0  48055000.gpio   2  eth0
223:          0          0       GIC  52  gpmc
...

So the DMA interrupt using the legacy mapping with something like
irq = 12 + OMAP44XX_IRQ_GIC_START now is wrong and unfortunately
at least omaps still have a bunch of the legacy interrupts still
around.

And that naturally produces all kinds of strange errors like:

WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x214/0x340()
44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Idle): Data Access in Supervisor mode during Functional access
...
[<c05f21e4>] (__irq_svc) from [<c05f1974>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[<c05f1974>] (_raw_spin_unlock_irqrestore) from [<c00914a8>] (__setup_irq+0x244/0x530)
[<c00914a8>] (__setup_irq) from [<c00917d4>] (setup_irq+0x40/0x8c)
[<c00917d4>] (setup_irq) from [<c0039c8c>] (omap_system_dma_probe+0x1d4/0x2b4)
[<c0039c8c>] (omap_system_dma_probe) from [<c03b2200>] (platform_drv_probe+0x44/0xa4)
...

Looks like the logic changed from:

if (of_property_read_u32(node, "arm,routable-irqs", &nr_routable_irqs))

to just

if (node)

Which now causes irq_domain_add_linear() to be called instead of
irq_domain_add_legacy(), which causes the breakage.

Anybody got a sane fix in mind for the -rc series, or should we just
revert it for now?

Regards,

Tony
