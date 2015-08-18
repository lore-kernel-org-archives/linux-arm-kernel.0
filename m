From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 18 Aug 2015 15:24:36 +0100
Subject: [PATCH 2/2] arm64: set MAX_MEMBLOCK_ADDR according to linear
 region size
In-Reply-To: <20150818100018.GA11021@arm.com>
References: <1439890482-20798-1-git-send-email-ard.biesheuvel@linaro.org>
 <1439890482-20798-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150818100018.GA11021@arm.com>
Message-ID: <20150818142435.GC11571@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 11:00:27AM +0100, Will Deacon wrote:
> On Tue, Aug 18, 2015 at 10:34:42AM +0100, Ard Biesheuvel wrote:
> > The linear region size of a 39-bit VA kernel is only 256 GB, which
> > may be insufficient to cover all of system RAM, even on platforms
> > that have much less than 256 GB of memory but which is laid out
> > very sparsely.
> > 
> > So make sure we clip the memory we will not be able to map before
> > installing it into the memblock memory table, by setting
> > MAX_MEMBLOCK_ADDR accordingly.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/include/asm/memory.h | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> > index f800d45ea226..44a59c20e773 100644
> > --- a/arch/arm64/include/asm/memory.h
> > +++ b/arch/arm64/include/asm/memory.h
> > @@ -114,6 +114,14 @@ extern phys_addr_t		memstart_addr;
> >  #define PHYS_OFFSET		({ memstart_addr; })
> >  
> >  /*
> > + * The maximum physical address that the linear direct mapping
> > + * of system RAM can cover. (PAGE_OFFSET can be interpreted as
> > + * a 2's complement signed quantity and negated to derive the
> > + * maximum size of the linear mapping.)
> > + */
> > +#define MAX_MEMBLOCK_ADDR	({ memstart_addr - PAGE_OFFSET - 1; })

With the current memory layout, this could also be __pa(~0UL). I guess
we could solve this with a single patch, though I'm not sure whether we
break other architectures:

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 07496560e5b9..ff8a885d5ff0 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -967,7 +967,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
 }
 
 #ifdef CONFIG_HAVE_MEMBLOCK
-#define MAX_PHYS_ADDR	((phys_addr_t)~0)
+#define MAX_PHYS_ADDR	(__pa(~0UL))
 
 void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {

> If we initialised memory_limit to this value and changed early_mem to
> use min (i.e. only restrict the limit further), would that avoid the
> need to change the of code?

Only that we can't initialise memory_limit statically since
memstart_addr is not constant. We would need to do this somewhere before
early_mem() is run (in setup_machine_fdt or immediately after it).

My point to Ard was that since we already do a sanity check on the
memblocks in early_init_dt_add_memory_arch() and ignore those below
PHYS_OFFSET, it makes sense to reuse the same function since it already
has all the logic in place and corresponding warnings. With a later
memblock limiting we would have to add extra printing to inform the
user.

-- 
Catalin
