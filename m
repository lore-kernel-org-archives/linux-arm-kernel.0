From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Mar 2015 16:00:31 +0200
Subject: [PATCH 4/4] arm64: align PHYS_OFFSET to block size
In-Reply-To: <20150330123011.GB5964@e104818-lin.cambridge.arm.com>
References: <20150317164353.GN23340@leverpostej>
 <1427125016-3873-5-git-send-email-ard.biesheuvel@linaro.org>
 <20150325145949.GE26903@localhost>
 <CAKv+Gu8LQGNVDw36B+Lv4xMQkcGN=M=uHxey-94cqrmE=AZDvg@mail.gmail.com>
 <CAKv+Gu_3PG7ffwn+TK7PdUPeovVoamb4XX1PSfor-3sNKW-0AQ@mail.gmail.com>
 <20150330123011.GB5964@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu84YezZSQmyf4cV34TxMKRPytcFyrrTGO3RFx=_17i-Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 March 2015 at 15:49, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Mar 27, 2015 at 02:16:19PM +0100, Ard Biesheuvel wrote:
>> On 26 March 2015 at 07:22, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 25 March 2015 at 15:59, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> >> On Mon, Mar 23, 2015 at 04:36:56PM +0100, Ard Biesheuvel wrote:
>> >>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>> >>> index 16134608eecf..fd8434753372 100644
>> >>> --- a/arch/arm64/kernel/head.S
>> >>> +++ b/arch/arm64/kernel/head.S
>> >>> @@ -49,13 +49,15 @@
>> >>>  #ifdef CONFIG_ARM64_64K_PAGES
>> >>>  #define BLOCK_SHIFT  PAGE_SHIFT
>> >>>  #define BLOCK_SIZE   PAGE_SIZE
>> >>> -#define TABLE_SHIFT  PMD_SHIFT
>> >>>  #else
>> >>>  #define BLOCK_SHIFT  SECTION_SHIFT
>> >>>  #define BLOCK_SIZE   SECTION_SIZE
>> >>> -#define TABLE_SHIFT  PUD_SHIFT
>> >>>  #endif
>> >>>
>> >>> +#define TABLE_SHIFT  (BLOCK_SHIFT + PAGE_SHIFT - 3)
>> >>> +#define TABLE_SIZE   (1 << TABLE_SHIFT)
>> >>> +#define TABLE_MASK   (~(TABLE_SIZE - 1))
>> >>> +
>> >>>  #define KERNEL_START _text
>> >>>  #define KERNEL_END   _end
>> >>>
>> >>> @@ -237,7 +239,10 @@ ENTRY(stext)
>> >>>       bl      el2_setup                       // Drop to EL1, w20=cpu_boot_mode
>> >>>
>> >>>       adrp    x24, __PHYS_OFFSET
>> >>> -     mov     x23, #KIMAGE_OFFSET
>> >>> +     and     x23, x24, #~TABLE_MASK          // image offset
>> >>> +     and     x24, x24, #TABLE_MASK           // PHYS_OFFSET
>> >>> +     mov     x0, #KIMAGE_OFFSET
>> >>> +     add     x23, x23, x0
>> >>
>> >> I'm still trying to figure out how this works. Does the code imply that
>> >> the kernel image can only be loaded within a block size of the
>> >> PHYS_OFFSET? If that's the case, it's not too flexible.
>> >
>> > For now, yes.
>
> Can we defer the setting of PHYS_OFFSET until we parse the DT memory
> nodes?
>

I experimented a bit with that, but it is quite hairy. Any
manipulation of the page tables goes through __va/__pa, so you need a
valid PHYS_OFFSET there to ensure they point at the right physical
region. But PHYS_OFFSET also needs to be small enough for the DT
parsing code not to disregard regions that are below it. And then
there is the memblock limit to ensure that early dynamically allocated
page tables come from a region that is already mapped.

I think it may be doable, but it would require some significant
hacking, e.g., call early_init_scan_dt() at its physical address with
only the ID map loaded and the MMU and caches on, and only after that
start populating the virtual address space. Or at least only populate
the lower half, i.e., mappings below PAGE_OFFSET for the kernel and
the FDT

>> >> My thoughts were to make PHYS_OFFSET permanently 0 (i.e. get rid of it
>> >> entirely) or at least compute it at DT parsing time. I'm more inclined
>> >> for making it 0 assuming that it doesn't break anything else (vmemmap
>> >> virtual range may get slightly bigger but still not significant,
>> >> basically max_phys_addr / sizeof(struct page)).
>> >
>> > Making it zero would be an improvement, I suppose
>>
>> Actually, wouldn't that reintroduce a similar VA range problem to the
>> one I fixed the other day?
>>
>> On Seattle, with its DRAM at 0x80_0000_0000, you wouldn't have enough
>> space after PAGE_OFFSET
>
> Ah, yes. When I thought about this PHYS_OFFSET == 0 in the past, we
> didn't have any patches and the VA range had to be sufficiently large.
>
> --
> Catalin
