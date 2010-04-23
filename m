From: eric.miao@canonical.com (Eric Miao)
Date: Fri, 23 Apr 2010 10:36:44 +0800
Subject: [PATCH - kexec] arm: place initrd to safer place according to zImage
	length
Message-ID: <h2xf17812d71004221936s779a4585r8b458f7f2630f7b1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 4b6d55c7780dbf383c6b64e560d459d15a891006
Author: Eric Miao <eric.miao@canonical.com>
Date:   Fri Apr 23 10:19:43 2010 +0800

    arm: place initrd to safer place according to zImage length

    The original fixed address of 0x800000 may be overwritten after the
    kernel is decompressed.  Assume a maximum decompression ratio of 4
    and place initrd right after that, just to be safer.

    Signed-off-by: Eric Miao <eric.miao@canonical.com>

diff --git a/kexec/arch/arm/kexec-zImage-arm.c
b/kexec/arch/arm/kexec-zImage-arm.c
index 72fcdd8..1a446d9 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -130,7 +130,7 @@ struct tag * atag_read_tags(void)
 static
 int atag_arm_load(struct kexec_info *info, unsigned long base,
 	const char *command_line, off_t command_line_len,
-	const char *initrd, off_t initrd_len)
+	const char *initrd, off_t initrd_len, off_t initrd_off)
 {
 	struct tag *saved_tags = atag_read_tags();
 	char *buf;
@@ -196,10 +196,8 @@ int atag_arm_load(struct kexec_info *info,
unsigned long base,
 	add_segment(info, buf, len, base, len);

 	if (initrd) {
-		struct memory_range *range;
-		int ranges;
-		get_memory_ranges(&range, &ranges, info->kexec_flags);
-		*initrd_start = locate_hole(info, initrd_len, getpagesize(),
range[0].start + 0x800000, ULONG_MAX, INT_MAX);
+		*initrd_start = locate_hole(info, initrd_len, getpagesize(),
+				initrd_off, ULONG_MAX, INT_MAX);
 		if (*initrd_start == ULONG_MAX)
 			return -1;
 		add_segment(info, initrd, initrd_len, *initrd_start, initrd_len);
@@ -219,6 +217,7 @@ int zImage_arm_load(int argc, char **argv, const
char *buf, off_t len,
 	const char *ramdisk;
 	char *ramdisk_buf;
 	off_t ramdisk_length;
+	off_t ramdisk_offset;
 	int opt;
 #define OPT_APPEND	'a'
 #define OPT_RAMDISK	'r'
@@ -271,9 +270,14 @@ int zImage_arm_load(int argc, char **argv, const
char *buf, off_t len,
 	if (base == ULONG_MAX)
 		return -1;

+	/* assume the maximum kernel compression ratio is 4,
+	 * and just to be safe, place ramdisk after that
+	 */
+	ramdisk_offset = base + len * 4;
+
 	if (atag_arm_load(info, base + atag_offset,
 			 command_line, command_line_len,
-			 ramdisk_buf, ramdisk_length)    == -1)
+			 ramdisk_buf, ramdisk_length, ramdisk_offset) == -1)
 		return -1;

 	add_segment(info, buf, len, base + offset, len);
