From: javi.merino@arm.com (Javi Merino)
Date: Mon, 28 Nov 2011 16:36:46 +0000
Subject: [PATCH v2] ARM: pl330: Fix a race condition
In-Reply-To: <000c01ccada6$f83f5be0$e8be13a0$%kim@samsung.com>
References: <4E8C5425.80303@arm.com>
 <1317892206-3600-1-git-send-email-javi.merino@arm.com>
 <CAJuYYwTXf-XU0fdGT0+sggN-MEY3v7UHkfjNkM4+QUW464J9Ew@mail.gmail.com>
 <4EB7B79A.2020004@arm.com> <000c01ccada6$f83f5be0$e8be13a0$%kim@samsung.com>
Message-ID: <4ED3B89E.7070903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/11 08:23, Boojin Kim wrote:
> Javi Merino wrote:
> 
>>> On Samsung's Exynos4 platform, while testing audio playback with i2s
>>> interface, the above change causes the playback to freeze. The
>>> _thrd_active(thrd) call always returns '1' and hence _start(thrd) is
>>> not getting called.
>>
>> If _thrd_active(thrd) returns '1', that means there is an active
>> transfer still running or, if it has finished, you haven't called
>> pl330_update() to acknowledge that.  pl330_update() calls _start() as
>> soon as it can.
>>
>> drivers/dma/pl330.c registers the irq handler in pl330_probe(), so
>> when
>> the transaction finishes, pl330_update() should clear it and call
>> _start().  If there is any outstanding transaction, it should start
>> straight away. If there isn't, it would mark the channel as free, so
>> _thrd_active() should return '0'.  If _thrd_active() is still '1', then
>> something has gone wrong in the way.
>>
>> Does this shed some light?
>>
> 
> Your patch makes the memcpy operation on dmatest.c and net DMA be frozen too
> as well as Samsung audio playback.

Is the IRQ correctly registered in drivers/dma/pl330.c:pl330_probe()?
Do you get interrupts when the transfer finish?

The only way I can think of that
ee3f615819404a9438b2dd01b7a39f276d2737f2 can break break something is
that you aren't calling pl330_update() at all.

> With our patch, common DMA memcpy sequence may be changed.

Which one is "our patch"?  I'm sorry, I'm not subscribed to any of the
lists so I may have missed something.

Cheers,
Javi
