From: javi.merino@arm.com (Javi Merino)
Date: Fri, 09 Dec 2011 11:58:40 +0000
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <4EDFD278.9090101@arm.com>
References: <4E8C5425.80303@arm.com>
 <1317892206-3600-1-git-send-email-javi.merino@arm.com>
 <CAJuYYwTXf-XU0fdGT0+sggN-MEY3v7UHkfjNkM4+QUW464J9Ew@mail.gmail.com>
 <4EB7B79A.2020004@arm.com> <000c01ccada6$f83f5be0$e8be13a0$%kim@samsung.com>
 <4ED3B89E.7070903@arm.com> <000e01ccae48$d76a7ba0$863f72e0$%kim@samsung.com>
 <4ED4AB9A.3060807@arm.com>
 <CAJe_Zhem0yTOV4L-kJ91fQN++hFzCUgjOfxSnJR25PuYNTedVQ@mail.gmail.com>
 <03f001ccb4b5$3441f5c0$9cc5e140$%kim@samsung.com> <4EDF3989.3060108@arm.com>
 <4EDFD278.9090101@arm.com>
Message-ID: <4EE1F7F0.70107@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/11 20:54, Javi Merino wrote:
> On 07/12/11 10:01, Javi Merino wrote:
>> On 07/12/11 07:52, Kukjin Kim wrote:
>>> Jassi Brar wrote:
>>>> On 29 November 2011 15:23, Javi Merino <javi.merino@arm.com> wrote:
>>>>>>>>>> On Samsung's Exynos4 platform, while testing audio playback with
>>>>>>> i2s
>>>>>>>>>> interface, the above change causes the playback to freeze. The
>>>>>>>>>> _thrd_active(thrd) call always returns '1' and hence _start(thrd)
>>>>>>> is
>>>>>>>>>> not getting called.
>>>>>>>>>
>>>>>>>> Your patch makes the memcpy operation on dmatest.c and net DMA be
>>>>>>> frozen too
>>>>>>>> as well as Samsung audio playback.
>>>>>>>
>>>> Javi, could you please check if you too get the memcpy failure with
>>>> dmatest ?
>>>
> Ok, I think I've just reproduced it in my end with the kernel's dmatest
> module.  After the first transaction it looks like the dma test wasn't
> able to issue any more transactions.  I'll have a look at it tomorrow
> and try to answer my own questions ;)

The problem is that pl330_submit_req() always puts the request in buffer 0 if
both buffers are free.

If you submit a transaction, it finishes and there's nothing else to run,
pl330_update() calls _start() but there is nothing to send.  This is all
right.  Then, if another transaction is submitted, pl330_submit_req() will
put it in buffer 0 again.  This time, the PC of the DMA is in the last
instruction of buffer 0 (the DMAEND of the *previous* transaction that
finished long ago) so _thrd_active() thinks that this buffer is active,
which makes pl330_chan_ctrl() not start the transaction and hence, the DMA
freezes.

I believe something like the following should fix it:

--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -1301,7 +1301,7 @@ int pl330_submit_req(void *ch_id, struct pl330_req *r)
 		goto xfer_exit;
 	}
 
-	idx = IS_FREE(&thrd->req[0]) ? 0 : 1;
+	idx = IS_FREE(&thrd->req[1 - thrd->lstenq]) ? 1 - thrd->lstenq : thrd->lstenq;
 
 	xs.ccr = ccr;
 	xs.r = r;


I have only tested this with a single-channel single-thread dma test.
I'll send a proper patch to the list once I've done more testing.

Cheers,
Javi
