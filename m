From: spengel@de.adit-jv.com (Steffen Pengel)
Date: Wed, 31 May 2017 13:25:30 +0200
Subject: [PATCH] kgdb,
 arm: Correct the macro used to define GDB register byte size
Message-ID: <1496229930-13696-1-git-send-email-spengel@de.adit-jv.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jimmy Durand Wesolowski <jwesolowski@de.adit-jv.com>

This patch corrects an issue introduced in the
commit 834b2964b7ab ("kgdb,arm: fix register dump"). The definition of
'NUMREGBYTES' was based on the number of the debug register number
('DBG_MAX_REG_NUM') instead of the memory space used to store them
('GDB_MAX_REGS').

The result was a kernel SIGSEGV signal when debugging with KGDB, with
'CONFIG_KGDB_KDB' disabled. When accessing the 23rd register of gdb_regs,
'dbg_get_reg' overwrote 'delayacct_cache' with '0's, leading later to the
crash.

Signed-off-by: Jimmy Durand Wesolowski <jwesolowski@de.adit-jv.com>
---
 arch/arm/include/asm/kgdb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
index 0a9d5dd..6949c7d 100644
--- a/arch/arm/include/asm/kgdb.h
+++ b/arch/arm/include/asm/kgdb.h
@@ -76,7 +76,7 @@ extern int kgdb_fault_expected;
 
 #define KGDB_MAX_NO_CPUS	1
 #define BUFMAX			400
-#define NUMREGBYTES		(DBG_MAX_REG_NUM << 2)
+#define NUMREGBYTES		(GDB_MAX_REGS << 2)
 #define NUMCRITREGBYTES		(32 << 2)
 
 #define _R0			0
-- 
2.7.4
