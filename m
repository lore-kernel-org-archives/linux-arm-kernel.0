From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 24 Sep 2018 18:01:33 +0200
Subject: [PATCH v5 07/14] irqchip/irq-mvebu-sei: add new driver for
 Marvell SEI
In-Reply-To: <86pnx7x5pz.wl-marc.zyngier@arm.com>
References: <20180830073535.10710-1-miquel.raynal@bootlin.com>
 <20180830073535.10710-8-miquel.raynal@bootlin.com>
 <86pnx7x5pz.wl-marc.zyngier@arm.com>
Message-ID: <20180924180133.2ea93762@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> > +
> > +static int mvebu_sei_cp_domain_alloc(struct mvebu_sei *sei)
> > +{
> > +	int hwirq;
> > +
> > +	mutex_lock(&sei->cp_msi_lock);
> > +	hwirq = find_first_zero_bit(sei->cp_msi_bitmap,
> > +				    sei->caps->cp_range.size);
> > +	set_bit(hwirq, sei->cp_msi_bitmap);
> > +	mutex_unlock(&sei->cp_msi_lock);
> > +
> > +	return hwirq;
> > +}
> > +
> > +static void mvebu_sei_cp_domain_free(struct mvebu_sei *sei, int hwirq)
> > +{
> > +	mutex_lock(&sei->cp_msi_lock);
> > +	clear_bit(hwirq, sei->cp_msi_bitmap);
> > +	mutex_unlock(&sei->cp_msi_lock);
> > +}
> > +
> > +static int mvebu_sei_irq_domain_alloc(struct irq_domain *domain,
> > +				      unsigned int virq, unsigned int nr_irqs,
> > +				      void *args)
> > +{
> > +	struct mvebu_sei *sei = domain->host_data;
> > +	struct irq_fwspec *fwspec = args;
> > +	int hwirq;
> > +	int ret;
> > +
> > +	/* The software only supports single allocations for now */
> > +	if (nr_irqs != 1)
> > +		return -ENOTSUPP;
> > +
> > +	hwirq = mvebu_sei_cp_domain_alloc(sei);
> > +	if (hwirq < 0)
> > +		return -ENOSPC;
> > +
> > +	fwspec->fwnode = domain->parent->fwnode;
> > +	fwspec->param_count = 3;
> > +	fwspec->param[0] = GIC_SPI;
> > +	fwspec->param[1] = 0;  
> 
> On first approximation, this deserves a good comment about 0
> representing INTID 32 at the GIC level. Then, another question is why
> this doesn't come from DT. I bet that in the future, this block will
> be reused and you'll find more than one is a single chip.

About the 0, sure, if we maintain this code, I should probably derive
the value from DT.

> 
> But the real question is why you are constantly calling
> irq_alloc_irqs_parent. I remember commenting about this in my previous
> round of review, and I still see this.

I really tried to remove it but I clearly failed. When there is
no irq_alloc_irqs_parent() call in mvebu_sei_irq_domain_alloc() it looks
like something is missing and I get a oops at probe time.

This is the oops:

[    3.112148] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000e8
[    3.120970] Mem abort info:
[    3.123775]   ESR = 0x96000004
[    3.126842]   Exception class = DABT (current EL), IL = 32 bits
[    3.132787]   SET = 0, FnV = 0
[    3.135853]   EA = 0, S1PTW = 0
[    3.139006] Data abort info:
[    3.141897]   ISV = 0, ISS = 0x00000004
[    3.145749]   CM = 0, WnR = 0
[    3.148728] [00000000000000e8] user address but active_mm is swapper
[    3.155110] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[    3.160705] Modules linked in:
[    3.163777] CPU: 0 PID: 35 Comm: kworker/0:1 Not tainted 4.19.0-rc1-00024-g1ff609093efd-dirty #1931
[    3.172861] Hardware name: Marvell Armada 7040 DB board (DT)
[    3.178556] Workqueue: events deferred_probe_work_func
[    3.183719] pstate: 60000085 (nZCv daIf -PAN -UAO)
[    3.188535] pc : irq_set_irqchip_state+0x160/0x1a0
[    3.193348] lr : irq_set_irqchip_state+0x160/0x1a0
[    3.198158] sp : ffff000009d037f0
[    3.201486] x29: ffff000009d037f0 x28: ffff000008e49d20 
[    3.206824] x27: ffff000008e49cb0 x26: 0000000000000000 
[    3.212161] x25: 0000000000000000 x24: ffff000008ad2570 
[    3.217498] x23: ffff8000e8f80c00 x22: ffff0000093e9000 
[    3.222835] x21: 0000000000000033 x20: 0000000000000000 
[    3.228172] x19: ffff8000e8bdf300 x18: ffffffffffffffff 
[    3.233509] x17: 0000000000000000 x16: 0000000000000000 
[    3.238846] x15: ffff0000093e96c8 x14: ffff0000895436bf 
[    3.244182] x13: ffff0000095436cd x12: ffff0000094010c8 
[    3.249519] x11: ffff000009401000 x10: 0000000005f5e0ff 
[    3.254856] x9 : ffff000009d034f0 x8 : 325b206574617473 
[    3.260192] x7 : 5f70696863717269 x6 : ffff0000085cd238 
[    3.265529] x5 : 0000000000000000 x4 : 0000000000000000 
[    3.270866] x3 : ffffffffffffffff x2 : 337acc4b0d752600 
[    3.276202] x1 : 0000000000000000 x0 : 000000000000001c 
[    3.281540] Process kworker/0:1 (pid: 35, stack limit = 0x(____ptrval____))
[    3.288530] Call trace:
[    3.290987]  irq_set_irqchip_state+0x160/0x1a0
[    3.295452]  mvebu_icu_irq_domain_alloc+0x180/0x208
[    3.300351]  __irq_domain_alloc_irqs+0x138/0x2a0
[    3.304988]  irq_create_fwspec_mapping+0x140/0x328
[    3.309799]  irq_create_of_mapping+0x78/0xa0
[    3.314089]  of_irq_get+0x88/0xf8
[    3.317419]  platform_get_irq+0x24/0x178
[    3.321360]  armada_thermal_probe+0x110/0x668
[    3.325735]  platform_drv_probe+0x50/0xb0
[    3.329763]  really_probe+0x1fc/0x290
[    3.333441]  driver_probe_device+0x58/0x100
[    3.337643]  __device_attach_driver+0x9c/0xf8
[    3.342019]  bus_for_each_drv+0x70/0xc8
[    3.345872]  __device_attach+0xe0/0x140
[    3.349725]  device_initial_probe+0x10/0x18
[    3.353926]  bus_probe_device+0x94/0xa0
[    3.357779]  deferred_probe_work_func+0x6c/0xa0
[    3.362331]  process_one_work+0x1dc/0x330
[    3.366359]  worker_thread+0x23c/0x430
[    3.370124]  kthread+0xf8/0x128
[    3.373280]  ret_from_fork+0x10/0x18
[    3.376872] Code: aa1803e1 aa1c03e0 528119a2 97fff760 (f9407680) 
[    3.382992] ---[ end trace f423829cb4b1c06c ]---


The faulty instruction is the if statement there: 
https://elixir.bootlin.com/linux/v4.19-rc5/source/kernel/irq/manage.c#L2243


I added traces to understand what is going on. The do-while loop gets
an irq_data structure, derives the chip pointer, then look at its
->set_irqchip_state() callback. It it does not exist, it tries with its
parent irq_data.

Here are the traces that show why the oops happens when
irq_alloc_irqs_parent() is not called:

With irq_alloc_irqs_parent() (running exactly what I sent in the series):

[    2.993887] irq_set_irqchip_state [2244] irq_data ptr: 0xffff8000e8f80c28 [    3.000703] irq_set_irqchip_state [2246]   chip ptr: 0xffff000009401538 (name: none)
[    3.008480] irq_set_irqchip_state [2249]   parent irq_data ptr ? 0xffff8000e8bdf200

[    3.024045] irq_set_irqchip_state [2244] irq_data ptr: 0xffff8000e8bdf200
[    3.030861] irq_set_irqchip_state [2246]   chip ptr: 0xffff00000941b658 (name: SEI MSI controller)
[    3.039857] irq_set_irqchip_state [2249]   parent irq_data ptr ? 0xffff8000e8bdf280

[    3.055420] irq_set_irqchip_state [2244] irq_data ptr: 0xffff8000e8bdf280
[    3.062236] irq_set_irqchip_state [2246]   chip ptr: 0xffff00000941b3e8 (name: CP SEI)
[    3.070185] irq_set_irqchip_state [2249]   parent irq_data ptr ? 0xffff8000e8bdf300

[    3.085750] irq_set_irqchip_state [2244] irq_data ptr: 0xffff8000e8bdf300
[    3.092566] irq_set_irqchip_state [2246]   chip ptr: 0x0000000000000000 (name: (null))
[    3.100515] irq_set_irqchip_state [2249]   parent irq_data ptr ? 0x0000000000000000

Without irq_alloc_irqs_parent() (same code base, with the call to this function commented out):

[    2.992364] irq_set_irqchip_state [2244] irq_data: 0xffff8000e7cb7228
[    2.999181] irq_set_irqchip_state [2246]   chip: 0xffff000009401538 (name: none)
[    3.006956] irq_set_irqchip_state [2249]   parent irq_data: 0xffff8000e93a9e00

[    3.022520] irq_set_irqchip_state [2244] irq_data: 0xffff8000e93a9e00
[    3.029337] irq_set_irqchip_state [2246]   chip: 0xffff00000941b658 (name: SEI MSI controller)
[    3.038333] irq_set_irqchip_state [2249]   parent irq_data: 0xffff8000e93a9e80

[    3.053896] irq_set_irqchip_state [2244] irq_data: 0xffff8000e93a9e80
[    3.060713] irq_set_irqchip_state [2246]   chip: 0xffff00000941b3e8 (name: CP SEI)
[    3.068662] irq_set_irqchip_state [2249]   parent irq_data: 0xffff8000e93a9f00

[    3.084225] irq_set_irqchip_state [2244] irq_data: 0xffff8000e93a9f00
[    3.091041] irq_set_irqchip_state [2246]   chip: 0xffff0000093ec148 (name: GICv2)
[    3.098903] irq_set_irqchip_state [2249]   parent irq_data: 0x0000000000000000


The difference is that at this stage, the irq_data->chip pointer of the
SEI controller _parent_ (ie. the GIC's chip pointer) is not valid. I
digged a lot in this direction during your vacations to find out what I
missed, and I ended up calling back irq_alloc_irqs_parent().

If you have an idea of how to handle this properly, I am all ears!

> 
> The whole SEI thing is a chained interrupt controller, a
> multiplexer. The output interrupt is known at probe time, and never
> change. You also have code to that effect in the probe routine. So
> what is this exactly? Dead code?
> 
> > +	/*
> > +	 * Assume edge rising for now, it will be properly set when
> > +	 * ->set_type() is called
> > +	 */
> > +	fwspec->param[2] = IRQ_TYPE_EDGE_RISING;
> > +	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, fwspec);
> > +	if (ret)
> > +		goto free_irq;
> > +

[...]

> > +
> > +struct mvebu_sei_caps mvebu_sei_ap806_caps = {
> > +	.ap_range = {
> > +		.first = 0,
> > +		.size = 21,
> > +	},
> > +	.cp_range = {
> > +		.first = 21,
> > +		.size = 43,
> > +	},  
> 
> I'd appreciate some symbolic constants instead of magic numbers.

I can definitely use symbolic constants but these numbers are already
quite meaningful, the constants could be named:

    SEI_AP806_FIRST_INT_IN_AP_RANGE
    SEI_AP806_SIZE_OF_AP_RANGE

> 
> > +};
> > +
> > +static const struct of_device_id mvebu_sei_of_match[] = {
> > +	{
> > +		.compatible = "marvell,ap806-sei",
> > +		.data = &mvebu_sei_ap806_caps,
> > +	},
> > +	{},
> > +};
> > +
> > +static struct platform_driver mvebu_sei_driver = {
> > +	.probe  = mvebu_sei_probe,
> > +	.driver = {
> > +		.name = "mvebu-sei",
> > +		.of_match_table = mvebu_sei_of_match,
> > +	},
> > +};
> > +builtin_platform_driver(mvebu_sei_driver);
> > -- 
> > 2.17.1
> >   
> 
> Thanks,
> 
> 	M.
> 


Thanks,
Miqu?l
