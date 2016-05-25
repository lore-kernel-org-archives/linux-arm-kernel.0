From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 May 2016 13:42:41 +0100
Subject: [PATCH] arm64:efi fix the format of debug message from efi
In-Reply-To: <20160525124024.GA4798@arm.com>
References: <1464174974-4733-1-git-send-email-dennis.chen@arm.com>
 <20160525112549.GJ1337@leverpostej> <20160525124024.GA4798@arm.com>
Message-ID: <20160525124241.GM1337@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 08:40:27PM +0800, Dennis Chen wrote:
> On Wed, May 25, 2016 at 12:25:49PM +0100, Mark Rutland wrote:
> > On Wed, May 25, 2016 at 07:16:14PM +0800, Dennis Chen wrote:
> > > When enable debug of efi and memblock with 'efi=debug memblock=debug' appended
> > > to the kernel command line, the debug message output for earyly_con looks like:
> > > [    0.000000] efi:   0x0000e1050000-0x0000e105ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> > > [    0.000000] efi:   0x0000e1300000-0x0000e1300fff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> > > [    0.000000] efi:   0x0000e8200000-0x0000e827ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> > > [    0.000000] efi:   0x008000000000-0x008001e7ffff [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]
> > > [    0.000000] memblock_add: [0x00008000000000-0x00008001e7ffff] flags 0x0 early_init_dt_add_memory_arch+0x54/0x5c
> > > [    0.000000] *
> > > ...
> > > This patch is trying to fix the above output messed up by memblock_add(), so we can get below debug mesg looks
> > > more formally after applied:
> > > [    0.000000] efi:   0x0000e1050000-0x0000e105ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> > > [    0.000000] efi:   0x0000e1300000-0x0000e1300fff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> > > [    0.000000] efi:   0x0000e8200000-0x0000e827ffff [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC]
> > > [    0.000000] efi:   0x008000000000-0x008001e7ffff [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC]*
> > > [    0.000000] memblock_add: [0x00008000000000-0x00008001e7ffff] flags 0x0 early_init_dt_add_memory_arch+0x54/0x5c
> > > ...
> > > 
> > > Signed-off-by: Dennis Chen <dennis.chen@arm.com>
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Steve Capper <steve.capper@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > ---
> > >  drivers/firmware/efi/arm-init.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> > > index a850cbc..272f674 100644
> > > --- a/drivers/firmware/efi/arm-init.c
> > > +++ b/drivers/firmware/efi/arm-init.c
> > > @@ -174,6 +174,7 @@ static __init void reserve_regions(void)
> > >  {
> > >         efi_memory_desc_t *md;
> > >         u64 paddr, npages, size;
> > > +       int resv;
> > > 
> > >         if (efi_enabled(EFI_DBG))
> > >                 pr_info("Processing EFI memory map:\n");
> > > @@ -190,12 +191,16 @@ static __init void reserve_regions(void)
> > >                 paddr = md->phys_addr;
> > >                 npages = md->num_pages;
> > > 
> > > +               resv = is_reserve_region(md);
> > >                 if (efi_enabled(EFI_DBG)) {
> > >                         char buf[64];
> > > 
> > >                         pr_info("  0x%012llx-0x%012llx %s%s",
> > >                                 paddr, paddr + (npages << EFI_PAGE_SHIFT) - 1,
> > > -                               efi_md_typeattr_format(buf, sizeof(buf), md));
> > > +                               efi_md_typeattr_format(buf, sizeof(buf), md),
> > > +                               resv ? "*" : "");
> > > +
> > > +                       pr_cont("\n");
> > 
> > As I mentioned in my (off-list) mail previously, please fold this
> > pr_cont in. You just need to move the "\n" into the end of the format
> > string for the pr_info.
> >
> Yes, my careless mistake. Will be updated in v2...;-)

Thanks. With that, my Acked-by holds.

I've just spotted that this has not gone to linux-efi, Matt Fleming, or
Ard Biesheuvel, who should all have been Cc'd. Please use
get_maintainer.pl, and send this to the relevant maintainers and lists.

Thanks,
Mark.
