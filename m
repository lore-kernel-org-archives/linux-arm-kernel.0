From: dianders@chromium.org (Doug Anderson)
Date: Wed,  4 Jun 2014 10:30:33 -0700
Subject: [PATCH 2/3] clocksource: exynos_mct: cache mct upper count
In-Reply-To: <1401903034-20074-1-git-send-email-dianders@chromium.org>
References: <1401903034-20074-1-git-send-email-dianders@chromium.org>
Message-ID: <1401903034-20074-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mandeep Singh Baines <msb@chromium.org>

Saves one register read.  Note that the upper count only changes every
~178 seconds with a 24MHz source clock, so it's likely it hasn't
changed from call to call.

Before: 1323852 us for 1000000 gettimeofday in userspace
After:  1173084 us for 1000000 gettimeofday in userspace

Note that even with this change the CPU is in exynos_frc_read() more
than 2% of the time in real world profiles of ChromeOS.  That
indicates that it's important to optimize.

Signed-off-by: Mandeep Singh Baines <msb@chromium.org>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/clocksource/exynos_mct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index ba3a683..7cbe4aa 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -167,8 +167,8 @@ static void exynos4_mct_frc_start(u32 hi, u32 lo)
 
 static inline cycle_t notrace _exynos4_frc_read(void)
 {
-	unsigned int lo, hi;
-	u32 hi2 = __raw_readl(reg_base + EXYNOS4_MCT_G_CNT_U);
+	u32 lo, hi;
+	static u32 hi2;
 
 	do {
 		hi = hi2;
-- 
2.0.0.526.g5318336
