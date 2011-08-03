From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 3 Aug 2011 17:02:07 +0530
Subject: spi/spi-pl022: Query on working of DMA mode
Message-ID: <4E3931B7.3010400@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Linus,

I am preparing few patches for spi-pl022 for "Allocating DMA channels as and when required".
And i found something strange.

When we have many transfers in a single message, following routines are called in
specified order:

tasklet_schedule(pump_transfers)
pump_transfers(unsigned long data)
configure_dma(pl022)
sg_alloc_table(&pl022->sgt_rx, pages, GFP_KERNEL);

Here, allocation is requested with GFP_KERNEL flag, from a tasklet.
Which gives following crash logs:

BUG: sleeping function called from invalid context at /data/csd_sw/spear/drives_os/vireshk/spear/kernel/linux-2.6/mm/slub.c:7
93
in_atomic(): 1, irqs_disabled(): 0, pid: 11, name: kworker/u:1
Backtrace: 
[<8003dabc>] (dump_backtrace+0x0/0x10c) from [<803aa4ec>] (dump_stack+0x18/0x1c)
 r6:00000001 r5:000000d0 r4:bf402200 r3:60000113
[<803aa4d4>] (dump_stack+0x0/0x1c) from [<8004f330>] (__might_sleep+0xec/0x10c)
[<8004f244>] (__might_sleep+0x0/0x10c) from [<800bbd2c>] (__kmalloc+0x74/0x110)
[<800bbcb8>] (__kmalloc+0x0/0x110) from [<8019f69c>] (sg_kmalloc+0x2c/0x30)
 r8:80541b40 r7:00000001 r6:00000001 r5:00000100 r4:bf47f1e8
r3:00000000
[<8019f670>] (sg_kmalloc+0x0/0x30) from [<8019f710>] (__sg_alloc_table+0x70/0x118)
[<8019f6a0>] (__sg_alloc_table+0x0/0x118) from [<8019f7e0>] (sg_alloc_table+0x28/0x54)
[<8019f7b8>] (sg_alloc_table+0x0/0x54) from [<802649a0>] (configure_dma+0x230/0x3fc)
 r5:bf47def8 r4:bf47f150
[<80264770>] (configure_dma+0x0/0x3fc) from [<8026509c>] (pump_transfers+0xcc/0x100)
[<80264fd0>] (pump_transfers+0x0/0x100) from [<8005ecb0>] (tasklet_action+0xb0/0x160)
 r7:805203c4 r6:bf488000 r5:bf47f1a0 r4:bf47f19c
[<8005ec00>] (tasklet_action+0x0/0x160) from [<8005f104>] (__do_softirq+0xa4/0x13c)
[<8005f060>] (__do_softirq+0x0/0x13c) from [<8005f590>] (irq_exit+0x4c/0x54)
[<8005f544>] (irq_exit+0x0/0x54) from [<80034094>] (asm_do_IRQ+0x94/0xd0)
[<80034000>] (asm_do_IRQ+0x0/0xd0) from [<800396f4>] (__irq_svc+0x34/0xc0)
Exception stack(0xbf489e90 to 0xbf489ed8)


Now, i didn't get them earlier due to a mistake of mine. I have updated
pl022_ssp_controller.enable_dma = 1,
but didn't do pl022_config_chip.com_mode = DMA_TRANSFER

So, finally DMA channels are allocated but never used, as both above must have
been set.
Today only I came to know of this mistake, and found it is actually not
working, with above crash occurring.

Is DMA mode working in your case?

-- 
viresh
