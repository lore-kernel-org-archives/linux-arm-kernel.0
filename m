From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu,  1 Nov 2012 07:04:21 +0800
Subject: [PATCH v3 9/9] pinctrl: single: dump pinmux register value
In-Reply-To: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
References: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1351724661-29050-10-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dump pinmux register value, not only function part in the pinmux
register.

Also fix the issue on caluclating pin offset. The last parameter
should be pin number, not register offset.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinctrl-single.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 3b97b65..72017e7 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -283,15 +283,15 @@ static int pcs_get_group_pins(struct pinctrl_dev *pctldev,
 
 static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
 					struct seq_file *s,
-					unsigned offset)
+					unsigned pin)
 {
 	struct pcs_device *pcs;
-	unsigned val;
+	unsigned val, mux_bytes;
 
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
-	val = pcs->read(pcs->base + offset);
-	val &= pcs->fmask;
+	mux_bytes = pcs->width / BITS_PER_BYTE;
+	val = pcs->read(pcs->base + pin * mux_bytes);
 
 	seq_printf(s, "%08x %s " , val, DRIVER_NAME);
 }
-- 
1.7.10.4
