From: cdall@kernel.org (Christoffer Dall)
Date: Mon,  4 Dec 2017 15:03:45 +0100
Subject: [PULL 16/19] kvm: arm: don't treat unavailable HYP mode as an error
In-Reply-To: <20171204135637.21620-1-cdall@kernel.org>
References: <20171204135637.21620-1-cdall@kernel.org>
Message-ID: <20171204140348.21965-14-cdall@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Since it is perfectly legal to run the kernel at EL1, it is not
actually an error if HYP mode is not available when attempting to
initialize KVM, given that KVM support cannot be built as a module.
So demote the kvm_err() to kvm_info(), which prevents the error from
appearing on an otherwise 'quiet' console.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 322c570d211e..ca65d06b38a8 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -1507,7 +1507,7 @@ int kvm_arch_init(void *opaque)
 	bool in_hyp_mode;
 
 	if (!is_hyp_mode_available()) {
-		kvm_err("HYP mode not available\n");
+		kvm_info("HYP mode not available\n");
 		return -ENODEV;
 	}
 
-- 
2.14.2
