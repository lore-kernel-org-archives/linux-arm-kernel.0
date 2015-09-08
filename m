From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Tue, 8 Sep 2015 15:53:07 +0000
Subject: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
In-Reply-To: <20150907180516.GC18079@leverpostej>
References: <1437670365-20704-1-git-send-email-mark.rutland@arm.com>
 <1437670365-20704-3-git-send-email-mark.rutland@arm.com>
 <55B5E8C1.4030707@arm.com> <55EA1C3F.1030300@caviumnetworks.com>
 <20150907180516.GC18079@leverpostej>
Message-ID: <CY1PR0301MB07484C8F1DE26A5EAFE9C7FD87530@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Monday, September 07, 2015 1:05 PM
> To: David Daney
> Cc: Marc Zyngier; tirumalesh.chalamarla at caviumnetworks.com; Richter, Robert; Chintakuntla, Radha;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; iommu at lists.linux-foundation.org; linux-arm-
> kernel at lists.infradead.org; Will Deacon; Robin Murphy; Lorenzo Pieralisi; arnd at arndb.de; treding at nvidia.com;
> majun258 at huawei.com; thunder.leizhen at huawei.com; laurent.pinchart at ideasonboard.com; Yoder Stuart-B08248
> Subject: Re: [PATCH 2/3] Docs: dt: Add PCI MSI map bindings
> 
> On Fri, Sep 04, 2015 at 11:33:35PM +0100, David Daney wrote:
> > Hi Mark,
> 
> Hi David,
> 
> > I now have a prototype implementation for irq-gic-v3-its.c that is using
> > this binding on Cavium's ThunderX platform.
> >
> > Q: Have you guys had any more thoughts on this that might require
> > changing the binding?
> 
> Having discussed this with Stuart and others at Linux Plumbers, I think
> that the binding is sufficient, and unlikely to change greatly unless
> there is a strong objection (Stuart, please correct me if I am wrong).
> 
> Per Marc's comments there are probably some edge cases and/or wording
> details to sort out, but I think the common/simple case is sorted. I'll
> send a v2 once those have been settled.

I think the binding as-is, is sufficient for the static description
of RID to SID.

I think the binding can be extended in a backwards compatible way
to support dynamic RID->SID mappings if we need that in the future.

The case that we (Freescale) are concerned with are where someone
plugs an SRIOV card into an SoC and enables, say 64 VFs.  It's
like hot-plugging 64 new PCI devices at once.  If all those devices
that show up belong to the host they belong to one 'isolation context' and
could share the same streamID, same SMMU mappings, and the same
ITT in the GIC ITS.  So a static mapping could work.

But, as soon as I want to assign VF#5 to a virtual machine I need
a new RID->SID mapping for VF#5.  To require firmware to do that mapping
ahead of time is a _real_ pain.  I think longer term we need some
mechanism to allow lazy, dynamic RID->SID mappings by Linux.

We can start with the static approach, but we need to keep in the
back of our minds that there may be cases in the near future
where a static mapping is too inflexible.

Thanks,
Stuart
