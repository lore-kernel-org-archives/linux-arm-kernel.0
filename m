From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:31:41 +0200
Subject: [PATCH 61/71] clocksource: sh_tmu: Fix channel IRQ retrieval in
 legacy case
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-61-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

In the legacy platform data case each TMU platform device handles a
single channel with a single IRQ for the platform device. Retrieve the
IRQ using the logical channel number instead of the hardware channel
number.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sh_tmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 4ba2c0f..ec34095 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -498,7 +498,7 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch, unsigned int index,
 			ch->base = tmu->mapbase + 8 + ch->index * 12;
 	}
 
-	ch->irq = platform_get_irq(tmu->pdev, ch->index);
+	ch->irq = platform_get_irq(tmu->pdev, index);
 	if (ch->irq < 0) {
 		dev_err(&tmu->pdev->dev, "ch%u: failed to get irq\n",
 			ch->index);
-- 
1.7.9.5
