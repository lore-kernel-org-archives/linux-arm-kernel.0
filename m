From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Jul 2015 12:27:43 +0200
Subject: [PATCH v5 2/6] arch: unify ioremap prototypes and macro aliases
In-Reply-To: <20150707101330.GJ7557@n2100.arm.linux.org.uk>
References: <20150622081028.35954.89885.stgit@dwillia2-desk3.jf.intel.com>
 <20150622082427.35954.73529.stgit@dwillia2-desk3.jf.intel.com>
 <20150622161002.GB8240@lst.de>
 <CAPcyv4h5OXyRvZvLGD5ZknO-YUPn675YGv0XdtW1QOO9qmZsug@mail.gmail.com>
 <20150701062352.GA3739@lst.de>
 <CAMuHMdUO4uSWH1Qc0SfDTLuXbiG2N9fq8Tf6j+3RoqVKdPugbA@mail.gmail.com>
 <20150701065948.GA4355@lst.de>
 <CAMuHMdXqjmo2T3V=msZySVSu2j4YjyE7FnVXWTjySEyfYLSg1A@mail.gmail.com>
 <20150701072828.GA4881@lst.de>
 <20150707095012.GQ7021@wotan.suse.de>
 <20150707101330.GJ7557@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdX539+TRrZ+NtQNzJecVgT_Mc=CTZggixtcUg_GsFMjoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 7, 2015 at 12:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Another issue is... the use of memcpy()/memset() directly on memory
> returned from ioremap*().  The pmem driver does this.  This fails sparse
> checks.  However, years ago, x86 invented the memcpy_fromio()/memcpy_toio()
> memset_io() functions, which took a __iomem pointer (which /presumably/
> means they're supposed to operate on the memory associated with an
> ioremap'd region.)
>
> Should these functions always be used for mappings via ioremap*(), and
> the standard memcpy()/memset() be avoided?  To me, that sounds like a
> very good thing, because that gives us more control over the
> implementation of the functions used to access ioremap'd regions,
> and the arch can decide to prevent GCC inlining its own memset() or
> memcpy() code if desired.

Yes they should. Not doing that is a typical portability bug (works on x86,
not everywhere).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
