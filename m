From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 26 Jun 2014 15:22:50 +0100
Subject: [PATCH 1/7] ASoC: fix debugfs directory creation bug
In-Reply-To: <20140626142231.GR32514@n2100.arm.linux.org.uk>
References: <20140626142231.GR32514@n2100.arm.linux.org.uk>
Message-ID: <E1X0AZe-0003i7-0z@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid creating duplicate directories by prefixing codecs and platforms
with their separate identifiers.  This avoids snd-soc-dummy (which can
appear both as a dummy platform and a dummy codec on the same card)
from clashing.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/soc-core.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b87d7d882e6d..91120b8e283e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -270,12 +270,32 @@ static const struct file_operations codec_reg_fops = {
 	.llseek = default_llseek,
 };
 
+static struct dentry *soc_debugfs_create_dir(struct dentry *parent,
+	const char *fmt, ...)
+{
+	struct dentry *de;
+	va_list ap;
+	char *s;
+
+	va_start(ap, fmt);
+	s = kvasprintf(GFP_KERNEL, fmt, ap);
+	va_end(ap);
+
+	if (!s)
+		return NULL;
+
+	de = debugfs_create_dir(s, parent);
+	kfree(s);
+
+	return de;
+}
+
 static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 {
 	struct dentry *debugfs_card_root = codec->card->debugfs_card_root;
 
-	codec->debugfs_codec_root = debugfs_create_dir(codec->name,
-						       debugfs_card_root);
+	codec->debugfs_codec_root = soc_debugfs_create_dir(debugfs_card_root,
+						"codec:%s", codec->name);
 	if (!codec->debugfs_codec_root) {
 		dev_warn(codec->dev,
 			"ASoC: Failed to create codec debugfs directory\n");
@@ -306,8 +326,8 @@ static void soc_init_platform_debugfs(struct snd_soc_platform *platform)
 {
 	struct dentry *debugfs_card_root = platform->card->debugfs_card_root;
 
-	platform->debugfs_platform_root = debugfs_create_dir(platform->name,
-						       debugfs_card_root);
+	platform->debugfs_platform_root = soc_debugfs_create_dir(debugfs_card_root,
+						"platform:%s", platform->name);
 	if (!platform->debugfs_platform_root) {
 		dev_warn(platform->dev,
 			"ASoC: Failed to create platform debugfs directory\n");
-- 
1.8.3.1
