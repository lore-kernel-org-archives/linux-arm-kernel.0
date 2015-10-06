From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  6 Oct 2015 15:44:00 +0100
Subject: [PATCH 3/3] hwrng: st: Use real-world device timings for timeout
In-Reply-To: <1444142640-14721-1-git-send-email-lee.jones@linaro.org>
References: <1444142640-14721-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1444142640-14721-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samples are documented to be available every 0.667us, so in theory
the 8 sample deep FIFO should take 5.336us to fill.  However, during
thorough testing, it became apparent that filling the FIFO actually
takes closer to 12us.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/hw_random/st-rng.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/st-rng.c b/drivers/char/hw_random/st-rng.c
index 44480fe..3b1432c 100644
--- a/drivers/char/hw_random/st-rng.c
+++ b/drivers/char/hw_random/st-rng.c
@@ -33,8 +33,13 @@
 #define ST_RNG_FIFO_DEPTH		8
 #define ST_RNG_FIFO_SIZE		(ST_RNG_FIFO_DEPTH * ST_RNG_SAMPLE_SIZE)
 
-/* Samples are available every 0.667us, which we round to 1us */
-#define ST_RNG_FILL_FIFO_TIMEOUT   (1 * (ST_RNG_FIFO_SIZE / ST_RNG_SAMPLE_SIZE))
+/*
+ * Samples are documented to be available every 0.667us, so in theory
+ * the 8 sample deep FIFO should take 5.336us to fill.  However, during
+ * thorough testing, it became apparent that filling the FIFO actually
+ * takes closer to 12us.
+ */
+#define ST_RNG_FILL_FIFO_TIMEOUT	12
 
 struct st_rng_data {
 	void __iomem	*base;
-- 
1.9.1
