From: geoff@infradead.org (Geoff Levand)
Date: Mon, 16 Jun 2014 13:27:12 -0700
Subject: [PATCH 3/4] arm64: export effective Image size to bootloaders
In-Reply-To: <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
References: <1400233839-15140-1-git-send-email-mark.rutland@arm.com>
 <1400233839-15140-4-git-send-email-mark.rutland@arm.com>
Message-ID: <1402950432.3708.22.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Sorry for such a delay in my reply.

On Fri, 2014-05-16 at 10:50 +0100, Mark Rutland wrote:
> Both the image load offset and the effective image size are forced to be
> little-endian regardless of the native endianness of the kernel to
> enable bootloaders to load a kernel of arbitrary endianness. Bootloaders
> which wish to make use of the load offset can inspect the effective
> image size field for a non-zero value to determine if the offset is of a
> known endianness.

Doing this conversion in the linker script seems complicated.  My
thought was to just have an image header field that specifies the
byte order, in the same way that the EI_DATA part of the ELF
e_ident field does.

Another advantage of having the byte order in the header is that
tools other than a boot loader that need to know the byte order
can get that info from the header, otherwise they would need to
guess the order with some kind of inspection.

A patch I had planned to post for this is below.

> --- a/Documentation/arm64/booting.txt
> +++ b/Documentation/arm64/booting.txt
> @@ -72,8 +72,8 @@ The decompressed kernel image contains a 64-byte header as follows:
>  
>    u32 code0;			/* Executable code */
>    u32 code1;			/* Executable code */
> -  u64 text_offset;		/* Image load offset */
> -  u64 res0	= 0;		/* reserved */
> +  u64 text_offset;		/* Image load offset, little endian */
> +  u64 image_size;		/* Effective Image size, little endian */

It seems __le64 would be a better type to use here, if the
value is decided to be little endian.

>    u64 res1	= 0;		/* reserved */
>    u64 res2	= 0;		/* reserved */
>    u64 res3	= 0;		/* reserved */
> @@ -86,9 +86,27 @@ Header notes:


>From a63dd2f24105c55734238efaacdac5048bbedf39 Mon Sep 17 00:00:00 2001
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 12 Jun 2014 11:23:23 -0700
Subject: [PATCH] arm64: Add byte order to image header

When working with a raw arm64 image one needs to know the byte order of the
image header to properly interpret the multi-byte values of the header.  Add
a character value to the image header indicating the byte order the image was
built with:

  1=LSB (little endian), 2=MSB (big endian), 0=no support.

A zero value will indicate a kernel that pre-dates this change.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/head.S | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b96a732..70c3656 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -109,7 +109,11 @@
 	 * DO NOT MODIFY. Image header expected by Linux boot-loaders.
 	 */
 	b	stext				// branch to kernel start, magic
-	.long	0				// reserved
+	CPU_LE(.byte	1)			// 1=LSB (little endian)
+	CPU_BE(.byte	2)			// 2=MSB (big endian)
+	.byte	0				// reserved
+	.byte	0				// reserved
+	.byte	0				// reserved
 	.quad	TEXT_OFFSET			// Image load offset from start of RAM
 	.quad	0				// reserved
 	.quad	0				// reserved
-- 
1.9.1
