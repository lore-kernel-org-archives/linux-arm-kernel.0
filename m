From: ccross@android.com (Colin Cross)
Date: Mon, 13 Jun 2011 11:20:34 -0700
Subject: [PATCH] ARM: mm: cache-l2x0: Add support for re-enabling l2x0
In-Reply-To: <20110613101942.GA7924@e102568-lin.cambridge.arm.com>
References: <1307926019-28958-1-git-send-email-ccross@android.com>
	<20110613101942.GA7924@e102568-lin.cambridge.arm.com>
Message-ID: <BANLkTingENSjDaE7O+Lb6P=ED4JtuJY1jkV25b3SW6RhsOQQkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 3:19 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Mon, Jun 13, 2011 at 01:46:58AM +0100, Colin Cross wrote:
>> Remove __init annotation from l2x0_init so it can be used to
>> reinitialize the l2x0 after it has been reset during suspend.
>>
>> Only print the init messages the first time l2x0_init is called.
>>
>> Add l2x0_enable to re-enable the l2x0 after l2x0_disable if
>> the l2x0 was not reset.
>>
>> l2x0_disable cannot use writel, as writel calls wmb(), and wmb()
>> may call outer_cache_sync, which takes the same spinlock as
>> l2x0_disable.
>>
>> Signed-off-by: Colin Cross <ccross@android.com>
>> ---
>> ?arch/arm/include/asm/hardware/cache-l2x0.h | ? ?3 ++-
>> ?arch/arm/mm/cache-l2x0.c ? ? ? ? ? ? ? ? ? | ? 18 ++++++++++++++----
>> ?2 files changed, 16 insertions(+), 5 deletions(-)
>>
>
> [...]
>
>> +/* enables l2x0 after l2x0_disable, does not invalidate */
>> +void l2x0_enable(void)
>> +{
>> + ? ? unsigned long flags;
>> +
>> + ? ? spin_lock_irqsave(&l2x0_lock, flags);
>> + ? ? writel_relaxed(1, l2x0_base + L2X0_CTRL);
>> + ? ? spin_unlock_irqrestore(&l2x0_lock, flags);
>> +}
>> +
>> ?static void l2x0_disable(void)
>> ?{
>> ? ? ? unsigned long flags;
>>
>> ? ? ? spin_lock_irqsave(&l2x0_lock, flags);
>> - ? ? writel(0, l2x0_base + L2X0_CTRL);
>> + ? ? writel_relaxed(0, l2x0_base + L2X0_CTRL);
>> ? ? ? spin_unlock_irqrestore(&l2x0_lock, flags);
>> ?}
>
> This function is still dodgy to use, since we are disabling L2
> possibly with current function stack lines allocated, which might wreak havoc.


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.23.1307989246.24103.linux-arm-kernel@lists.infradead.org>

working with) flushes on disable.  I had a problem where reads with
the cache disabled were getting incorrect data because the data was
stuck in the cache.  With the CPU paused, I disabled the PL310 with
the L2X0_CTRL register, and my data appeared in memory.  I'll try to
find some documentation to support this.

Otherwise, wouldn't a flush_cache_all() and l2x0_flush_all() in
l2x0_disable() ensure the stack lines were flushed out?  Probably
needs a readl_releaxed as well, to ensure the disable has taken
effect.

>>
>> -void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask=
)
>> +void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>> =A0{
>> =A0 =A0 =A0 __u32 aux;
>> =A0 =A0 =A0 __u32 cache_id;
>> @@ -340,7 +350,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_=
val, __u32 aux_mask)
>> =A0 =A0 =A0 outer_cache.disable =3D l2x0_disable;
>> =A0 =A0 =A0 outer_cache.set_debug =3D l2x0_set_debug;
>>
>> - =A0 =A0 printk(KERN_INFO "%s cache controller enabled\n", type);
>> - =A0 =A0 printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%=
08x, Cache size: %d B\n",
>> + =A0 =A0 pr_info_once("%s cache controller enabled\n", type);
>> + =A0 =A0 pr_info_once("l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x,=
 Cache size: %d B\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ways, cache_id, aux, l2x0_si=
ze);
>> =A0}
>
> We might still need hooks to save/restore PL310 context since registers
> like tag and data RAM control are gone on reset. Furthermore, on L2 RAM
> retention we want to reinit L2 without having to invalidate L2 RAM(s),
> which means we cannot use l2x0_init as it is. I added a couple of hooks t=
o
> outer_cache in order to carry out this task, patch coming.

I'm assuming that every platform has a function to set up the tag ram
control the way they want them, which then calls l2x0_init.  That
platform cache init function can be called instead of directly calling
l2x0_init from the resume path.

Calling l2x0_enable instead of l2x0_init solves the retention problem.

> Lorenzo
>
>
