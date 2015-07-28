From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:53 +0200
Subject: [PATCH v2 22/22] ASoC: core: Probe components on demand
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-23-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a component through its firmware node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 sound/soc/soc-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c81aec9c872a..4c55da97f9ed 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -865,10 +865,12 @@ static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
 static struct snd_soc_component *soc_find_component(
-	const struct device_node *of_node, const char *name)
+	struct device_node *of_node, const char *name)
 {
 	struct snd_soc_component *component;
 
+	fwnode_ensure_device(&of_node->fwnode);
+
 	lockdep_assert_held(&client_mutex);
 
 	list_for_each_entry(component, &component_list, list) {
@@ -890,6 +892,8 @@ static struct snd_soc_dai *snd_soc_find_dai(
 	struct snd_soc_dai *dai;
 	struct device_node *component_of_node;
 
+	fwnode_ensure_device(&dlc->of_node->fwnode);
+
 	lockdep_assert_held(&client_mutex);
 
 	/* Find CPU DAI from registered DAIs*/
-- 
2.4.3
