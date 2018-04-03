From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Tue, 3 Apr 2018 14:03:48 -0600
Subject: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
In-Reply-To: <CY1PR0701MB201215C9F38E8760732B595088A50@CY1PR0701MB2012.namprd07.prod.outlook.com>
References: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
 <1521736009-23387-4-git-send-email-okaya@codeaurora.org>
 <ac46b4e4-7e6c-c15f-06eb-01b1e4893d50@codeaurora.org>
 <CY1PR0701MB201215C9F38E8760732B595088A50@CY1PR0701MB2012.namprd07.prod.outlook.com>
Message-ID: <20180403200348.GB21167@ziepe.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 07:42:28AM +0000, Kalderon, Michal wrote:
> > From: Sinan Kaya [mailto:okaya at codeaurora.org]
> > Sent: Tuesday, April 03, 2018 5:30 AM
> > To: linux-rdma at vger.kernel.org; timur at codeaurora.org;
> > sulrich at codeaurora.org
> > Cc: linux-arm-msm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > Kalderon, Michal <Michal.Kalderon@cavium.com>; Elior, Ariel
> > <Ariel.Elior@cavium.com>; Doug Ledford <dledford@redhat.com>; Jason
> > Gunthorpe <jgg@ziepe.ca>; linux-kernel at vger.kernel.org
> > Subject: Re: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on
> > weakly-ordered archs #2
> > 
> > On 3/22/2018 12:26 PM, Sinan Kaya wrote:
> > > @@ -860,7 +860,7 @@ static void doorbell_cq(struct qedr_cq *cq, u32
> > cons, u8 flags)
> > >  	wmb();
> > >  	cq->db.data.agg_flags = flags;
> > >  	cq->db.data.value = cpu_to_le32(cons);
> > > -	writeq(cq->db.raw, cq->db_addr);
> > > +	writeq_relaxed(cq->db.raw, cq->db_addr);
> > 
> > Given the direction to get rid of wmb() in front of writeX() functions, I have
> > been reviewing this code. Under normal circumstances, I can get rid of all
> > wmb() as follows.
> > 
> > However, I started having my doubts now. Are these wmb() used as a SMP
> > barrier too?
> > I can't find any smp_Xmb() in drivers/infiniband/hw/qedr directory.
> 
> Your doubts are in place. You initial patch series modified writel to writel_relaxed
> Simply removing the wmb is dangerous. The wmb before writel are used to make sure the
> HW observes the changes in memory before we trigger the doorbell. Smp barriers here
> wouldn't suffice, as on a single processor. we still need to make sure memory is updated
> and not remained in cache when HW accesses it.
> Reviewing the qedr barriers, I can find places where this may have not been necessary, 
> But definitely you can't simply remove this wmb barriers. 

As Sinan said, the consensus is that wmb();writel(); is redundant if
the only purpose of the wmb is to order DMA and system memory.

So can you review these patches on that basis please? Is the WMB doing
something else, eg SMP related? If yes, please send a patch adding
appropriate comments.

Thanks,
Jason
