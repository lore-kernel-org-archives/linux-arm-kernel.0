From: keescook@chromium.org (Kees Cook)
Date: Sat, 22 Mar 2014 08:16:57 -0700
Subject: [PATCH v3] ARM: mm: fix reporting of read-only PMD bits
Message-ID: <20140322151657.GA23606@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On non-LPAE ARMv6+, read-only PMD bits are defined with the combination
"PMD_SECT_APX | PMD_SECT_AP_WRITE". Adjusted the bit masks to correctly
report this.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
 - check for pre-v6 CPUs on the page table report.
v2:
 - reorder bits, suggested by Olof.
---
 arch/arm/mm/dump.c |   31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index ef69152f9b52..c1122d266c45 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -121,23 +121,42 @@ static const struct prot_bits pte_bits[] = {
 
 static const struct prot_bits section_bits[] = {
 #ifndef CONFIG_ARM_LPAE
-	/* These are approximate */
+# if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K) || defined(CONFIG_CPU_V7)
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
+# else
+	/* These are approximate */
+	{
+		.mask   = PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.val    = 0,
+		.set    = "    ro",
+	}, {
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
+# endif
 #else
 	{
 		.mask	= PMD_SECT_USER,
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
