From: keescook@chromium.org (Kees Cook)
Date: Sat, 22 Mar 2014 21:20:50 -0700
Subject: [PATCH v4] ARM: mm: fix reporting of read-only PMD bits
Message-ID: <20140323042050.GA15181@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On non-LPAE ARMv6+, read-only PMD bits are defined with the combination
"PMD_SECT_APX | PMD_SECT_AP_WRITE". Adjusted the bit masks to correctly
report this.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v4:
 - clean up defines for CPU versions; Rob Herring.
v3:
 - check for pre-v6 CPUs on the page table report.
v2:
 - reorder bits, suggested by Olof.
---
 arch/arm/mm/dump.c |   47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index ef69152f9b52..c508f41a43bc 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -120,34 +120,51 @@ static const struct prot_bits pte_bits[] = {
 };
 
 static const struct prot_bits section_bits[] = {
-#ifndef CONFIG_ARM_LPAE
-	/* These are approximate */
+#ifdef CONFIG_ARM_LPAE
+	{
+		.mask	= PMD_SECT_USER,
+		.val	= PMD_SECT_USER,
+		.set	= "USR",
+	}, {
+		.mask	= PMD_SECT_RDONLY,
+		.val	= PMD_SECT_RDONLY,
+		.set	= "ro",
+		.clear	= "RW",
+#elif __LINUX_ARM_ARCH__ >= 6
 	{
-		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
-		.val	= 0,
+		.mask	= PMD_SECT_APX | PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.val	= PMD_SECT_APX | PMD_SECT_AP_WRITE,
 		.set	= "    ro",
 	}, {
-		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.mask	= PMD_SECT_APX | PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
 		.val	= PMD_SECT_AP_WRITE,
 		.set	= "    RW",
 	}, {
-		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.mask	= PMD_SECT_APX | PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
 		.val	= PMD_SECT_AP_READ,
 		.set	= "USR ro",
 	}, {
-		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.mask	= PMD_SECT_APX | PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
 		.val	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
 		.set	= "USR RW",
-#else
+#else /* ARMv4/ARMv5  */
+	/* These are approximate */
 	{
-		.mask	= PMD_SECT_USER,
-		.val	= PMD_SECT_USER,
-		.set	= "USR",
+		.mask   = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.val    = 0,
+		.set    = "    ro",
 	}, {
-		.mask	= PMD_SECT_RDONLY,
-		.val	= PMD_SECT_RDONLY,
-		.set	= "ro",
-		.clear	= "RW",
+		.mask   = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.val    = PMD_SECT_AP_WRITE,
+		.set    = "    RW",
+	}, {
+		.mask   = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.val    = PMD_SECT_AP_READ,
+		.set    = "USR ro",
+	}, {
+		.mask   = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.val    = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.set    = "USR RW",
 #endif
 	}, {
 		.mask	= PMD_SECT_XN,
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
