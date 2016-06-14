From: glider@google.com (Alexander Potapenko)
Date: Tue, 14 Jun 2016 18:57:21 +0200
Subject: [PATCH v2] arm64: allow building with kcov coverage on ARM64
Message-ID: <1465923441-107596-1-git-send-email-glider@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARCH_HAS_KCOV to ARM64 config. To avoid crashes, disable
instrumentation of the following files:

arch/arm64/boot/*
arch/arm64/kvm/hyp/*

Signed-off-by: Alexander Potapenko <glider@google.com>
---
v2: - disable instrumentation of arch/arm64/{boot,kvm/hyp}
    - enable instrumentation of arch/arm64/lib/delay.c
---
 arch/arm64/Kconfig          | 1 +
 arch/arm64/boot/Makefile    | 4 ++++
 arch/arm64/kvm/hyp/Makefile | 4 ++++
 3 files changed, 9 insertions(+)

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
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index 305c552..74cec89 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -14,6 +14,10 @@
 # Based on the ia64 boot/Makefile.
 #
 
+# Avoid potential boot-time problems with kcov instrumentation. We are mostly
+# interested in syscall coverage, so boot code is not interesting anyway.
+KCOV_INSTRUMENT		:= n
+
 targets := Image Image.gz
 
 $(obj)/Image: vmlinux FORCE
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
