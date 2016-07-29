From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 29 Jul 2016 11:33:00 +0200
Subject: SPI: performance regression when using the common message queuing
 infrastructure
In-Reply-To: <57959ADD.40700@denx.de>
References: <577CD464.6050506@atmel.com> <577CD767.2080309@ti.com>
 <577E0EF3.6000308@atmel.com> <57959ADD.40700@denx.de>
Message-ID: <41cb8a2a-7138-d2c0-e668-6c03add1882e@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Le 25/07/2016 ? 06:51, Heiko Schocher a ?crit :
> Hello Cyrille,
> 
> sorry for the late answer, but just back from holidays ...
> 
> Am 07.07.2016 um 10:12 schrieb Cyrille Pitchen:
>> Hi Grygorii,
>>
>> Le 06/07/2016 12:03, Grygorii Strashko a ?crit :
>>> On 07/06/2016 12:50 PM, Cyrille Pitchen wrote:
>>>> Hi Mark,
>>>>
>>>> recently Heiko reported to us a performance regression with Atmel SPI
>>>> controllers. He noticed the issue on a sam9g15ek board and I was also able to
>>>> reproduce it on a sama5d36ek board.
>>>>
>>>> We found out that the performance regression was introduced in 3.14 by commit:
>>>> 8090d6d1a415d3ae1a7208995decfab8f60f4f36
>>>> spi: atmel: Refactor spi-atmel to use SPI framework queue
>>>>
>>>> For the test, I connected a Spansion S25FL512 memory on the SPI1 controller of
>>>> a sama5d36ek board. Then with an oscilloscope I monitored the chip-select, clock
>>>> and MOSI signals on the SPI bus.
>>>>
>>>>
>>>> 1 - Reading 512 bytes from the memory
>>>>
>>>> # dd if=/dev/mtd6 bs=512 count=1 of=/dev/null
>>>>
>>>> With the oscilloscope, I measured the time between the chip-select fell before
>>>> the Read Status command (05h) and the chip-select rose after all data had been
>>>> read by the 4-byte address Fast Read 1-1-1 command (13h).
>>>>
>>>> 3.14 vanilla                      : 305 ?s
>>>> 3.14 commit 8090d6d1a415 reverted : 242 ?s   -21%
>>>>
>>>> 2 - Reading 1000 x 1024 bytes from the memory
>>>>
>>>> # dd if=/dev/mtd6 bs=1024 count=1000 of=/dev/null
>>>>
>>>> Still with the scope, I measured the time to read all data.
>>>>
>>>> 3.14 vanilla                      : 435 ms
>>>> 3.14 commit 8090d6d1a415 reverted : 361 ms   -17%
>>>>
>>>>
>>>> Indeed the oscilloscope shows that more time is spent between messages and
>>>> transfers.
> 
> Yes this fits with my observations.
> 
>>>> commit 8090d6d1a415 replaced the tasklet used to manage a SPI message/transfer
>>>> queue by a workqueue provided by the SPI framework.
>>>>
>>>> The support of this (optional) workqueue was introduced by commit:
>>>> ffbbdd21329f3e15eeca6df2d4bc11c04d9d91c0
>>>> spi: create a message queuing infrastructure
>>>>
>>>> Though the commit message claims that is common infrastructure is optional,
>>>> the patch also claims the .transfer() hook is deprecated, suggesting drivers
>>>> should implement the new .transfer_one_message() hook instead.
>>>>
>>>> This is the reason why commit 8090d6d1a415 was submitted. However we lost
>>>> quite amount of performances moving from our tasklet to the generic workqueue.
>>>>
>>>> So do you recommend us to keep our current generic implementation relying on
>>>> the SPI framework workqueue or to go back to a custom implementation using
>>>> tasklet?
>>>> If we keep the current implementation, is there a way to improve the
>>>> performances so we go back to something close to what he had before?
>>>>
>>>> We saw in commit ffbbdd21329f that we can change the workqueue thread
>>>> scheduling policy to SCHED_FIFO by setting master->rt.
>>>>
>>>
>>> master->rt is not a good choice as i know and
>>> you may find thread [1] useful for you.
>>>
>>> [1] http://www.spinics.net/lists/linux-rt-users/msg14347.html
>>>
>>
>> thanks for the link, I'll look at it :)
> 
> Thanks for digging into this issue and your tests!
> 
> Do you have some new results? Can I help you?
> 
> bye,
> Heiko


We talked about moving back to a tasklet implementation but nothing was done
yet so nothing new for now, sorry.
Also, I will be out of office for the next 3 weeks: I will be back on August,
22th.


Best regards,

Cyrille
