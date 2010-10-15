From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 15 Oct 2010 17:15:20 +0300
Subject: [PATCH .36-rc8] arm: mm: allow, but warn,
	when issuing ioremap() on RAM
Message-ID: <1287152120-7201-1-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

Drivers have been relying on this behavior, but done so wrongly.
However, rather than breaking drivers from .35 to .36, we should warn on
.36 and only break on .37. This way we give a chance for contributors to
fix the issues.

According to ARM, the behavior of having multiple mappings is
unspecified from ARMv6+. This causes real issues specially on modern
hardware, and specially with speculative prefetching. So drivers need to
be fixed.

Also, since current hardware has palliative meassures to deal with
multiple mappings with the same memory type but diferent cacheability
attributes, ensure that such restriction is taking place.

Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mm/ioremap.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ab50627..7dfd6dd 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -202,10 +202,14 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 		return NULL;
 
 	/*
-	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
+	 * This causes problems with ARMv6+. Will be disallowed soon.
+	 * Also avoid a second mapping with different shareability, which is
+	 * not supposed to work anyway.
 	 */
 	if (WARN_ON(pfn_valid(pfn)))
-		return NULL;
+		if (__LINUX_ARM_ARCH__ >= 6 &&
+		    (mtype != MT_DEVICE_CACHED && mtype != MT_DEVICE_WC))
+			mtype = MT_DEVICE_WC;
 
 	type = get_mem_type(mtype);
 	if (!type)
-- 
1.7.3.1.2.g7fe2b
