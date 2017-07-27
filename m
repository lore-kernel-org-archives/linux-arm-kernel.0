From: borneo.antonio@gmail.com (Antonio Borneo)
Date: Fri, 28 Jul 2017 01:26:10 +0200
Subject: [PATCH v2 1/3] ASoC: fix use of of_node_put() in
 of_for_each_phandle() loops
In-Reply-To: <20170727232612.23543-1-antonio.borneo@st.com>
References: <20170727232612.23543-1-antonio.borneo@st.com>
Message-ID: <20170727232612.23543-2-antonio.borneo@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antonio Borneo <borneo.antonio@gmail.com>

On Hikey target board, enabling CONFIG_OF_DYNAMIC triggers several
errors at kernel boot, like the following one
OF: ERROR: Bad of_node_put() on /soc/i2s at f7118000/ports/port at 0
each followed by stack dump.

Each iteration of of_for_each_phandle(){} already provides the
needed of_node_put(); adding one more in the body of the loop
triggers the error.
Fixed by removing the wrong of_node_put(), but adding it when the
loop is break out.

Tested with kernel v4.13-rc2 with hikey_defconfig taken from
https://git.linaro.org/people/john.stultz/android-dev.git
branch dev/hikey-mainline-WIP

This fixes commit 2692c1c63c29 ("ASoC: add audio-graph-card
support").

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
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/audio-graph-card.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 105ec3a..20c2029 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -224,9 +224,10 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
 
 	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
 		ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);
-		of_node_put(it.node);
-		if (ret < 0)
+		if (ret < 0) {
+			of_node_put(it.node);
 			return ret;
+		}
 	}
 
 	return asoc_simple_card_parse_card_name(card, NULL);
@@ -239,10 +240,8 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	int count = 0;
 	int rc;
 
-	of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
+	of_for_each_phandle(&it, rc, node, "dais", NULL, 0)
 		count++;
-		of_node_put(it.node);
-	}
 
 	return count;
 }
-- 
1.9.1
