From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 7 Dec 2015 08:32:12 +0000
Subject: [PATCH v9 3/4] irqchip:create irq domain for each mbigen device
In-Reply-To: <5664A040.6080500@huawei.com>
References: <1448248513-39760-1-git-send-email-majun258@huawei.com>
 <1448248513-39760-4-git-send-email-majun258@huawei.com>
 <56606D0C.5010702@arm.com> <5664A040.6080500@huawei.com>
Message-ID: <20151207083212.1ee1477d@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 6 Dec 2015 15:53:20 -0500
majun <majun258@huawei.com> wrote:

> Hi Marc:
> 
> On 2015/12/3 11:25, Marc Zyngier wrote:
> > On 23/11/15 03:15, MaJun wrote:
> >> From: Ma Jun <majun258@huawei.com>
> >>
> >> For peripheral devices which connect to mbigen,mbigen is a interrupt
> >> controller. So, we create irq domain for each mbigen device and add
> >> mbigen irq domain into irq hierarchy structure.
> >>
> >> Signed-off-by: Ma Jun <majun258@huawei.com>
> >> ---
> >>  drivers/irqchip/irq-mbigen.c |  119 ++++++++++++++++++++++++++++++++++++++++++
> >>  1 files changed, 119 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> >> index 9f036c2..81ae61f 100644
> >> --- a/drivers/irqchip/irq-mbigen.c
> >> +++ b/drivers/irqchip/irq-mbigen.c
> >> @@ -16,13 +16,36 @@
> >>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> >>   */
> >>  
> >> +#include <linux/interrupt.h>
> >> +#include <linux/irqchip.h>
> >>  #include <linux/module.h>
> >> +#include <linux/msi.h>
> >>  #include <linux/of_address.h>
> >>  #include <linux/of_irq.h>
> >>  #include <linux/of_platform.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/slab.h>
> >>  
> >> +/* Interrupt numbers per mbigen node supported */
> >> +#define IRQS_PER_MBIGEN_NODE		128
> >> +
> >> +/* 64 irqs (Pin0-pin63) are reserved for each mbigen chip */
> >> +#define RESERVED_IRQ_PER_MBIGEN_CHIP	64
> >> +
> >> +/**
> >> + * In mbigen vector register
> >> + * bit[21:12]:	event id value
> >> + * bit[11:0]:	device id
> >> + */
> >> +#define IRQ_EVENT_ID_SHIFT		12
> >> +#define IRQ_EVENT_ID_MASK		0x3ff
> >> +
> >> +/* register range of each mbigen node */
> >> +#define MBIGEN_NODE_OFFSET		0x1000
> >> +
> >> +/* offset of vector register in mbigen node */
> >> +#define REG_MBIGEN_VEC_OFFSET		0x200
> >> +
> >>  /**
> >>   * struct mbigen_device - holds the information of mbigen device.
> >>   *
> >> @@ -34,10 +57,94 @@ struct mbigen_device {
> >>  	void __iomem		*base;
> >>  };
> >>  
> >> +static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
> >> +{
> >> +	unsigned int nid, pin;
> >> +
> >> +	hwirq -= RESERVED_IRQ_PER_MBIGEN_CHIP;
> >> +	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
> >> +	pin = hwirq % IRQS_PER_MBIGEN_NODE;
> >> +
> >> +	return pin * 4 + nid * MBIGEN_NODE_OFFSET
> >> +			+ REG_MBIGEN_VEC_OFFSET;
> >> +}
> >> +
> >> +static struct irq_chip mbigen_irq_chip = {
> >> +	.name =			"mbigen-v2",
> >> +};
> >> +
> >> +static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> >> +{
> >> +	struct irq_data *d = irq_get_irq_data(desc->irq);
> >> +	void __iomem *base = d->chip_data;
> >> +	u32 val;
> >> +
> >> +	base += get_mbigen_vec_reg(d->hwirq);
> >> +	val = readl_relaxed(base);
> >> +
> >> +	val &= ~(IRQ_EVENT_ID_MASK << IRQ_EVENT_ID_SHIFT);
> >> +	val |= (msg->data << IRQ_EVENT_ID_SHIFT);
> >> +
> >> +	writel_relaxed(val, base);
> > 
> > nit: It would be good to have a comment explaining why you do not need
> > to program the address of the doorbell...
> 
> The address of doorbell is encoded in mbigen register by default,
> So, we don't need to program the doorbell address in mbigen driver.
> 
> I'll add this comment in next version.
> 
> > 
> >> +}
> >> +
> >> +static int mbigen_domain_translate(struct irq_domain *d,
> >> +				    struct irq_fwspec *fwspec,
> >> +				    unsigned long *hwirq,
> >> +				    unsigned int *type)
> >> +{
> >> +	if (is_of_node(fwspec->fwnode)) {
> >> +		if (fwspec->param_count != 2)
> >> +			return -EINVAL;
> >> +
> >> +		*hwirq = fwspec->param[0];
> >> +		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
> >> +
> >> +		return 0;
> >> +	}
> >> +	return -EINVAL;
> >> +}
> >> +
> >> +static int mbigen_irq_domain_alloc(struct irq_domain *domain,
> >> +					unsigned int virq,
> >> +					unsigned int nr_irqs,
> >> +					void *args)
> >> +{
> >> +	struct irq_fwspec *fwspec = args;
> >> +	irq_hw_number_t hwirq;
> >> +	unsigned int type;
> >> +	struct mbigen_device *mgn_chip;
> >> +	int i, err;
> >> +
> >> +	err = mbigen_domain_translate(domain, fwspec, &hwirq, &type);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	mgn_chip = platform_msi_get_host_data(domain);
> >> +
> >> +	for (i = 0; i < nr_irqs; i++)
> >> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> >> +				      &mbigen_irq_chip, mgn_chip->base);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static struct irq_domain_ops mbigen_domain_ops = {
> >> +	.translate	= mbigen_domain_translate,
> >> +	.alloc		= mbigen_irq_domain_alloc,
> >> +	.free		= irq_domain_free_irqs_common,
> >> +};
> >> +
> >>  static int mbigen_device_probe(struct platform_device *pdev)
> >>  {
> >>  	struct mbigen_device *mgn_chip;
> >>  	struct resource *res;
> >> +	struct irq_domain *domain;
> >> +	u32 num_msis;
> >>  
> >>  	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
> >>  	if (!mgn_chip)
> >> @@ -50,6 +157,18 @@ static int mbigen_device_probe(struct platform_device *pdev)
> >>  	if (IS_ERR(mgn_chip->base))
> >>  		return PTR_ERR(mgn_chip->base);
> >>  
> >> +	/* If there is no "num-msis" property, assume 64... */
> >> +	if (of_property_read_u32(pdev->dev.of_node, "num-msis", &num_msis) < 0)
> >> +		num_msis = 64;
> > 
> > nit: Is that always true? This has been lifted from my dummy example,
> 
> do you mean patch v2? I just checked your patch, this part still exits.

It does exist because this example is just a toy, and I wanted to make
it easy for people to play with it.

>  so
> > I wonder if that's what you actually want to do.
> 
> I think the default num_msis value should be maximum msis(256) the current
> msi core supported.

I don't think so. If you have a fallback mechanism, it should reflect
the default value on your *own* HW. If there is no common value that is
generally used, then you should not have a default.

> How about your opinion, or I need to remove this part ?

If you don't know what this value should really be, just drop that
part, and generate an error when the num-msis property is not present.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
