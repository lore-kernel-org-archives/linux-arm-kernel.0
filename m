From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Dec 2015 15:37:23 +0000
Subject: [PATCH v3 5/7] arm64: move kernel mapping out of linear region
In-Reply-To: <CAKv+Gu8un0YhVJ0Tji-GZ7TJr=t1PraBgHf60OLdYu09AuxSLw@mail.gmail.com>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447672998-20981-6-git-send-email-ard.biesheuvel@linaro.org>
 <20151207122642.GA7083@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-XtzU0QvJQhJH+yXEppLnva1TS2ougN6i_6dvNZzo3YA@mail.gmail.com>
 <CAKv+Gu8un0YhVJ0Tji-GZ7TJr=t1PraBgHf60OLdYu09AuxSLw@mail.gmail.com>
Message-ID: <20151207153722.GC7083@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 01:34:19PM +0100, Ard Biesheuvel wrote:
> On 7 December 2015 at 13:33, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 7 December 2015 at 13:26, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> On Mon, Nov 16, 2015 at 12:23:16PM +0100, Ard Biesheuvel wrote:
> >>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> >>> index 23cfc08fc8ba..d3e4b5d6a8d2 100644
> >>> --- a/arch/arm64/kernel/head.S
> >>> +++ b/arch/arm64/kernel/head.S
> >> [...]
> >>> @@ -210,7 +210,15 @@ section_table:
> >>>  ENTRY(stext)
> >>>       bl      preserve_boot_args
> >>>       bl      el2_setup                       // Drop to EL1, w20=cpu_boot_mode
> >>> -     adrp    x24, __PHYS_OFFSET
> >>> +
> >>> +     /*
> >>> +      * Before the linear mapping has been set up, __va() translations will
> >>> +      * not produce usable virtual addresses unless we tweak PHYS_OFFSET to
> >>> +      * compensate for the offset between the kernel mapping and the base of
> >>> +      * the linear mapping. We will undo this in map_mem().
> >>> +      */
> >>
> >> Minor typo in comment: I guess you meant "__pa() translations will not
> >> produce usable...".
> >
> > No, not quite. __va() translations will normally produce addresses in
> > the linear mapping, which will not be set up when we first start using
> > it in create_mapping(). So until that time, we have to redirect __va()
> > translations into the kernel mapping, where swapper_pg_dir is
> > shadowed.

I guessed what you meant and I remember the reason based on past
discussions, only that to me "linear mapping" sounds like something in
virtual space while __va() generates a linear mapping -> physical
translation (just some wording, nothing serious).

> > I am hoping that Mark's planned changes to create_mapping()
> > will make this unnecessary, but I haven't seen any of his code yet.

Not sure, I haven't seen the details yet.

> > As far as __pa() is concerned, that translation is actually tweaked so
> > it will always produce usable addresses, regardless of whether the
> > bias is still set or not. The reason is that va-to-pa translations are
> > always unambiguous.

Only that very early during boot memstart_addr is still based on the
kernel load address rather than memblock_start_of_DRAM(), that's why I
thought you meant __pa().

> ... so of course, the comment is still wrong, -> s/virtual/physical/
> addresses

This would do.

-- 
Catalin
