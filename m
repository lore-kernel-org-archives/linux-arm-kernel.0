From: eric.auger@linaro.org (Eric Auger)
Date: Thu,  4 Dec 2014 10:48:01 +0100
Subject: [PATCH v2 1/4] KVM: arm/arm64: vgic: vgic_init_maps returns -ENODEV
 when no online vcpu
In-Reply-To: <1417686484-20828-1-git-send-email-eric.auger@linaro.org>
References: <1417686484-20828-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1417686484-20828-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be more explicit upon vgic initialization failure, -ENODEV is
returned by vgic_init_maps when no online vcpus can be found at
init.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 virt/kvm/arm/vgic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index b76c38c..907ba0e 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -1991,7 +1991,7 @@ static int vgic_init_maps(struct kvm *kvm)
 
 	nr_cpus = dist->nr_cpus = atomic_read(&kvm->online_vcpus);
 	if (!nr_cpus)		/* No vcpus? Can't be good... */
-		return -EINVAL;
+		return -ENODEV;
 
 	/*
 	 * If nobody configured the number of interrupts, use the
-- 
1.9.1
