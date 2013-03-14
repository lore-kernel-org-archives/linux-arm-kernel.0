From: smoch@web.de (Soeren Moch)
Date: Thu, 14 Mar 2013 21:22:46 +0100
Subject: [PATCH] USB: EHCI: fix for leaking isochronous data
In-Reply-To: <51421B89.6020308@web.de>
References: <Pine.LNX.4.44L0.1303101638330.3146-100000@netrider.rowland.org>
 <51421B89.6020308@web.de>
Message-ID: <51423196.6090907@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.03.2013 19:48, Soeren Moch wrote:
> On 10.03.2013 21:59, Alan Stern wrote:
>> On Sun, 10 Mar 2013, Soeren Moch wrote:
>>>> On Wed, 20 Feb 2013, Soeren Moch wrote:
>>>>
>>>>> Ok. I use 2 em2840-based usb sticks (em28xx driver) attached to a
>>>>> Marvell Kirkwood-SoC with a orion-ehci usb controller. These usb
>>>>> sticks
>>>>> stream dvb data (digital TV) employing isochronous usb transfers (user
>>>>> application is vdr).
>>>>>
>>>>> Starting from linux-3.6 I see
>>>>>      ERROR: 1024 KiB atomic DMA coherent pool is too small!
>>>>> in the syslog after several 10 minutes (sometimes hours) of streaming
>>>>> and then streaming stops.
>>>>>
>>>>> In linux-3.6 the memory management for the arm architecture was
>>>>> changed,
>>>>> so that atomic coherent dma allocations are served from a special
>>>>> pool.
>>>>> This pool gets exhausted. The only user of this pool (in my test) is
>>>>> orion-ehci. Although I have only 10 URBs in flight (5 for each stick,
>>>>> resubmitted in the completion handler), I have 256 atomic coherent
>>>>> allocations (memory from the pool is allocated in pages) from
>>>>> orion-ehci
>>>>> when I see this error. So I think there must be a memory leak (memory
>>>>> allocated atomic somewhere below the usb_submit_urb call in
>>>>> em28xx-core.c).
>>>>>
>>>>> With other dvb sticks using usb bulk transfers I never see this error.
>>>>>
>>>>> Since you already found a memory leak in the ehci driver for isoc
>>>>> transfers, I hoped you can help to solve this problem. If there are
>>>>> additional questions, please ask. If there is something I can test, I
>>>>> would be glad to do so.
>>>>
>>>> I guess the first thing is to get a dmesg log showing the problem.  You
>>>> should build a kernel with CONFIG_USB_DEBUG enabled and post the part
>>>> of the dmesg output starting from when you plug in the troublesome DVB
>>>> stick.
>>>
>>> Sorry for my late response. Now I built a kernel 3.8.0 with usb_debug
>>> enabled. See below for the syslog of device plug-in.
>>>
>>>> It also might help to have a record of all the isochronous-related
>>>> coherent allocations and deallocations done by the ehci-hcd driver.
>>>> Are you comfortable making your own debugging changes?  The allocations
>>>> are done by a call to dma_pool_alloc() in
>>>> drivers/usb/host/ehci-sched.c:itd_urb_transaction() if the device runs
>>>> at high speed and sitd_urb_transaction() if the device runs at full
>>>> speed.  The deallocations are done by calls to dma_pool_free() in
>>>> ehci-timer.c:end_free_itds().
>>>>
>>>
>>> I added a debug message to
>>> drivers/usb/host/ehci-sched.c:itd_urb_transaction() to log the
>>> allocation flags, see log below.
>>
>> But it looks like you didn't add a message to end_free_itds(), so we
>> don't know when the memory gets deallocated.  And you didn't print out
>> the values of urb, num_itds, and i, or the value of itd (so we can
>> match up allocations against deallocations).
>
> OK, I will implement this more detailed logging. But with several
> allocations per second and runtime of several hours this will result in
> a very long logfile.
>
>>> For me this looks like nothing is
>>> allocated atomic here, so this function should not be the root cause of
>>> the dma coherent pool exhaustion.
>>
>> I don't understand.  If non-atomic allocations can't exhaust the pool,
>> why do we see these allocations fail?
>
> Good point. Unfortunately I'm not familiar with the memory management
> details.
>
> Arnd, can memory allocated with dma_pool_alloc() and gfp_flags
> 0x20000093 or 0x80000093 come from the atomic dma coherent pool?

Sorry, I logged the wrong flags. All allocations are GFP_ATOMIC (0x20) 
and therefore coming from the pool.

   Soeren

>>> Are there other allocation functions
>>> which I could track?
>>
>> Yes, but they wouldn't be used for isochronous transfers.  See
>> ehci_qtd_alloc(), ehci_qtd_free(), ehci_qh_alloc(), and qh_destroy() in
>> ehci-mem.c, as well as some other one-time-only coherent allocations in
>> that file.
>>
>> Alan Stern
>>
> Soeren Moch
