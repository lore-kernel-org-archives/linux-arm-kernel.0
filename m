From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 08 May 2015 14:52:46 +0200
Subject: [PATCH v2 1/5] Documentation: dmaengine: pxa-dma design
In-Reply-To: <20150508043616.GY3521@localhost> (Vinod Koul's message of "Fri,
 8 May 2015 10:06:16 +0530")
References: <1428781236-25806-1-git-send-email-robert.jarzmik@free.fr>
 <1428781236-25806-2-git-send-email-robert.jarzmik@free.fr>
 <20150508043616.GY3521@localhost>
Message-ID: <87y4kzten5.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Sat, Apr 11, 2015 at 09:40:32PM +0200, Robert Jarzmik wrote:
>> Document the new design of the pxa dma driver.
>> +  a) Transfers hot queuing
>> +     A driver submitting a transfer and issuing it should be granted the transfer
>> +     is queued even on a running DMA channel.
> this is bit confusing, esp latter part.. do you mean "A driver submitting a
> transfer and issuing it should be granted the transfer queue even on a
> running DMA channel" ??

Euh no, I meant that a transfer which is submitted and issued on a _phy_
doesn't wait for a _phy_ to stop and restart, but is submitted on a "running
channel". The other drivers, especially mmp_pdma waited for the phy to stop
before relaunching a new transfer.

I don't have a clear idea on a better wording yet ...

>> +     This implies that the queuing doesn't wait for the previous transfer end,
>> +     and that the descriptor chaining is not only done in the irq/tasklet code
>> +     triggered by the end of the transfer.
> how is it differenat than current dmaengine semantics where you say
> issue_pending() is invoked when current transfer finished? Here is you have
> to do descriptor chaining so bit it.
Your sentence is a bit difficult for me to understand.

>> +  c) Channel residue calculation
>> +     A channel should be able to report how much advanced is a transfer. The
> in a							    ^^^^
For v3.

>> +     granularity is still descriptor based.
> This is not pxa specfic
True. Do you want me to remove the (c) from the document ?

>> +
>> +  d) Channel running state
>> +     A driver should be able to query if a channel is running or not. For the
>> +     multimedia case, such as video capture, if a transfer is submitted and then
>> +     a check of the DMA channel reports a "stopped channel", the transfer should
>> +     not be issued until the next "start of frame interrupt", hence the need to
>> +     know if a channel is in running or stopped state.
> How do you query that?
With dma_async_is_tx_complete() giving :
 - dma_cookie_t last_submitted
 - dma_cookie_t last_issued

The channel is still running if (last_submitted < last_issued).

>
>> +
>> +  e) Bandwidth guarantee
>> +     The PXA architecture has 4 levels of DMAs priorities : high, normal, low.
>> +     The high prorities get twice as much bandwidth as the normal, which get twice
>> +     as much as the low priorities.
>> +     A driver should be able to request a priority, especially the real-time
>> +     ones such as pxa_camera with (big) throughputs.
> and how..?
By passing this information :
 - in a devicetree environment, check pxad_dma_xlate()
 - in a platform device environment, check pxad_filter_fn()

>> +  f) Transfer reusability
>> +     An issued and finished transfer should be "reusable". The choice of
>> +     "DMA_CTRL_ACK" should be left to the client, not the dma driver.
> again how is this pxa specfic, if not documented we should move this to
> dmaengine documentation

Yes, I agree. I should move this to dmaengine slave documentation, in
Documentation/dmaengine/provider.txt (in the Misc notes section). Do you want me
to submit a patch to change the "Undocumented feature" into a properly
documented feature ?

Cheers.

-- 
Robert
