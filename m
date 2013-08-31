From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 31 Aug 2013 13:45:37 +0100
Subject: [PATCH 11/14] ASoC: kirkwood-openrd: add DAPM links between codec
 and cpu DAI
In-Reply-To: <20130831123458.GF6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
Message-ID: <E1VFkYb-0003JA-5Z@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DAPM links to connect the codec DAC and ADCs to the cpu DAI
I2S inputs/outputs.  This is required to restore audio on this
platform as kirkwood-i2s must know which output streams to enable.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-openrd.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index a25dfcf..258fcce 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -50,6 +50,7 @@ static struct snd_soc_ops openrd_client_ops = {
 };
 
 
+/* This will need to be updated when DPCM support works. */
 static struct snd_soc_dai_link openrd_client_dai[] = {
 {
 	.name = "CS42L51",
@@ -63,12 +64,19 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 },
 };
 
+static const struct snd_soc_dapm_route routes[] = {
+	/* Connect the codec streams to the I2S connections */
+	{ "Playback", NULL, "i2sdo" },
+	{ "i2sdi", NULL, "Capture" },
+};
 
 static struct snd_soc_card openrd_client = {
 	.name = "OpenRD Client",
 	.owner = THIS_MODULE,
 	.dai_link = openrd_client_dai,
 	.num_links = ARRAY_SIZE(openrd_client_dai),
+	.dapm_routes = routes,
+	.num_dapm_routes = ARRAY_SIZE(routes),
 };
 
 static int openrd_probe(struct platform_device *pdev)
-- 
1.7.4.4
