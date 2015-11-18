From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 18 Nov 2015 23:36:20 +0300
Subject: [PATCH v6 16/19] aarch64: ilp32: use generic stat64 structure
In-Reply-To: <4020528.IPMzSqapue@wuerfel>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-17-git-send-email-ynorov@caviumnetworks.com>
 <4020528.IPMzSqapue@wuerfel>
Message-ID: <20151118203620.GC11264@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 11:09:05PM +0100, Arnd Bergmann wrote:
> On Wednesday 18 November 2015 00:16:56 Yury Norov wrote:
> > Generic 32-bit and AARCH32 stat64 structures has same names.
> > ILP32 needs generic stat64. So we can either make ILP32 mutual
> > exclusive with AARCH32, or duplicate generic cp_new_stat64 code
> > and struct stat64 to sys_ilp32.c. We choose second because it's
> > more flexible to have independend support for ABIs.
> > 
> 
> I commented on the previous version, but you have not replied to that,
> or changed anything.
> 
> 	Arnd

Hi Arnd,

It seems I misunderstood you.

Are you OK if we'll enable __ARCH_WANT_COMPAT_STAT64
for ILP32, as for AARCH32_EL0, and turn glibc to use
struct stat from sysdeps/unix/sysv/linux/bits/stat.h
with this calls? It seems, this is how ARM ABI works.

Yury.

---
 arch/arm64/include/asm/stat.h   | 2 --
 arch/arm64/include/asm/unistd.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/stat.h b/arch/arm64/include/asm/stat.h
index af04276..15e3559 100644
--- a/arch/arm64/include/asm/stat.h
+++ b/arch/arm64/include/asm/stat.h
@@ -22,7 +22,6 @@
 
 #include <asm/compat.h>
 
-#ifdef CONFIG_AARCH32_EL0
 /*
  * struct stat64 is needed for compat tasks only. Its definition is different
  * from the generic struct stat64.
@@ -60,4 +59,3 @@ struct stat64 {
 
 #endif
 #endif
-#endif
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 696e638..3b196f3 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -19,7 +19,6 @@
 #endif
 #ifdef CONFIG_AARCH32_EL0
 #define __ARCH_WANT_COMPAT_SYS_GETDENTS64
-#define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
 #define __ARCH_WANT_SYS_GETPGRP
@@ -42,6 +41,7 @@
 #define __NR_compat_sigreturn		119
 #define __NR_compat_rt_sigreturn	173
 
+#define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_LLSEEK
 
 /*
-- 
2.1.4
