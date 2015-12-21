From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Dec 2015 00:11:32 +0100
Subject: [PATCH v2 0/8] Raspberry Pi 2 support.
In-Reply-To: <20151220221158.GA6416@omega>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <20151218100826.GB1145@omega> <20151220221158.GA6416@omega>
Message-ID: <201512220011.32234.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 20 December 2015, Alexander Aring wrote:
> On Fri, Dec 18, 2015 at 11:08:26AM +0100, Alexander Aring wrote:
> > [    0.000000] Memory policy: Data cache writeback
> > [    0.000000] BUG: mapping for 0x3f201000 at 0xf0201000 out of vmalloc space

This is a separate bug, right?

> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm/kernel/devtree.c:149 arm_dt_init_cpu_maps+0x100/0x1a4()
> > [    0.000000] DT /cpu 2 nodes greater than max cores 1, capping them
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.0-rc5+ #989
> > [    0.000000] Hardware name: BCM2835
> > [    0.000000] [<c0016c4c>] (unwind_backtrace) from [<c0013e58>] (show_stack+0x20/0x24)
> > [    0.000000] [<c0013e58>] (show_stack) from [<c0247620>] (dump_stack+0x20/0x28)
> > [    0.000000] [<c0247620>] (dump_stack) from [<c0023a84>] (warn_slowpath_common+0x9c/0xc4)
> > [    0.000000] [<c0023a84>] (warn_slowpath_common) from [<c0023aec>] (warn_slowpath_fmt+0x40/0x48)
> > [    0.000000] [<c0023aec>] (warn_slowpath_fmt) from [<c074ef94>] (arm_dt_init_cpu_maps+0x100/0x1a4)
> > [    0.000000] [<c074ef94>] (arm_dt_init_cpu_maps) from [<c074e60c>] (setup_arch+0x6f4/0x89c)
> > [    0.000000] [<c074e60c>] (setup_arch) from [<c074b9cc>] (start_kernel+0x74/0x3a4)
> > [    0.000000] [<c074b9cc>] (start_kernel) from [<00008078>] (0x8078)
> > [    0.000000] ---[ end trace cb88537fdc8fa200 ]---
> > [    0.000000] DT missing boot CPU MPIDR[23:0], fall back to default cpu_logical_map
> > [    0.000000] CPU: All CPU(s) started in SVC mode.
> 
> I can remove this WARNING when I enable CONFIG_SMP.

I think we should try to change this in the code.

> > [    0.000000] Virtual kernel memory layout:
> > [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> > [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> > [    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
> > [    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
> > [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> > [    0.000000]       .text : 0xc0008000 - 0xc074a7cc   (7434 kB)
> > [    0.000000]       .init : 0xc074b000 - 0xc07b4000   ( 420 kB)
> > [    0.000000]       .data : 0xc07b4000 - 0xc081e910   ( 427 kB)
> > [    0.000000]        .bss : 0xc081e910 - 0xc08ca80c   ( 688 kB)
> > [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> > [    0.000000] NR_IRQS:16 nr_irqs:16 16
> > [    0.000000] Kernel panic - not syncing: /soc/local_intc: unable to map local interrupt registers
> > [    0.000000] 
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Tainted: G        W       4.4.0-rc5+ #989
> > [    0.000000] Hardware name: BCM2835
> > [    0.000000] [<c0016c4c>] (unwind_backtrace) from [<c0013e58>] (show_stack+0x20/0x24)
> > [    0.000000] [<c0013e58>] (show_stack) from [<c0247620>] (dump_stack+0x20/0x28)
> > [    0.000000] [<c0247620>] (dump_stack) from [<c00c17c0>] (panic+0x84/0x210)
> > [    0.000000] [<c00c17c0>] (panic) from [<c0771d5c>] (bcm2836_arm_irqchip_l1_intc_of_init+0x94/0x110)
> > [    0.000000] [<c0771d5c>] (bcm2836_arm_irqchip_l1_intc_of_init) from [<c0779f04>] (of_irq_init+0x1a0/0x2a8)
> > [    0.000000] [<c0779f04>] (of_irq_init) from [<c0771af4>] (irqchip_init+0x14/0x1c)
> > [    0.000000] [<c0771af4>] (irqchip_init) from [<c074d7a8>] (init_IRQ+0x28/0x88)
> > [    0.000000] [<c074d7a8>] (init_IRQ) from [<c074bb64>] (start_kernel+0x20c/0x3a4)
> > [    0.000000] [<c074bb64>] (start_kernel) from [<00008078>] (0x8078)
> > [    0.000000] ---[ end Kernel panic - not syncing: /soc/local_intc: unable to map local interrupt registers
> > 
> 
> But still getting this panic, your patches does not contain some
> defconfig, so I still try to figure out what I need to enable to get it
> working. Maybe it is some missing config entry which should be enabled.
> 
> But, for me it looks like some devicetree issue, because of_iomem returns
> NULL, at [0]. Don't know what I am doing wrong.

That is the most likely cause, yes. You can try replacing it with an ioremap with a
hardcoded physical address to see if that works.

	Arnd
