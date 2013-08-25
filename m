From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 25 Aug 2013 03:15:09 +0200
Subject: [PATCH v4 1/4] dma: mmp_pdma: only complete one transaction from
 dma_do_tasklet()
In-Reply-To: <52131E40.5040304@gmail.com> (Daniel Mack's message of "Tue, 20
 Aug 2013 09:44:00 +0200")
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-2-git-send-email-zonque@gmail.com>
 <5212D419.5030504@marvell.com> <52131E40.5040304@gmail.com>
Message-ID: <878uzqr2oy.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack <zonque@gmail.com> writes:

> Hi Xiang,
>
> On 20.08.2013 04:27, Xiang Wang wrote:
>> I think we would not run into the situation that there is a descriptor 
>> with ENDIRQEN set in the middle of the running chain.
>> 
>> in mmp_pdma.c:
>> mmp_pdma_tx_submit() -> append_pending_queue() ->
>> tail->desc.dcmd &= ~DCMD_ENDIRQEN;
>> 
>> So in the pending list (same for running list), only the last descriptor 
>> will have ENDIRQEN set.
>
> Right, thanks for noting that.
>
> But is that what we want? I think that clearing of the ENDIRQEN bit
> needs to be removed then, because if we really have multiple
> transactions running, then we want to get an interrupt whenever _any_ of
> it is completed.

At least that's something pxa_camera.c needs, ie. have the dma interrupt handler
called as soon as the _first_ of many transactions queued on the same channel is
finished.

This is necessary to declare the video capture buffer as "done", which is
signaled by a terminated DMA transaction. And of course, in video recording,
another one is beginning on the channel, while the finished video buffer can be
safely unmapped and handed over to userland.

> Hence, would you agree that we should remove that "tail->desc.dcmd &=
> ~DCMD_ENDIRQEN;" modification in order to make the above logic work?
Same question on my side.

My understanding is that the current bebaviour violates the dmaengine
specification (Documentation/dmaengine.txt, chapter 5, "On completion of each
DMA operation, the next in queue is started and a tasklet triggered. The tasklet
will then call the client driver completion callback routine for notification,
if set.)

Cheers.

--
Robert
