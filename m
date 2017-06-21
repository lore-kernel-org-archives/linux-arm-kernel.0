From: jnair@caviumnetworks.com (Jayachandran C)
Date: Wed, 21 Jun 2017 15:25:10 +0000
Subject: [PATCH v3 2/2] acpi, gicv3-its, numa: Adding numa node mapping
 for gic-its units
In-Reply-To: <a3550a73-9345-b360-44e6-949f0b6c42da@arm.com>
References: <1498025743-6340-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1498025743-6340-3-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170621070941.GA6124@localhost>
 <a3550a73-9345-b360-44e6-949f0b6c42da@arm.com>
Message-ID: <20170621152509.GA4485@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 09:44:58AM +0100, Marc Zyngier wrote:
> On 21/06/17 08:09, Jayachandran C wrote:
> > On Wed, Jun 21, 2017 at 11:45:43AM +0530, Ganapatrao Kulkarni wrote:
> >> Add code to parse SRAT ITS Affinity sub table as defined in ACPI 6.2
> >> Later in per device probe, ITS devices are mapped to
> >> numa node using ITS id to proximity domain mapping.
> >>
> >> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> >> ---
> >>  drivers/irqchip/irq-gic-v3-its.c | 80 +++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 79 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> >> index 45ea1933..88cfb32 100644
> >> --- a/drivers/irqchip/irq-gic-v3-its.c
> >> +++ b/drivers/irqchip/irq-gic-v3-its.c
> >> @@ -1833,6 +1833,82 @@ static int __init its_of_probe(struct device_node *node)
> >>  
> >>  #define ACPI_GICV3_ITS_MEM_SIZE (SZ_128K)
> >>  
> >> +#ifdef CONFIG_ACPI_NUMA
> >> +struct its_srat_map {
> >> +	u32	numa_node;  /* numa node id */
> >> +	u32	its_id;  /* GIC ITS ID */
> >> +};
> >> +
> >> +static struct its_srat_map its_srat_maps[MAX_NUMNODES] __initdata = {
> >> +	[0 ... MAX_NUMNODES - 1] = {NUMA_NO_NODE, UINT_MAX} };
> >> +
> >> +static int its_in_srat __initdata;
> >> +
> >> +static int __init
> >> +acpi_get_its_numa_node(u32 its_id)
> >> +{
> >> +	int i;
> >> +
> >> +	for (i = 0; i < its_in_srat; i++) {
> >> +		if (its_id == its_srat_maps[i].its_id)
> >> +			return its_srat_maps[i].numa_node;
> >> +	}
> >> +	return NUMA_NO_NODE;
> >> +}
> >> +
> >> +static int __init
> >> +gic_acpi_parse_srat_its(struct acpi_subtable_header *header,
> >> +			 const unsigned long end)
> >> +{
> >> +	int pxm, node;
> >> +	struct acpi_srat_its_affinity *its_affinity;
> >> +
> >> +	its_affinity = (struct acpi_srat_its_affinity *)header;
> >> +	if (!its_affinity)
> >> +		return -EINVAL;
> >> +
> >> +	if (its_affinity->header.length <
> >> +			sizeof(struct acpi_srat_its_affinity)) {
> >> +		pr_err("SRAT:ITS: Invalid SRAT header length: %d\n",
> >> +			its_affinity->header.length);
> > 
> > The original driver does not use pr_fmt properly, it may be worth
> > fixing that up rather than having prefixes, here...
> 
> Irrespective of what the "proper" usage is

The prefixes of the prints in this driver are a bit inconsistent. And
there are a few error messages like the "Failed to allocate PROPBASE"
and "Bad LPI chunk %d\n" without any prefix at all. pr_fmt would be
helpful to clean it up.

> this kind of cleanup doesn't belong in this series.

Right. I think the printed messages in this patch can be improved quite
a bit. currently the tags and spacing are inconsistent, something like:
|  pr_err("SRAT: Invalid header length %d in ITS affinity\n", ...
|  pr_err("SRAT: Invalid NUMA node %d in ITS affinity\n", node);
|  pr_info("SRAT: PXM %d -> ITS %d -> Node %d\n",
would be better in my opinion.

> Feel free to submit a separate patch.

The driver also prints 2 lines per CPU on boot which can get to a few
hundred lines on our test machines. So there are a few things worth
fixing up here... maybe in another kernel dev cycle.

JC.
