From: geoff@infradead.org (Geoff Levand)
Date: Mon, 16 Dec 2013 16:21:54 -0800
Subject: [PATCH 5/5] arm64: Add LOAD_OFFSET symbol for linker scripts
In-Reply-To: <20131216172917.GJ20193@mudshark.cambridge.arm.com>
References: <cover.1386879684.git.geoff@infradead.org>
 <92660d1b81279aa6784a33eff2f102e78d883931.1386879684.git.geoff@infradead.org>
 <20131213164517.GM19177@mudshark.cambridge.arm.com>
 <1386980430.1002.96.camel@smoke>
 <20131216172917.GJ20193@mudshark.cambridge.arm.com>
Message-ID: <1387239714.1002.154.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Mon, 2013-12-16 at 17:29 +0000, Will Deacon wrote:
> On Sat, Dec 14, 2013 at 12:20:30AM +0000, Geoff Levand wrote:
> > On Fri, 2013-12-13 at 16:45 +0000, Will Deacon wrote:
> > > On Thu, Dec 12, 2013 at 08:39:46PM +0000, Geoff Levand wrote:
> > > > Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
> > > 
> > > This isn't a standard SoB line. Please choose an email address and lose the
> > > non-standard suffix.
> > 
> > It took me a little while to find it, but here are the comments
> > regarding sign-off tags from the 2004 discussion:
> > 
> >   https://lkml.org/lkml/2004/5/25/108
> > 
> > I put on the extra tag for the benefit of those who generate patch
> > submission statistics.
> 
> Hmm, there still doesn't appear to be a *single* occurrence of this in the
> git log, even nearly a decade later. I'm also not very interested in patch
> submission statistics, so I'd rather we stick with the status-quo.

One is at commit 534afb90a9cd0b9643f62d660c164e1d924f39cf (ppc32: fix
ppc440 pagetable attributes).  You can find others in the git history,
and some in the bitkeeper history also, so it is not unprecedented.
Linus says 'I think this is great. In general, I think people who want
to add their own extra tags after their email address should be able to
do so.'.  Can you still deny me this?

> > > > ---
> > > >  arch/arm64/include/asm/memory.h | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > > > index 3776217..1994c56 100644
> > > > --- a/arch/arm64/include/asm/memory.h
> > > > +++ b/arch/arm64/include/asm/memory.h
> > > > @@ -52,6 +52,8 @@
> > > >  #define EARLYCON_IOBASE		(MODULES_VADDR - SZ_4M)
> > > >  #define TASK_SIZE_64		(UL(1) << VA_BITS)
> > > >  
> > > > +#define LOAD_OFFSET		(PAGE_OFFSET)
> > > 
> > > Can you be more specific about why we need this please? We don't seem to use
> > > this on ARM, and I can't really think of a sensible value to define it as,
> > > either. PAGE_OFFSET is a virtual address, which doesn't make much sense to
> > > me, but perhaps I'm missing something.
> > 
> > As I mentioned before, LOAD_OFFSET defaults to zero if it is not defined by the
> > arch, so our arm64 vmlinux files currently have their paddr's equal to their
> > vaddr's, so something like 0xffffffc000080000.
> > 
> > kexec-tools uses the paddr from the elf file in its generic elf file loader.
> > Those kexec-tools routines do some sanity checks on the elf headers and one of
> > those checks is if the paddr seems sane.  A paddr of 0xffffffc000080000 fails
> > the test, and rightfully so I think.
> > 
> > I could make a special arm64 hack in kexec-tools to handle this, but I think
> > the proper thing to do is to get some sane paddr values in our vmlinux files.
> 
> But how? There isn't an architected physical address map, so it's impossible
> to pick a correct physical address base at link time.

Yes, and so just locate it at zero to make the tools happy.  It doesn't
change the behavior of the kernel in any way, it just sets the elf file
header values.

> > I agree that PAGE_OFFSET isn't quite right, since zero is not really where the
> > kernel is located, but it is a handy base, as the proper location is an offset
> > from there.  My plan is to have the arm64 vmlinux loader routines in kexec-tools
> > either take a load offset from the kexec command line, or dig out the value from
> > the device tree.  I'm still working on that part and am not sure what will work.
> 
> Using PAGE_OFFSET is worse than `isn't quite right'. In fact, it's only
> right in exactly one case: where physical memory begins at 0x0!
> 
> > I haven't looked into it yet, but we shouldn't have this problem with the boot
> > wrapper files, as we know where the kernel is located at from the device tree.
> > 
> > Sorry for such a long explanation.  Does it make sense?  Any suggestions would
> > be appreciated.
> 
> I think kexec-tools needs to drop the expectation that the kernel is linked
> to run at a particular physical address, since this isn't the case.

Sure, I can fixup kexec-tools.  It doesn't really matter that much to
me, but I suspect there are other loaders out there (Jason mentions his
arm32 loader) that will not like such paddr values in the elf header,
and is why I thought this change was of use.

-Geoff
