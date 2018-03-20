From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Tue, 20 Mar 2018 18:13:06 +0800
Subject: Failed to boot ARM64 boards for recent linux-next
In-Reply-To: <fe56e7e3-50dd-88de-ce61-f3cbcc1f572b@rock-chips.com>
References: <dae4b3b8-3da4-4a86-ac4a-0631802fa546@rock-chips.com>
 <077cecdd-7982-dd33-454f-e38cc571366c@arm.com>
 <9cff515e-fcb9-a1c0-329b-a18c3bed0071@rock-chips.com>
 <fe56e7e3-50dd-88de-ce61-f3cbcc1f572b@rock-chips.com>
Message-ID: <5AB0DEB2.4000803@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 03/20/2018 05:39 PM, Shawn Lin wrote:
>
>
> Also another patch warns a lot when booting the kernel. Is there
> anything else I could do to let it go? Seems I am using broken
> dts for requesting IRQ_TYPE_NONE there?

could be:
https://github.com/torvalds/linux/blob/master/drivers/irqchip/irq-gic-v3.c#L1145

		struct irq_fwspec ppi_fwspec = {
			.fwnode		= gic_data.fwnode,
			.param_count	= 3,
			.param		= {
				[0]	= 1,
				[1]	= i,
				[2]	= IRQ_TYPE_NONE, <--
			},
		};

		irq = irq_create_fwspec_mapping(&ppi_fwspec);


>
> [    0.000000] WARNING: CPU: 0 PID: 0 at
> drivers/irqchip/irq-gic-v3.c:909 gic_irq_domain_translate+0x84/0xe8
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 4.16.0-rc6-next-20180320-00006-g841c1d1-dirty #257
> [    0.000000] Hardware name: Excavator-RK3399 Board (DT)
> [    0.000000] pstate: 60000085 (nZCv daIf -PAN -UAO)
> [    0.000000] pc : gic_irq_domain_translate+0x84/0xe8
> [    0.000000] lr : irq_create_fwspec_mapping+0x64/0x328
> [    0.000000] sp : ffff000009033cb0
> [    0.000000] x29: ffff000009033cb0 x28: 0000000000000002
> [    0.000000] x27: ffff8000f280fc90 x26: 0000000000000003
> [    0.000000] x25: 0000000000000000 x24: ffff8000f280fc80
> [    0.000000] x23: ffff00000903c8f8 x22: ffff00000903c000
> [    0.000000] x21: ffff000009033d88 x20: ffff000009039000
> [    0.000000] x19: ffff8000f2825000 x18: ffffffffffffffff
> [    0.000000] x17: 000000000000000a x16: 00000000000007ff
> [    0.000000] x15: ffff0000090396c8 x14: 31407570632f7375
> [    0.000000] x13: 70632f207b205d31 x12: 5b312d6e6f697469
> [    0.000000] x11: 747261702d747075 x10: 727265746e69206e
> [    0.000000] x9 : 6f69746974726170 x8 : 407570632f737570
> [    0.000000] x7 : 0000000000000000 x6 : 0000000000000002
> [    0.000000] x5 : 0000000000000001 x4 : ffff000008c153f8
> [    0.000000] x3 : ffff000009033cec x2 : ffff000009033cf0
> [    0.000000] x1 : ffff000009033d88 x0 : 0000000000000000
> [    0.000000] Call trace:
> [    0.000000]  gic_irq_domain_translate+0x84/0xe8
> [    0.000000]  gic_populate_ppi_partitions+0x1fc/0x280
> [    0.000000]  gic_of_init+0x174/0x214
> [    0.000000]  of_irq_init+0x180/0x2e8
> [    0.000000]  irqchip_init+0x14/0x38
> [    0.000000]  init_IRQ+0xfc/0x130
> [    0.000000]  start_kernel+0x284/0x414
> [    0.000000] ---[ end trace 5a16819db6b2d5d2 ]---
>
> commit 6ef6386ef7c15bea21afce06f951c87de7e2a562
> Author: Marc Zyngier <marc.zyngier@arm.com>
> Date:   Fri Mar 16 14:35:17 2018 +0000
>
>      irqchip/gic-v3: Loudly complain about the use of IRQ_TYPE_NONE
>
>      There is a huge number of broken device trees out there. Just
>      grepping through the tree for the use of IRQ_TYPE_NONE in conjunction
>      with the GIC is scary.
>
>      People just don't realise that IRQ_TYPE_NONE just doesn't exist, and
>      you just get whatever junk was there before. So let's make them aware
>      of the issue.
>
>      Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
