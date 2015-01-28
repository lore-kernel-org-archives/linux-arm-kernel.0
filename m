From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 20:48:21 +0100
Subject: [PATCH 14/15] ARM: do not use optimized do_div for ARMv3
In-Reply-To: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
References: <1422474502-3097078-1-git-send-email-arnd@arndb.de>
Message-ID: <1422474502-3097078-15-git-send-email-arnd@arndb.de>
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
 arch/arm/include/asm/div64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 64498221888a..5f6f49505f54 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -46,7 +46,7 @@
 	__rem;							\
 })
 
-#if __GNUC__ < 4 || !defined(CONFIG_AEABI)
+#if __GNUC__ < 4 || !defined(CONFIG_AEABI) || defined(CONFIG_CPU_32v3)
 
 /*
  * gcc versions earlier than 4.0 are simply too problematic for the
-- 
2.1.0.rc2
