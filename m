From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Feb 2010 10:41:07 +0100
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <1265105976.12634.10.camel@pc1117.cambridge.arm.com>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
	<000001caa0fd$cef2f740$9fca010a@Emea.Arm.com>
	<20100202090121.GC22848@pengutronix.de>
	<F01D8B85CFF58440B2A13965FBA90CA4177969@GEORGE.Emea.Arm.com>
	<20100202095537.GA32099@pengutronix.de>
	<1265105976.12634.10.camel@pc1117.cambridge.arm.com>
Message-ID: <20100203094107.GC11354@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Catalin,

On Tue, Feb 02, 2010 at 10:19:36AM +0000, Catalin Marinas wrote:
> On Tue, 2010-02-02 at 09:55 +0000, Uwe Kleine-K?nig wrote:
> > On Tue, Feb 02, 2010 at 09:07:47AM +0000, Colin Tuckley wrote:
> > > > -----Original Message-----
> > > > From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> > >
> > > > What do you mean saying "kernel image"?  zImage, Image, vmlinux,
> > > > arch/arm/boot/compressed/vmlinux?
> > >
> > > It's actually a uImage (compressed image with u-boot 64 byte header).
> > >
> > > > So where do you place your zImage, what is zreladdr, how big is your
> > > > RAM?
> > >
> > > It gets loaded by u-boot TFTP into RAM at the physical address of 
> > > memory at 0x70000000 and we have either 512MB or 1GB of RAM 
> > > depending on which system it is.
> > >
> > > zreladdr is 0x70008000
> > That should be fine.
> > 
> > What is the output on your machine?  If you see "done", can you try
> > defining DEBUG in arch/arm/boot/compressed/head.S?
> 
> I don't think we were seeing any "done". Just "Uncompressing Linux ...".
> 
> I need to get back to a bigger kernel image and I'll then try to
> increase the stack size in the compressed head.S.
Can you try the patch below and report the output in the failing case?

I tried to get STAND_ALONE_DEBUG running, but the code suffered bit rot
and is far away from working.

And I think it makes sense to make sure it's not a toolchain problem.
So can you send me a config and I give you back an uImage compiled with
my toolchain?  And maybe the other way round, too?

Best regards
Uwe

---
 arch/arm/boot/compressed/head.S |    2 +-
 arch/arm/boot/compressed/misc.c |   20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 4fddc50..78ac6d2 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -241,7 +241,7 @@ not_relocated:	mov	r0, #0
 		bl	cache_on
 
 		mov	r1, sp			@ malloc space above stack
-		add	r2, sp, #0x10000	@ 64k max
+		add	r2, sp, #0x80000	@ 512KiB max
 
 /*
  * Check to see if we will overwrite ourselves.
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 56a0d11..f537f8f 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -274,6 +274,21 @@ asmlinkage void __div0(void)
 
 #ifndef STANDALONE_DEBUG
 
+int
+decompress_flush(char *buf, unsigned int len)
+{
+	unsigned int n;
+	char *out = &output_data[output_ptr];
+
+	for (n = 0; n < len; ++n)
+		*out++ = *buf++;
+
+	putstr(".");
+	output_ptr += len;
+
+	return len;
+}
+
 unsigned long
 decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		unsigned long free_mem_ptr_end_p,
@@ -288,12 +303,9 @@ decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 
 	arch_decomp_setup();
 
-	tmp = (unsigned char *) (((unsigned long)input_data_end) - 4);
-	output_ptr = get_unaligned_le32(tmp);
-
 	putstr("Uncompressing Linux...");
 	decompress(input_data, input_data_end - input_data,
-			NULL, NULL, output_data, NULL, error);
+			NULL, decompress_flush, output_data, NULL, error);
 	putstr(" done, booting the kernel.\n");
 	return output_ptr;
 }
-- 
1.6.6


-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
