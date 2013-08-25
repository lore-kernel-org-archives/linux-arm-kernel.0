From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 25 Aug 2013 21:41:04 +0530
Subject: [PATCH v4 3/4] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <5214AC80.2090102@gmail.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-4-git-send-email-zonque@gmail.com>
 <5214A601.1010607@marvell.com>
 <CAHp75VfFFq0kaf7wDt3WTwsx6peBmt=rDXaUGXz=cnn4-bBKZw@mail.gmail.com>
 <5214AC80.2090102@gmail.com>
Message-ID: <20130825161104.GC2748@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 02:03:12PM +0200, Daniel Mack wrote:
> Hi Andy,
> 
> On 21.08.2013 13:52, Andy Shevchenko wrote:
> > On Wed, Aug 21, 2013 at 2:35 PM, Xiang Wang <wangx@marvell.com> wrote:
> >> On 08/17/2013 01:05 AM, Daniel Mack wrote:
> >>>
> >>> In order to report the channel's residue, we walk the list of running
> >>> descriptors, look for those which match the cookie, and then try to find
> >>> the descriptor which defines upper and lower boundaries that embrace the
> >>> current transport pointer.
> >>>
> >>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> > 
> >> One thing I want to check with you and all:
> >> If we have these descriptors in the running chain:
> >> D1T1 -> D2T1 -> D3T1 => D1T2 -> D2T2 -> D3T2
> >> |    Transaction 1    | Transaction 2      |
> >>
> >> And DMA currently running to D2T1, if we provide the cookie of D3T2, what
> >> the residual value we should get? All unfinished bytes in T1+T2 or only
> >> unfinished bytes in T2 (seems not easy to implement)?
> > 
> > You have a really good question. Different drivers do different things.
> 
> I think the idea of how things should work is pretty clear, but I'd like
> Vinod to ack my understanding here :)
> 
> The user is free to submit multiple transactions per channel, and
> dmaengine_submit() will submit a new cookie for each one.
> 
> When the engine is asked about the residue of a specific cookie, it
> should of course only return the value for the related transaction. If
> that transaction is not yet processed, the residue value should be the
> complete length, regardless of the transaction that is currently processed.
Yes that is the idea. See the argument of the dmaengine_tx_status() API is a
cookie. This is the cookie you need to check and find out the status. Now there
is an intresting thing about last argument dma_tx_state. Here you would know
which was last cookie completed and which is used (in progress).

Also descriptor is returned for a transaction when you invoke .device_prep_xxx.
And each descriptor is assigned a cookie value.

Now in above case you wont have D1TI unless at client level you have broken to
differen prepare calls to dmaengine.
Assuming that you get cookie 1, 2, 3, 4, 5, 6 assigned respectively to above.

Now if you called dmaengine_tx_status() for cookie 5, when 1 has completed and
2nd in progress, the right implementation would tell you residue is size, and
state->completed =1, state->used =2.

If you have invoked for 2, then you would get in-flight residue.
> 
> > In dw_dmac, for example, we return the T1 (means 'active') residue always.
> 
> I'd say that's a bug.
yes, that would be a bug BUT since you call dma_cookie_status() and maintain
chan->completed_cookie by invoking dma_cookie_complete() dmaengine gives right
values for completed ones. For pending ones looks like it is not right and you
need to see if cookie invoked for is in progress or not.

> 
> > I don't think you have different cookies per descriptors in chain of
> > one transaction.
cookie is assigned to a descriptor.

> Currently, the pdma driver does in fact assign a cookie to each
> descriptor, but the external user will only get so see the cookie for
> the last descriptor in the transaction. I don't think that's a problem,
> but we have to maintain an understanding of which descriptors belong to
> one transaction.
descriptor->cookie tells you the cookie value for the transaction represented by
the descriptor which you check and should pass when calling
dmaengine_tx_status(). The last completed descriptor is
marked in chan->completed_cookie. So when somone calls dmaengine_tx_status() you
already know if its in flight or not.

~Vinod
