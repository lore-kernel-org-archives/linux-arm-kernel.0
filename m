From: ccross@android.com (Colin Cross)
Date: Tue, 25 Jan 2011 12:54:55 -0800
Subject: [PATCH 1/5] ARM: gic: Add hooks for architecture specific
	extensions
In-Reply-To: <AANLkTikT=muk5A8MkSe0dXvE-GPsfMn4Am7KuOndvBdi@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-2-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTikT=muk5A8MkSe0dXvE-GPsfMn4Am7KuOndvBdi@mail.gmail.com>
Message-ID: <AANLkTi=umZYcb2MozjjLhjjRD305t8iKw2jNr3Ke=9H7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 7:03 PM, Colin Cross <ccross@android.com> wrote:
> On Mon, Jan 24, 2011 at 12:51 AM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Few architectures combine the GIC with an external interrupt controller.
>> On such systems it may be necessary to update both the GIC registers
>> and the external controller's registers to control IRQ behavior.
>>
>> This can be addressed in couple of possible methods.
>> ?1. ? ? Export common GIC routines along with 'struct irq_chip gic_chip'
>> ? ? ? ?and allow architectures to have custom function by override.
>>
>> ?2. ? ? Provide architecture specific function pointer hooks
>> ? ? ? ?within GIC library and leave platforms to add the necessary
>> ? ? ? ?code as part of these hooks.
>>
>> First one might be non-intrusive but have few shortcomings like arch needs
>> to have there own custom gic library. Locks used should be common since it
>> caters to same IRQs etc. Maintenance point of view also it leads to
>> multiple file fixes.
>>
>> The second probably is cleaner and portable. It ensures that all the
>> common GIC infrastructure is not touched and also provides archs to
>> address their specific issue.
>
> This method would work for most of Tegra's needs, although we would
> need gic_set_type and gic_ack_irq to have arch extensions as well.
> However, it does not allow for irq_retrigger, which can be implemented
> on Tegra.

irq_retrigger does work with this method, the core IRQ code checks for
a return value if the retrigger was successful.  Tegra works with your
patch along with these changes:

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 0b6c043..7993f07 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -90,6 +90,8 @@ static inline unsigned int gic_irq(struct irq_data *d)
 static void gic_ack_irq(struct irq_data *d)
 {
 	spin_lock(&irq_controller_lock);
+	if (gic_arch_extn.irq_ack)
+		gic_arch_extn.irq_ack(d);
 	writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
 	spin_unlock(&irq_controller_lock);
 }
@@ -161,6 +163,14 @@ static int gic_set_type(struct irq_data *d,
unsigned int type)
 	return 0;
 }

+static int gic_retrigger(struct irq_data *d)
+{
+	if (gic_arch_extn.irq_retrigger)
+		return gic_arch_extn.irq_retrigger(d);
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 static int
 gic_set_cpu(struct irq_data *d, const struct cpumask *mask_val, bool force)
@@ -234,6 +244,7 @@ static struct irq_chip gic_chip = {
 	.irq_mask		= gic_mask_irq,
 	.irq_unmask		= gic_unmask_irq,
 	.irq_set_type		= gic_set_type,
+	.irq_retrigger		= gic_retrigger,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	= gic_set_cpu,
 #endif
