From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 2 May 2017 10:59:25 +0100
Subject: [RFC PATCH 1/2] net: revert commit 1a8b6d76dc5b
In-Reply-To: <1493719166-9036-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1493719166-9036-1-git-send-email-gabriele.paoloni@huawei.com>
Message-ID: <1493719166-9036-2-git-send-email-gabriele.paoloni@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: gabriele paoloni <gabriele.paoloni@huawei.com>

commit 1a8b6d76dc5b was introducing relaxed ordering as global
symbol. This does not make sense as relaxed ordering support
depends on the PCIe EP and on the Root Complex (therefore it is
not related to the CPU architecture)

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
---
 arch/Kconfig                                    | 3 ---
 arch/sparc/Kconfig                              | 1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index c4d6833..c0b118d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -851,7 +851,4 @@ config STRICT_MODULE_RWX
 	  and non-text memory will be made non-executable. This provides
 	  protection against certain security exploits (e.g. writing to text)
 
-config ARCH_WANT_RELAX_ORDER
-	bool
-
 source "kernel/gcov/Kconfig"
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ed96869..3f47142 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -43,7 +43,6 @@ config SPARC
 	select ARCH_HAS_SG_CHAIN
 	select CPU_NO_EFFICIENT_FFS
 	select LOCKDEP_SMALL if LOCKDEP
-	select ARCH_WANT_RELAX_ORDER
 
 config SPARC32
 	def_bool !64BIT
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index c38d50c..094e1d6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -350,7 +350,7 @@ s32 ixgbe_start_hw_gen2(struct ixgbe_hw *hw)
 	}
 	IXGBE_WRITE_FLUSH(hw);
 
-#ifndef CONFIG_ARCH_WANT_RELAX_ORDER
+#ifndef CONFIG_SPARC
 	/* Disable relaxed ordering */
 	for (i = 0; i < hw->mac.max_tx_queues; i++) {
 		u32 regval;
-- 
2.7.4
