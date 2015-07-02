From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 02 Jul 2015 11:41:07 +0300
Subject: [PATCH 1/7] KVM: api: add kvm_irq_routing_extended_msi
In-Reply-To: <011f01d0b498$6a17aeb0$3e470c10$@samsung.com>
References: <1435592237-17924-1-git-send-email-eric.auger@linaro.org>
 <1435592237-17924-2-git-send-email-eric.auger@linaro.org>
 <011f01d0b498$6a17aeb0$3e470c10$@samsung.com>
Message-ID: <018f01d0b4a2$d74e29f0$85ea7dd0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> What if we use KVM_MSI_VALID_DEVID flag instead of new KVM_IRQ_ROUTING_EXTENDED_MSI
> definition? I
> believe this would make an API more consistent and introduce less new definitions.

 I have just found one more flaw in your implementation. If you take a look at irqfd_wakeup()...
--- cut ---
		/* An event has been signaled, inject an interrupt */
		if (irq.type == KVM_IRQ_ROUTING_MSI)
			kvm_set_msi(&irq, kvm, KVM_USERSPACE_IRQ_SOURCE_ID, 1,
					false);
		else
			schedule_work(&irqfd->inject);
--- cut ---
 You apparently missed KVM_IRQ_ROUTING_EXTENDED_MSI here, as well as in irqfd_update(). But, if you
accept my API proposal, this becomes irrelevant.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
