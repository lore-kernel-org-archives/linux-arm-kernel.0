From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Oct 2012 07:28:57 +0800
Subject: [PATCH v2 3/5] ARM: use generic unaligned.h
In-Reply-To: <507338F1.7030604@gmail.com>
References: <1344129840-16447-1-git-send-email-robherring2@gmail.com>
 <1344129840-16447-4-git-send-email-robherring2@gmail.com>
 <20121008164353.GB6140@S2101-09.ap.freescale.net>
 <507338F1.7030604@gmail.com>
Message-ID: <20121008232853.GA21822@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 03:34:57PM -0500, Rob Herring wrote:
> On 10/08/2012 11:43 AM, Shawn Guo wrote:
> > This patch has been merged into mainline as commit below.
> > 
> >  d25c881 ARM: 7493/1: use generic unaligned.h
> > 
> > It introduces a regression for me.  Check out the commit on mainline,
> > build a v7 only kernel (imx5/6) with imx_v6_v7_defconfig, the kernel
> > halts in decompressor.  But v6/v7 kernel (imx3/5/6) works fine.  The
> > kernel built on the parent commit below works all fine.
> 
> It actually fails in the decompressor or that's the last output you get?

I think it fails in the decompressor, because what I see is 

Uncompressing Linux...

not

Uncompressing Linux... done, booting the kernel.

> I compared the decompressor disassembly of both cases and get the same
> number of ldrb/strb instructions, so I don't think it is directly
> related to alignment.
> 
> I tried the XY decompressor as that is one difference, but that works
> fine for me on highbank.
> 
> Does it work with an empty uncompress.h functions? That should be the
> only difference in our decompressor code.

No, empty putc() in uncompress.h does not help.

New finding is that it only fails with LZO decompressor while the other
3 Gzip, LZMA and XZ all work good.  We happen to have LZO as the default
one in imx_v6_v7_defconfig.

Shawn
