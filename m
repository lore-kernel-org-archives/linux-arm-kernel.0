From: glider@google.com (Alexander Potapenko)
Date: Thu, 16 Jun 2016 18:39:52 +0200
Subject: [PATCH v4] arm64: allow building with kcov coverage on ARM64
Message-ID: <1466095192-106891-1-git-send-email-glider@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARCH_HAS_KCOV to ARM64 config. To avoid potential crashes, disable
instrumentation of the files in arch/arm64/kvm/hyp/*.

Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Tested-by: James Morse <james.morse@arm.com>
---
v4: - added ack from Marc Zyngier and Tested-by from James Morse
v3: - reverted arch/arm64/boot/Makefile, there's no code in that dir
    - added ack from Mark Rutland
v2: - disable instrumentation of arch/arm64/{boot,kvm/hyp}
    - enable instrumentation of arch/arm64/lib/delay.c
---
 arch/arm64/Kconfig          | 1 +
 arch/arm64/kvm/hyp/Makefile | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5a0a691..eb0b0a0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -7,6 +7,7 @@ config ARM64
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_KCOV
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 778d0ef..0c85feb 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -17,6 +17,10 @@ obj-$(CONFIG_KVM_ARM_HOST) += tlb.o
 obj-$(CONFIG_KVM_ARM_HOST) += hyp-entry.o
 obj-$(CONFIG_KVM_ARM_HOST) += s2-setup.o
 
+# KVM code is run at a different exception code with a different map, so
+# compiler instrumentation that inserts callbacks or checks into the code may
+# cause crashes. Just disable it.
 GCOV_PROFILE	:= n
 KASAN_SANITIZE	:= n
 UBSAN_SANITIZE	:= n
+KCOV_INSTRUMENT	:= n
-- 
2.8.0.rc3.226.g39d4020
