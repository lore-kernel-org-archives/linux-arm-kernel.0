From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue,  9 Mar 2010 11:43:52 +0200
Subject: [PATCH 5/5] [ARM] pxa/cm-x300: update the memory fixup.
In-Reply-To: <1268127832-20563-4-git-send-email-grinberg@compulab.co.il>
References: <1268127832-20563-1-git-send-email-grinberg@compulab.co.il>
	<1268127832-20563-2-git-send-email-grinberg@compulab.co.il>
	<1268127832-20563-3-git-send-email-grinberg@compulab.co.il>
	<1268127832-20563-4-git-send-email-grinberg@compulab.co.il>
Message-ID: <1268127832-20563-5-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CM-X300 bootloader passes DRAM configuration information in ATAGS,
however, the first memory bank is reported at actual physical address 0x8000000.
Use the configuration information supplied by the bootloader and
cope with the necessity to have PHYS_ADDR=0xa0000000.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 2012588..be9dc7a 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -767,13 +767,13 @@ static void __init cm_x300_init(void)
 static void __init cm_x300_fixup(struct machine_desc *mdesc, struct tag *tags,
 				 char **cmdline, struct meminfo *mi)
 {
-	mi->nr_banks = 2;
-	mi->bank[0].start = 0xa0000000;
-	mi->bank[0].node = 0;
-	mi->bank[0].size = (64*1024*1024);
-	mi->bank[1].start = 0xc0000000;
-	mi->bank[1].node = 0;
-	mi->bank[1].size = (64*1024*1024);
+	/* Make sure that mi->bank[0].start = PHYS_ADDR */
+	for (; tags->hdr.size; tags = tag_next(tags))
+		if (tags->hdr.tag == ATAG_MEM &&
+			tags->u.mem.start == 0x80000000) {
+			tags->u.mem.start = 0xa0000000;
+			break;
+		}
 }
 
 MACHINE_START(CM_X300, "CM-X300 module")
-- 
1.6.4.4
