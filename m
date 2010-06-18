From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 18 Jun 2010 07:48:53 +0200
Subject: [PATCH 2/4] pxa2xx/cpufreq: Simplify DRI recomputation routine
In-Reply-To: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
References: <1276840135-5982-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1276840135-5982-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch:
1) Simpifies the DRI recomputation routine by pulling out the common code
2) Fixes a bug in PXA27x DRI recomputation caused by incorrect parenthesis

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/cpufreq-pxa2xx.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
index 1949850..74fc4b5 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
@@ -256,12 +256,13 @@ static void init_sdram_rows(void)
 
 static u32 mdrefr_dri(unsigned int freq)
 {
-	u32 dri = 0;
+	u32 dri = freq * SDRAM_TREF / sdram_rows;
 
-	if (cpu_is_pxa25x())
-		dri = ((freq * SDRAM_TREF) / (sdram_rows * 32));
 	if (cpu_is_pxa27x())
-		dri = ((freq * SDRAM_TREF) / (sdram_rows - 31)) / 32;
+		dri -= 31;
+
+	dri /= 32;
+
 	return dri;
 }
 
-- 
1.7.1
