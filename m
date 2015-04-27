From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 27 Apr 2015 08:15:13 +0000
Subject: [PATCH 1/2] mmc: sdhci-sirf: fix the tuning count in
 platform_execute_tuning
Message-ID: <1430122514-6541-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Weijun Yang <Weijun.Yang@csr.com>

hardware has 16bit to record the tuning count, so fix it to 16384.
at the same time, tuned_phases[SIRF_TUNING_COUNT] is useless as the
array is never used, so move it to a variant.

Signed-off-by: Weijun Yang <Weijun.Yang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/mmc/host/sdhci-sirf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index 32848eb..2201f76 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -17,7 +17,7 @@
 
 #define SDHCI_CLK_DELAY_SETTING 0x4C
 #define SDHCI_SIRF_8BITBUS BIT(3)
-#define SIRF_TUNING_COUNT 128
+#define SIRF_TUNING_COUNT 16384
 
 struct sdhci_sirf_priv {
 	int gpio_cd;
@@ -46,7 +46,7 @@ static void sdhci_sirf_set_bus_width(struct sdhci_host *host, int width)
 static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int tuning_seq_cnt = 3;
-	u8 phase, tuned_phases[SIRF_TUNING_COUNT];
+	int phase;
 	u8 tuned_phase_cnt = 0;
 	int rc = 0, longest_range = 0;
 	int start = -1, end = 0, tuning_value = -1, range = 0;
@@ -58,6 +58,7 @@ static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
 
 retry:
 	phase = 0;
+	tuned_phase_cnt = 0;
 	do {
 		sdhci_writel(host,
 			clock_setting | phase,
@@ -65,7 +66,7 @@ retry:
 
 		if (!mmc_send_tuning(mmc)) {
 			/* Tuning is successful at this tuning point */
-			tuned_phases[tuned_phase_cnt++] = phase;
+			tuned_phase_cnt++;
 			dev_dbg(mmc_dev(mmc), "%s: Found good phase = %d\n",
 				 mmc_hostname(mmc), phase);
 			if (start == -1)
@@ -85,7 +86,7 @@ retry:
 			start = -1;
 			end = range = 0;
 		}
-	} while (++phase < ARRAY_SIZE(tuned_phases));
+	} while (++phase < SIRF_TUNING_COUNT);
 
 	if (tuned_phase_cnt && tuning_value > 0) {
 		/*
-- 
2.3.5
