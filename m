From: geoff@infradead.org (Geoff Levand)
Date: Fri, 13 Dec 2013 16:20:30 -0800
Subject: [PATCH 5/5] arm64: Add LOAD_OFFSET symbol for linker scripts
In-Reply-To: <20131213164517.GM19177@mudshark.cambridge.arm.com>
References: <cover.1386879684.git.geoff@infradead.org>
 <92660d1b81279aa6784a33eff2f102e78d883931.1386879684.git.geoff@infradead.org>
 <20131213164517.GM19177@mudshark.cambridge.arm.com>
Message-ID: <1386980430.1002.96.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Will,

On Fri, 2013-12-13 at 16:45 +0000, Will Deacon wrote:
> On Thu, Dec 12, 2013 at 08:39:46PM +0000, Geoff Levand wrote:
> > Add a definition for the LOAD_OFFSET symbol used in the linker
> > scripts.  LOAD_OFFSET is used to generate the load address of
> > the section.
> > 
> > Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
> 
> This isn't a standard SoB line. Please choose an email address and lose the
> non-standard suffix.

It took me a little while to find it, but here are the comments
regarding sign-off tags from the 2004 discussion:

  https://lkml.org/lkml/2004/5/25/108

I put on the extra tag for the benefit of those who generate patch
submission statistics.

> > ---
> >  arch/arm64/include/asm/memory.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index 3776217..1994c56 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -52,6 +52,8 @@
> >  #define EARLYCON_IOBASE		(MODULES_VADDR - SZ_4M)
> >  #define TASK_SIZE_64		(UL(1) << VA_BITS)
> >  
> > +#define LOAD_OFFSET		(PAGE_OFFSET)
> 
> Can you be more specific about why we need this please? We don't seem to use
> this on ARM, and I can't really think of a sensible value to define it as,
> either. PAGE_OFFSET is a virtual address, which doesn't make much sense to
> me, but perhaps I'm missing something.

As I mentioned before, LOAD_OFFSET defaults to zero if it is not defined by the
arch, so our arm64 vmlinux files currently have their paddr's equal to their
vaddr's, so something like 0xffffffc000080000.

kexec-tools uses the paddr from the elf file in its generic elf file loader.
Those kexec-tools routines do some sanity checks on the elf headers and one of
those checks is if the paddr seems sane.  A paddr of 0xffffffc000080000 fails
the test, and rightfully so I think.

I could make a special arm64 hack in kexec-tools to handle this, but I think
the proper thing to do is to get some sane paddr values in our vmlinux files.

I agree that PAGE_OFFSET isn't quite right, since zero is not really where the
kernel is located, but it is a handy base, as the proper location is an offset
from there.  My plan is to have the arm64 vmlinux loader routines in kexec-tools
either take a load offset from the kexec command line, or dig out the value from
the device tree.  I'm still working on that part and am not sure what will work.

I haven't looked into it yet, but we shouldn't have this problem with the boot
wrapper files, as we know where the kernel is located at from the device tree.

Sorry for such a long explanation.  Does it make sense?  Any suggestions would
be appreciated.

-Geoff
