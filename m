From: toshi.kani@hpe.com (Kani, Toshi)
Date: Wed, 27 Jun 2018 16:13:22 +0000
Subject: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with addr
In-Reply-To: <20180627155632.GH30631@arm.com>
References: <20180627141348.21777-1-toshi.kani@hpe.com>
 <20180627141348.21777-3-toshi.kani@hpe.com>
 <20180627155632.GH30631@arm.com>
Message-ID: <1530115885.14039.295.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-06-27 at 16:56 +0100, Will Deacon wrote:
> Hi Toshi,
> 
> On Wed, Jun 27, 2018 at 08:13:47AM -0600, Toshi Kani wrote:
> > From: Chintan Pandya <cpandya@codeaurora.org>
> > 
> > The following kernel panic was observed on ARM64 platform due to a stale
> > TLB entry.
> > 
> >  1. ioremap with 4K size, a valid pte page table is set.
> >  2. iounmap it, its pte entry is set to 0.
> >  3. ioremap the same address with 2M size, update its pmd entry with
> >     a new value.
> >  4. CPU may hit an exception because the old pmd entry is still in TLB,
> >     which leads to a kernel panic.
> > 
> > Commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
> > table") has addressed this panic by falling to pte mappings in the above
> > case on ARM64.
> > 
> > To support pmd mappings in all cases, TLB purge needs to be performed
> > in this case on ARM64.
> > 
> > Add a new arg, 'addr', to pud_free_pmd_page() and pmd_free_pte_page()
> > so that TLB purge can be added later in seprate patches.
> 
> So I acked v13 of Chintan's series posted here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582953.html
> 
> any chance this lot could all be merged together, please?

Hi Will,

Chintan's patch 2/3 and 3/3 apply cleanly on top of my series. Can you
please coordinate with Thomas on the logistics?

Thanks,
-Toshi
