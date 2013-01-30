From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Wed, 30 Jan 2013 17:01:31 +0200
Subject: [RFC PATCH v3 2/2] ARM: OMAP4: setup SoC model name during ID
 initialisation
In-Reply-To: <1359558091-29251-1-git-send-email-ruslan.bilovol@ti.com>
References: <1359558091-29251-1-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <1359558091-29251-3-git-send-email-ruslan.bilovol@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set up the SoC model name during OMAP ID initialisation
so it will be displayed in /proc/cpuinfo:

/ # cat proc/cpuinfo
[...]
CPU variant     : 0x2
CPU part        : 0xc09
CPU revision    : 10

SoC name        : OMAP4470

Hardware        : OMAP4 Blaze Tablet
Revision        : 20edb4
[...]

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
---
 arch/arm/mach-omap2/id.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 45cc7ed4..dca7ac7 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 
 #include <asm/cputype.h>
+#include <asm/setup.h>
 
 #include "common.h"
 
@@ -33,6 +34,7 @@
 
 static unsigned int omap_revision;
 static const char *cpu_rev;
+static char omap_soc_model_name[80];
 u32 omap_features;
 
 unsigned int omap_rev(void)
@@ -502,6 +504,9 @@ void __init omap4xxx_check_revision(void)
 		omap_revision = OMAP4430_REV_ES2_3;
 	}
 
+	sprintf(omap_soc_model_name, "OMAP%04x", omap_rev() >> 16);
+	set_soc_model_name(omap_soc_model_name);
+
 	pr_info("OMAP%04x ES%d.%d\n", omap_rev() >> 16,
 		((omap_rev() >> 12) & 0xf), ((omap_rev() >> 8) & 0xf));
 }
-- 
1.7.9.5
