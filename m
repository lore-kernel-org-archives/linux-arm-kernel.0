From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 15:02:00 +0100
Subject: [PATCH 8/9] ARM: do not use optimized do_div for ARMv3
In-Reply-To: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
Message-ID: <1455804123-2526139-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gcc-4.9 optimization goes wrong while building target_core_iblock.c
for ARMv3 and leaves a bogus reference to __aeabi_uldivmod in the
output:

ERROR: "__aeabi_uldivmod" [drivers/target/target_core_iblock.ko] undefined!

I could not find anyone who is interested in fixing it in gcc,
so as a workaround this disables the do_div magic, just like
we do for old compilers and for OABI.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/div64.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 7d919a9b32e5..958fdc2363f5 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -58,6 +58,14 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
  */
 #define do_div(n, base) __div64_32(&(n), base)
 
+#elif defined(CONFIG_CPU_32v3)
+
+/*
+ * modern compiler versions (>= gcc-4.9) tend to misoptimize
+ * the code for ARMv3, and this is not getting fixed any more.
+ */
+#define do_div(n, base) __div64_32(&(n), base)
+
 #else
 
 /*
-- 
2.7.0
