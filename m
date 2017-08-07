From: miles.chen@mediatek.com (Miles Chen)
Date: Mon, 7 Aug 2017 21:36:20 +0800
Subject: [PATCH] arm64: correct modules range of kernel virtual memory
 layout
In-Reply-To: <CAKv+Gu9qD_-GNHus5txiqj9eHLpU5S7RX8QxYeUG17Ok0QNz-A@mail.gmail.com>
References: <1502103886-19725-1-git-send-email-miles.chen@mediatek.com>
 <20170807131608.GA18817@arm.com>
 <CAKv+Gu9qD_-GNHus5txiqj9eHLpU5S7RX8QxYeUG17Ok0QNz-A@mail.gmail.com>
Message-ID: <1502112980.16683.6.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-08-07 at 14:18 +0100, Ard Biesheuvel wrote:
> On 7 August 2017 at 14:16, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Aug 07, 2017 at 07:04:46PM +0800, Miles Chen wrote:
> >> The commit f80fb3a3d508 ("arm64: add support for kernel ASLR")
> >> moved module virtual address to
> >> [module_alloc_base, module_alloc_base + MODULES_VSIZE).
> >>
> >> Display module information of the virtual kernel
> >> memory layout by using module_alloc_base.
> >>
> >> testing output:
> >> 1) Current implementation:
> >> Virtual kernel memory layout:
> >>       modules : 0xffffff8000000000 - 0xffffff8008000000   (   128 MB)
> >> 2) this patch + KASLR:
> >> Virtual kernel memory layout:
> >>       modules : 0xffffff8000560000 - 0xffffff8008560000   (   128 MB)
> >> 3) this patch + KASLR and a dummy seed:
> >> Virtual kernel memory layout:
> >>       modules : 0xffffffa7df637000 - 0xffffffa7e7637000   (   128 MB)
> >>
> >> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> >> ---
> >>  arch/arm64/mm/init.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > Does this mean the modules code in our pt dumper is busted
> > (arch/arm64/mm/dump.c)? Also, what about KASAN, which uses these addresses
> > too (in kasan_init)? Should we just remove MODULES_VADDR and MODULES_END
> > altogether?
> >
The module range is not randomized if CONFIG_KASAN is enabled.
(arch/arm64/kernel/kaslr.c)
> 
> I don't think we need this patch. The 'module' line simply prints the
> VA region that is reserved for modules. The fact that we end up
> putting them elsewhere when running randomized does not necessarily
> mean this line should reflect that.

The Kernel virtual layout info should be as correct as possible
or we should remove the "modules line" in the kernel address layout
since it does not show the correct information.
