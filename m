From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Nov 2015 18:50:11 +0000
Subject: [PATCH v2 17/21] arm64: KVM: Map the kernel RO section into HYP
In-Reply-To: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1448650215-15218-18-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to run C code in HYP, we must make sure that the kernel's
RO section in mapped into HYP (otherwise things break badly).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index e06fd29..d80aefe 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -44,6 +44,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
 #include <asm/kvm_psci.h>
+#include <asm/sections.h>
 
 #ifdef REQUIRES_VIRT
 __asm__(".arch_extension	virt");
@@ -1067,6 +1068,12 @@ static int init_hyp_mode(void)
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
