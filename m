From: eduardo.valentin@nokia.com (Eduardo Valentin)
Date: Wed,  5 May 2010 11:42:07 +0300
Subject: [RESEND PATCHv3 3/4] mach-omap1: Add SoC info data for OMAP1 into
	/proc/cpuinfo
In-Reply-To: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
References: <1273048928-6105-1-git-send-email-eduardo.valentin@nokia.com>
Message-ID: <1273048928-6105-4-git-send-email-eduardo.valentin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Report OMAP data into system_soc_info. Now we get omap
information under /proc/cpuinfo.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/mach-omap1/id.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index a0e3560..9a84347 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -120,7 +120,7 @@ static u8 __init omap_get_die_rev(void)
 
 void __init omap_check_revision(void)
 {
-	int i;
+	int i, sz;
 	u16 jtag_id;
 	u8 die_rev;
 	u32 omap_id;
@@ -194,11 +194,14 @@ void __init omap_check_revision(void)
 		printk(KERN_INFO "Unknown OMAP cpu type: 0x%02x\n", cpu_type);
 	}
 
-	printk(KERN_INFO "OMAP%04x", omap_revision >> 16);
+	sz = snprintf(system_soc_info, SYSTEM_SOC_INFO_SIZE, "OMAP%04x",
+							 omap_revision >> 16);
 	if ((omap_revision >> 8) & 0xff)
-		printk(KERN_INFO "%x", (omap_revision >> 8) & 0xff);
-	printk(KERN_INFO " revision %i handled as %02xxx id: %08x%08x\n",
-	       die_rev, omap_revision & 0xff, system_serial_low,
-	       system_serial_high);
+		snprintf(system_soc_info + sz, SYSTEM_SOC_INFO_SIZE - sz,
+				"%x", (omap_revision >> 8) & 0xff);
+	pr_info("%s revision %i handled as %02xxx id: %08x%08x\n",
+		system_soc_info, die_rev, omap_revision & 0xff,
+		system_serial_low, system_serial_high);
+
 }
 
-- 
1.7.0.4.361.g8b5fe.dirty
