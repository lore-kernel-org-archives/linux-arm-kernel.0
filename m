From: javi.merino@arm.com (Javi Merino)
Date: Wed, 07 Dec 2011 10:01:45 +0000
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <03f001ccb4b5$3441f5c0$9cc5e140$%kim@samsung.com>
References: <4E8C5425.80303@arm.com>
 <1317892206-3600-1-git-send-email-javi.merino@arm.com>
 <CAJuYYwTXf-XU0fdGT0+sggN-MEY3v7UHkfjNkM4+QUW464J9Ew@mail.gmail.com>
 <4EB7B79A.2020004@arm.com> <000c01ccada6$f83f5be0$e8be13a0$%kim@samsung.com>
 <4ED3B89E.7070903@arm.com> <000e01ccae48$d76a7ba0$863f72e0$%kim@samsung.com>
 <4ED4AB9A.3060807@arm.com>
 <CAJe_Zhem0yTOV4L-kJ91fQN++hFzCUgjOfxSnJR25PuYNTedVQ@mail.gmail.com>
 <03f001ccb4b5$3441f5c0$9cc5e140$%kim@samsung.com>
Message-ID: <4EDF3989.3060108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/11 07:52, Kukjin Kim wrote:
> Jassi Brar wrote:
>>
>> On 29 November 2011 15:23, Javi Merino <javi.merino@arm.com> wrote:
>>>>>>>> On Samsung's Exynos4 platform, while testing audio playback with
>>>>> i2s
>>>>>>>> interface, the above change causes the playback to freeze. The
>>>>>>>> _thrd_active(thrd) call always returns '1' and hence _start(thrd)
>>>>> is
>>>>>>>> not getting called.
>>>>>>>
>>>>>>> If _thrd_active(thrd) returns '1', that means there is an active
>>>>>>> transfer still running or, if it has finished, you haven't called
>>>>>>> pl330_update() to acknowledge that.  pl330_update() calls _start()
>>>>> as
>>>>>>> soon as it can.
>>>>>>>
>>>>>>> drivers/dma/pl330.c registers the irq handler in pl330_probe(), so
>>>>>>> when
>>>>>>> the transaction finishes, pl330_update() should clear it and call
>>>>>>> _start().  If there is any outstanding transaction, it should start
>>>>>>> straight away. If there isn't, it would mark the channel as free,
>>>>> so
>>>>>>> _thrd_active() should return '0'.  If _thrd_active() is still '1',
>>>>> then
>>>>>>> something has gone wrong in the way.
>>>>>>>
>>>>>>> Does this shed some light?
>>>>>>>
>>>>>>
>>>>>> Your patch makes the memcpy operation on dmatest.c and net DMA be
>>>>> frozen too
>>>>>> as well as Samsung audio playback.
>>>>>
>>>>> Is the IRQ correctly registered in drivers/dma/pl330.c:pl330_probe()?
>>>>> Do you get interrupts when the transfer finish?
>>>> Sure. IRQ works well.
>>>
>>> Ok, so can you check if pl330_update() is correctly marking the request
>>> as free?  Do you know if there is another request in the queue when that
>>> happens?
>>>
>>> Thomas, you said in a previous email that _thrd_active() always returned
>>> '1'.  Was that after a request in req[0] finished?
>>>  - If so, can you check that MARK_FREE was actually called for that
>>>    request in pl330_update()?
>>>  - If it was after a request in req[1] finished and there was a
>>>    request already waiting in req[0], can you debug why _start()
>>>    didn't activate it.
>>>
>> Javi, could you please check if you too get the memcpy failure with
>> dmatest ?
> 
> (Please adding me in this thread)
> 
> Hi Javi,
> How was going on the test? If any update, please let us know.

I'm currently very busy at work, I'll run it as soon as I can.  This
appears to happen only in exynos, can't anybody else help with the
debugging?

Cheers,
Javi
