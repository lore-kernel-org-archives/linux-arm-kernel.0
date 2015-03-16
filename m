From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 Mar 2015 14:20:53 -0700
Subject: [PATCH 2/5] ARM: Add Broadcom Brahma-B15 readahead cache support
In-Reply-To: <20150316210251.GP8656@n2100.arm.linux.org.uk>
References: <1425689693-31034-1-git-send-email-f.fainelli@gmail.com>
 <1425689693-31034-3-git-send-email-f.fainelli@gmail.com>
 <20150316210251.GP8656@n2100.arm.linux.org.uk>
Message-ID: <55074935.9020805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/15 14:02, Russell King - ARM Linux wrote:
> On Fri, Mar 06, 2015 at 04:54:50PM -0800, Florian Fainelli wrote:
>> This patch adds support for the Broadcom Brahma-B15 CPU readahead cache
>> controller. This cache controller sits between the L2 and the memory bus
>> and its purpose is to provide a friendler burst size towards the DDR
>> interface than the native cache line size.
>>
>> The readahead cache is mostly transparent, except for
>> flush_kern_cache_all, flush_kern_cache_louis and flush_icache_all, which
>> is precisely what we are overriding here.
>>
>> The readahead cache only intercepts reads, not writes, as such, some
>> data can remain stale in any of its buffers, such that we need to flush
>> it, which is an operation that needs to happen in a particular order:
>>
>> - disable the readahead cache
>> - flush it
>> - call the appropriate cache-v7.S function
>> - re-enable
>>
>> This patch tries to minimize the impact to the cache-v7.S file by only
>> providing a stub in case CONFIG_CACHE_B15_RAC is enabled (default for
>> ARCH_BRCMSTB since it is the current user).
>>
>> Signed-off-by: Alamy Liu <alamyliu@broadcom.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---

[snip]

>> +/* Bitmask to enable instruction and data prefetching with a 256-bytes stride */
>> +#define RAC_DATA_INST_EN_MASK		(1 << RACPREFINST_SHIFT | \
>> +					 RACENPREF_MASK << RACENINST_SHIFT | \
>> +					 1 << RACPREFDATA_SHIFT | \
>> +					 RACENPREF_MASK << RACENDATA_SHIFT)
>> +
>> +#define RAC_ENABLED			(1 << 0)
> 
> 					BIT(0) ?
> 
> However, you don't use RAC_ENABLED as a bitmask, but a bit index, so
> shouldn't this be zero?

In subsequent patches we have a need for distinguishing RAC_ENABLED from
RAC_SUSPENDED, so that's the primary reason for using it as a bitmask
(could make that clear somewhere).

[snip]

>> +#define BUILD_RAC_CACHE_OP(name, bar)				\
>> +void b15_flush_##name(void)					\
>> +{								\
>> +	unsigned int do_flush;					\
>> +	u32 val = 0;						\
>> +								\
>> +	spin_lock(&rac_lock);					\
>> +	do_flush = test_bit(RAC_ENABLED, &b15_rac_flags);	\
> 
> Do you need to use test_bit() here?  You set and test this location
> under a spinlock, so it's safe to use non-atomic ops here.

Right, we don't need the test_bit, it just felt a little nicer.

> 
>> +static void b15_rac_enable(void)
>> +{
>> +	unsigned int cpu;
>> +	u32 enable = 0;
>> +
>> +	for_each_possible_cpu(cpu)
>> +		enable |= (RAC_DATA_INST_EN_MASK << (cpu * RAC_CPU_SHIFT));
> 
> 		enable |= RAC_DATA_INST_EN_MASK << (cpu * RAC_CPU_SHIFT);
> 
> You don't need the additional parens - the right hand side of |= is
> already expected to be an expression by the compiler.
> 
>> +	spin_lock(&rac_lock);
>> +	reg = __raw_readl(b15_rac_base + RAC_CONFIG0_REG);
>> +	for_each_possible_cpu(cpu)
>> +		en_mask |= ((1 << RACPREFDATA_SHIFT) << (cpu * RAC_CPU_SHIFT));
> 
> 		en_mask |= 1 << (RACPREFDATA_SHIFT + cpu * RAC_CPU_SHIFT);
> 
> looks nicer, rather than having two shifts.

Indeed, thanks.

> 
> What happens when the system goes down (eg, for kexec?)  Does the RAC
> need to be disabled for that?

Per boot convention, I would say so, yes, since this is another level of
instruction and data cache, we should turn it off. Can we register some
sort of notifier specifically for kexec?

Thanks!
-- 
Florian
