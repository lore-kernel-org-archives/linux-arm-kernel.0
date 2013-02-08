From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri,  8 Feb 2013 23:17:41 +0000
Subject: [PATCH 11/17] ARM: fixup atags to be endian agnostic
In-Reply-To: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1360365467-25056-12-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the atag32_to_cpu() function to allow the main atag handling code
to be agnostic of any endian configuration.

Signed-of-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/kernel/atags_parse.c |   51 +++++++++++++++++++++--------------------
 arch/arm/kernel/atags_proc.c  |    6 ++---
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index 14512e6..cffcbc2 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -43,19 +43,19 @@ static struct {
 	struct tag_mem32  mem;
 	struct tag_header hdr3;
 } default_tags __initdata = {
-	{ tag_size(tag_core), ATAG_CORE },
-	{ 1, PAGE_SIZE, 0xff },
-	{ tag_size(tag_mem32), ATAG_MEM },
-	{ MEM_SIZE },
-	{ 0, ATAG_NONE }
+	{ atag32_to_cpu(tag_size(tag_core)), atag32_to_cpu(ATAG_CORE) },
+	{ atag32_to_cpu(1), atag32_to_cpu(PAGE_SIZE), atag32_to_cpu(0xff) },
+	{ atag32_to_cpu(tag_size(tag_mem32)), atag32_to_cpu(ATAG_MEM) },
+	{ atag32_to_cpu(MEM_SIZE) },
+	{ atag32_to_cpu(0), atag32_to_cpu(ATAG_NONE) }
 };
 
 static int __init parse_tag_core(const struct tag *tag)
 {
-	if (tag->hdr.size > 2) {
-		if ((tag->u.core.flags & 1) == 0)
+	if (atag32_to_cpu(tag->hdr.size) > 2) {
+		if ((atag32_to_cpu(tag->u.core.flags) & 1) == 0)
 			root_mountflags &= ~MS_RDONLY;
-		ROOT_DEV = old_decode_dev(tag->u.core.rootdev);
+		ROOT_DEV = old_decode_dev(atag32_to_cpu(tag->u.core.rootdev));
 	}
 	return 0;
 }
@@ -64,7 +64,7 @@ __tagtable(ATAG_CORE, parse_tag_core);
 
 static int __init parse_tag_mem32(const struct tag *tag)
 {
-	return arm_add_memory(tag->u.mem.start, tag->u.mem.size);
+	return arm_add_memory(atag32_to_cpu(tag->u.mem.start), atag32_to_cpu(tag->u.mem.size));
 }
 
 __tagtable(ATAG_MEM, parse_tag_mem32);
@@ -91,13 +91,14 @@ __tagtable(ATAG_VIDEOTEXT, parse_tag_videotext);
 static int __init parse_tag_ramdisk(const struct tag *tag)
 {
 	extern int rd_size, rd_image_start, rd_prompt, rd_doload;
+	unsigned int flags = atag32_to_cpu(tag->u.ramdisk.flags);
 
-	rd_image_start = tag->u.ramdisk.start;
-	rd_doload = (tag->u.ramdisk.flags & 1) == 0;
-	rd_prompt = (tag->u.ramdisk.flags & 2) == 0;
+	rd_image_start = atag32_to_cpu(tag->u.ramdisk.start);
+	rd_doload = (flags & 1) == 0;
+	rd_prompt = (flags & 2) == 0;
 
-	if (tag->u.ramdisk.size)
-		rd_size = tag->u.ramdisk.size;
+	if (atag32_to_cpu(tag->u.ramdisk.size))
+		rd_size = atag32_to_cpu(tag->u.ramdisk.size);
 
 	return 0;
 }
@@ -107,8 +108,8 @@ __tagtable(ATAG_RAMDISK, parse_tag_ramdisk);
 
 static int __init parse_tag_serialnr(const struct tag *tag)
 {
-	system_serial_low = tag->u.serialnr.low;
-	system_serial_high = tag->u.serialnr.high;
+	system_serial_low = atag32_to_cpu(tag->u.serialnr.low);
+	system_serial_high = atag32_to_cpu(tag->u.serialnr.high);
 	return 0;
 }
 
@@ -116,7 +117,7 @@ __tagtable(ATAG_SERIAL, parse_tag_serialnr);
 
 static int __init parse_tag_revision(const struct tag *tag)
 {
-	system_rev = tag->u.revision.rev;
+	system_rev = atag32_to_cpu(tag->u.revision.rev);
 	return 0;
 }
 
@@ -150,7 +151,7 @@ static int __init parse_tag(const struct tag *tag)
 	struct tagtable *t;
 
 	for (t = &__tagtable_begin; t < &__tagtable_end; t++)
-		if (tag->hdr.tag == t->tag) {
+		if (atag32_to_cpu(tag->hdr.tag) == t->tag) {
 			t->parse(tag);
 			break;
 		}
@@ -164,17 +165,17 @@ static int __init parse_tag(const struct tag *tag)
  */
 static void __init parse_tags(const struct tag *t)
 {
-	for (; t->hdr.size; t = tag_next(t))
+	for_each_tag(t, t)
 		if (!parse_tag(t))
 			printk(KERN_WARNING
 				"Ignoring unrecognised tag 0x%08x\n",
-				t->hdr.tag);
+				atag32_to_cpu(t->hdr.tag));
 }
 
 static void __init squash_mem_tags(struct tag *tag)
 {
-	for (; tag->hdr.size; tag = tag_next(tag))
-		if (tag->hdr.tag == ATAG_MEM)
+	for_each_tag(tag, tag)
+		if (tag->hdr.tag == atag32_to_cpu(ATAG_MEM))
 			tag->hdr.tag = ATAG_NONE;
 }
 
@@ -213,10 +214,10 @@ struct machine_desc * __init setup_machine_tags(phys_addr_t __atags_pointer,
 	 * If we have the old style parameters, convert them to
 	 * a tag list.
 	 */
-	if (tags->hdr.tag != ATAG_CORE)
+	if (tags->hdr.tag != atag32_to_cpu(ATAG_CORE))
 		convert_to_tag_list(tags);
 #endif
-	if (tags->hdr.tag != ATAG_CORE) {
+	if (tags->hdr.tag != atag32_to_cpu(ATAG_CORE)) {
 		early_print("Warning: Neither atags nor dtb found\n");
 		tags = (struct tag *)&default_tags;
 	}
@@ -224,7 +225,7 @@ struct machine_desc * __init setup_machine_tags(phys_addr_t __atags_pointer,
 	if (mdesc->fixup)
 		mdesc->fixup(tags, &from, &meminfo);
 
-	if (tags->hdr.tag == ATAG_CORE) {
+	if (tags->hdr.tag == atag32_to_cpu(ATAG_CORE)) {
 		if (meminfo.nr_banks != 0)
 			squash_mem_tags(tags);
 		save_atags(tags);
diff --git a/arch/arm/kernel/atags_proc.c b/arch/arm/kernel/atags_proc.c
index 42a1a14..50e7e9c 100644
--- a/arch/arm/kernel/atags_proc.c
+++ b/arch/arm/kernel/atags_proc.c
@@ -46,18 +46,18 @@ static int __init init_atags_procfs(void)
 	struct buffer *b;
 	size_t size;
 
-	if (tag->hdr.tag != ATAG_CORE) {
+	if (tag->hdr.tag != atag32_to_cpu(ATAG_CORE)) {
 		printk(KERN_INFO "No ATAGs?");
 		return -EINVAL;
 	}
 
-	for (; tag->hdr.size; tag = tag_next(tag))
+	for_each_tag(tag, tag)
 		;
 
 	/* include the terminating ATAG_NONE */
 	size = (char *)tag - atags_copy + sizeof(struct tag_header);
 
-	WARN_ON(tag->hdr.tag != ATAG_NONE);
+	WARN_ON(tag->hdr.tag != atag32_to_cpu(ATAG_NONE));
 
 	b = kmalloc(sizeof(*b) + size, GFP_KERNEL);
 	if (!b)
-- 
1.7.10.4
