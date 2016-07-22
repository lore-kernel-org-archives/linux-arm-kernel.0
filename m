From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jul 2016 18:28:25 +0100
Subject: [PATCH 08/55] arm64: KVM: Always reference __hyp_panic_string via its
 kernel VA
In-Reply-To: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
References: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1469208552-4155-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__hyp_panic_string is passed via the HYP panic code to the panic
function, and is being "upgraded" to a kernel address, as it is
referenced by the HYP code (in a PC-relative way).

This is a bit silly, and we'd be better off obtaining the kernel
address and not mess with it at all. This patch implements this
with a tiny bit of asm glue, by forcing the string pointer to be
read from the literal pool.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/hyp/switch.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 437cfad..81f21a2 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -299,9 +299,16 @@ static const char __hyp_panic_string[] = "HYP panic:\nPS:%08llx PC:%016llx ESR:%
 
 static void __hyp_text __hyp_call_panic_nvhe(u64 spsr, u64 elr, u64 par)
 {
-	unsigned long str_va = (unsigned long)__hyp_panic_string;
+	unsigned long str_va;
 
-	__hyp_do_panic(hyp_kern_va(str_va),
+	/*
+	 * Force the panic string to be loaded from the literal pool,
+	 * making sure it is a kernel address and not a PC-relative
+	 * reference.
+	 */
+	asm volatile("ldr %0, =__hyp_panic_string" : "=r" (str_va));
+
+	__hyp_do_panic(str_va,
 		       spsr,  elr,
 		       read_sysreg(esr_el2),   read_sysreg_el2(far),
 		       read_sysreg(hpfar_el2), par,
-- 
2.8.1
