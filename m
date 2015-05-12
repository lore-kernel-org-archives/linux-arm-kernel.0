From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 12 May 2015 21:13:20 +0200
Subject: [PATCH v2 1/5] Documentation: dmaengine: pxa-dma design
In-Reply-To: <20150512101201.GB5418@localhost> (Vinod Koul's message of "Tue,
 12 May 2015 15:42:01 +0530")
References: <1428781236-25806-1-git-send-email-robert.jarzmik@free.fr>
 <1428781236-25806-2-git-send-email-robert.jarzmik@free.fr>
 <20150508043616.GY3521@localhost> <87y4kzten5.fsf@belgarion.home>
 <20150512101201.GB5418@localhost>
Message-ID: <87h9rhmwxb.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Fri, May 08, 2015 at 02:52:46PM +0200, Robert Jarzmik wrote:
>> Vinod Koul <vinod.koul@intel.com> writes:
>> 
>> Euh no, I meant that a transfer which is submitted and issued on a _phy_
>> doesn't wait for a _phy_ to stop and restart, but is submitted on a "running
>> channel". The other drivers, especially mmp_pdma waited for the phy to stop
>> before relaunching a new transfer.
>> 
>> I don't have a clear idea on a better wording yet ...
> Ah okay, with that explanation it helps, can you add that to
> comments/documentation
Sure, for v3.

>> >> +     This implies that the queuing doesn't wait for the previous transfer end,
>> >> +     and that the descriptor chaining is not only done in the irq/tasklet code
>> >> +     triggered by the end of the transfer.
>> > how is it differenat than current dmaengine semantics where you say
>> > issue_pending() is invoked when current transfer finished? Here is you have
>> > to do descriptor chaining so bit it.
>> Your sentence is a bit difficult for me to understand.
> Sorry for typo, meant:
> how is it different than current dmaengine semantics where you say
> issue_pending() is invoked when current transfer finishes? Here you are
> doing descriptor chaining, so be it.

It is not "different" from dmaengine semantics. It's an implementation choice
which is not strictly required by dmaengine, and therefore a requirement on top
of what dmaengine offers.
Dmaengine requires to submit a transfer, and gives issue_pending() to provide a
guarantee the transfer will be executed. The dmaengine drivers can choose to
either queue the transfer when the previous one's completion is notified
(interrupt), or hot-queue the transfer while the channel is running.

This constraint documents the fact that this specific dmaengine driver's
implementation chose to hot-chain transfers whenever possible.

> Ideally dmaengine driver should keep submitting txns and opportunistically
> based on HW optimize it. All this is transparent to clients, they submit and
> wait for callback.
True. Yet this is not a requirement, it's a "good design" behavior. I wonder how
many dmaengine drivers are behaving in an optimize way ...

>> >> +     granularity is still descriptor based.
>> > This is not pxa specfic
>> True. Do you want me to remove the (c) from the document ?
> yes
Ok, for v3.

>> >> +  f) Transfer reusability
>> >> +     An issued and finished transfer should be "reusable". The choice of
>> >> +     "DMA_CTRL_ACK" should be left to the client, not the dma driver.
>> > again how is this pxa specfic, if not documented we should move this to
>> > dmaengine documentation
>> 
>> Yes, I agree. I should move this to dmaengine slave documentation, in
>> Documentation/dmaengine/provider.txt (in the Misc notes section). Do you want me
>> to submit a patch to change the "Undocumented feature" into a properly
>> documented feature ?
> That would be great
On my way, for v3.

Cheers.

-- 
Robert
