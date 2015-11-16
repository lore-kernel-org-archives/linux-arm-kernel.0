From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 16 Nov 2015 13:11:55 +0000
Subject: [PATCH 17/21] arm64: KVM: Map the kernel RO section into HYP
In-Reply-To: <1447679519-17888-1-git-send-email-marc.zyngier@arm.com>
References: <1447679519-17888-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1447679519-17888-18-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to run C code in HYP, we must make sure that the kernel's
RO section in mapped into HYP (otherwise things break badly).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index eab83b2..6c4549a 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -44,6 +44,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
 #include <asm/kvm_psci.h>
+#include <asm/sections.h>
 
 #ifdef REQUIRES_VIRT
 __asm__(".arch_extension	virt");
@@ -1072,6 +1073,12 @@ static int init_hyp_mode(void)
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
