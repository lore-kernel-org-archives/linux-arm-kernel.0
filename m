From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 31 Jul 2015 13:53:03 +0100
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <CAKv+Gu-G9Vpmt_c84OsG0JNRKopJ44uneJaAEpY3AMq6oS-Qdg@mail.gmail.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <55B0E1AD.60409@arm.com>
 <BY2PR0301MB0743CBCFC5476E39A5D1EC0B878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <CAKv+Gu9LHBd7wM6P4H0X5WigzDETtpr2++_Ebo=adg5QtTOW2w@mail.gmail.com>
 <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <20150730101358.GA30796@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-G9Vpmt_c84OsG0JNRKopJ44uneJaAEpY3AMq6oS-Qdg@mail.gmail.com>
Message-ID: <20150731125303.GO407@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 09:27:03PM +0200, Ard Biesheuvel wrote:
> On 30 July 2015 at 12:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, Jul 29, 2015 at 08:49:57PM +0000, Stuart Yoder wrote:
> >> > From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
> [...]
> >> > To be honest, I think this is poorly designed, and I am not sure we
> >> > should cater for such configurations in the defconfig.
> >>
> >> Agree, if this is a one-off weird platform then we shouldn't.
> >>
> >> But, the 'Principles of ARM Memory Maps' doc proposes this:
> >> 2 GB at 0x8000_0000
> >> 30 GB at 0x8_8000_0000
> >> 480 GB at 0x88_0000_0000
> >
> > I'm not particularly recommending this layout, at least not without some
> > clarifications on DRAM aliases (I'll ping people internally about it
> > again). The original layout pre-dates ARMv8, it was meant for ARMv7/LPAE
> > and all the memory beyond 32-bit was highmem anyway. It was later
> > updated for AArch64 but only to allow 44/48-bit PA (a few sections
> > added).
> 
> As an aside, is there any reason why the direct mapping *must* be a
> linear mapping?
> Other than the performance concerns regarding
> phys_to_virt/virt_to_phys, I mean?

Mostly performance concerns. You could compact the physical range into a
smaller virtual one but the conversion will be costly, especially if you
want to make it multi-platform (having to look-up memory ranges,
memblock offsets). This would affect page table entry setup, code that
requires a page structure (like virt_to_page) and anything else doing
the virt/phys conversion.

I tried something like that for RealView PBX in the past but it was
hard-coded (no multi-platform at the time). See
arch/arm/mach-realview/include/mach/memory.h.

As for the mem_map array, on arm64 we have enough VA space available
(with vmemmap it takes a few GB to cover a 512GB RAM space).

-- 
Catalin
