From: minghuan.lian@nxp.com (M.H. Lian)
Date: Fri, 6 Jan 2017 08:23:51 +0000
Subject: [PATCH v2,9/9] irqchip/ls-scfg-msi: add MSI affinity support
In-Reply-To: <7888f3a1-ae4a-f2b6-f41b-fc414f7ca968@arm.com>
References: <1483603837-4629-1-git-send-email-Minghuan.Lian@nxp.com>
 <1483603837-4629-9-git-send-email-Minghuan.Lian@nxp.com>
 <7888f3a1-ae4a-f2b6-f41b-fc414f7ca968@arm.com>
Message-ID: <VI1PR04MB1615683AF0EAE68CAB22154DE8630@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Thanks for your review.
Please see my comments inline.

Thanks,
Minghuan

> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Thursday, January 05, 2017 11:33 PM
> To: M.H. Lian <minghuan.lian@nxp.com>; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org
> Cc: Rob Herring <robh@kernel.org>; Jason Cooper
> <jason@lakedaemon.net>; Roy Zang <roy.zang@nxp.com>; Mingkai Hu
> <mingkai.hu@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>; Leo Li
> <leoyang.li@nxp.com>; Scott Wood <scott.wood@nxp.com>
> Subject: Re: [PATCH v2,9/9] irqchip/ls-scfg-msi: add MSI affinity support
> 
> On 05/01/17 08:10, Minghuan Lian wrote:
> > For LS1046a and LS1043a v1.1, the MSI controller has 4 MSIRs and 4
> > CPUs. A GIC SPI interrupt of MSIR can be associated with a CPU.
> > When changing MSI interrupt affinity, this MSI will be moved to the
> > corresponding MSIR and MSI message data will be changed according to
> > MSIR. when requesting a MSI, the bits of all 4 MSIR will be reserved.
> > The parameter 'msi_affinity_flag' is provide to change this mode.
> > "lsmsi=no-affinity" will disable affinity, all MSI can only be
> > associated with CPU 0.
> >
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> > ---
> > v2-v1:
> > - None
> >
> >  drivers/irqchip/irq-ls-scfg-msi.c | 75
> > ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 70 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-ls-scfg-msi.c
> > b/drivers/irqchip/irq-ls-scfg-msi.c
> > index dc19569..753fe39 100644
> > --- a/drivers/irqchip/irq-ls-scfg-msi.c
> > +++ b/drivers/irqchip/irq-ls-scfg-msi.c
> > @@ -40,6 +40,7 @@ struct ls_scfg_msir {
> >  	unsigned int gic_irq;
> >  	unsigned int bit_start;
> >  	unsigned int bit_end;
> > +	unsigned int srs; /* Shared interrupt register select */
> >  	void __iomem *reg;
> >  };
> >
> > @@ -70,6 +71,19 @@ struct ls_scfg_msi {
> >  	.chip	= &ls_scfg_msi_irq_chip,
> >  };
> >
> > +static int msi_affinity_flag = 1;
> > +
> > +static int __init early_parse_ls_scfg_msi(char *p) {
> > +	if (p && strncmp(p, "no-affinity", 11) == 0)
> > +		msi_affinity_flag = 0;
> > +	else
> > +		msi_affinity_flag = 1;
> > +
> > +	return 0;
> > +}
> > +early_param("lsmsi", early_parse_ls_scfg_msi);
> 
> What is the point of this option? If feels like an unnecessary complexity.
[Minghuan Lian] For LS1043a rev1.1, there are only 8 MSI interrupts for each MSI controller when enable affinity.
(32 MSI interrupts are evenly distributed to 4 cores).  3 MSI controllers can only provide 32 MSI interrupts.
When disable affinity, the MSI interrupts number of 3 controllers can up to 32*3= 96.
32 MSI interrupts may be not enough.
For example: an Ethernet card with 4 ports, each port needs 4 RX, 4TX and 1 error interrupts, totally need 4*(4+4+1)
36 MSI interrupts.
With the parameter "lsmsi=no-affinity" this Ethernet card can work well, although the performance is poor.
  
> 
> > +
> >  static void ls_scfg_msi_compose_msg(struct irq_data *data, struct
> > msi_msg *msg)  {
> >  	struct ls_scfg_msi *msi_data = irq_data_get_irq_chip_data(data);
> @@
> > -77,12 +91,43 @@ static void ls_scfg_msi_compose_msg(struct irq_data
> *data, struct msi_msg *msg)
> >  	msg->address_hi = upper_32_bits(msi_data->msiir_addr);
> >  	msg->address_lo = lower_32_bits(msi_data->msiir_addr);
> >  	msg->data = data->hwirq;
> > +
> > +	if (msi_affinity_flag) {
> > +		u32 msir_index;
> > +
> > +		msir_index = cpumask_first(data->common->affinity);
> > +		if (msir_index >= msi_data->msir_num)
> > +			msir_index = 0;
> 
> How can this happen?
[Minghuan Lian]  This will never happen. I will remove this "if" sentence. 

> 
> > +
> > +		msg->data |= msir_index;
> 
> How do you guarantee that the low bits were clear? Please document the
> way you encode your MSI payload.
[Minghuan Lian] the available message data is a bytes.
   7    6  5  4  3   2    1    0
| - |       ibs           |   srs |

SRS  bit 0-1  is used to select MSIR register/CPU.  A MSIR is associated with a CPU.
IBS bit2-6 of ls1046,  bit2-4 for ls1043 is used to select bit of the MSIR. 
When enable affinity,  only bits of MSIR0(srs = 0 cpu0) is be freed for requesting MSI.
all bits of the MSIR1-3(cpu1-3) are reserved to be sure this MSI can be successfully associated with cpu 1-3.
So, When requesting a MSI interrupt, srs always is 0. 
The hwirq always equals bits number of the MSIR0(SRS = 0).
First, MSI message data payload equals hwirq, and then plus the real SRS according to smp_affinity.
This MSI interrupt will be routed to the corresponding the MSIR/CPU.



> 
> > +	}
> >  }
> >
> >  static int ls_scfg_msi_set_affinity(struct irq_data *irq_data,
> >  				    const struct cpumask *mask, bool force)  {
> > -	return -EINVAL;
> > +	struct ls_scfg_msi *msi_data = irq_data_get_irq_chip_data(irq_data);
> > +	u32 cpu;
> > +
> > +	if (!msi_affinity_flag)
> > +		return -EINVAL;
> > +
> > +	if (!force)
> > +		cpu = cpumask_any_and(mask, cpu_online_mask);
> > +	else
> > +		cpu = cpumask_first(mask);
> > +
> > +	if (cpu >= msi_data->msir_num)
> > +		return -EINVAL;
> > +
> > +	if (msi_data->msir[cpu].gic_irq <= 0) {
> > +		pr_warn("cannot bind the irq to cpu%d\n", cpu);
> 
> Please don't. Returning an error is enough. If you really want to have
> something, turn it into a proper debug message.
[Minghuan Lian] ok, I will change it.
> 
> > +		return -EINVAL;
> > +	}
> > +
> > +	cpumask_copy(irq_data->common->affinity, mask);
> > +
> > +	return IRQ_SET_MASK_OK;
> >  }
> >
> >  static struct irq_chip ls_scfg_msi_parent_chip = { @@ -158,7 +203,7
> > @@ static void ls_scfg_msi_irq_handler(struct irq_desc *desc)
> >
> >  	for_each_set_bit_from(pos, &val, size) {
> >  		hwirq = ((msir->bit_end - pos) << msi_data->cfg->ibs_shift) |
> > -			msir->index;
> > +			msir->srs;
> >  		virq = irq_find_mapping(msi_data->parent, hwirq);
> >  		if (virq)
> >  			generic_handle_irq(virq);
> > @@ -221,10 +266,19 @@ static int ls_scfg_msi_setup_hwirq(struct
> ls_scfg_msi *msi_data, int index)
> >  					 ls_scfg_msi_irq_handler,
> >  					 msir);
> >
> > +	if (msi_affinity_flag) {
> > +		/* Associate MSIR interrupt to the cpu */
> > +		irq_set_affinity(msir->gic_irq, get_cpu_mask(index));
> > +		msir->srs = 0; /* This value is determined by the CPU */
> > +	} else
> > +		msir->srs = index;
> > +
> >  	/* Release the hwirqs corresponding to this MSIR */
> > -	for (i = 0; i < msi_data->cfg->msir_irqs; i++) {
> > -		hwirq = i << msi_data->cfg->ibs_shift | msir->index;
> > -		bitmap_clear(msi_data->used, hwirq, 1);
> > +	if (!msi_affinity_flag || msir->index == 0) {
> > +		for (i = 0; i < msi_data->cfg->msir_irqs; i++) {
> > +			hwirq = i << msi_data->cfg->ibs_shift | msir->index;
> > +			bitmap_clear(msi_data->used, hwirq, 1);
> > +		}
> >  	}
> >
> >  	return 0;
> > @@ -316,6 +370,17 @@ static int ls_scfg_msi_probe(struct
> platform_device *pdev)
> >  	bitmap_set(msi_data->used, 0, msi_data->irqs_num);
> >
> >  	msi_data->msir_num = of_irq_count(pdev->dev.of_node);
> > +
> > +	if (msi_affinity_flag) {
> > +		u32 cpu_num;
> > +
> > +		cpu_num = num_possible_cpus();
> > +		if (msi_data->msir_num >= cpu_num)
> > +			msi_data->msir_num = cpu_num;
> > +		else
> > +			msi_affinity_flag = 0;
> > +	}
> > +
> >  	msi_data->msir = devm_kcalloc(&pdev->dev, msi_data->msir_num,
> >  				      sizeof(*msi_data->msir),
> >  				      GFP_KERNEL);
> >
> 
> This is a very confusing patch. Please get rid of this useless option and
> document how you encode the routing in the hwirq.
[Minghuan Lian]  Both LS1021a and LS1043av1.0 have only a MSIR, a gic interrupt.
MSI controllers cannot support affinity.
Then LS1046a/LS1043av1.1 extends MSIR number to 4 same to cpu number. So each MSIR with a GIC interrupt can be associated with a cpu.
To keep simple, the first patch for ls1046 and ls1043av1.1 keep the same way with ls1021 and ls1043av1.0 that does not support affinity and
all interrupts of MSIR0-3 are different and can be used for requesting MSI interrupts.
This patch is to enable affinity, that means, for ls1046a and ls1043av1.1, the same bit of MSIR0-3 will be looked as one interrupt using the same hwirq. And MSIRN  only is used when the MSI interrupt is associated with the corresponding cpu.

> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
