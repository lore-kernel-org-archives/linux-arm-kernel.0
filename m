From: kyungsik.lee@lge.com (Kyungsik Lee)
Date: Fri, 3 May 2013 18:02:52 +0900
Subject: [PATCH v3 -next 3/5] arm: Add support for LZ4-compressed kernel
In-Reply-To: <20130430135602.2aa0d3b4ec392bf83a9b64d0@linux-foundation.org>
References: <1362484056-9778-1-git-send-email-kyungsik.lee@lge.com>
 <1362484056-9778-4-git-send-email-kyungsik.lee@lge.com>
 <20130430135602.2aa0d3b4ec392bf83a9b64d0@linux-foundation.org>
Message-ID: <20130503090252.GB3170@Corona>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 30, 2013 at 01:56:02PM -0700, Andrew Morton wrote:
> On Tue,  5 Mar 2013 20:47:34 +0900 Kyungsik Lee <kyungsik.lee@lge.com> wrote:
> 
> > This patch integrates the LZ4 decompression code to the arm pre-boot code.
> > And it depends on two patchs below
> > 
> > lib: Add support for LZ4-compressed kernel
> > decompressor: Add LZ4 decompressor module
> > 
> > ...
> >
> > - Apply CFLAGS, -Os to decompress.o to improve decompress
> >   performance during boot-up process
> >
> > ...
> >
> > --- a/arch/arm/boot/compressed/Makefile
> > +++ b/arch/arm/boot/compressed/Makefile
> > @@ -24,6 +24,9 @@ endif
> >  AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
> >  HEAD	= head.o
> >  OBJS	+= misc.o decompress.o
> > +ifeq ($(CONFIG_KERNEL_LZ4),y)
> > +CFLAGS_decompress.o := -Os
> > +endif
> 
> Surprised.  You found that -Os produces faster code than -O2?  Details,
> please?
-Os is enforced here, based on the test result of decompression time
below, slightly faster than -O2.
But further tests with UA show that using -O2 will be the right choice
especially in the case of the unaligned access enabled.

Decompression Time(counts)
             UA
-Os  6717    3447
-O2  6720    2728

Note: ARM v7, Kernel 3.4
      counter freq. = 32768 HZ
      UA(Unaligned Access)
      gcc version 4.6.2 (Ubuntu/Linaro 4.6.2-14ubuntu2~ppa1)

Thanks,
Kyungsik
