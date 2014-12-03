From: eric.auger@linaro.org (Eric Auger)
Date: Wed,  3 Dec 2014 17:07:11 +0100
Subject: [PATCH v5 4/5] KVM: irqfd: use kvm_arch_is_virtual_intc_initialized
In-Reply-To: <1417622832-5460-1-git-send-email-eric.auger@linaro.org>
References: <1417622832-5460-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1417622832-5460-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm/arm64, the interrupt controller is dynamically instantiated.
There is a risk the user-space assigns an irqfd before this latter
is initialized and ready to accept virtual irq injection. On such
attempt, the IRQFD setup is rejected and -EAGAIN is returned.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 virt/kvm/eventfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index b0fb390..f837c83 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -314,6 +314,9 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
 	unsigned int events;
 	int idx;
 
+	if (!kvm_arch_is_virtual_intc_initialized(kvm))
+		return -EAGAIN;
+
 	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
 	if (!irqfd)
 		return -ENOMEM;
-- 
1.9.1
