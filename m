From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Mar 2011 22:07:28 +0100
Subject: [PATCH] ARM: mx5: forbid building i.MX51 with any of i.MX50 or i.MX53
Message-ID: <1299013648-26630-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A config supporting all three SoCs compiles just fine, but the image
is broken because of different PHYS_OFFSETs.

This fix is a bit ugly because the i.MX50/i.MX53 machines simply
disappear in the config system when the first i.MX51 machine is
selected, but the upside is that no additional Kconfig symbol is
needed which would break more configs than this change.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/Kconfig |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index f065a0d..4419f76 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -135,6 +135,11 @@ config MACH_MX51_EFIKASB
 	  Include support for Genesi Efika Smartbook. This includes specific
 	  configurations for the board and its peripherals.
 
+# i.MX51 uses a different PHYS_OFFSET than i.MX50 and i.MX53, so until this is
+# supported in a single kernel forbid selecting i.MX50/i.MX53 bases machines
+# when a i.MX51 based one is already selected.
+if !SOC_IMX51
+
 config MACH_MX53_EVK
 	bool "Support MX53 EVK platforms"
 	select SOC_IMX53
@@ -180,3 +185,5 @@ config MACH_MX50_RDP
 	  includes specific configurations for the board and its peripherals.
 
 endif
+
+endif
-- 
1.7.2.3
