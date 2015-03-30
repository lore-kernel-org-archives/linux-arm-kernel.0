From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 30 Mar 2015 15:55:26 +0100
Subject: [PATCH 4/4] arm64: align PHYS_OFFSET to block size
In-Reply-To: <CAKv+Gu84YezZSQmyf4cV34TxMKRPytcFyrrTGO3RFx=_17i-Mg@mail.gmail.com>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-5-git-send-email-ard.biesheuvel@linaro.org>
 <20150325145949.GE26903@localhost>
 <CAKv+Gu8LQGNVDw36B+Lv4xMQkcGN=M=uHxey-94cqrmE=AZDvg@mail.gmail.com>
 <CAKv+Gu_3PG7ffwn+TK7PdUPeovVoamb4XX1PSfor-3sNKW-0AQ@mail.gmail.com>
 <20150330123011.GB5964@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84YezZSQmyf4cV34TxMKRPytcFyrrTGO3RFx=_17i-Mg@mail.gmail.com>
Message-ID: <20150330145525.GA30015@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 03:00:31PM +0100, Ard Biesheuvel wrote:
> On 30 March 2015 at 15:49, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Mar 27, 2015 at 02:16:19PM +0100, Ard Biesheuvel wrote:
> >> On 26 March 2015 at 07:22, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> > On 25 March 2015 at 15:59, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> >> On Mon, Mar 23, 2015 at 04:36:56PM +0100, Ard Biesheuvel wrote:
> >> >>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> >> >>> index 16134608eecf..fd8434753372 100644
> >> >>> --- a/arch/arm64/kernel/head.S
> >> >>> +++ b/arch/arm64/kernel/head.S
> >> >>> @@ -49,13 +49,15 @@
> >> >>>  #ifdef CONFIG_ARM64_64K_PAGES
> >> >>>  #define BLOCK_SHIFT  PAGE_SHIFT
> >> >>>  #define BLOCK_SIZE   PAGE_SIZE
> >> >>> -#define TABLE_SHIFT  PMD_SHIFT
> >> >>>  #else
> >> >>>  #define BLOCK_SHIFT  SECTION_SHIFT
> >> >>>  #define BLOCK_SIZE   SECTION_SIZE
> >> >>> -#define TABLE_SHIFT  PUD_SHIFT
> >> >>>  #endif
> >> >>>
> >> >>> +#define TABLE_SHIFT  (BLOCK_SHIFT + PAGE_SHIFT - 3)
> >> >>> +#define TABLE_SIZE   (1 << TABLE_SHIFT)
> >> >>> +#define TABLE_MASK   (~(TABLE_SIZE - 1))
> >> >>> +
> >> >>>  #define KERNEL_START _text
> >> >>>  #define KERNEL_END   _end
> >> >>>
> >> >>> @@ -237,7 +239,10 @@ ENTRY(stext)
> >> >>>       bl      el2_setup                       // Drop to EL1, w20=cpu_boot_mode
> >> >>>
> >> >>>       adrp    x24, __PHYS_OFFSET
> >> >>> -     mov     x23, #KIMAGE_OFFSET
> >> >>> +     and     x23, x24, #~TABLE_MASK          // image offset
> >> >>> +     and     x24, x24, #TABLE_MASK           // PHYS_OFFSET
> >> >>> +     mov     x0, #KIMAGE_OFFSET
> >> >>> +     add     x23, x23, x0
> >> >>
> >> >> I'm still trying to figure out how this works. Does the code imply that
> >> >> the kernel image can only be loaded within a block size of the
> >> >> PHYS_OFFSET? If that's the case, it's not too flexible.
> >> >
> >> > For now, yes.
> >
> > Can we defer the setting of PHYS_OFFSET until we parse the DT memory
> > nodes?
> >
> 
> I experimented a bit with that, but it is quite hairy. Any
> manipulation of the page tables goes through __va/__pa, so you need a
> valid PHYS_OFFSET there to ensure they point at the right physical
> region. But PHYS_OFFSET also needs to be small enough for the DT
> parsing code not to disregard regions that are below it. And then
> there is the memblock limit to ensure that early dynamically allocated
> page tables come from a region that is already mapped.

Could we not use fixmaps to bootstrap the page tables to a state where
we can address them via the linear mapping? That would allow us to
forget about the memblock limit.

If we can do that, then we won't care about PHYS_OFFSET until later, and
we should be able to leave it zero for parsing the DT, then move it up
if necessary (dropping memory we can't address) once we know where
memory is.

This is of course a vast simplification of the work involved ;)

> I think it may be doable, but it would require some significant
> hacking, e.g., call early_init_scan_dt() at its physical address with
> only the ID map loaded and the MMU and caches on, and only after that
> start populating the virtual address space. Or at least only populate
> the lower half, i.e., mappings below PAGE_OFFSET for the kernel and
> the FDT

I thought we were going to use the fixmap for the DT, which would avoid
messiness there, no?

Mark.
