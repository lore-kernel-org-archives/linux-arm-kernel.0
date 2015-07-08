From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 08 Jul 2015 11:40:36 +0800
Subject: [PATCH v2 6/9] irqchip / gic: Add stacked irqdomain support for
 ACPI based GICv2 init
In-Reply-To: <559288CA.40605@arm.com>
References: <1434703572-26221-1-git-send-email-hanjun.guo@linaro.org>
 <1434703572-26221-7-git-send-email-hanjun.guo@linaro.org>
 <20150622172014.GB26129@red-moon> <5589772A.8070708@linaro.org>
 <20150623173845.GC31466@red-moon> <558E1DEE.3090900@linaro.org>
 <55910440.8070702@arm.com> <559282A0.8090601@linaro.org>
 <559288CA.40605@arm.com>
Message-ID: <559C9BB4.90103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 06/30/2015 08:17 PM, Marc Zyngier wrote:
> On 30/06/15 12:50, Hanjun Guo wrote:
>> Hi Marc,
>>
>> On 06/29/2015 04:39 PM, Marc Zyngier wrote:
>>> On 27/06/15 04:52, Hanjun Guo wrote:
>>>> On 06/24/2015 01:38 AM, Lorenzo Pieralisi wrote:
>>>>> On Tue, Jun 23, 2015 at 04:11:38PM +0100, Hanjun Guo wrote:
>> [...]
>>>>>
>>>>>>>>      	for (i = 0; i < nr_irqs; i++)
>>>>>>>>      		gic_irq_domain_map(domain, virq + i, hwirq + i);
>>>>>>>> @@ -945,11 +952,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>>>>>>>      		gic_irqs = 1020;
>>>>>>>>      	gic->gic_irqs = gic_irqs;
>>>>>>>>
>>>>>>>> -	if (node) {		/* DT case */
>>>>>>>> +	if (node || !acpi_disabled) {		/* DT or ACPI case */
>>>>>>>>      		gic->domain = irq_domain_add_linear(node, gic_irqs,
>>>>>>>>      						    &gic_irq_domain_hierarchy_ops,
>>>>>>>>      						    gic);
>>>>>
>>>>> I think this is a bit more worrying, I mean passing a NULL node pointer to
>>>>> the irqdomain layer which basically means you are booting out of ACPI
>>>>
>>>> I'm little confused here, would you mind explaining more for your
>>>> worrying? To me, node pointer is optional and it's ok for ACPI
>>>> case.
>>>>
>>>>> (for you, if that's true for the irq_domain_add_linear implementation
>>>>> that's another story), the node pointer should be optional but you
>>>>> need feedback from IRQ layer maintainers here.
>>>>
>>>> Sure.
>>>
>>> Frankly, I'd really like to see ACPI using the "node" parameter for
>>> something useful. This would save having to cache pointers all over the
>>> place, will make find_irq_host() work as expected... etc.
>>>
>>> See the comment at the top of linux/irqdomain.h :
>>>
>>> "... This code could thus be used on other architectures by replacing
>>> those two by some sort of arch-specific void * "token" used to identify
>>> interrupt controllers."

I'm stuck here, I think the token for now is tied to device tree as
the device node pointer for now in the code if the pointer is not NULL,
just see the of_node_get(of_node) in __irq_domain_add(), if dynamic
dt is enabled:

struct device_node *of_node_get(struct device_node *node)
{
         if (node)
                 kobject_get(&node->kobj);
         return node;
}
EXPORT_SYMBOL(of_node_get);

so if the node is not NULL, it will be used to get the node's
kobject, that will be a problem for acpi case if we pass a token
as a parameter.

I rethink for quite a while and have a discussion with Graeme,
I come out another idea and we don't need the token at all
for ACPI case.

>>
>> To init GIC in ACPI, we can only use the table entry pointer as
>> the token, but the ACPI static tables are early mem/io remapped
>> memory at boot stage, and it will be not available after boot,
>> also we need muti types of MADT enties to init GIC (GICC and GICD
>> for GICv2, GICC or GICR and GICD for GICv3), not as DT, just
>> one single node to include all the information needed to init
>> the GIC.
>
> A single pointer would be enough, you don't need all of them.
>
>> We use ACPI handle for devices as node for DT when the namespace
>> is available, but that's pretty late in the boot stage which GIC,
>> SMP and timers were already initialized, so ACPI handle can not
>> use as the token too.
>>
>> I see multi places just pass NULL as the pointer directly for
>> irq_domain_add_linear() which works fine, and for ACPI, we tested
>> this patch and also it works.
>
> Yes it works. But you're reinventing the wheel by keeping references
> outside of the normal framework, which is simply going to make the code

That's the framework for DT not suitable for ACPI, just see the comments
below.

> more difficult to maintain in the long run.
>
> Putting NULL as the device_node parameter really means "this is a domain
> I don't need to look up later". In your case, you will have to lookup

I agree that we need to look up the domain not just using the
global acpi_irq_domain pointer everywhere, which make the code not
scalable, but I don't think it's not OK to put NULL as the device_node
parameter in ACPI case.

The reason is that we use different model of mapping interrupt with
device in ACPI, for ACPI device in DSDT, it's using another mapping of
device and hwirq number than DT, in DT, we using the interrupt parent
property to get the device node of irqchip, that's why we need the
matching function that match the device node with the one associated
with the irqdomain. But for ACPI, we only can get the gsi which the
device is using, no interrupt parent will be used, that because gsi is
a flat hwirq number which is unique in the system, then we can get its
associated irq domain by matching the gsi supported by this irqchip
(see drawings below),  then we can be without the token pointer
matching the interrupt controller.

                   ------------      ---> gsi_base0
                  |            |
                  |            |
   irqdomain <----| irqchip 0  |
                  |            |
                  |            |
                  |____________|     ---> gsi_end0

                  ------------      ---> gsi_base1 (probably gsi_end0+1)
                  |            |
                  |            |
   irqdomain <----| irqchip 1  |
                  |            |
                  |            |
                  |____________|     ---> gsi_end1

                   .....

so if a device is using gsi number n, we can match it with the compare
of if (n <= gsi_base && gsi_end), then find its associated irq domain.

> that domain, all the time. You're just doing it in your own little
> corner, which is what bothers me.

Not really the corner, that's because how ACPI works, I prepared a
patch on top of this patch set following your suggestion to lookup
the irqdomain to make the code scalable, could you please review it? I
can squash it to this patch set if it's ok to you:

  [RFC PATCH] ACPI / gsi: use gsi to find its irqdomain

As we use the acpi_irq_domain as the global pointer to the acpi core
irq domain, which lead to multi places referring it and the way is not
scalable, so introduce a struct gsi_cfg_data to abstract the gsi data
for the irqchips then match the irq domain with the gsi.

For a ACPI based irqchip for example a GICD, it defines System Vector
Base in the GICD entry, which means the global system interrupt number
where this GIC Distributor?s interrupt inputs start, then we can get
the irq number supported by reading the register for this GICD, so we
can explictly get the gsi's associated irqdomain if the gsi is within
the range of gsi supported by this GICD.

For ACPI device in DSDT, it using another mapping of device and hwirq
number than DT, in DT, we using the interrupt parent property to get
the device node of irqchip, that's why we need the matching function
that match the device node with the one associated with the irqdomain.
For ACPI, we only can get the gsi which the device is using, no interrupt
parent will be used, that because gsi is a flat hwirq number which is
unique in the system, then we can get its associated irq domain as I said
above, which can be without the token pointer matching the interrupt
controller.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
  drivers/acpi/gsi.c           | 58 
++++++++++++++++++++++++++++++++++++++------
  drivers/irqchip/irq-gic-v3.c |  4 ++-
  drivers/irqchip/irq-gic.c    |  7 +++++-
  include/linux/acpi.h         |  2 +-
  4 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 02c8408..85dee53 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -15,11 +15,51 @@

  enum acpi_irq_model_id acpi_irq_model;

-static struct irq_domain *acpi_irq_domain __read_mostly;
+struct gsi_cfg_data {
+       struct list_head list;
+       u32 gsi_base;
+       u32 gsi_end;
+       struct irq_domain *domain;
+};

-void set_acpi_irq_domain(struct irq_domain *domain)
+static LIST_HEAD(gsi_cfg_data_list);
+static DEFINE_MUTEX(gsi_mutex);
+
+int gsi_cfg_data_add(struct irq_domain *domain, u32 gsi_base, u32 gsi_end)
+{
+       struct gsi_cfg_data *data;
+
+       data = kzalloc(sizeof(*data), GFP_KERNEL);
+       if (!data)
+               return -ENOMEM;
+
+       data->domain = domain;
+       data->gsi_base = gsi_base;
+       data->gsi_end = gsi_end;
+
+       mutex_lock(&gsi_mutex);
+       list_add(&data->list, &gsi_cfg_data_list);
+       mutex_unlock(&gsi_mutex);
+
+       return 0;
+}
+
+/* Find irqdomain with GSI (hwirq number) */
+static struct irq_domain *acpi_find_irqdomain(u32 gsi)
  {
-       acpi_irq_domain = domain;
+       struct gsi_cfg_data *data;
+       struct irq_domain *domain = NULL;
+
+       mutex_lock(&gsi_mutex);
+       list_for_each_entry(data, &gsi_cfg_data_list, list) {
+               if (gsi >= data->gsi_base && gsi <= data->gsi_end) {
+                       domain = data->domain;
+                       break;
+               }
+       }
+       mutex_unlock(&gsi_mutex);
+
+       return domain;
  }

  static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
@@ -53,7 +93,9 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, 
int polarity)
   */
  int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
  {
-       *irq = irq_find_mapping(acpi_irq_domain, gsi);
+       struct irq_domain *domain = acpi_find_irqdomain(gsi);
+
+       *irq = irq_find_mapping(domain, gsi);
         /*
          * *irq == 0 means no mapping, that should
          * be reported as a failure
@@ -77,12 +119,13 @@ int acpi_register_gsi(struct device *dev, u32 gsi, 
int trigger,
  {
         int irq;
         unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
+       struct irq_domain *domain = acpi_find_irqdomain(gsi);

-       irq = irq_find_mapping(acpi_irq_domain, gsi);
+       irq = irq_find_mapping(domain, gsi);
         if (irq > 0)
                 return irq;

-       irq = irq_domain_alloc_irqs(acpi_irq_domain, 1, dev_to_node(dev),
+       irq = irq_domain_alloc_irqs(domain, 1, dev_to_node(dev),
                                     &gsi);
         if (irq <= 0)
                 return -EINVAL;
@@ -101,7 +144,8 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
   */
  void acpi_unregister_gsi(u32 gsi)
  {
-       int irq = irq_find_mapping(acpi_irq_domain, gsi);
+       struct irq_domain *domain = acpi_find_irqdomain(gsi);
+       int irq = irq_find_mapping(domain, gsi);

         irq_dispose_mapping(irq);
  }
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index a11c020..21a7404 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -947,6 +947,7 @@ static LIST_HEAD(redist_list);
  static struct redist_region *redist_regs __initdata;
  static u32 nr_redist_regions __initdata;
  static phys_addr_t dist_phy_base __initdata;
+static u32 gsi_base __initdata;

  static int __init
  gic_acpi_register_redist(u64 phys_base, u64 size)
@@ -1014,6 +1015,7 @@ gic_acpi_parse_madt_distributor(struct 
acpi_subtable_header *header,
         if (BAD_MADT_ENTRY(dist, end))
                 return -EINVAL;

+       gsi_base = dist->global_irq_base;
         dist_phy_base = dist->base_address;
         return 0;
  }
@@ -1168,7 +1170,7 @@ init_base:
         if (err)
                 goto out_release_redist;

-       set_acpi_irq_domain(gic_data.domain);
+       gsi_cfg_data_add(gic_data.domain, gsi_base, gsi_base + 
gic_data.irq_nr);
         return 0;

  out_release_redist:
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 7f943ef..15934fb 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1051,6 +1051,7 @@ IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", 
gic_of_init);

  #ifdef CONFIG_ACPI
  static phys_addr_t dist_phy_base, cpu_phy_base __initdata;
+static u32 gsi_base __initdata;

  static int __init
  gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
@@ -1089,6 +1090,7 @@ gic_acpi_parse_madt_distributor(struct 
acpi_subtable_header *header,
         if (BAD_MADT_ENTRY(dist, end))
                 return -EINVAL;

+       gsi_base = dist->global_irq_base;
         dist_phy_base = dist->base_address;
         return 0;
  }
@@ -1139,7 +1141,10 @@ gic_v2_acpi_init(struct acpi_table_header *table)
         }

         gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
-       set_acpi_irq_domain(gic_data[0].domain);
+
+       /* since we have only one GICD, we can safely use gic_data[0] 
here */
+       gsi_cfg_data_add(gic_data[0].domain, gsi_base,
+                        gsi_base + gic_data[0].gic_irqs);

         acpi_irq_model = ACPI_IRQ_MODEL_GIC;
         return 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6de4b0e..8154359 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -223,7 +223,7 @@ void acpi_unregister_gsi (u32 gsi);

  #ifdef CONFIG_ACPI_GENERIC_GSI
  struct irq_domain;
-void set_acpi_irq_domain(struct irq_domain *domain);
+int gsi_cfg_data_add(struct irq_domain *domain, u32 gsi_base, u32 gsi_end);
  #endif

  struct pci_dev;
-- 
1.9.1
