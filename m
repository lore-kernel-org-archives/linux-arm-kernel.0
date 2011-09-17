From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2011 12:59:41 +0100
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level
	debug uart
In-Reply-To: <20110912141440.GC7007@n2100.arm.linux.org.uk>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
	<20110906202555.GQ28816@pengutronix.de>
	<20110907110001.GI8148@S2100-06.ap.freescale.net>
	<20110912084439.GO31404@pengutronix.de>
	<20110912141440.GC7007@n2100.arm.linux.org.uk>
Message-ID: <20110917115941.GF16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 03:14:41PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 12, 2011 at 10:44:39AM +0200, Sascha Hauer wrote:
> > I vote to skip params_phys and initrd_phys now. Every recent bootloader
> > does not need them. As the i.MX6 is a new SoC, we have no reason to
> > handle legacy bootloaders.
> 
> Can we stop this misunderstanding right now.
> 
> It's NOT about legacy boot loaders.  It's about the bootp code which
> allows an initrd to be packaged up together with a zImage file as one
> single file.
> 
> That's used to be able to boot with an initrd on platforms which can
> only obtain one file from the boot media, and they specify where the
> parameters are expected to be (which can be solved by updating the
> code to use r2) and where to place the initrd image (which can't be
> solved as it would mean encoding memory information for every platform
> into the bootp code.)
> 
> An example of a current boot loader which requires this: Simtec's Able
> boot loader.

Here's a patch to reduce the reliance of arch/arm/boot/bootp on having
a correct initrd image location passed from the platform Makefile.boot.
It doesn't get rid of it, as it's required if the platform does not
pass a valid value in r2 to the kernel.

Note - I have a new code for a platform (of the nommu variety) which
requires this to be able to boot.  Also note that we're probably going
to have to find a way to make this work with DT too (if not then I may
be submitting this platform without DT any support.)

---
 arch/arm/boot/bootp/init.S |   34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/bootp/init.S b/arch/arm/boot/bootp/init.S
index 78b5080..d1cb5a9 100644
--- a/arch/arm/boot/bootp/init.S
+++ b/arch/arm/boot/bootp/init.S
@@ -16,6 +16,14 @@
  *  size immediately following the kernel, we could build this into
  *  a binary blob, and concatenate the zImage using the cat command.
  */
+
+#define ATAG_CORE 0x54410001
+#define ATAG_CORE_SIZE ((2*4 + 3*4) >> 2)
+#define ATAG_CORE_SIZE_EMPTY ((2*4) >> 2)
+
+#define ATAG_INITRD2 0x54420005
+#define ATAG_INITRD2_SIZE ((4*4) >> 2)
+
 		.section .start,#alloc,#execinstr
 		.type	_start, #function
 		.globl	_start
@@ -37,13 +45,31 @@ _start:		add	lr, pc, #-0x8		@ lr = current load addr
 						@ r8 = initrd end
 						@ r9 = param_struct address
 
+/*
+ * Check whether we were given a valid ATAG list from the boot loader.
+ * If it looks like a valid pointer, then use that rather than the
+ * hard-coded value.
+ */
+		tst	r2, #3			@ aligned
+		bne	1f
+		ldr	r10, [r2, #0]		@ get first tag size
+		teq	r10, #ATAG_CORE_SIZE
+		teqne	r10, #ATAG_CORE_SIZE_EMPTY
+		bne	1f
+		ldr	r10, [r2, #4]		@ get first tag type
+		teq	r10, r5			@ is it ATAG_CORE?
+		bne	1f
+		mov	r9, r2
+		b	taglist
+
+1:		mov	r2, r9			@ params for the kernel
 		ldr	r10, [r9, #4]		@ get first tag
 		teq	r10, r5			@ is it ATAG_CORE?
 /*
  * If we didn't find a valid tag list, create a dummy ATAG_CORE entry.
  */
 		movne	r10, #0			@ terminator
-		movne	r4, #2			@ Size of this entry (2 words)
+		movne	r4, #ATAG_CORE_SIZE_EMPTY @ Size of this entry (2 words)
 		stmneia	r9, {r4, r5, r10}	@ Size, ATAG_CORE, terminator
 
 /*
@@ -56,7 +82,7 @@ taglist:	ldr	r10, [r9, #0]		@ tag length
 		addne	r9, r9, r10, lsl #2
 		bne	taglist
 
-		mov	r5, #4			@ Size of initrd tag (4 words)
+		mov	r5, #ATAG_INITRD2_SIZE	@ Size of initrd tag (4 words)
 		stmia	r9, {r5, r6, r7, r8, r10}
 		b	kernel_start		@ call kernel
 
@@ -80,8 +106,8 @@ data:		.word	initrd_start		@ source initrd address
 		.word	initrd_phys		@ destination initrd address
 		.word	initrd_size		@ initrd size
 
-		.word	0x54410001		@ r5 = ATAG_CORE
-		.word	0x54420005		@ r6 = ATAG_INITRD2
+		.word	ATAG_CORE		@ r5
+		.word	ATAG_INITRD2		@ r6
 		.word	initrd_phys		@ r7
 		.word	initrd_size		@ r8
 		.word	params_phys		@ r9
