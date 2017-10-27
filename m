From: cdall@linaro.org (Christoffer Dall)
Date: Fri, 27 Oct 2017 10:34:33 +0200
Subject: [PATCH v5 12/20] genirq: Document vcpu_info usage for percpu_devid
 interrupts
In-Reply-To: <1509093281-15225-1-git-send-email-cdall@linaro.org>
References: <1509093281-15225-1-git-send-email-cdall@linaro.org>
Message-ID: <1509093281-15225-13-git-send-email-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is currently unclear how to set the VCPU affinity for a percpu_devid
interrupt , since the Linux irq_data structure describes the state for
multiple interrupts, one for each physical CPU on the system.  Since
each such interrupt can be associated with different VCPUs or none at
all, associating a single VCPU state with such an interrupt does not
capture the necessary semantics.

The implementers of irq_set_affinity are the Intel and AMD IOMMUs, and
the ARM GIC irqchip.  The Intel and AMD callers do not appear to use
percpu_devid interrupts, and the ARM GIC implementation only checks the
pointer against NULL vs. non-NULL.

Therefore, simply update the function documentation to explain the
expected use in the context of percpu_devid interrupts, allowing future
changes or additions to irqchip implementers to do the right thing.

This documents the use of the vcpu_info parameter for percpu_devid
interrupts when setting the VCPU affinity for the virtual timer
interrupt in KVM/ARM.

Cc: linux-kernel at vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 kernel/irq/manage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d00132b..38ec7a8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -381,7 +381,8 @@ int irq_select_affinity_usr(unsigned int irq)
 /**
  *	irq_set_vcpu_affinity - Set vcpu affinity for the interrupt
  *	@irq: interrupt number to set affinity
- *	@vcpu_info: vCPU specific data
+ *	@vcpu_info: vCPU specific data or pointer to a percpu array of vCPU
+ *	            specific data for percpu_devid interrupts
  *
  *	This function uses the vCPU specific data to set the vCPU
  *	affinity for an irq. The vCPU specific data is passed from
-- 
2.7.4
