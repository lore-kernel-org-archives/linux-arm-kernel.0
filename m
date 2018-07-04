From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Jul 2018 18:36:06 +0100
Subject: [PATCH v4 2/3] ioremap: Update pgtable free interfaces with addr
In-Reply-To: <alpine.DEB.2.21.1807032301140.1816@nanos.tec.linutronix.de>
References: <20180627141348.21777-1-toshi.kani@hpe.com>
 <20180627141348.21777-3-toshi.kani@hpe.com>
 <20180627155632.GH30631@arm.com>
 <1530115885.14039.295.camel@hpe.com>
 <20180629122358.GC17859@arm.com>
 <1530287995.14039.361.camel@hpe.com>
 <alpine.DEB.2.21.1807032301140.1816@nanos.tec.linutronix.de>
Message-ID: <20180704173605.GB9668@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 11:02:15PM +0200, Thomas Gleixner wrote:
> On Fri, 29 Jun 2018, Kani, Toshi wrote:
> > On Fri, 2018-06-29 at 13:23 +0100, Will Deacon wrote:
> > > On Wed, Jun 27, 2018 at 04:13:22PM +0000, Kani, Toshi wrote:
> > > > On Wed, 2018-06-27 at 16:56 +0100, Will Deacon wrote:
> > > > > On Wed, Jun 27, 2018 at 08:13:47AM -0600, Toshi Kani wrote:
> > > > > > From: Chintan Pandya <cpandya@codeaurora.org>
> > > > > > 
> > > > > > The following kernel panic was observed on ARM64 platform due to a stale
> > > > > > TLB entry.
> > > > > > 
> > > > > >  1. ioremap with 4K size, a valid pte page table is set.
> > > > > >  2. iounmap it, its pte entry is set to 0.
> > > > > >  3. ioremap the same address with 2M size, update its pmd entry with
> > > > > >     a new value.
> > > > > >  4. CPU may hit an exception because the old pmd entry is still in TLB,
> > > > > >     which leads to a kernel panic.
> > > > > > 
> > > > > > Commit b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page
> > > > > > table") has addressed this panic by falling to pte mappings in the above
> > > > > > case on ARM64.
> > > > > > 
> > > > > > To support pmd mappings in all cases, TLB purge needs to be performed
> > > > > > in this case on ARM64.
> > > > > > 
> > > > > > Add a new arg, 'addr', to pud_free_pmd_page() and pmd_free_pte_page()
> > > > > > so that TLB purge can be added later in seprate patches.
> > > > > 
> > > > > So I acked v13 of Chintan's series posted here:
> > > > > 
> > > > > http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/582953.html
> > > > > 
> > > > > any chance this lot could all be merged together, please?
> > > > 
> > > > Chintan's patch 2/3 and 3/3 apply cleanly on top of my series. Can you
> > > > please coordinate with Thomas on the logistics?
> > > 
> > > Sure. I guess having this series on a common branch that I can pull into
> > > arm64 and apply Chintan's other patches on top would work.
> > > 
> > > How does that sound?
> > 
> > Should this go thru -mm tree then?
> > 
> > Andrew, Thomas, what do you think? 
> 
> I just pick it up and provide Will a branch to pull that lot from.

Thanks, Thomas. Please let me know once you've pushed something out.

Will
