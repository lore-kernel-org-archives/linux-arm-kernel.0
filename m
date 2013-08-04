From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:25:03 +0100
Subject: [PATCH RFC 04/13] ASoC: HACK: avoid creating duplicated widgets
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V63vL-0004lQ-Bl@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU DAI widgets are created twice by the core when the CPU DAI
and the platform DAI are registered against the same device structure
since commit be09ad90e1 (ASoC: core: Add platform DAI widget mapping).
This wouldn't be a problem except that these widgets are stored in the
DAI structure, and the platform ones are created first, and the CPU
ones later.

We end up with two sets of widgets: the platform ones appear in debugfs,
but the CPU ones do not, and these two sets of widgets with the same
name are added to the card's DAI list.  This makes it difficult to
ensure that the right set of widgets (which will be activated by
playback) are correctly linked to other widgets by the DAPM routes.
It's also very confusing because the widgets you can view via debugfs
may not be the ones ASoC is actually using.

This needs fixing properly - this patch is just a hack around the
problem which gets Kirkwood with SPDIF working.  It is likely this
patch breaks other implementations.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d56bbea..48e883e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1362,7 +1362,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 				return -ENODEV;
 
 			list_add(&cpu_dai->dapm.list, &card->dapm_list);
-			snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
+//			snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
 		}
 
 		if (cpu_dai->driver->probe) {
-- 
1.7.4.4
