From: jhovold@gmail.com (Johan Hovold)
Date: Tue, 22 Oct 2013 18:32:39 +0200
Subject: [PATCH 1/2] misc: atmel_pwm: add deferred-probing support
In-Reply-To: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
References: <1382459560-26596-1-git-send-email-jhovold@gmail.com>
Message-ID: <1382459560-26596-2-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two drivers (atmel-pwm-bl and leds-atmel-pwm) currently depend on the
atmel_pwm driver to have bound to any pwm-device before their devices
are probed.

Support deferred probing of such devices by making sure to return
-EPROBE_DEFER from pwm_channel_alloc when no pwm-device has yet been
bound.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/misc/atmel_pwm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/atmel_pwm.c b/drivers/misc/atmel_pwm.c
index 494d050..a6dc56e 100644
--- a/drivers/misc/atmel_pwm.c
+++ b/drivers/misc/atmel_pwm.c
@@ -90,8 +90,10 @@ int pwm_channel_alloc(int index, struct pwm_channel *ch)
 	unsigned long	flags;
 	int		status = 0;
 
-	/* insist on PWM init, with this signal pinned out */
-	if (!pwm || !(pwm->mask & 1 << index))
+	if (!pwm)
+		return -EPROBE_DEFER;
+
+	if (!(pwm->mask & 1 << index))
 		return -ENODEV;
 
 	if (index < 0 || index >= PWM_NCHAN || !ch)
-- 
1.8.4
