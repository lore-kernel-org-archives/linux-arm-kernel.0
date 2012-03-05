From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon,  5 Mar 2012 17:41:48 -0500
Subject: [PATCH 1/3] arm: anticipate build breakages due in pending merge
In-Reply-To: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
References: <1330987310-8108-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1330987310-8108-2-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Testing in linux-next has revealed that the omap2plus_defconfig
will fail upon the merge of "arm-soc/for-next" as follows:

arch/arm/mach-omap2/control.c:238: error: 'OMAP343X_CTRL_BASE' undeclared (first use in this function)
arch/arm/mach-omap2/common.c:48: error: 'OMAP2420_SDRC_BASE' undeclared here (not in a function)
arch/arm/mach-omap2/common.c:49: error: 'OMAP2420_SMS_BASE' undeclared here (not in a function)
arch/arm/mach-omap2/common.c:50: error: 'OMAP242X_CTRL_BASE' undeclared here (not in a function)
 [...]
arch/arm/mach-omap2/common.c:167: error: 'OMAP4430_CM2_BASE' undeclared here (not in a function)
arch/arm/mach-omap2/sdrc2xxx.c:108: error: 'OMAP2420_PRM_BASE' undeclared (first use in this function)
arch/arm/mach-omap2/cm2xxx_3xxx.c:310: error: 'OMAP3430_CM_BASE' undeclared (first use in this function)

It appears that a once implicit path to <plat/hardware.h> has gone
away once two of the arm streams come together.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/mach-omap2/cm2xxx_3xxx.c |    2 ++
 arch/arm/mach-omap2/common.c      |    1 +
 arch/arm/mach-omap2/control.c     |    1 +
 arch/arm/mach-omap2/sdrc2xxx.c    |    1 +
 4 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index c79ed63..389f9f8 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -18,6 +18,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
+
 #include "iomap.h"
 #include "common.h"
 #include "cm.h"
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 93419de..d620362 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -20,6 +20,7 @@
 #include <plat/board.h>
 #include <plat/mux.h>
 #include <plat/clock.h>
+#include <plat/hardware.h>
 
 #include "iomap.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 2fd5fd1..18ff359 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 
 #include <plat/sdrc.h>
+#include <plat/hardware.h>
 
 #include "iomap.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 2c329a6..181b0c5 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -27,6 +27,7 @@
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
+#include <plat/hardware.h>
 
 #include "iomap.h"
 #include "common.h"
-- 
1.7.9.1
