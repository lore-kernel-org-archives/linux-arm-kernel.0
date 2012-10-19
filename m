From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 19 Oct 2012 08:57:12 +0300
Subject: [PATCH v2 0/2] Add DMA and device tree support to the flash
 controller FLCTL
In-Reply-To: <CABYn4szACuH3LQ193VJj6E=J4q4Ye4E4O6cUgjB8jmQK6RRmpA@mail.gmail.com>
References: <1349776729-9311-1-git-send-email-hechtb@gmail.com>
 <1350473030.5769.137.camel@sauron.fi.intel.com>
 <CABYn4szACuH3LQ193VJj6E=J4q4Ye4E4O6cUgjB8jmQK6RRmpA@mail.gmail.com>
Message-ID: <1350626232.5769.318.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-10-17 at 15:05 +0200, Bastian Hecht wrote:
> Hi Artem,
> 
> > Hi, I used to be able to compile MTD stuff for mackerel board with the
> > defconfig attached, but now it fails with 3.7-rc1 with as error:
> >
> > /tmp/cc2Nr7AN.s: Error: bad immediate value for 8-bit offset (1024)
> >
> > It fails for dogc4.c, but if I disable DOCG4, it fails for other drivers
> > with a similar error.
> >
> > I've tried (arm) gcc 4.6.3 and the latest Linaro 4.7 build.
> >
> > Any idea? I did not dig this, is this a known issue? Could you try to
> > reproduce this in your setup?
> >
> 
> I can reproduce the error with the following output:
> /tmp/ccYAbker.s: Assembler messages:
> /tmp/ccYAbker.s: Error: bad immediate value for 8-bit offset (2048)
> make[3]: *** [drivers/mtd/nand/docg4.o] Error 1
> 
> The compiler version is: gcc version 4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5)
> I usually use: gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202) and
> can compile things without problems.

Yeah, a bug report would be great. I've switched to 4.4.1 and checked
your patches with aiaiai:

--------------------------------------------------------------------------------

Successfully built configuration "arm-mackerel_defconfig,arm,arm-none-linux-gnueabi-", results:

--- before_patching.log
+++ after_patching.log
@@ @@
+drivers/mtd/nand/sh_flctl.c:1142 flctl_probe() warn: 'irq' was not released on error [smatch]
+drivers/mtd/nand/sh_flctl.c:1142:2-8: ERROR: missing iounmap; ioremap on line 1117 and execution via conditional on line 1140 [coccinelle]
+drivers/mtd/nand/sh_flctl.c:164:25: warning: cast removes address space of expression [sparse]
+drivers/mtd/nand/sh_flctl.c:181:25: warning: cast removes address space of expression [sparse]
-drivers/mtd/nand/sh_flctl.c:311 write_fiforeg() Error invalid range 4096 to -1 [smatch]
-drivers/mtd/nand/sh_flctl.c:317:17: warning: incorrect type in argument 2 (different address spaces) [sparse]
-drivers/mtd/nand/sh_flctl.c:317:17:    expected void volatile [noderef] <asn:2>*addr [sparse]
-drivers/mtd/nand/sh_flctl.c:317:17:    got void *fifo_addr [sparse]
+drivers/mtd/nand/sh_flctl.c:469 write_fiforeg() Error invalid range 4096 to -1 [smatch]
+drivers/mtd/nand/sh_flctl.c:485:17: warning: incorrect type in argument 2 (different address spaces) [sparse]
+drivers/mtd/nand/sh_flctl.c:485:17:    expected void volatile [noderef] <asn:2>*addr [sparse]
+drivers/mtd/nand/sh_flctl.c:485:17:    got void *fifo_addr [sparse]

--------------------------------------------------------------------------------


Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121019/e8f29d12/attachment.sig>
