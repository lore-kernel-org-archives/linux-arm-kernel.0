From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 13 Sep 2013 10:21:35 +0530
Subject: [PATCH v5 4/5] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <522F3ECB.3070307@gmail.com>
References: <1377086938-29145-1-git-send-email-zonque@gmail.com>
 <1377086938-29145-5-git-send-email-zonque@gmail.com>
 <20130825163337.GD2748@intel.com> <522F3ECB.3070307@gmail.com>
Message-ID: <20130913045135.GI17188@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 05:46:19PM +0200, Daniel Mack wrote:
> Hi Vinod,
> 
> Sorry for the late response, I've been on vacations.
> 
> On 25.08.2013 18:33, Vinod Koul wrote:
> > On Wed, Aug 21, 2013 at 02:08:57PM +0200, Daniel Mack wrote:
> >> In order to report the channel's residue, we walk the list of running
> >> descriptors, look for those which match the cookie, and then try to find
> >> the descriptor which defines upper and lower boundaries that embrace the
> >> current transport pointer.
> > 
> >>
> >> +		/*
> >> +		 * 'passed' will be latched once we found the descriptor which
> >> +		 * lies inside the boundaries of the curr pointer. All
> >> +		 * descriptors that occur in the list _after_ we found that
> >> +		 * partially handled descriptor are still to be processed and
> >> +		 * are hence added to the residual bytes counter.
> >> +		 */
> > do you have multiple descriptors for one transaction? Should be No.
> 
> Sure, that can be the case. One transaction could span across multiple
> descriptors, especially if its overall length exceeds the maximum length
> of one descriptor.
Yes and these addiional descriptor for a transacation should be child
descriptors. 
The child descriptors should have ->parent point to parent descriptor and ->next
to next in the chain of children.

> > The cookie is assigned to a transaction when it is submitted. so when you see
> > descriptor cookie is less than completed one, then it already completed and
> > should not be in pending list.
> 
> Hmm, what about an integer overrun?
The cookie needs to wrapped to 1. If you use virtual dma code then it would be
done. Since the variable is 32bit, i dont think you will have so many eonding
trasaction so i havent seen any concerns on that.

~Vinod

-- 
