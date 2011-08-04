From: swarren@nvidia.com (Stephen Warren)
Date: Thu,  4 Aug 2011 17:00:20 -0600
Subject: [PATCH 3/3] ASoC: jack_add_gpios: Don't gpio_request GPIOs used as
	IRQs.
In-Reply-To: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
Message-ID: <1312498820-2275-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

request_any_context_irq now performs this internally. Remove the exra
calls from the driver so that request_any_context_irq succeeds.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-jack.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 7c17b98..306d521 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -310,14 +310,6 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 			goto undo;
 		}
 
-		ret = gpio_request(gpios[i].gpio, gpios[i].name);
-		if (ret)
-			goto undo;
-
-		ret = gpio_direction_input(gpios[i].gpio);
-		if (ret)
-			goto err;
-
 		INIT_DELAYED_WORK(&gpios[i].work, gpio_work);
 		gpios[i].jack = jack;
 
@@ -328,7 +320,7 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 					      gpios[i].name,
 					      &gpios[i]);
 		if (ret)
-			goto err;
+			goto undo;
 
 		if (gpios[i].wake) {
 			ret = irq_set_irq_wake(gpio_to_irq(gpios[i].gpio), 1);
@@ -349,8 +341,6 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 
 	return 0;
 
-err:
-	gpio_free(gpios[i].gpio);
 undo:
 	snd_soc_jack_free_gpios(jack, i, gpios);
 
@@ -378,7 +368,6 @@ void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 #endif
 		free_irq(gpio_to_irq(gpios[i].gpio), &gpios[i]);
 		cancel_delayed_work_sync(&gpios[i].work);
-		gpio_free(gpios[i].gpio);
 		gpios[i].jack = NULL;
 	}
 }
-- 
1.7.0.4
