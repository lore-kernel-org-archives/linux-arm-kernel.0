From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Nov 2017 09:35:17 +0000
Subject: [PATCH RFC] irq-bcm2836: Avoid "Invalid trigger warning"
In-Reply-To: <2064584856.232280.1510857755863@email.1und1.de> (Stefan Wahren's
 message of "Thu, 16 Nov 2017 19:42:35 +0100")
References: <1510815182-4889-1-git-send-email-stefan.wahren@i2se.com>
 <87tvxur47b.fsf@on-the-bus.cambridge.arm.com>
 <543996743.201290.1510853694865@email.1und1.de>
 <26ca38d8-953a-ff1d-9dd3-cee2608b3a18@raspberrypi.org>
 <e5d7a277-0794-eb10-3c7c-22c001375177@arm.com>
 <2064584856.232280.1510857755863@email.1und1.de>
Message-ID: <86k1yp1c4q.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16 2017 at  7:42:35 pm GMT, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Marc Zyngier <marc.zyngier@arm.com> hat am 16. November 2017 um 19:16 geschrieben:
>> 
>> 
>> On 16/11/17 17:53, Phil Elwell wrote:
>> > Hi Stefan,
>> > 
>> > On 16/11/2017 17:34, Stefan Wahren wrote:
>> >> Hi Phil,
>> >>
>> >>> Marc Zyngier <marc.zyngier@arm.com> hat am 16. November 2017 um 09:57 geschrieben:
>> >>>
>> >>>
>> >>> On Thu, Nov 16 2017 at  7:53:02 am GMT, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> >>>> From: Phil Elwell <phil@raspberrypi.org>
>> >>>>
>> >>>> Initialise the level for each IRQ to avoid a warning from the
>> >>>> arm arch timer code:
>> >>>>
>> >>>>     arch_timer: WARNING: Invalid trigger for IRQ19, assuming level low
>> >>>>     arch_timer: WARNING: Please fix your firmware
>> >>>>     arch_timer: cp15 timer(s) running at 19.20MHz (virt).
>> >>>>
>> >>>> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
>> >>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> >>>> ---
>> >>>>  drivers/irqchip/irq-bcm2836.c | 2 +-
>> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>>>
>> >>>> diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
>> >>>> index 667b9e1..abc9b40 100644
>> >>>> --- a/drivers/irqchip/irq-bcm2836.c
>> >>>> +++ b/drivers/irqchip/irq-bcm2836.c
>> >>>> @@ -104,7 +104,7 @@ static void bcm2836_arm_irqchip_register_irq(int hwirq, struct irq_chip *chip)
>> >>>>  
>> >>>>  	irq_set_percpu_devid(irq);
>> >>>>  	irq_set_chip_and_handler(irq, chip, handle_percpu_devid_irq);
>> >>>> -	irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> >>>> +	irq_set_status_flags(irq, IRQ_NOAUTOEN | IRQ_TYPE_LEVEL_LOW);
>> >>>>  }
>> >>>>  
>> >>>>  static void
>> >>>
>> >>> Why is this only done for the per-cpu interrupts? I can't see what
>> >>> guarantees the same thing for global interrupts...
>> >>
>> >> i don't know. Could you please answer?
>> >>
>> >> I'm only interested to get the rid of this ugly warning ...
>> >>
>> >> and the right fix ;-)
>> > 
>> > That was my motivation too, with a preference for the smallest change that had
>> > the desired effect.
>> > 
>> > The warning message comes from the arch_timer code, which only cares about the
>> > interrupts it has been configured to use. Since these are all per-cpu
>> > interrupts, the state of the global interrupts is irrelevant.
>> 
>> The fact that no driver screams about it doesn't make it right. You're
>> being bitten by the lack of interrupt polarity description in your DT.
>> That is fine as long as you only support one type, but you need to tell
>> the core code what you're doing.
>> 
>> Your whole interrupt registration thing is already quite a departure
>> from the normal flow, where the interrupt should be created via the DT
>> parsing code, and not eagerly like it is done here. I'd rather you
>> address it by using the expected flow for a DT platform, with a xlate
>> method that returns the actual trigger type (I assume all interrupts on
>> this system are level...).
>> 
>> The same issue is present in the bcm2835 interrupt controller, which
>> seems to be the one implementing global interrupts.
>
> Okay, thanks for the explanation.
>
> Can you please point me to a good reference implementation?

Any interrupt controller that has both an xlate and a map function
should be good enough. The result should look something like the hack
below (untested). Fixing the bcm2835 driver should be even simpler,
though the lack of DT trigger information may unearth some horrible
things in drivers. We'll see.

Thanks,

	M.

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index dc8c1e3eafe7..5d5ff2a19e61 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -151,13 +151,33 @@ static struct irq_chip bcm2836_arm_irqchip_gpu = {
 	.irq_unmask	= bcm2836_arm_irqchip_unmask_gpu_irq,
 };
 
-static void bcm2836_arm_irqchip_register_irq(int hwirq, struct irq_chip *chip)
+static int bcm2836_map(struct irq_domain *d, unsigned int irq,
+		       irq_hw_number_t hw)
 {
-	int irq = irq_create_mapping(intc.domain, hwirq);
+	struct irq_chip *chip;
+
+	switch (hw) {
+	case LOCAL_IRQ_CNTPSIRQ:
+	case LOCAL_IRQ_CNTPNSIRQ:
+	case LOCAL_IRQ_CNTHPIRQ:
+	case LOCAL_IRQ_CNTVIRQ:
+		chip = &bcm2836_arm_irqchip_timer;
+		break;
+	case LOCAL_IRQ_GPU_FAST:
+		chip = &bcm2836_arm_irqchip_gpu;
+		break;
+	case LOCAL_IRQ_PMU_FAST:
+		chip = &bcm2836_arm_irqchip_pmu;
+		break;
+	default:
+		BUG();
+	}
 
 	irq_set_percpu_devid(irq);
-	irq_set_chip_and_handler(irq, chip, handle_percpu_devid_irq);
+	irq_domain_set_info(d, irq, hw, chip, d->host_data,
+			    handle_percpu_devid_irq, NULL, NULL);
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
+	return 0;
 }
 
 static void
@@ -235,8 +255,18 @@ static const struct smp_operations bcm2836_smp_ops __initconst = {
 #endif
 #endif
 
+static int bcm2836_xlate(struct irq_domain *d, struct device_node *ctrlr,
+			 const u32 *intspec, unsigned int intsize,
+			 unsigned long *out_hwirq, unsigned int *out_type)
+{
+	*out_hwirq = intspec[0];
+	*out_type = IRQ_TYPE_LEVEL_LOW;
+	return 0;
+}
+
 static const struct irq_domain_ops bcm2836_arm_irqchip_intc_ops = {
-	.xlate = irq_domain_xlate_onecell
+	.xlate = bcm2836_xlate,
+	.map = bcm2836_map,
 };
 
 static void
@@ -293,19 +323,6 @@ static int __init bcm2836_arm_irqchip_l1_intc_of_init(struct device_node *node,
 	if (!intc.domain)
 		panic("%pOF: unable to create IRQ domain\n", node);
 
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_CNTPSIRQ,
-					 &bcm2836_arm_irqchip_timer);
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_CNTPNSIRQ,
-					 &bcm2836_arm_irqchip_timer);
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_CNTHPIRQ,
-					 &bcm2836_arm_irqchip_timer);
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_CNTVIRQ,
-					 &bcm2836_arm_irqchip_timer);
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_GPU_FAST,
-					 &bcm2836_arm_irqchip_gpu);
-	bcm2836_arm_irqchip_register_irq(LOCAL_IRQ_PMU_FAST,
-					 &bcm2836_arm_irqchip_pmu);
-
 	bcm2836_arm_irqchip_smp_init();
 
 	set_handle_irq(bcm2836_arm_irqchip_handle_irq);

-- 
Jazz is not dead. It just smells funny.
