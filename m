From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2018 19:13:47 +0000
Subject: [PATCH 1/6] ARM: compressed: move sharpsl startup code into
 subroutine
In-Reply-To: <CAKv+Gu-XcWy0jYG-u9rQRuWZOshQALiMsJY_uZLUij-5Vcp4-Q@mail.gmail.com>
References: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
 <20181105184438.19494-2-ard.biesheuvel@linaro.org>
 <20181105185944.GS30658@n2100.armlinux.org.uk>
 <CAKv+Gu-XcWy0jYG-u9rQRuWZOshQALiMsJY_uZLUij-5Vcp4-Q@mail.gmail.com>
Message-ID: <20181105191347.GW30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 08:07:10PM +0100, Ard Biesheuvel wrote:
> On 5 November 2018 at 19:59, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Mon, Nov 05, 2018 at 07:44:33PM +0100, Ard Biesheuvel wrote:
> >> Instead of relying on unspecified linker behavior, move the
> >> SharpSL startup code into a subroutine and call it from the
> >> location we expect the linker to put the code.
> >
> > Why is it "unspecified linker behaviour" ?  Lots of libraries and
> > programs rely on the linker building tables, whether it be data or
> > code from sections.
> >
> > For example, programs build a section called .init which starts with
> > the code in crti.o, code from other files, and finishes with code
> > from crtn.o.
> >
> > crti.o:
> >
> > Disassembly of section .init:
> >
> > 00000000 <_init>:
> >    0:   e92d4008        push    {r3, lr}
> >    4:   ebfffffe        bl      0 <_init>
> >                         4: R_ARM_CALL   call_weak_fn
> >
> > crtn.o:
> >
> > Disassembly of section .init:
> >
> > 00000000 <.init>:
> >    0:   e8bd8008        pop     {r3, pc}
> >
> > So, I don't think there's anything "unspecified" here.
> >
> 
> In that case, we should do what GCC's builtin linker script uses:
> 
>   .init           :
>   {
>     KEEP (*(SORT_NONE(.init)))
>   } =0
> 
> > We also rely heavily on this in the kernel to build exception tables,
> > symbol tables, and so forth.
> >
> 
> No, not really. In that case, they are arrays of data structures, not
> sequences of instructions, and if they need to appear in a particular
> order, they are sorted explicitly.

Sorry, I disagree completely with you, as does the ld documentation:

   Normally, the linker will place files and sections matched by
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
wildcards in the order in which they are seen during the link.  You can
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
change this by using the 'SORT_BY_NAME' keyword, which appears before a
wildcard pattern in parentheses (e.g., 'SORT_BY_NAME(.text*)').  When
the 'SORT_BY_NAME' keyword is used, the linker will sort the files or
sections into ascending order by name before placing them in the output
file.
...
   'SORT_NONE' disables section sorting by ignoring the command line
section sorting option.

Sorting by command line order is what we want.  Therefore, our existing
linker script is correct.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
