From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Oct 2015 10:27:31 +0100
Subject: [PATCH] iommu/arm-smmu: Only return IRQ_NONE if FSR is not set
In-Reply-To: <vnkwzizv688u.fsf@codeaurora.org>
References: <1443226325-28456-1-git-send-email-mitchelh@codeaurora.org>
 <20151005142402.GF8818@arm.com> <vnkwzizv688u.fsf@codeaurora.org>
Message-ID: <20151007092730.GA16065@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 01:40:33PM -0700, Mitchel Humpherys wrote:
> On Mon, Oct 05 2015 at 03:24:03 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Sat, Sep 26, 2015 at 01:12:05AM +0100, Mitchel Humpherys wrote:
> >> Currently we return IRQ_NONE from the context fault handler if the FSR
> >> doesn't actually have the fault bit set (some sort of miswired
> >> interrupt?) or if the client doesn't register an IOMMU fault handler.
> >> However, registering a client fault handler is optional, so telling the
> >> interrupt framework that the interrupt wasn't for this device if the
> >> client doesn't register a handler isn't exactly accurate.  Fix this by
> >> returning IRQ_HANDLED even if the client doesn't register a handler.
> >> 
> >> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> >> ---
> >>  drivers/iommu/arm-smmu.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> >> index 48a39dfa9777..95560d447a54 100644
> >> --- a/drivers/iommu/arm-smmu.c
> >> +++ b/drivers/iommu/arm-smmu.c
> >> @@ -653,7 +653,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
> >>  		dev_err_ratelimited(smmu->dev,
> >>  		    "Unhandled context fault: iova=0x%08lx, fsynr=0x%x, cb=%d\n",
> >>  		    iova, fsynr, cfg->cbndx);
> >> -		ret = IRQ_NONE;
> >> +		ret = IRQ_HANDLED;
> >>  		resume = RESUME_TERMINATE;
> >
> > Hmm, but if we haven't actually done anything to rectify the cause of the
> > fault, what means that we won't take it again immediately? I guess I'm not
> > understanding the use-case that triggered you to write this patch...
> 
> Does returning IRQ_NONE actually prevent us from taking another
> interrupt (despite clearing the FSR below)?  We definitely take more
> interrupts on our platform despite returning IRQ_NONE, but maybe we have
> something misconfigured...

No, IRQ_NONE doesn't prevent anything unless we trigger the spurious IRQ
detector (1000 IRQs / second iirc). In that case, the handler ends up being
invoked off the back of a timer tick last time I looked.

My concern is that the source of the interrupt isn't handled at all in
the case above. Sure, we clear the FSR, but we haven't actually done
anything to stop the fault occuring again. It would be like dealing with
a page fault from userspace by simply returning back to the application
without actually updating the page tables.

Will
