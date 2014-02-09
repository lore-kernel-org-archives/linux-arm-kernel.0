From: keescook@chromium.org (Kees Cook)
Date: Sun, 9 Feb 2014 14:06:22 -0800
Subject: [PATCH] ARM: mm: fix reporting of read-only PMD bits
Message-ID: <20140209220622.GA30511@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On non-LPAE, read-only PMD bits are defined with the combination
"PMD_SECT_APX | PMD_SECT_AP_WRITE". Adjusted the bit masks to correctly
detect this.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mm/dump.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 2b3a56414271..1f7b1e13d945 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -123,19 +123,19 @@ static const struct prot_bits section_bits[] = {
 #ifndef CONFIG_ARM_LPAE
 	/* These are approximate */
 	{
-		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
-		.val	= 0,
+		.mask	= PMD_SECT_AP_READ | PMD_SECT_APX | PMD_SECT_AP_WRITE,
+		.val	= PMD_SECT_APX | PMD_SECT_AP_WRITE,
 		.set	= "    ro",
 	}, {
-		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.mask	= PMD_SECT_AP_READ | PMD_SECT_APX | PMD_SECT_AP_WRITE,
 		.val	= PMD_SECT_AP_WRITE,
 		.set	= "    RW",
 	}, {
-		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.mask	= PMD_SECT_AP_READ | PMD_SECT_APX | PMD_SECT_AP_WRITE,
 		.val	= PMD_SECT_AP_READ,
 		.set	= "USR ro",
 	}, {
-		.mask	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
+		.mask	= PMD_SECT_AP_READ | PMD_SECT_APX | PMD_SECT_AP_WRITE,
 		.val	= PMD_SECT_AP_READ | PMD_SECT_AP_WRITE,
 		.set	= "USR RW",
 #else
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
