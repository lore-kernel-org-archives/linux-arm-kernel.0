From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 28 Sep 2011 22:56:28 -0700
Subject: [PATCH v3 1/3] genirq: add support for per-cpu dev_id interrupts
In-Reply-To: <1316793788-14500-2-git-send-email-marc.zyngier@arm.com>
References: <1316793788-14500-1-git-send-email-marc.zyngier@arm.com>
	<1316793788-14500-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <4E84088C.8050101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2011 09:03 AM, Marc Zyngier wrote:
> The ARM GIC interrupt controller offers per CPU interrupts (PPIs),
> which are usually used to connect local timers to each core.
> Each CPU has its own private interface to the GIC,
> and only sees the PPIs that are directly connect to it.
>
> While these timers are separate devices and have a separate
> interrupt line to a core, they all use the same IRQ number.
>
> For these devices, request_irq() is not the right API as it
> assumes that an IRQ number is visible by a number of CPUs
> (through the affinity setting), but makes it very awkward to
> express that an IRQ number can be handled by all CPUs, and
> yet be a different interrupt line on each CPU, requiring a
> different dev_id cookie to be passed back to the handler.
>
> The *_percpu_irq() functions is designed to overcome these
> limitations, by providing a per-cpu dev_id vector:
>
> int request_percpu_irq(unsigned int irq, irq_handler_t handler,
> 		   const char *devname, void __percpu *percpu_dev_id);
> void free_percpu_irq(unsigned int, void __percpu *);
> int setup_percpu_irq(unsigned int irq, struct irqaction *new);
> void remove_percpu_irq(unsigned int irq, struct irqaction *act);
> void enable_percpu_irq(unsigned int irq);

As mentioned here
https://lkml.org/lkml/2011/9/25/121

can we add irqflags to enable_percpu_irq? This will make msm's
usage cleaner and it wont have to rely on accessing the gic
registers outside the driver.

---
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
