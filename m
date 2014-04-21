From: elder@linaro.org (Alex Elder)
Date: Mon, 21 Apr 2014 16:11:37 -0500
Subject: [PATCH v4 RESEND 1/7] clk: bcm281xx: warn if ccu_wait_bit() fails
In-Reply-To: <1398114703-32410-1-git-send-email-elder@linaro.org>
References: <1398114703-32410-1-git-send-email-elder@linaro.org>
Message-ID: <1398114703-32410-2-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't let a failure of ccu_wait_bit() go unnoticed.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/clk/bcm/clk-kona.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index db11a87..4b4e35a 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -207,6 +207,9 @@ __ccu_wait_bit(struct ccu_data *ccu, u32 reg_offset, u32 bit, bool want)
 			return true;
 		udelay(1);
 	}
+	pr_warn("%s: %s/0x%04x bit %u was never %s\n", __func__,
+		ccu->name, reg_offset, bit, want ? "set" : "clear");
+
 	return false;
 }
 
-- 
1.9.1
