From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  6 Aug 2015 16:11:55 +0200
Subject: [PATCH v3 18/18] ASoC: core: Probe components on demand
In-Reply-To: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438870315-18689-19-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a component through its OF node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3: None
Changes in v2: None

 sound/soc/soc-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c81aec9c872a..1157049b1a34 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -34,6 +34,7 @@
 #include <linux/ctype.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
@@ -865,10 +866,12 @@ static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
 static struct snd_soc_component *soc_find_component(
-	const struct device_node *of_node, const char *name)
+	struct device_node *of_node, const char *name)
 {
 	struct snd_soc_component *component;
 
+	of_platform_probe(of_node);
+
 	lockdep_assert_held(&client_mutex);
 
 	list_for_each_entry(component, &component_list, list) {
@@ -890,6 +893,8 @@ static struct snd_soc_dai *snd_soc_find_dai(
 	struct snd_soc_dai *dai;
 	struct device_node *component_of_node;
 
+	of_platform_probe(dlc->of_node);
+
 	lockdep_assert_held(&client_mutex);
 
 	/* Find CPU DAI from registered DAIs*/
-- 
2.4.3
