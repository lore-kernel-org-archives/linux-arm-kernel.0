From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 14 Apr 2016 20:23:26 +0200
Subject: [PATCH] dmaengine: pxa: handle bus errors
In-Reply-To: <20160413135324.GQ2274@localhost> (Vinod Koul's message of "Wed,
 13 Apr 2016 19:23:24 +0530")
References: <1459200744-13245-1-git-send-email-robert.jarzmik@free.fr>
 <20160413135324.GQ2274@localhost>
Message-ID: <87k2k0t5gh.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Mon, Mar 28, 2016 at 11:32:24PM +0200, Robert Jarzmik wrote:
>> In the current state, upon bus error the driver will spin endlessly,
>> relaunching the last tx, which will fail again and again :
>>  - a bus error happens
>>  - pxad_chan_handler() is called
>>  - as PXA_DCSR_STOPSTATE is true, the last non-terminated transaction is
>>    lauched, which is the one triggering the bus error, as it didn't
>>    terminate
>>  - moreover, the STOP interrupt fires a new, as the STOPIRQEN is still
>>    active
>> 
>> Break this logic by stopping the automatic relaunch of a dma channel
>> upon a bus error, even if there are still pending issued requests on it.
>> 
>> As dma_cookie_status() seems unable to return DMA_ERROR in its current
>> form, ie. there seems no way to mark a DMA_ERROR on a per-async-tx
>> basis, it is chosen in this patch to remember on the channel which
>> transaction failed, and report it in pxad_tx_status().
>> 
>> It's a bit misleading because if T1, T2, T3 and T4 were queued, and T1
>> was completed while T2 causes a bus error, the status of T3 and T4 will
>> be reported as DMA_IN_PROGRESS, while the channel is actually stopped.
>
> No it is not misleading. The subsequent descriptor can be submitted and
> continued. But yes you are right on the error reporting part, that is
> something we need to add.
Ok, fair enough.

> So what exactly are you trying to fix/achive here?
Euh you mean the first chapter about the "endless spin" is not clear ?
This is what I'm trying to fix, the unstoppable endless relauch of a descriptor
doomed to make the same bus error over and over again.

For the record, I saw this corner case by programming an address hole as
destination address ... not very clever I know :)

Cheers.

--
Robert
