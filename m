From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 12 May 2014 18:06:35 +0200
Subject: [PATCH 07/12] drivers: clk: st: Add quadfs reset handling
In-Reply-To: <1399910800-12847-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1399910800-12847-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1399910800-12847-8-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the support of quadfs reset handling.

Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
---
 drivers/clk/st/clkgen-fsyn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index 5aae17c..46b29c4 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -70,12 +70,14 @@ struct clkgen_quadfs_data {
 	bool powerup_polarity;
 	bool standby_polarity;
 	bool nsdiv_present;
+	bool nrst_present;
 	struct clkgen_field ndiv;
 	struct clkgen_field ref_bw;
 	struct clkgen_field nreset;
 	struct clkgen_field npda;
 	struct clkgen_field lock_status;
 
+	struct clkgen_field nrst[QUADFS_MAX_CHAN];
 	struct clkgen_field nsb[QUADFS_MAX_CHAN];
 	struct clkgen_field en[QUADFS_MAX_CHAN];
 	struct clkgen_field mdiv[QUADFS_MAX_CHAN];
@@ -615,6 +617,9 @@ static int quadfs_fsynth_enable(struct clk_hw *hw)
 
 	CLKGEN_WRITE(fs, nsb[fs->chan], !fs->data->standby_polarity);
 
+	if (fs->data->nrst_present)
+		CLKGEN_WRITE(fs, nrst[fs->chan], 0);
+
 	if (fs->lock)
 		spin_unlock_irqrestore(fs->lock, flags);
 
-- 
1.9.1
