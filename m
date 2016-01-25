From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 25 Jan 2016 12:17:12 +0000
Subject: [PATCH v3 1/2] ARM: rework ARM_CPU_SUSPEND dependencies
In-Reply-To: <1453724233-27251-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1453724233-27251-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1453724233-27251-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code enabled by the ARM_CPU_SUSPEND config option is used by
kernel subsystems for purposes that go beyond system suspend so its
config entry should be augmented to take more default options into
account and avoid forcing its selection to prevent dependencies
override.

To achieve this goal, this patch reworks the ARM_CPU_SUSPEND config
entry and updates its default config value (by adding the BL_SWITCHER
option to it) and its dependencies (ARCH_SUSPEND_POSSIBLE), so that the
symbol is still selected by default by the subsystems requiring it and
at the same time enforcing the dependencies correctly.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4f799e5..8456f69 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1337,7 +1337,6 @@ config BIG_LITTLE
 config BL_SWITCHER
 	bool "big.LITTLE switcher support"
 	depends on BIG_LITTLE && MCPM && HOTPLUG_CPU && ARM_GIC
-	select ARM_CPU_SUSPEND
 	select CPU_PM
 	help
 	  The big.LITTLE "switcher" provides the core functionality to
@@ -2111,7 +2110,8 @@ config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
 config ARM_CPU_SUSPEND
-	def_bool PM_SLEEP
+	def_bool PM_SLEEP || BL_SWITCHER
+	depends on ARCH_SUSPEND_POSSIBLE
 
 config ARCH_HIBERNATION_POSSIBLE
 	bool
-- 
2.5.1
