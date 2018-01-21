From: david@lechnology.com (David Lechner)
Date: Sun, 21 Jan 2018 17:03:13 -0600
Subject: [PATCH] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
Message-ID: <1516575793-30526-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes pcs_request_gpio() in the pinctrl-single driver when
bits_per_mux != 0. It appears this was overlooked when the multiple
pins per register feature was added.

Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure
multiple pins of different modules")

Cc: Tony Lindgren <tony@atomide.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/pinctrl/pinctrl-single.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 3501491..7a5e2f1 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -391,9 +391,25 @@ static int pcs_request_gpio(struct pinctrl_dev *pctldev,
 			|| pin < frange->offset)
 			continue;
 		mux_bytes = pcs->width / BITS_PER_BYTE;
-		data = pcs->read(pcs->base + pin * mux_bytes) & ~pcs->fmask;
-		data |= frange->gpiofunc;
-		pcs->write(data, pcs->base + pin * mux_bytes);
+
+		if (pcs->bits_per_mux) {
+			int byte_num, offset, pin_shift;
+
+			byte_num = (pcs->bits_per_pin * pin) / BITS_PER_BYTE;
+			offset = (byte_num / mux_bytes) * mux_bytes;
+			pin_shift = pin % (pcs->width / pcs->bits_per_pin) *
+				    pcs->bits_per_pin;
+
+			data = pcs->read(pcs->base + offset);
+			data &= ~(pcs->fmask << pin_shift);
+			data |= frange->gpiofunc << pin_shift;
+			pcs->write(data, pcs->base + offset);
+		} else {
+			data = pcs->read(pcs->base + pin * mux_bytes);
+			data &= ~pcs->fmask;
+			data |= frange->gpiofunc;
+			pcs->write(data, pcs->base + pin * mux_bytes);
+		}
 		break;
 	}
 	return 0;
-- 
2.7.4
