From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Sep 2018 23:36:31 +0200
Subject: [RESEND PATCHv2 1/2] ARM: dts: ti: add support for building Texas
 Instruments specific overlays
In-Reply-To: <ac8227f4-4be3-df90-e2b9-6994b8b62592@gmail.com>
References: <1535722107-13767-1-git-send-email-t-kristo@ti.com>
 <1536049651-10206-1-git-send-email-t-kristo@ti.com>
 <1536049651-10206-2-git-send-email-t-kristo@ti.com>
 <ac8227f4-4be3-df90-e2b9-6994b8b62592@gmail.com>
Message-ID: <CAMuHMdUeTjR6cDuYj_5mwHK8dexn4fXxX1yMHDhdOxHhh3d5-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On Wed, Sep 5, 2018 at 10:54 PM Frank Rowand <frowand.list@gmail.com> wrote:
> On 09/04/18 01:27, Tero Kristo wrote:
> > Add support for TI specific DT subdir, along with support for building
> > DT overlays. Right now, no DT files are specified in this directory,
> > those are to be added later.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>

> > --- /dev/null
> > +++ b/arch/arm/boot/dts/ti/Makefile
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Make file to build device tree binaries for boards based on
> > +# Texas Instruments Inc processors
> > +#
> > +# Copyright (C) 2016-2018 Texas Instruments Incorporated - http://www.ti.com/
> > +#
> > +
> > +DTC_FLAGS += -@
> >
>
> I will nack any attempt to unconditionally compile a devicetree file with the
> -@ flag (which adds symbols to the resulting .dtb).  The resulting overhead
> is not acceptable.
>
> Adding the symbols must be under the control of the person either creating
> or using the .dtb.  The way to provide that control is the challenging part.
>
> One way would be to configure the compile option via kbuild configuration.
> There is opposition to this approach because it makes the .dtb dependent
> on the Linux kernel configuration.  So suggestions of an alternative
> mechanism would be welcome.

IMHO that would be quite a "soft" dependency: it's just about adding symbols
or not. No real dependency on Linux or kernel features.

> Another _possible_ solution would be to add a dtc_strip tool to the dtc
> project.  dtc_strip would remove the symbol information from a .dtb,
> in a manner that is analogous to strip removing debug information from
> a program file.

Removing unwanted symbols is indeed easier than adding them to an
existing DTB.

> One aspect of unconditionally building a .dtb with symbols, then
> optionally removing the symbols with dtc_strip is that it seems
> like a backwards process.  For example, we don't build the kernel
> with debug symbols then strip the symbols out when we don't want
> them.  I'll have to mull this over if the dtc_strip method sounds
> like a good approach to other people.

That's not a fair comparison: DTB symbols are not debug information,
but an ABI. It's more akin to exporting kernel symbols to (possible
out-of-tree) kernel modules, which is controlled by CONFIG_MODULES.

So a Kconfig symbol to enable it, and a dtc_strip for removing them,
makes most sense to me.

BTW, we do run strip on vmlinux ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
