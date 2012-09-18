From: robherring2@gmail.com (Rob Herring)
Date: Tue, 18 Sep 2012 07:00:26 -0500
Subject: [PATCH v2] ARM: l2x0: make background cache ops optional for
 clean and flush range
In-Reply-To: <20120918082127.GA5990@arm.com>
References: <1347306334-781-1-git-send-email-robherring2@gmail.com>
 <1347890398-22088-1-git-send-email-robherring2@gmail.com>
 <20120917194733.GQ12245@n2100.arm.linux.org.uk> <5057881A.9020604@gmail.com>
 <20120917214732.GR12245@n2100.arm.linux.org.uk> <5057DFEB.40101@gmail.com>
 <20120918082127.GA5990@arm.com>
Message-ID: <5058625A.9060103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2012 03:21 AM, Catalin Marinas wrote:
> On Tue, Sep 18, 2012 at 03:43:55AM +0100, Rob Herring wrote:
>> On 09/17/2012 04:47 PM, Russell King - ARM Linux wrote:
>>> On Mon, Sep 17, 2012 at 03:29:14PM -0500, Rob Herring wrote:
>>>> On 09/17/2012 02:47 PM, Russell King - ARM Linux wrote:
>>>>> (a) you're not describing hardware, you're describing a feature of the
>>>>>     Linux kernel's implementation - no, you're describing a configuration
>>>>>     feature of the kernel.  This should not be in DT.
>>>>> (b) you're disabling the optimization to avoid doing a lengthy line-by-line
>>>>>     cache operation when the size is larger than the cache size, and trading
>>>>>     it for possibly slightly quicker accesses.
>>>>>
>>>>> The problem I have with this is it's likely that you've only looked at
>>>>> "oh, this makes IO accesses faster" and not the total picture wrt the
>>>>> effect on time taken by the DMA API.
>>>>
>>>> I could easily "fix" this in the xgmac driver by using __raw_writel or
>>>> writel_relaxed, but that would break non-coherent operation which does
>>>> need the L2 cache barriers.
>>>
>>> Note that in many cases, drivers do not need a barrier before every write
>>> or after every read operation.
>>>
>>> In terms of L2 coherency, the only time that L2 actually needs to be
>>> touched is when your MMIO access provokes the device to read from memory.
>>> Most accesses do not.
>>
>> Agreed. The current approach is a bit of a sledge hammer for relatively
>> few places that need it.
>>
>>> The solution - using the relaxed MMIO accessors, not fiddling around
>>> with the L2 cache code.
>>
>> I have done that in critical paths as well. As I explained in my
>> response to Catalin, too many barriers is not my problem. The network
>> transmit path is a single writel and one explicit wmb already. Using
>> relaxed accessors will only make both wmb's explicit. I still need them
>> at least for the L1 in the coherent case. Even if I'm coherent, I still
>> have to ensure the order the DMA descriptors are written and the order
>> of DMA descriptor writes with the DMA poll register write. But there are
>> not any universal L1 only barriers.
>>
>> The sequence is like this:
>> Write out N DMA descriptors
>> barrier
>> Write 1st DMA descriptor's ready bit
>> barrier
>> Write DMA poll register
>>
>> For non-coherent, the barrier needs to be a dsb and L2 sync. For
>> coherent, this only really needs to be a dsb. Removal of the spinlock is
>> enough to make the L2 sync a don't care.
> 
> Is your platform coherent for all devices? You could override the
> outer_sync() to be a no-op. You wouldn't need it for other operations
> and DSB is enough.

No. coherency is per device and PCI is never coherent.

>>> However, there's an in-built problem here - which I'm told of by PowerPC
>>> folk.  Apparantly, Linus refuses to accept that anyone needs relaxed MMIO
>>> accessors and essentially says "all platforms must behave like x86 does".
>>> I don't actually know Linus' real position, or what his position would be
>>> if he new that without relaxed accessors, we have to do a very time
>>> consuming operation...  It might be worth broaching the subject of true
>>> relaxed MMIO accessors again.
>>>
>>> The only issue with that approach is getting people who don't have the
>>> problem (iow, x86 driver authors) to understand this issue - and that's
>>> where I absolutely agree with Linus' apparant position...
>>
>> Also, how much of this knowledge should be in the driver? While I really
>> don't care if the xgmac driver works in non-coherent mode, that's
>> clearly not going to be acceptable. Differences between coherent or
>> non-coherent need to stay abstracted out of the drivers.
> 
> I agree. So you either change outer_sync() for your platform if it is
> fully coherent or improve the DMA API (the latter requiring wider
> acceptance, though it has more benefits).
> 
> Dropping the locks in cache-l2x0.c is not the right solution. It seems
> that you don't actually need the L2 cache sync for your device at all.

You had the same solution removing all the spinlocks before the
background flushes got added to the range operations.

It is quite sad that a register access on CortexA9 is a spinlock and a
register write in addition to the actually access. Why do I have to pay
that penalty when I'll never do >4MB buffer flushes?

Rob
