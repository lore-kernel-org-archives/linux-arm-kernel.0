From: vernoninhand@gmail.com (Vernon Sauder)
Date: Wed, 17 Feb 2010 23:54:44 -0500
Subject: [PATCH] pxamci: close a serious race
In-Reply-To: <4A4DA584.7080402@gmail.com>
References: <f383264b0906151408u7b7087b8u815b337836a4b2c6@mail.gmail.com>		<4A373E72.4030104@gmail.com>
	<4A37A343.9000106@sdgsystems.com>		<4A37A622.5050507@gmail.com>	<6f7de2b00906161221l684f3cb2ra3831f2a4eec50e3@mail.gmail.com>
	<4A4DA584.7080402@gmail.com>
Message-ID: <4B7CC814.5080402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote, On 07/03/2009 02:30 AM:
> Matt Reimer wrote:
>> On Tue, Jun 16, 2009 at 7:03 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>>
>>> Aric D. Blumer wrote:
>>>> Eric Miao wrote:
>>>>
>>>>>> Matt Reimer wrote:
>>>>>>
>>>>>>>> Close a race condition that could result in the last 32 bytes not
>>>>>>>> being transferred:
>>>>>>>>
>>>>>>>> . . .
>>>>>> Mmm... sounds reasonable (though I didn't observe this on PXA320 yet).
>>>>>>
>>>>>>>> Fix this by not calling pxamci_data_done() until the DMA channel
>>> stops.
>>>>>> The patch - however - I'm not sure if DATA_TRAN_DONE happens only for
>>>>>> READ (sounds like a WRITE will also trigger DATA_TRAN_DONE?)
>>>>>>
>>>> You are correct; it does happen for writes too.  Looks like we need to
>>>> take that into account somehow, because we're probably introducing a
>>>> race with writes now:  The DMA finishes and turns off the SD clock
>>>> possibly before the transaction occurs across the SD bus.  It's not
>>>> clear to me from the documentation if the MMC controller will finish
>>>> the transaction before turning off the clock.  Either way, the code
>>>> should be cleaner to guarantee that it doesn't.
>>>>
>>> A quick solution would be waiting for DMA to stop in pxamci_data_done()
>>> if it's a read - though not clean enough as using STOPIRQEN.
>>>
>>>
>> How about the attached patch? I've been running a test reading and writing a
>> 79M file for over an hour without a failure. I'll let it run a while and
>> report back if there are any problems.
>>
>> Matt
>>
> 
> Hi Matt,
> 
> Sorry for the long long latency. This patch doesn't apply to the latest
> tree however - could you take a look and make this refreshed?
> 
> Thanks
> - eric
> 

I am sorry to bring this back up again but it looks like this patch died
without a resolution that made it into mainline. I am working on an
issue with a PXA 270 that looks identical to this. However, this patch
still does not apply cleanly and causes other problems.

I have a platform where I can cause this issue within minutes. For some
reason, running an web server serving pages off a read-only SD mount and
serving a large file across a Bluetooth network connection brings out
the worst of this bug.

The first problem with this patch is calling data_done from dma_irq
breaks the synchronization. If the DMA interrupt comes before the
END_CMD_RES interrupt (which is normally does for me), then data_done is
called before cmd_done. This either causes cmd_done to not disable the
DATA_DONE interrupt (when called from pxamci_irq but after request_done
sets cmd == NULL) or a WARN_ON if start_cmd is called from data_done to
start processing another command.

The second problem is that the slab corruption patch which I submitted
[1] causes short messages to fail. If the algorithm assumes that all
messages are DMA, then things fall down when using PIO. I would like to
reconcile these two patches and see if we can get these issues fixed and
upstream.

For an immediate fix, the simplest thing is to add a busy-wait inside
data_done to wait for the DMA to stop [2]. From my testing, this wait
takes ~3 usec at the most.

If anyone has any good ideas, let's have them. I'll try to carve out
some time to follow this through if we can agree on a solution.

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/41288

[2] the patch:
*** src.cache/drivers/mmc/host/pxamci.c.orig    2010-02-17
18:54:54.000000000 -0500
--- src.cache/drivers/mmc/host/pxamci.c 2010-02-17 23:33:37.000000000 -0500
@@ -322,6 +307,10 @@ static int pxamci_data_done(struct pxamc
        }
    }
    else {
+       // make sure DMA is finished
+       while (!(DCSR(host->dma) & DCSR_STOPSTATE)) {
+           udelay(1);
+       }
        DCSR(host->dma) = 0;
        dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
                 host->dma_dir);


-- 
Regards,
 Vernon Sauder
