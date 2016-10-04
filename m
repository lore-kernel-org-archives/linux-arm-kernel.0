From: fredrik.markstrom@gmail.com (Fredrik Markstrom)
Date: Tue,  4 Oct 2016 15:49:46 +0200
Subject: [PATCH] arm: Added support for getcpu() vDSO using TPIDRURW
Message-ID: <1475589000-29315-1-git-send-email-fredrik.markstrom@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes getcpu() ~1000 times faster, this is very useful when
implementing per-cpu buffers in userspace (to avoid cache line
bouncing). As an example lttng ust becomes ~30% faster.

The patch will break applications using TPIDRURW (which is context switched
since commit 4780adeefd042482f624f5e0d577bf9cdcbb760 ("ARM: 7735/2:
Preserve the user r/w register TPIDRURW on context switch and fork")) and
is therefore made configurable.

Signed-off-by: Fredrik Markstrom <fredrik.markstrom@gmail.com>
---
 arch/arm/include/asm/tls.h   |  8 +++++++-
 arch/arm/kernel/entry-armv.S |  1 -
 arch/arm/mm/Kconfig          | 10 ++++++++++
 arch/arm/vdso/Makefile       |  3 +++
 arch/arm/vdso/vdso.lds.S     |  3 +++
 5 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
index 5f833f7..170fd76 100644
--- a/arch/arm/include/asm/tls.h
+++ b/arch/arm/include/asm/tls.h
@@ -10,10 +10,15 @@
 	.endm
 
 	.macro switch_tls_v6k, base, tp, tpuser, tmp1, tmp2
+#ifdef CONFIG_VDSO_GETCPU
+	ldr	\tpuser, [r2, #TI_CPU]
+#else
 	mrc	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
+	ldr	\tpuser, [r2, #TI_TP_VALUE + 4]
+	str	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
+#endif
 	mcr	p15, 0, \tp, c13, c0, 3		@ set TLS register
 	mcr	p15, 0, \tpuser, c13, c0, 2	@ and the user r/w register
-	str	\tmp2, [\base, #TI_TP_VALUE + 4] @ save it
 	.endm
 
 	.macro switch_tls_v6, base, tp, tpuser, tmp1, tmp2
@@ -22,6 +27,7 @@
 	mov	\tmp2, #0xffff0fff
 	tst	\tmp1, #HWCAP_TLS		@ hardware TLS available?
 	streq	\tp, [\tmp2, #-15]		@ set TLS value at 0xffff0ff0
+	ldrne	\tpuser, [r2, #TI_TP_VALUE + 4] @ load the saved user r/w reg
 	mrcne	p15, 0, \tmp2, c13, c0, 2	@ get the user r/w register
 	mcrne	p15, 0, \tp, c13, c0, 3		@ yes, set TLS register
 	mcrne	p15, 0, \tpuser, c13, c0, 2	@ set user r/w register
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 9f157e7..4e1369a 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -787,7 +787,6 @@ ENTRY(__switch_to)
  THUMB(	str	sp, [ip], #4		   )
  THUMB(	str	lr, [ip], #4		   )
 	ldr	r4, [r2, #TI_TP_VALUE]
-	ldr	r5, [r2, #TI_TP_VALUE + 4]
 #ifdef CONFIG_CPU_USE_DOMAINS
 	mrc	p15, 0, r6, c3, c0, 0		@ Get domain register
 	str	r6, [r1, #TI_CPU_DOMAIN]	@ Save old domain register
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c1799dd..f18334a 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -854,6 +854,16 @@ config VDSO
 	  You must have glibc 2.22 or later for programs to seamlessly
 	  take advantage of this.
 
+config VDSO_GETCPU
+	bool "Enable VDSO for getcpu"
+	depends on VDSO && (CPU_V6K || CPU_V7 || CPU_V7M)
+	help
+	  Say Y to make getcpu a VDSO (fast) call. This is useful if you
+	  want to implement per cpu buffers to avoid cache line bouncing
+	  in user mode.
+	  This mechanism uses the TPIDRURW register so enabling it will break
+	  applications using this register for it's own purpose.
+
 config DMA_CACHE_RWFO
 	bool "Enable read/write for ownership DMA cache maintenance"
 	depends on CPU_V6K && SMP
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 59a8fa7..9f1ec51 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -1,6 +1,9 @@
 hostprogs-y := vdsomunge
 
 obj-vdso := vgettimeofday.o datapage.o
+#ifeq ($(CONFIG_VDSO_GETCPU),y)
+obj-vdso += vgetcpu.o
+#endif
 
 # Build rules
 targets := $(obj-vdso) vdso.so vdso.so.dbg vdso.so.raw vdso.lds
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 89ca89f..1af39fb 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -82,6 +82,9 @@ VERSION
 	global:
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
+#ifdef CONFIG_VDSO_GETCPU
+		__vdso_getcpu;
+#endif
 	local: *;
 	};
 }
-- 
2.7.2
