From: miles.chen@mediatek.com (Miles Chen)
Date: Tue, 8 Aug 2017 12:44:10 +0800
Subject: [PATCH] arm64: correct modules range of kernel virtual memory
 layout
In-Reply-To: <20170807140138.GB18817@arm.com>
References: <1502103886-19725-1-git-send-email-miles.chen@mediatek.com>
 <20170807131608.GA18817@arm.com>
 <CAKv+Gu9qD_-GNHus5txiqj9eHLpU5S7RX8QxYeUG17Ok0QNz-A@mail.gmail.com>
 <20170807140138.GB18817@arm.com>
Message-ID: <1502167450.24380.21.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-08-07 at 15:01 +0100, Will Deacon wrote:
> On Mon, Aug 07, 2017 at 02:18:00PM +0100, Ard Biesheuvel wrote:
> > On 7 August 2017 at 14:16, Will Deacon <will.deacon@arm.com> wrote:
> > > On Mon, Aug 07, 2017 at 07:04:46PM +0800, Miles Chen wrote:
> > >> The commit f80fb3a3d508 ("arm64: add support for kernel ASLR")
> > >> moved module virtual address to
> > >> [module_alloc_base, module_alloc_base + MODULES_VSIZE).
> > >>
> > >> Display module information of the virtual kernel
> > >> memory layout by using module_alloc_base.
> > >>
> > >> testing output:
> > >> 1) Current implementation:
> > >> Virtual kernel memory layout:
> > >>       modules : 0xffffff8000000000 - 0xffffff8008000000   (   128 MB)
> > >> 2) this patch + KASLR:
> > >> Virtual kernel memory layout:
> > >>       modules : 0xffffff8000560000 - 0xffffff8008560000   (   128 MB)
> > >> 3) this patch + KASLR and a dummy seed:
> > >> Virtual kernel memory layout:
> > >>       modules : 0xffffffa7df637000 - 0xffffffa7e7637000   (   128 MB)
> > >>
> > >> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> > >> ---
> > >>  arch/arm64/mm/init.c | 5 +++--
> > >>  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > Does this mean the modules code in our pt dumper is busted
> > > (arch/arm64/mm/dump.c)? Also, what about KASAN, which uses these addresses
> > > too (in kasan_init)? Should we just remove MODULES_VADDR and MODULES_END
> > > altogether?
> > >
> > 
> > I don't think we need this patch. The 'module' line simply prints the
> > VA region that is reserved for modules. The fact that we end up
> > putting them elsewhere when running randomized does not necessarily
> > mean this line should reflect that.
> 
> I was more concerned by other users of MODULES_VADDR tbh, although I see
> now that we don't randomize the module region if kasan is enabled. Still,
> the kcore code adds the modules region as a separate area (distinct from
> vmalloc) if MODULES_VADDR is defined, the page table dumping code uses
> MODULES_VADDR to identify the module region and I think we'll get false
> positives from is_vmalloc_or_module_addr, which again uses the static
> region.
> 
> So, given that MODULES_VADDR never points at the module area, can't we get
> rid of it?

Agreed.MODULES_VADDR should be phased out. Considering the kernel
modules live somewhere between [VMALLOC_START, VMALLOC_END) now:
(arch/arm64/kernel/module.c:module_alloc). I suggest the following
changes:

1. is_vmalloc_or_module_addr() should return is_vmalloc_addr() directly
2. arch/arm64/mm/dump.c does not need MODULES_VADDR and MODULES_END.
3. kasan uses [module_alloc_base, module_alloc_base + MODULES_VSIZE) to
get the shadow memory? (the kernel modules still live in this range when
kasan is enabled)
4. remove modules line in kernel memory layout
(optional, thanks for Ard's feedback)
5. remove MODULE_VADDR, MODULES_END definition


Miles
> 
> Will
