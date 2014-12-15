From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Dec 2014 17:39:11 +0000
Subject: [PATCH 0/4] Generic IOMMU page table framework
In-Reply-To: <1703241.O5cxT4doxg@avalon>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <2133922.nksBEtjI2q@avalon> <20141215161052.GM20738@arm.com>
 <1703241.O5cxT4doxg@avalon>
Message-ID: <20141215173911.GT20738@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 05:33:32PM +0000, Laurent Pinchart wrote:
> On Monday 15 December 2014 16:10:52 Will Deacon wrote:
> > On Sun, Dec 14, 2014 at 11:49:30PM +0000, Laurent Pinchart wrote:
> > > diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> > > index c1cff3d045db..a41a15d30596 100644
> > > --- a/drivers/iommu/io-pgtable.h
> > > +++ b/drivers/iommu/io-pgtable.h
> > > @@ -24,6 +24,9 @@ struct iommu_gather_ops {
> > >  	void (*flush_pgtable)(void *ptr, size_t size, void *cookie);
> > >  };
> > > 
> > > +/* Set the Non-Secure bit in the PTEs */
> > > +#define IO_PGTABLE_QUIRK_NON_SECURE	(1 << 0)
> > 
> > I think I'd stick an _ARM_ somewhere in here, so maybe
> > IO_PGTABLE_QUIRK_ARM_NS?
> 
> I'm fine with that.
> 
> By the way, I'm only familiar with the Renesas implementation of the VMSA 
> IOMMU, could you double-check whether setting the NSTABLE and NS bits on all 
> levels make sense to you ? It seems to be required by my hardware, even though 
> the ARM spec mentions that setting the NSTABLE bit causes non-secure accesses 
> to page tables for all lower levels regardless of their NSTABLE/NS bits.

The ARM ARM is very clear that subsequent levels of lookup must ignore the
NSTABLE/NS bits since otherwise you potentially have a security violation
where you can use the table walker to access secure memory from
non-secure...

So, you might want to check up on that, but given that this is a quirk I'm
happy for it to do whatever you need.

Will
