From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 24 Dec 2015 11:12:28 +0000
Subject: [PATCH 20/31] arm64: KVM: Map the kernel RO section into HYP
In-Reply-To: <1450955559-15639-1-git-send-email-marc.zyngier@arm.com>
References: <1450955559-15639-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1450955559-15639-21-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to run C code in HYP, we must make sure that the kernel's
RO section is mapped into HYP (otherwise things break badly).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 8a79a57..6e35d1d 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -44,6 +44,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
 #include <asm/kvm_psci.h>
+#include <asm/sections.h>
 
 #ifdef REQUIRES_VIRT
 __asm__(".arch_extension	virt");
@@ -1068,6 +1069,12 @@ static int init_hyp_mode(void)
 		goto out_free_mappings;
 	}
 
+	err = create_hyp_mappings(__start_rodata, __end_rodata);
+	if (err) {
+		kvm_err("Cannot map rodata section\n");
+		goto out_free_mappings;
+	}
+
 	/*
 	 * Map the Hyp stack pages
 	 */
-- 
2.1.4
