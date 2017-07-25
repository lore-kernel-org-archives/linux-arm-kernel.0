From: borneo.antonio@gmail.com (Antonio Borneo)
Date: Tue, 25 Jul 2017 23:49:52 +0200
Subject: [PATCH] ASoC: fix balance of of_node_get()/of_node_put()
Message-ID: <20170725214952.6491-1-borneo.antonio@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Hikey target board, enabling CONFIG_OF_DYNAMIC triggers several
errors at kernel boot, like the following one
OF: ERROR: Bad of_node_put() on /soc/i2s at f7118000/ports/port at 0/endpoint
each followed by stack dump.

Fixed by:
- removing of_node_put() in the body of of_for_each_phandle(){},
  since already provided at each iteration. Add it in case the
  loop is break out;
- adding of_node_get() before calling of_graph_get_port_parent()
  or asoc_graph_card_dai_link_of().

Tested with kernel v4.13-rc1 with hikey_defconfig taken from
https://git.linaro.org/people/john.stultz/android-dev.git
branch dev/hikey-mainline-WIP

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
To: alsa-devel at alsa-project.org
Cc: linux-kernel at vger.kernel.org
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 sound/soc/generic/audio-graph-card.c  | 14 +++++++++-----
 sound/soc/generic/simple-card-utils.c |  5 +++++
 sound/soc/soc-core.c                  |  5 +++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index c0f08a6..7574c5f 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -228,10 +228,16 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 	 */
 
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
+		/*
+		 * asoc_graph_card_dai_link_of() will call
+		 * of_node_put(). So, call of_node_get() here
+		 */
+		of_node_get(it.node);
 		ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);
-		of_node_put(it.node);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(it.node);
 			return ret;
+		}
 	}
 
 	return asoc_simple_card_parse_card_name(card, NULL);
@@ -244,10 +250,8 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	int count = 0;
 	int rc;
 
-	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
+	of_for_each_phandle(&it, rc, node, "dais", NULL, 0)
 		count++;
-		of_node_put(it.node);
-	}
 
 	return count;
 }
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 26d64fa..144954b 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -250,6 +250,11 @@ static int asoc_simple_card_get_dai_id(struct device_node *ep)
 	if (ret != -ENOTSUPP)
 		return ret;
 
+	/*
+	 * of_graph_get_port_parent() will call
+	 * of_node_put(). So, call of_node_get() here
+	 */
+	of_node_get(ep);
 	node = of_graph_get_port_parent(ep);
 
 	/*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 921622a..a0f39de 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4087,6 +4087,11 @@ int snd_soc_get_dai_id(struct device_node *ep)
 	struct device_node *node;
 	int ret;
 
+	/*
+	 * of_graph_get_port_parent() will call
+	 * of_node_put(). So, call of_node_get() here
+	 */
+	of_node_get(ep);
 	node = of_graph_get_port_parent(ep);
 
 	/*
-- 
1.9.1
