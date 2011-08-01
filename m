From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 1 Aug 2011 19:38:10 +0800
Subject: [PATCH 1/1] ASoC: core: cache index fix
Message-ID: <1312198690-13237-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For codecs whose reg_cache_step is not 1, the original cache io
code may fetch a wrong value since it does not check the
reg_cache_step and remainly use the reg as index to fetch value
from cache.

This patch provides help functions for conversion between cache index
and register index and the cache io functions will use them in right
place to ensure to fetch a correct register value.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 include/sound/soc.h   |    4 ++
 sound/soc/soc-cache.c |  117 +++++++++++++++++++++++++++++++++++++------------
 sound/soc/soc-core.c  |   15 +++---
 sound/soc/soc-io.c    |   10 +++-
 4 files changed, 107 insertions(+), 39 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index aa19f5a..b70789d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -306,6 +306,10 @@ int snd_soc_cache_write(struct snd_soc_codec *codec,
 			unsigned int reg, unsigned int value);
 int snd_soc_cache_read(struct snd_soc_codec *codec,
 		       unsigned int reg, unsigned int *value);
+int snd_soc_cache_reg_to_idx(struct snd_soc_codec *codec,
+				unsigned int reg);
+int snd_soc_cache_idx_to_reg(struct snd_soc_codec *codec,
+				unsigned int idx);
 int snd_soc_default_volatile_register(struct snd_soc_codec *codec,
 				      unsigned int reg);
 int snd_soc_default_readable_register(struct snd_soc_codec *codec,
diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index d9f8ade..1a08bcf 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -66,6 +66,38 @@ static unsigned int snd_soc_get_cache_val(const void *base, unsigned int idx,
 	return -1;
 }
 
+int snd_soc_cache_reg_to_idx(struct snd_soc_codec *codec,
+				   unsigned int reg)
+{
+	const struct snd_soc_codec_driver *codec_drv;
+	unsigned int idx = 0;
+
+	codec_drv = codec->driver;
+
+	if (codec_drv->reg_cache_step > 0)
+		idx = reg / codec_drv->reg_cache_step;
+	else
+		idx = reg;
+
+	return idx;
+}
+
+int snd_soc_cache_idx_to_reg(struct snd_soc_codec *codec,
+				   unsigned int idx)
+{
+	const struct snd_soc_codec_driver *codec_drv;
+	unsigned int reg = 0;
+
+	codec_drv = codec->driver;
+
+	if (codec_drv->reg_cache_step > 0)
+		reg = idx * codec_drv->reg_cache_step;
+	else
+		reg = idx;
+
+	return reg;
+}
+
 struct snd_soc_rbtree_node {
 	struct rb_node node; /* the actual rbtree node holding this block */
 	unsigned int base_reg; /* base register handled by this block */
@@ -262,14 +294,17 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 	unsigned int pos;
 	int i;
 	int ret;
+	unsigned int idx;
+
+	idx = snd_soc_cache_reg_to_idx(codec, reg);
 
 	rbtree_ctx = codec->reg_cache;
 	/* look up the required register in the cached rbnode */
 	rbnode = rbtree_ctx->cached_rbnode;
 	if (rbnode) {
 		snd_soc_rbtree_get_base_top_reg(rbnode, &base_reg, &top_reg);
-		if (reg >= base_reg && reg <= top_reg) {
-			reg_tmp = reg - base_reg;
+		if (idx >= base_reg && idx <= top_reg) {
+			reg_tmp = idx - base_reg;
 			val = snd_soc_rbtree_get_register(rbnode, reg_tmp);
 			if (val == value)
 				return 0;
@@ -280,9 +315,9 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 	/* if we can't locate it in the cached rbnode we'll have
 	 * to traverse the rbtree looking for it.
 	 */
-	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
+	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, idx);
 	if (rbnode) {
-		reg_tmp = reg - rbnode->base_reg;
+		reg_tmp = idx - rbnode->base_reg;
 		val = snd_soc_rbtree_get_register(rbnode, reg_tmp);
 		if (val == value)
 			return 0;
@@ -298,15 +333,15 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 			rbnode_tmp = rb_entry(node, struct snd_soc_rbtree_node, node);
 			for (i = 0; i < rbnode_tmp->blklen; ++i) {
 				reg_tmp = rbnode_tmp->base_reg + i;
-				if (abs(reg_tmp - reg) != 1)
+				if (abs(reg_tmp - idx) != 1)
 					continue;
 				/* decide where in the block to place our register */
-				if (reg_tmp + 1 == reg)
+				if (reg_tmp + 1 == idx)
 					pos = i + 1;
 				else
 					pos = i;
 				ret = snd_soc_rbtree_insert_to_block(rbnode_tmp, pos,
-								     reg, value);
+								     idx, value);
 				if (ret)
 					return ret;
 				rbtree_ctx->cached_rbnode = rbnode_tmp;
@@ -322,7 +357,7 @@ static int snd_soc_rbtree_cache_write(struct snd_soc_codec *codec,
 		if (!rbnode)
 			return -ENOMEM;
 		rbnode->blklen = 1;
-		rbnode->base_reg = reg;
+		rbnode->base_reg = idx;
 		rbnode->word_size = codec->driver->reg_word_size;
 		rbnode->block = kmalloc(rbnode->blklen * rbnode->word_size,
 					GFP_KERNEL);
@@ -345,14 +380,17 @@ static int snd_soc_rbtree_cache_read(struct snd_soc_codec *codec,
 	struct snd_soc_rbtree_node *rbnode;
 	unsigned int base_reg, top_reg;
 	unsigned int reg_tmp;
+	unsigned int idx;
+
+	idx = snd_soc_cache_reg_to_idx(codec, reg);
 
 	rbtree_ctx = codec->reg_cache;
 	/* look up the required register in the cached rbnode */
 	rbnode = rbtree_ctx->cached_rbnode;
 	if (rbnode) {
 		snd_soc_rbtree_get_base_top_reg(rbnode, &base_reg, &top_reg);
-		if (reg >= base_reg && reg <= top_reg) {
-			reg_tmp = reg - base_reg;
+		if (idx >= base_reg && reg <= top_reg) {
+			reg_tmp = idx - base_reg;
 			*value = snd_soc_rbtree_get_register(rbnode, reg_tmp);
 			return 0;
 		}
@@ -360,9 +398,9 @@ static int snd_soc_rbtree_cache_read(struct snd_soc_codec *codec,
 	/* if we can't locate it in the cached rbnode we'll have
 	 * to traverse the rbtree looking for it.
 	 */
-	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, reg);
+	rbnode = snd_soc_rbtree_lookup(&rbtree_ctx->root, idx);
 	if (rbnode) {
-		reg_tmp = reg - rbnode->base_reg;
+		reg_tmp = idx - rbnode->base_reg;
 		*value = snd_soc_rbtree_get_register(rbnode, reg_tmp);
 		rbtree_ctx->cached_rbnode = rbnode;
 	} else {
@@ -408,6 +446,7 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 	unsigned int val;
 	int i;
 	int ret;
+	unsigned int reg;
 
 	codec->reg_cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
 	if (!codec->reg_cache)
@@ -426,7 +465,8 @@ static int snd_soc_rbtree_cache_init(struct snd_soc_codec *codec)
 					    word_size);
 		if (!val)
 			continue;
-		ret = snd_soc_rbtree_cache_write(codec, i, val);
+		reg = snd_soc_cache_idx_to_reg(codec, i);
+		ret = snd_soc_rbtree_cache_write(codec, reg, val);
 		if (ret)
 			goto err;
 	}
@@ -560,21 +600,23 @@ static int snd_soc_lzo_cache_sync(struct snd_soc_codec *codec)
 	unsigned int val;
 	int i;
 	int ret;
+	unsigned int reg;
 
 	lzo_blocks = codec->reg_cache;
 	for_each_set_bit(i, lzo_blocks[0]->sync_bmp, lzo_blocks[0]->sync_bmp_nbits) {
+		reg = snd_soc_cache_idx_to_reg(codec, i);
 		WARN_ON(codec->writable_register &&
-			codec->writable_register(codec, i));
-		ret = snd_soc_cache_read(codec, i, &val);
+			codec->writable_register(codec, reg));
+		ret = snd_soc_cache_read(codec, reg, &val);
 		if (ret)
 			return ret;
 		codec->cache_bypass = 1;
-		ret = snd_soc_write(codec, i, val);
+		ret = snd_soc_write(codec, reg, val);
 		codec->cache_bypass = 0;
 		if (ret)
 			return ret;
 		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
-			i, val);
+			reg, val);
 	}
 
 	return 0;
@@ -587,11 +629,14 @@ static int snd_soc_lzo_cache_write(struct snd_soc_codec *codec,
 	int ret, blkindex, blkpos;
 	size_t blksize, tmp_dst_len;
 	void *tmp_dst;
+	unsigned int idx;
+
+	idx = snd_soc_cache_reg_to_idx(codec, reg);
 
 	/* index of the compressed lzo block */
-	blkindex = snd_soc_lzo_get_blkindex(codec, reg);
+	blkindex = snd_soc_lzo_get_blkindex(codec, idx);
 	/* register index within the decompressed block */
-	blkpos = snd_soc_lzo_get_blkpos(codec, reg);
+	blkpos = snd_soc_lzo_get_blkpos(codec, idx);
 	/* size of the compressed block */
 	blksize = snd_soc_lzo_get_blksize(codec);
 	lzo_blocks = codec->reg_cache;
@@ -632,7 +677,7 @@ static int snd_soc_lzo_cache_write(struct snd_soc_codec *codec,
 	}
 
 	/* set the bit so we know we have to sync this register */
-	set_bit(reg, lzo_block->sync_bmp);
+	set_bit(idx, lzo_block->sync_bmp);
 	kfree(tmp_dst);
 	kfree(lzo_block->src);
 	return 0;
@@ -649,12 +694,15 @@ static int snd_soc_lzo_cache_read(struct snd_soc_codec *codec,
 	int ret, blkindex, blkpos;
 	size_t blksize, tmp_dst_len;
 	void *tmp_dst;
+	unsigned int idx;
+
+	idx = snd_soc_cache_reg_to_idx(codec, reg);
 
 	*value = 0;
 	/* index of the compressed lzo block */
-	blkindex = snd_soc_lzo_get_blkindex(codec, reg);
+	blkindex = snd_soc_lzo_get_blkindex(codec, idx);
 	/* register index within the decompressed block */
-	blkpos = snd_soc_lzo_get_blkpos(codec, reg);
+	blkpos = snd_soc_lzo_get_blkpos(codec, idx);
 	/* size of the compressed block */
 	blksize = snd_soc_lzo_get_blksize(codec);
 	lzo_blocks = codec->reg_cache;
@@ -820,23 +868,25 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 	int ret;
 	const struct snd_soc_codec_driver *codec_drv;
 	unsigned int val;
+	unsigned int reg;
 
 	codec_drv = codec->driver;
 	for (i = 0; i < codec_drv->reg_cache_size; ++i) {
+		reg = snd_soc_cache_idx_to_reg(codec, i);
 		WARN_ON(codec->writable_register &&
-			codec->writable_register(codec, i));
-		ret = snd_soc_cache_read(codec, i, &val);
+			codec->writable_register(codec, reg));
+		ret = snd_soc_cache_read(codec, reg, &val);
 		if (ret)
 			return ret;
 		if (codec->reg_def_copy)
 			if (snd_soc_get_cache_val(codec->reg_def_copy,
-						  i, codec_drv->reg_word_size) == val)
+						  reg, codec_drv->reg_word_size) == val)
 				continue;
-		ret = snd_soc_write(codec, i, val);
+		ret = snd_soc_write(codec, reg, val);
 		if (ret)
 			return ret;
 		dev_dbg(codec->dev, "Synced register %#x, value = %#x\n",
-			i, val);
+			reg, val);
 	}
 	return 0;
 }
@@ -844,15 +894,24 @@ static int snd_soc_flat_cache_sync(struct snd_soc_codec *codec)
 static int snd_soc_flat_cache_write(struct snd_soc_codec *codec,
 				    unsigned int reg, unsigned int value)
 {
-	snd_soc_set_cache_val(codec->reg_cache, reg, value,
+	unsigned int idx;
+
+	idx = snd_soc_cache_reg_to_idx(codec, reg);
+
+	snd_soc_set_cache_val(codec->reg_cache, idx, value,
 			      codec->driver->reg_word_size);
+
 	return 0;
 }
 
 static int snd_soc_flat_cache_read(struct snd_soc_codec *codec,
 				   unsigned int reg, unsigned int *value)
 {
-	*value = snd_soc_get_cache_val(codec->reg_cache, reg,
+	unsigned int idx;
+
+	idx = snd_soc_cache_reg_to_idx(codec, reg);
+
+	*value = snd_soc_get_cache_val(codec->reg_cache, idx,
 				       codec->driver->reg_word_size);
 	return 0;
 }
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 83ad8ca..a23971e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -125,11 +125,12 @@ static int format_register_str(struct snd_soc_codec *codec,
 static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
 				  size_t count, loff_t pos)
 {
-	int i, step = 1;
+	int i;
 	int wordsize, regsize;
 	int len;
 	size_t total = 0;
 	loff_t p = 0;
+	unsigned int reg;
 
 	wordsize = min_bytes_needed(codec->driver->reg_cache_size) * 2;
 	regsize = codec->driver->reg_word_size * 2;
@@ -139,22 +140,20 @@ static ssize_t soc_codec_reg_show(struct snd_soc_codec *codec, char *buf,
 	if (!codec->driver->reg_cache_size)
 		return 0;
 
-	if (codec->driver->reg_cache_step)
-		step = codec->driver->reg_cache_step;
-
-	for (i = 0; i < codec->driver->reg_cache_size; i += step) {
-		if (codec->readable_register && !codec->readable_register(codec, i))
+	for (i = 0; i <= codec->driver->reg_cache_size; i++) {
+		reg = snd_soc_cache_idx_to_reg(codec, i);
+		if (codec->readable_register && !codec->readable_register(codec, reg))
 			continue;
 		if (codec->driver->display_register) {
 			count += codec->driver->display_register(codec, buf + count,
-							 PAGE_SIZE - count, i);
+							 PAGE_SIZE - count, reg);
 		} else {
 			/* only support larger than PAGE_SIZE bytes debugfs
 			 * entries for the default case */
 			if (p >= pos) {
 				if (total + len >= count - 1)
 					break;
-				format_register_str(codec, i, buf + total, len);
+				format_register_str(codec, reg, buf + total, len);
 				total += len;
 			}
 			p += len;
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index cca490c..e5c15d3 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -35,9 +35,12 @@ static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
 		       unsigned int value, const void *data, int len)
 {
 	int ret;
+	unsigned int idx;
+
+	idx = snd_soc_cache_reg_to_idx(codec, reg);
 
 	if (!snd_soc_codec_volatile_register(codec, reg) &&
-	    reg < codec->driver->reg_cache_size &&
+	    idx < codec->driver->reg_cache_size &&
 	    !codec->cache_bypass) {
 		ret = snd_soc_cache_write(codec, reg, value);
 		if (ret < 0)
@@ -62,8 +65,11 @@ static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
 {
 	int ret;
 	unsigned int val;
+	unsigned int idx;
+
+	idx = snd_soc_cache_reg_to_idx(codec, reg);
 
-	if (reg >= codec->driver->reg_cache_size ||
+	if (idx >= codec->driver->reg_cache_size ||
 	    snd_soc_codec_volatile_register(codec, reg) ||
 	    codec->cache_bypass) {
 		if (codec->cache_only)
-- 
1.7.0.4
