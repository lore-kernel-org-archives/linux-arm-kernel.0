From: dilinger@queued.net (Andres Salomon)
Date: Mon, 22 Aug 2011 19:08:38 -0700
Subject: [PATCH] ARM: mmp: map sram as MT_MEMORY rather than MT_DEVICE
In-Reply-To: <CAMPhdO-cttCzdm_gh=KdNqqPYQOgPBNS57DtPduPahpkP2rk0g@mail.gmail.com>
References: <1313377794-26721-1-git-send-email-leoy@marvell.com>
	<1313377794-26721-2-git-send-email-leoy@marvell.com>
	<20110822164740.5682541b@queued.net>
	<CAMPhdO-cttCzdm_gh=KdNqqPYQOgPBNS57DtPduPahpkP2rk0g@mail.gmail.com>
Message-ID: <20110822190838.3e03c3ec@debxo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Aug 2011 08:07:41 +0800
Eric Miao <eric.y.miao@gmail.com> wrote:

> On Tue, Aug 23, 2011 at 7:47 AM, Andres Salomon <dilinger@queued.net>
> wrote:
> > The sram code allocates memory with ioremap, which assumes MT_DEVICE
> > for memory protections. ?This explodes when we map sram for power
> > management purposes and then attempt to execute it (jump_to_lp_sram)
> > on the OLPC XO-1.75. ?Instead, we want to specify MT_MEMORY, which
> > doesn't set the L_PTE_XN bit.
> >
> > Signed-off-by: Andres Salomon <dilinger@queued.net>
> > ---
> > ?arch/arm/mach-mmp/sram.c | ? ?4 +++-
> > ?1 files changed, 3 insertions(+), 1 deletions(-)
> >
> > Eric, this patch is against the devel branch of your pxa tree.
> >
> > diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
> > index 4304f95..ca4d3c1 100644
> > --- a/arch/arm/mach-mmp/sram.c
> > +++ b/arch/arm/mach-mmp/sram.c
> > @@ -21,6 +21,7 @@
> > ?#include <linux/err.h>
> > ?#include <linux/slab.h>
> > ?#include <linux/genalloc.h>
> > +#include <asm/mach/map.h>
> >
> > ?#include <mach/sram.h>
> >
> > @@ -87,7 +88,8 @@ static int __devinit sram_probe(struct
> > platform_device *pdev)
> >
> > ? ? ? ?info->sram_phys ? = (phys_addr_t)res->start;
> > ? ? ? ?info->sram_size ? = resource_size(res);
> > - ? ? ? info->sram_virt ? = ioremap(info->sram_phys,
> > info->sram_size);
> > + ? ? ? info->sram_virt ? = __arm_ioremap(info->sram_phys,
> > info->sram_size,
> > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MT_MEMORY);
> 
> I doubt MT_MEMORY is intended for use with __arm_ioremap(). There
> could be other way around to the L_PTE_XN bit.
> 
> One other way I'm actually thinking of is to add the SRAM mapping to
> mmp_map_io(). The difference of SRAM offset/size may result the
> separation of mmp_map_io() into {pxa168,pxa910,mmp2}_map_io()
> if necessary.
> 

I guess I don't follow.  I think you're talking about adding it to the
standard_io_desc array, but that would require having it pre-mapped and
knowing the virtual address.  Or were you planning to ioremap it?
