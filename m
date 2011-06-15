From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 15 Jun 2011 12:05:51 +0530
Subject: [PATCH] ARM: mm: cache-l2x0: Add support for re-enabling l2x0
In-Reply-To: <20110614173013.GA9234@e102568-lin.cambridge.arm.com>
References: <1307926019-28958-1-git-send-email-ccross@android.com>
	<20110613101942.GA7924@e102568-lin.cambridge.arm.com>
	<BANLkTingENSjDaE7O+Lb6P=ED4JtuJY1jkV25b3SW6RhsOQQkw@mail.gmail.com>
	<20110614173013.GA9234@e102568-lin.cambridge.arm.com>
Message-ID: <4DF852C7.6000904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/14/2011 11:00 PM, Lorenzo Pieralisi wrote:
> On Mon, Jun 13, 2011 at 07:20:34PM +0100, Colin Cross wrote:
>> On Mon, Jun 13, 2011 at 3:19 AM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com>  wrote:
>>> On Mon, Jun 13, 2011 at 01:46:58AM +0100, Colin Cross wrote:
>>>> Remove __init annotation from l2x0_init so it can be used to
>>>> reinitialize the l2x0 after it has been reset during suspend.
>>>>
>>>> Only print the init messages the first time l2x0_init is called.
>>>>
>>>> Add l2x0_enable to re-enable the l2x0 after l2x0_disable if
>>>> the l2x0 was not reset.
>>>>
>>>> l2x0_disable cannot use writel, as writel calls wmb(), and wmb()
>>>> may call outer_cache_sync, which takes the same spinlock as
>>>> l2x0_disable.
>>>>
>>>> Signed-off-by: Colin Cross<ccross@android.com>
>>>> ---
>>>> ?arch/arm/include/asm/hardware/cache-l2x0.h | ? ?3 ++-
>>>> ?arch/arm/mm/cache-l2x0.c ? ? ? ? ? ? ? ? ? | ? 18 ++++++++++++++----
>>>> ?2 files changed, 16 insertions(+), 5 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> +/* enables l2x0 after l2x0_disable, does not invalidate */
>>>> +void l2x0_enable(void)
>>>> +{
>>>> + ? ? unsigned long flags;
>>>> +
>>>> + ? ? spin_lock_irqsave(&l2x0_lock, flags);
>>>> + ? ? writel_relaxed(1, l2x0_base + L2X0_CTRL);
>>>> + ? ? spin_unlock_irqrestore(&l2x0_lock, flags);
>>>> +}
>>>> +
>>>> ?static void l2x0_disable(void)
>>>> ?{
>>>> ? ? ? unsigned long flags;
>>>>
>>>> ? ? ? spin_lock_irqsave(&l2x0_lock, flags);
>>>> - ? ? writel(0, l2x0_base + L2X0_CTRL);
>>>> + ? ? writel_relaxed(0, l2x0_base + L2X0_CTRL);
>>>> ? ? ? spin_unlock_irqrestore(&l2x0_lock, flags);
>>>> ?}
>>>
>>> This function is still dodgy to use, since we are disabling L2
>>> possibly with current function stack lines allocated, which might wreak havoc.
>>
>>  From my JTAG debugging, I think the PL310 (at least the one I'm
>> working with) flushes on disable.  I had a problem where reads with
>> the cache disabled were getting incorrect data because the data was
>> stuck in the cache.  With the CPU paused, I disabled the PL310 with
>> the L2X0_CTRL register, and my data appeared in memory.  I'll try to
>> find some documentation to support this.
>>
>
> According to the PL310 TRM (r3p2 3-9) on disable the PL310 syncs, which means
> it flushes internal buffers, but it is not supposed to clean dirty lines.
> It seems unsafe to me to use the stack and other cacheable data right before
> disabling.
>
That's right. Disabling L2 won't clean the cache lines. They need
to be cleaned before entering low power state where you loose
it.
Though, cleaning of L2 cache would work even with L2 enable
is not set.
