From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 24 Mar 2017 12:00:45 +0100
Subject: [RFC PATCH 24/30] iommu: Specify PASID state when unbinding a task
In-Reply-To: <9d318e88-11af-6dab-b30e-d6b5c02443fe@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-25-jean-philippe.brucker@arm.com>
 <20170322154429.GE7266@8bytes.org>
 <e2bb4c67-9b61-01cf-cc17-68088cdc5e5b@arm.com>
 <20170322225320.GF7266@8bytes.org>
 <a093bc07-a345-a689-9d97-f15a306f922d@arm.com>
 <20170323143014.GK7266@8bytes.org>
 <20170323145311.GA22972@e106794-lin.localdomain>
 <20170323165218.GL7266@8bytes.org>
 <9d318e88-11af-6dab-b30e-d6b5c02443fe@arm.com>
Message-ID: <20170324110045.GM7266@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 05:03:46PM +0000, Jean-Philippe Brucker wrote:
> On 23/03/17 16:52, Joerg Roedel wrote:
> > Thanks for that, I have a closer look. Is that stopper packet visible to
> > software (e.g. is an entry created in the queue)?
> 
> As far as I understand, it should be added to the queue like a normal PPR,
> and software should check the R/W/L flags combination. For SMMU at least,
> it is the same. The only difference is that when the PRI queue overflows,
> the SMMU would discard a Stop Marker instead of sending an automated
> response to the device (as it would do with others PPR that have the L
> flag.) Software shouldn't send a response to a Stop Marker either.

The document you posted is an addition to the spec, so we can't rely on
a stop marker being sent by a device when it shuts down a context.
Current AMD GPUs don't send one, afaik.

I think the best we can do is shutting down processing for this PASID
when and inform the device driver, when we receive a stop marker. An
additional, optional call-back would do the job.



	Joerg
