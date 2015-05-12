From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 12 May 2015 15:42:01 +0530
Subject: [PATCH v2 1/5] Documentation: dmaengine: pxa-dma design
In-Reply-To: <87y4kzten5.fsf@belgarion.home>
References: <1428781236-25806-1-git-send-email-robert.jarzmik@free.fr>
 <1428781236-25806-2-git-send-email-robert.jarzmik@free.fr>
 <20150508043616.GY3521@localhost> <87y4kzten5.fsf@belgarion.home>
Message-ID: <20150512101201.GB5418@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 02:52:46PM +0200, Robert Jarzmik wrote:
> Vinod Koul <vinod.koul@intel.com> writes:
> 
> > On Sat, Apr 11, 2015 at 09:40:32PM +0200, Robert Jarzmik wrote:
> >> Document the new design of the pxa dma driver.
> >> +  a) Transfers hot queuing
> >> +     A driver submitting a transfer and issuing it should be granted the transfer
> >> +     is queued even on a running DMA channel.
> > this is bit confusing, esp latter part.. do you mean "A driver submitting a
> > transfer and issuing it should be granted the transfer queue even on a
> > running DMA channel" ??
> 
> Euh no, I meant that a transfer which is submitted and issued on a _phy_
> doesn't wait for a _phy_ to stop and restart, but is submitted on a "running
> channel". The other drivers, especially mmp_pdma waited for the phy to stop
> before relaunching a new transfer.
> 
> I don't have a clear idea on a better wording yet ...
Ah okay, with that explanation it helps, can you add that to
comments/documentation

> 
> >> +     This implies that the queuing doesn't wait for the previous transfer end,
> >> +     and that the descriptor chaining is not only done in the irq/tasklet code
> >> +     triggered by the end of the transfer.
> > how is it differenat than current dmaengine semantics where you say
> > issue_pending() is invoked when current transfer finished? Here is you have
> > to do descriptor chaining so bit it.
> Your sentence is a bit difficult for me to understand.
Sorry for typo, meant:
how is it different than current dmaengine semantics where you say
issue_pending() is invoked when current transfer finishes? Here you are
doing descriptor chaining, so be it.
Ideally dmaengine driver should keep submitting txns and opportunistically
based on HW optimize it. All this is transparent to clients, they submit and
wait for callback.

> >> +     granularity is still descriptor based.
> > This is not pxa specfic
> True. Do you want me to remove the (c) from the document ?
yes

> >> +  f) Transfer reusability
> >> +     An issued and finished transfer should be "reusable". The choice of
> >> +     "DMA_CTRL_ACK" should be left to the client, not the dma driver.
> > again how is this pxa specfic, if not documented we should move this to
> > dmaengine documentation
> 
> Yes, I agree. I should move this to dmaengine slave documentation, in
> Documentation/dmaengine/provider.txt (in the Misc notes section). Do you want me
> to submit a patch to change the "Undocumented feature" into a properly
> documented feature ?
That would be great

-- 
~Vinod
