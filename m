From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:24:03 +0100
Subject: [PATCH RFC 03/13] ASoC: avoid duplicated DAI routes
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V63uN-0004lL-7q@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ASoC automatically creates snd_soc_dapm_dai_in and snd_soc_dapm_dai_out
widgets for DAI drivers, and adds them to the list.  Later on, ASoC
creates automatic routes between these widgets and a widget with a
stream name.

We look for a snd_soc_dapm_dai_in or snd_soc_dapm_dai_out widget, and
use this to obtain the DAI structure.  We then scan all widgets for
any with a stream name refering to either the capture or the playback
stream, and create routes.

If you have both a snd_soc_dapm_dai_in and a snd_soc_dapm_dai_out
referring to the same DAI structure, this ends up creating one set of
routes for the DAI for the snd_soc_dapm_dai_in widget, and a duplicated
set of routes for the snd_soc_dapm_dai_out widget.

Fix this by checking that the stream name for the widget matches the
DAI widget name.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c7051c4..9f67976 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3439,7 +3439,7 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 				break;
 			}
 
-			if (!w->sname)
+			if (!w->sname || !strstr(w->sname, dai_w->name))
 				continue;
 
 			if (dai->driver->playback.stream_name &&
-- 
1.7.4.4
