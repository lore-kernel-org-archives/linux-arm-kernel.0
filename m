From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 16 Sep 2015 17:55:28 +0100
Subject: Regression by 01f779f4862b ("irqchip/GIC: Don't deactivate
 interrupts forwarded to a guest")
In-Reply-To: <20150917004330.208ec1c6@xhacker>
References: <20150917003202.498ff83c@xhacker> <20150917004330.208ec1c6@xhacker>
Message-ID: <55F99F00.4040708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/15 17:43, Jisheng Zhang wrote:
> Hi Marc,
> 
> On Thu, 17 Sep 2015 00:32:02 +0800
> Jisheng Zhang <jszhang@marvell.com> wrote:
> 
>> Hi Marc,
>>
>> Commit 01f779f4862b ("irqchip/GIC: Don't deactivate interrupts forwarded to a
>> guest") causes a regression on Marvell BG4CT SoC. In this SoC, there's only one
> 
> The regression phenomenon is all cascaded irq can't be handled correctly.
> 
> Thanks,
> Jisheng
> 
>> GIC, the secondary irq controller is Synopsys DW iCtl:
>> drivers/irqchip/irq-dw-apb-ictl.c
>>
>> So cascading_gic_irq() should return true on Marvell BG4CT SoC, but it returns
>> false. The logic in cascading_gic_irq() doesn't take cascaded irq controller
>> which is provided by non-gic controllers.

This logic is only for secondary GICs, and doesn't make any sense
for another interrupt controller.

More importantly, I don't quite understand how this:

 static void gic_eoimode1_eoi_irq(struct irq_data *d)
 {
+       /* Do not deactivate an IRQ forwarded to a vcpu. */
+       if (forwarded_irq(d))
+               return;
+
        writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_DEACTIVATE);
 }

can break any system since there is no caller of the forwarding API
just yet. Can you pinpoint why part of the patch breaks your system?
Is any code calling the irq_set_vcpu_affinity() function?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
