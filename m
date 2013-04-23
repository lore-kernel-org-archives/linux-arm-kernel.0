From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:35 +0200
Subject: [PATCH 03/21] ARM: use optimized do_div only for EABI
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In OABI configurations, some uses of the do_div function
cause gcc to run out of registers. To work around that,
we can force the use of the out-of-line version for
configurations that build a OABI kernel.

Without this patch, building netx_defconfig results in:

net/core/pktgen.c: In function 'pktgen_if_show':
net/core/pktgen.c:682:2775: error: can't find a register in class 'GENERAL_REGS' while reloading 'asm'
net/core/pktgen.c:682:3153: error: can't find a register in class 'GENERAL_REGS' while reloading 'asm'
net/core/pktgen.c:682:2775: error: 'asm' operand has impossible constraints
net/core/pktgen.c:682:3153: error: 'asm' operand has impossible constraints

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/include/asm/div64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index fe92ccf..191ada6 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -46,7 +46,7 @@
 	__rem;							\
 })
 
-#if __GNUC__ < 4
+#if __GNUC__ < 4 || !defined(CONFIG_AEABI)
 
 /*
  * gcc versions earlier than 4.0 are simply too problematic for the
-- 
1.8.1.2
