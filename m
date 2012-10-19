From: hechtb@googlemail.com (Bastian Hecht)
Date: Fri, 19 Oct 2012 12:15:34 +0200
Subject: [PATCH v3 1/3] mtd: sh_flctl: Minor cleanups
In-Reply-To: <1350641736-18192-1-git-send-email-hechtb@gmail.com>
References: <1350641736-18192-1-git-send-email-hechtb@gmail.com>
Message-ID: <1350641736-18192-2-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some small fixes to avoid sparse and smatch complain. Other cosmetic fixes
as well.

- Change of the type of the member index in struct sh_flctl from signed
to unsigned. We use index by addressing array members, so unsigned is more
concise here. Adapt functions relying on sh_flctl::index.
- Remove a blurring cast in write_fiforeg().
- Apply consistent naming scheme when refering to the data buffer.
- Shorten some unnecessarily verbose functions.
- Remove spaces at start of lines.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
v3: This is a newly added patch (v3 is misleading here) in reaction to the
aiaiai output of Artem. My smatch (git head) didn't complain about the
range problem mentioned in Artem's comment of v2 but I thought switching
to unsigned int can't hurt here and seems more clean.

 drivers/mtd/nand/sh_flctl.c  |   37 ++++++++++++++++---------------------
 include/linux/mtd/sh_flctl.h |    2 +-
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 4fbfe96..78d18c0f 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -225,7 +225,7 @@ static enum flctl_ecc_res_t wait_recfifo_ready
 
 		for (i = 0; i < 3; i++) {
 			uint8_t org;
-			int index;
+			unsigned int index;
 
 			data = readl(ecc_reg[i]);
 
@@ -305,28 +305,29 @@ static enum flctl_ecc_res_t read_ecfiforeg
 	return res;
 }
 
-static void write_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
+static void write_fiforeg(struct sh_flctl *flctl, int rlen,
+						unsigned int offset)
 {
 	int i, len_4align;
-	unsigned long *data = (unsigned long *)&flctl->done_buff[offset];
-	void *fifo_addr = (void *)FLDTFIFO(flctl);
+	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
 
 	len_4align = (rlen + 3) / 4;
 	for (i = 0; i < len_4align; i++) {
 		wait_wfifo_ready(flctl);
-		writel(cpu_to_be32(data[i]), fifo_addr);
+		writel(cpu_to_be32(buf[i]), FLDTFIFO(flctl));
 	}
 }
 
-static void write_ec_fiforeg(struct sh_flctl *flctl, int rlen, int offset)
+static void write_ec_fiforeg(struct sh_flctl *flctl, int rlen,
+						unsigned int offset)
 {
 	int i, len_4align;
-	unsigned long *data = (unsigned long *)&flctl->done_buff[offset];
+	unsigned long *buf = (unsigned long *)&flctl->done_buff[offset];
 
 	len_4align = (rlen + 3) / 4;
 	for (i = 0; i < len_4align; i++) {
 		wait_wecfifo_ready(flctl);
-		writel(cpu_to_be32(data[i]), FLECFIFO(flctl));
+		writel(cpu_to_be32(buf[i]), FLECFIFO(flctl));
 	}
 }
 
@@ -748,41 +749,35 @@ static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
 static void flctl_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-	int index = flctl->index;
 
-	memcpy(&flctl->done_buff[index], buf, len);
+	memcpy(&flctl->done_buff[flctl->index], buf, len);
 	flctl->index += len;
 }
 
 static uint8_t flctl_read_byte(struct mtd_info *mtd)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-	int index = flctl->index;
 	uint8_t data;
 
-	data = flctl->done_buff[index];
+	data = flctl->done_buff[flctl->index];
 	flctl->index++;
 	return data;
 }
 
 static uint16_t flctl_read_word(struct mtd_info *mtd)
 {
-       struct sh_flctl *flctl = mtd_to_flctl(mtd);
-       int index = flctl->index;
-       uint16_t data;
-       uint16_t *buf = (uint16_t *)&flctl->done_buff[index];
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	uint16_t *buf = (uint16_t *)&flctl->done_buff[flctl->index];
 
-       data = *buf;
-       flctl->index += 2;
-       return data;
+	flctl->index += 2;
+	return *buf;
 }
 
 static void flctl_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-	int index = flctl->index;
 
-	memcpy(buf, &flctl->done_buff[index], len);
+	memcpy(buf, &flctl->done_buff[flctl->index], len);
 	flctl->index += len;
 }
 
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 01e4b15..4815576 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -147,7 +147,7 @@ struct sh_flctl {
 
 	uint8_t	done_buff[2048 + 64];	/* max size 2048 + 64 */
 	int	read_bytes;
-	int	index;
+	unsigned int index;
 	int	seqin_column;		/* column in SEQIN cmd */
 	int	seqin_page_addr;	/* page_addr in SEQIN cmd */
 	uint32_t seqin_read_cmd;		/* read cmd in SEQIN cmd */
-- 
1.7.9.5
