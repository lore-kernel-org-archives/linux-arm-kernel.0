From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 10 Aug 2011 14:20:57 +0530
Subject: [PATCH V2 4/6] spi/spi-pl022: calculate_effective_freq() must set
	rate <= requested rate
In-Reply-To: <cover.1312965741.git.viresh.kumar@st.com>
References: <cover.1312965741.git.viresh.kumar@st.com>
Message-ID: <cd90e62517be5d5df5f4df79893215f23e23967f.1312965742.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There were few issues with calculate_effective_freq() routine:
- It was returning first rate found >= requested rate. Now, if system have spi's
  rate as 83 MHz, with possible prescaled rates as 83, 41.5, 20.75, 13.83 (as we
  can prescale with multiples of 2). If user has given rate to be programmed as
  22 MHz, then driver programmes it to 41.5 MHz. This looks to be incorrect, as
  user might have given the upper limit of the device, and we are programming it
  above it.
- Driver finds the first satisfying rate and programmes it, but with other
  values of scr & cpsdvsr, it is possible to get more closer rate.

This patch fixes these two issues, with some reformatting inside the code.  This
also creates a inline routine to calculate prescaled rate based on spi's rate,
cpsdvsr and scr.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c |  102 +++++++++++++++++++++++-----------------------
 1 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 1c8b9ec..d1bcc79 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1791,67 +1791,67 @@ static int pl022_transfer(struct spi_device *spi, struct spi_message *msg)
 	return 0;
 }
 
-static int calculate_effective_freq(struct pl022 *pl022,
-				    int freq,
-				    struct ssp_clock_params *clk_freq)
+static inline u32 spi_rate(u32 rate, u16 cpsdvsr, u16 scr)
+{
+	return rate / (cpsdvsr * (1 + scr));
+}
+
+static int calculate_effective_freq(struct pl022 *pl022, int freq, struct
+				    ssp_clock_params * clk_freq)
 {
 	/* Lets calculate the frequency parameters */
-	u16 cpsdvsr = 2;
-	u16 scr = 0;
-	bool freq_found = false;
-	u32 rate;
-	u32 max_tclk;
-	u32 min_tclk;
+	u16 cpsdvsr = CPSDVR_MIN, scr = SCR_MIN;
+	u32 rate, max_tclk, min_tclk, best_freq = 0, best_cpsdvsr = 0,
+		best_scr = 0, tmp, found = 0;
 
 	rate = clk_get_rate(pl022->clk);
 	/* cpsdvscr = 2 & scr 0 */
-	max_tclk = (rate / (CPSDVR_MIN * (1 + SCR_MIN)));
+	max_tclk = spi_rate(rate, CPSDVR_MIN, SCR_MIN);
 	/* cpsdvsr = 254 & scr = 255 */
-	min_tclk = (rate / (CPSDVR_MAX * (1 + SCR_MAX)));
-
-	if ((freq <= max_tclk) && (freq >= min_tclk)) {
-		while (cpsdvsr <= CPSDVR_MAX && !freq_found) {
-			while (scr <= SCR_MAX && !freq_found) {
-				if ((rate /
-				     (cpsdvsr * (1 + scr))) > freq)
-					scr += 1;
-				else {
-					/*
-					 * This bool is made true when
-					 * effective frequency >=
-					 * target frequency is found
-					 */
-					freq_found = true;
-					if ((rate /
-					     (cpsdvsr * (1 + scr))) != freq) {
-						if (scr == SCR_MIN) {
-							cpsdvsr -= 2;
-							scr = SCR_MAX;
-						} else
-							scr -= 1;
-					}
-				}
-			}
-			if (!freq_found) {
-				cpsdvsr += 2;
-				scr = SCR_MIN;
-			}
-		}
-		if (cpsdvsr != 0) {
-			dev_dbg(&pl022->adev->dev,
-				"SSP Effective Frequency is %u\n",
-				(rate / (cpsdvsr * (1 + scr))));
-			clk_freq->cpsdvsr = (u8) (cpsdvsr & 0xFF);
-			clk_freq->scr = (u8) (scr & 0xFF);
-			dev_dbg(&pl022->adev->dev,
-				"SSP cpsdvsr = %d, scr = %d\n",
-				clk_freq->cpsdvsr, clk_freq->scr);
-		}
-	} else {
+	min_tclk = spi_rate(rate, CPSDVR_MAX, SCR_MAX);
+
+	if (!((freq <= max_tclk) && (freq >= min_tclk))) {
 		dev_err(&pl022->adev->dev,
 			"controller data is incorrect: out of range frequency");
 		return -EINVAL;
 	}
+
+	/*
+	 * best_freq will give closest possible available rate (<= requested
+	 * freq) for all values of scr & cpsdvsr.
+	 */
+	while ((cpsdvsr <= CPSDVR_MAX) && !found) {
+		while (scr <= SCR_MAX) {
+			tmp = spi_rate(rate, cpsdvsr, scr);
+
+			if (tmp > freq)
+				scr++;
+			/*
+			 * If found exact value, update and break.
+			 * If found more closer value, update and continue.
+			 */
+			else if ((tmp == freq) || (tmp > best_freq)) {
+				best_freq = tmp;
+				best_cpsdvsr = cpsdvsr;
+				best_scr = scr;
+
+				if (tmp == freq)
+					break;
+			}
+			scr++;
+		}
+		cpsdvsr += 2;
+		scr = SCR_MIN;
+	}
+
+	clk_freq->cpsdvsr = (u8) (best_cpsdvsr & 0xFF);
+	clk_freq->scr = (u8) (best_scr & 0xFF);
+	dev_dbg(&pl022->adev->dev,
+		"SSP Target Frequency is: %u, Effective Frequency is %u\n",
+		freq, best_freq);
+	dev_dbg(&pl022->adev->dev, "SSP cpsdvsr = %d, scr = %d\n",
+		clk_freq->cpsdvsr, clk_freq->scr);
+
 	return 0;
 }
 
-- 
1.7.2.2
