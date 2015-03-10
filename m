From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 18:54:38 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <54FF3865.8080301@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150310171751.GD13687@e104818-lin.cambridge.arm.com>
 <54FF2986.6020503@list.ru>
 <20150310173807.GU8656@n2100.arm.linux.org.uk>
 <54FF3865.8080301@list.ru>
Message-ID: <20150310185438.GW8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 09:31:01PM +0300, Stas Sergeev wrote:
> 10.03.2015 20:38, Russell King - ARM Linux ?????:
> > On Tue, Mar 10, 2015 at 08:27:34PM +0300, Stas Sergeev wrote:
> >> Please also find the same crash here:
> >> http://lists.linaro.org/pipermail/kernel-build-reports/2014-June/003872.html
> > Hmm, looks like from the exynos5420-arndale-octa failure in that, we
> > don't dump the page table entries.  We should do.  Sorry about my
> > previous mail.
> >
> > If you can reproduce this, please do so with this patch so that we
> > can get the page table entries associated with the problem.  Thanks.
> >
> >  arch/arm/mm/fault.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > index a982dc3190df..6333d9c17875 100644
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> > @@ -552,6 +552,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> >  
> >  	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
> >  		inf->name, fsr, addr);
> > +	show_pte(current->mm, addr);
> >  
> >  	info.si_signo = inf->sig;
> >  	info.si_errno = 0;
> >
> >

Thanks.

> [    5.383283] Unhandled fault: external abort on non-linefetch (0x808)
> at 0xf00d3018
> [    5.390871] pgd = c0004000
> [    5.393583] [f00d3018] *pgd=2d404811, *pte=efc1e65f, *ppte=efc1e45f

This is interesting.

So, the L1 page table entry is:
	PMD_TYPE_TABLE
	PMD_BIT4
	PMD_DOMAIN(0)
	Pointing at physical address 0x2f404800

L2 page table entry:
	PTE_EXT_XN
	PTE_BUFFERABLE
	PTE_CACHEABLE
	PTE_EXT_AP_UNO_SRW
	PTE_EXT_TEX(1)
	PTE_EXT_SHARED
	Physical address 0xefc1e000

That corresponds with L_PTE_MT_WRITEALLOC, so that's a memory type mapping
with cacheable, write-back, write-allocate attributes.

The thing which has me wondering though is the difference in physical
addresses - that looks /very/ wrong - unless you have close to 4GB of
memory.

Let's see whether we can get some debug from vmalloc to work out what's
going on - can you also apply the patch below.

Also, if you could include details about how much memory your platform
has, and where it's located, that would be useful - passing memblock=debug
should allow us to see what's going on at the memblock level.

Also, the full kernel boot log would be useful to see.

Thanks.

(Patch isn't tested.)

 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 35b25e1340ca..3379bcd6d280 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -129,6 +129,8 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 			return -EBUSY;
 		if (WARN_ON(!page))
 			return -ENOMEM;
+printk("vmalloc: mapping page %p (0x%08lx000) at 0x%08lx\n",
+	page, page_to_pfn(page), addr);
 		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
 		(*nr)++;
 	} while (pte++, addr += PAGE_SIZE, addr != end);

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
