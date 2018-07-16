From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 16 Jul 2018 09:13:24 +0200
Subject: [PATCH] pwm-omap: handle timers not ready in probe
In-Reply-To: <20180711142526.dto6iost57zx5t5l@earth.universe>
References: <20180709081534.GA6799@amd>
 <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd> <20180711132739.GL99251@atomide.com>
 <20180711142526.dto6iost57zx5t5l@earth.universe>
Message-ID: <20180716071323.GB23110@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


When all the drivers are built-in, timers are not ready and probing
fails. Fix that with -EPROBE_DEFFER.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 665da3c..debeb70 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -265,7 +271,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	timer_pdata = dev_get_platdata(&timer_pdev->dev);
 	if (!timer_pdata) {
 		dev_err(&pdev->dev, "dmtimer pdata structure NULL\n");
-		ret = -EINVAL;
+		ret = -EPROBE_DEFER;
 		goto put;
 	}
 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180716/764fd600/attachment-0001.sig>
