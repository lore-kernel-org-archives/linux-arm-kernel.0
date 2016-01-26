From: bp@alien8.de (Borislav Petkov)
Date: Tue, 26 Jan 2016 21:57:27 +0100
Subject: [PATCH 11/17] arm/samsung: Change s3c_pm_run_res() to use System RAM
 type
In-Reply-To: <1453841853-11383-1-git-send-email-bp@alien8.de>
References: <1453841853-11383-1-git-send-email-bp@alien8.de>
Message-ID: <1453841853-11383-12-git-send-email-bp@alien8.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Toshi Kani <toshi.kani@hpe.com>

Change s3c_pm_run_res() to check with IORESOURCE_SYSTEM_RAM, instead of
strcmp() with "System RAM", to walk through System RAM ranges in the
iomem table.

No functional change is made to the interface.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-arch at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mm <linux-mm@kvack.org>
Cc: linux-samsung-soc at vger.kernel.org
Link: http://lkml.kernel.org/r/1452020081-26534-11-git-send-email-toshi.kani at hpe.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/arm/plat-samsung/pm-check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/pm-check.c b/arch/arm/plat-samsung/pm-check.c
index 04aff2c31b46..70f2f699bed3 100644
--- a/arch/arm/plat-samsung/pm-check.c
+++ b/arch/arm/plat-samsung/pm-check.c
@@ -53,8 +53,8 @@ static void s3c_pm_run_res(struct resource *ptr, run_fn_t fn, u32 *arg)
 		if (ptr->child != NULL)
 			s3c_pm_run_res(ptr->child, fn, arg);
 
-		if ((ptr->flags & IORESOURCE_MEM) &&
-		    strcmp(ptr->name, "System RAM") == 0) {
+		if ((ptr->flags & IORESOURCE_SYSTEM_RAM)
+				== IORESOURCE_SYSTEM_RAM) {
 			S3C_PMDBG("Found system RAM at %08lx..%08lx\n",
 				  (unsigned long)ptr->start,
 				  (unsigned long)ptr->end);
-- 
2.3.5
