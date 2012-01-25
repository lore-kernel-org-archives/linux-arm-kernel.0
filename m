From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 24 Jan 2012 17:26:37 -0700
Subject: [RFCv2 13/14] irq_domain: Remove 'new' irq_domain in favour of
 the ppc one
In-Reply-To: <4F1F2C3A.3060607@gmail.com>
References: <1327352870-14687-1-git-send-email-grant.likely@secretlab.ca>
 <1327352870-14687-14-git-send-email-grant.likely@secretlab.ca>
 <4F1F2C3A.3060607@gmail.com>
Message-ID: <CACxGe6sP0p1r6u6uG5fhTf0jC85F=vX7Nj_YezQFE65caH+2Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 3:10 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 01/23/2012 03:07 PM, Grant Likely wrote:
>> This patch removes the simplistic implementation of irq_domains and enables
>> the powerpc infrastructure for all irq_domain users. ?The powerpc
>> infrastructure includes support for complex mappings between Linux and
>> hardware irq numbers, and can manage allocation of irq_descs.
>>
>> This patch also converts the few users of irq_domain_add()/irq_domain_del()
>> to call irq_domain_add_legacy() instead.
>>
>> v2: Fix removal of irq_alloc_descs() call in gic driver
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>> ?arch/arm/common/gic.c ? ? ? ? ? ? ? | ? 85 ++++++++-----------
>> ?arch/arm/common/vic.c ? ? ? ? ? ? ? | ? 16 +---
>> ?arch/arm/include/asm/hardware/gic.h | ? ?4 +-
>> ?arch/arm/include/asm/hardware/vic.h | ? ?2 +
>> ?arch/arm/mach-exynos/common.c ? ? ? | ? ?2 +-
>> ?arch/arm/mach-versatile/core.c ? ? ?| ? ?5 +-
>> ?drivers/mfd/twl-core.c ? ? ? ? ? ? ?| ? 12 +--
>> ?include/linux/irqdomain.h ? ? ? ? ? | ? 45 +---------
>> ?kernel/irq/irqdomain.c ? ? ? ? ? ? ?| ?159 +++--------------------------------
>> ?9 files changed, 69 insertions(+), 261 deletions(-)
>>
>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>
> snip
>
>> @@ -716,17 +708,17 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>> ? ? ? ? ? ? ? gic_irqs = 1020;
>> ? ? ? gic->gic_irqs = gic_irqs;
>>
>> - ? ? domain->nr_irq = gic_irqs - domain->hwirq_base;
>> - ? ? domain->irq_base = irq_alloc_descs(irq_start, 16, domain->nr_irq,
>> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?numa_node_id());
>> - ? ? if (IS_ERR_VALUE(domain->irq_base)) {
>> + ? ? irq_base = irq_alloc_descs(irq_start, 16, gic_irqs - hwirq_base,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?numa_node_id());
>> + ? ? if (IS_ERR_VALUE(irq_base)) {
>> ? ? ? ? ? ? ? WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>> ? ? ? ? ? ? ? ? ? ?irq_start);
>> - ? ? ? ? ? ? domain->irq_base = irq_start;
>> + ? ? ? ? ? ? irq_base = irq_start;
>> ? ? ? }
>> - ? ? domain->host_data = gic;
>> - ? ? domain->ops = &gic_irq_domain_ops;
>> - ? ? irq_domain_add(domain);
>> + ? ? gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
>
> gic_irqs is wrong here. It needs 16 or 32 subtracted off. This patch
> will fix things:

Good catch, I've integrated this into my series.

g.
