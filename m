From: tony@atomide.com (Tony Lindgren)
Date: Tue, 3 Aug 2010 09:57:10 +0300
Subject: [PATCH] omap: Fix DEBUG_LL uart to access phys addr when MMU
	isn't enable
In-Reply-To: <AANLkTi=ocZPDi5eU_F8VdAzJzYRCEp+B7MZ2q3DAesa3@mail.gmail.com>
References: <1280807058-8394-1-git-send-email-jason77.wang@gmail.com>
	<AANLkTi=ocZPDi5eU_F8VdAzJzYRCEp+B7MZ2q3DAesa3@mail.gmail.com>
Message-ID: <20100803065709.GP12293@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eric Miao <eric.y.miao@gmail.com> [100803 07:29]:
> On Tue, Aug 3, 2010 at 11:44 AM, Jason Wang <jason77.wang@gmail.com> wrote:
> > Now we use a memory address to store the debug port info, So we need
> > to read/write this address when we choose DEBUG_LL. When MMU isn't
> > enable(I.E. the begining part of init stage of the linux kernel boot),
> > we need to access physical address instead of virtual address,
> > otherwise the kernel will crash.
> >
> > Signed-off-by: Jason Wang <jason77.wang@gmail.com>
> > ---
> > ?arch/arm/mach-omap1/include/mach/debug-macro.S | ? 10 +++++--
> > ?arch/arm/mach-omap2/include/mach/debug-macro.S | ? 29 +++++++++++++++++------
> > ?2 files changed, 28 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > index e8a8cf3..671408e 100644
> > --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> > +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> > @@ -33,7 +33,7 @@ omap_uart_virt: ? ? ? .word ? 0x0
> > ? ? ? ? ? ? ? ?/* Use omap_uart_phys/virt if already configured */
> > ?9: ? ? ? ? ? ? mrc ? ? p15, 0, \rx, c1, c0
> > ? ? ? ? ? ? ? ?tst ? ? \rx, #1 ? ? ? ? ? ? ? ? @ MMU enabled?
> > - ? ? ? ? ? ? ? ldreq ? \rx, =omap_uart_phys ? ?@ physical base address
> > + ? ? ? ? ? ? ? ldreq ? \rx, =__virt_to_phys(omap_uart_phys) ? ?@ physical base address
> 
> Along with introduction of run-time phys_offset, I'm afraid this
> macro won't work in assembly any longer.

/me scratches head wondering how this has been working so far on the
systems tested.. Looks like we've been lucky and the omap_uart_virt
and phys have been initialized twice to different memory addresses,
first with MMU off then on.

For the run-time phys_offset, can we use the same logic here and
set it based on the PC?
 
> And having a variable version of debugging uart base, in my POV,
> may not be generic enough to handle the fundamental issue. Tho
> I'm not sure if it will feasible to have a generic debug function in
> 'struct machine_desc' and make that structure available as early
> as possible.

That might cover the most typical debug cases, but is not available
right from the start.

What if we initialize the low level debug functions in some static
memory location already in uncompress.h? That would help sorting
out the debug-macro.S issue from compiling in multile ARM archs
point of view.

Regards,

Tony
