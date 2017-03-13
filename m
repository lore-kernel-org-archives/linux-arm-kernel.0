From: dingtianhong@huawei.com (Ding Tianhong)
Date: Mon, 13 Mar 2017 20:03:08 +0800
Subject: [PATCH] arm64: enable ARCH_WANT_RELAX_ORDER for aarch64
Message-ID: <35233df0-3406-e66f-d9d2-bf7ed7814386@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARCH_WANT_RELAX_ORDER will enable Relaxed Ordering (RO) which allows
transactions that do not have any order of completion requirements to
complete more efficiently compare to the Stricted Ordering (SO) for ixbge
nic card. The system will see high write-to-memory performance when RO is
enabled on the data transactions just like the SPARC did.

The aarch64 pcie controller could both support Relaxed Ordering (RO)
and Stricted Ordering (SO), so enable ARCH_WANT_RELAX_ORDER for ixgbe
nic card to get much more better performance, and didn't see any
adverse effects.

Nic Card(Ixgbe)			Disable RO	|	Enable RO
Performance(Per thread)		8.4Gb/s		|	9.4Gb/s

Tested by Iperf on Hip06/Hip07 Soc Board.

Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8c7c244..36249a3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -115,6 +115,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select ARCH_WANT_RELAX_ORDER
 	help
 	  ARM 64-bit (AArch64) Linux support.

-- 
1.9.0
