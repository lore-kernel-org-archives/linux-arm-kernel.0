From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 26 May 2015 10:53:10 +0100
Subject: [PATCH 1/7] arm-cci: Do not enable CCI-400 PMU by default
In-Reply-To: <1432633996-7229-1-git-send-email-suzuki.poulose@arm.com>
References: <1432633996-7229-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1432633996-7229-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Do not enable CCI-400 PMU by default and fix the dependency on PERF_EVENTS
than HW_PERF_EVENTS.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: arm at kernel.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
Changes since V1:
 - Make CCI400_PMU depend on CPU_V7 for ARM (Suggested by: Russell)
---
 drivers/bus/Kconfig |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index a1d4af6..a6b37d4 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -13,15 +13,13 @@ config ARM_CCI400_COMMON
 
 config ARM_CCI400_PMU
 	bool "ARM CCI400 PMU support"
-	default y
-	depends on ARM || ARM64
-	depends on HW_PERF_EVENTS
+	depends on (ARM && CPU_V7) || ARM64
+	depends on PERF_EVENTS
 	select ARM_CCI400_COMMON
 	help
-	  Support for PMU events monitoring on the ARM CCI cache coherent
-	  interconnect.
-
-	  If unsure, say Y
+	  Support for PMU events monitoring on the ARM CCI-400 (cache coherent
+	  interconnect). CCI-400 supports counting events related to the
+	  connected slave/master interfaces.
 
 config ARM_CCI400_PORT_CTRL
 	bool
-- 
1.7.9.5
