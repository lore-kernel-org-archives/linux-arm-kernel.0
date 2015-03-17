From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 Mar 2015 17:32:02 -0700
Subject: [PATCH 2/5] ARM: Add Broadcom Brahma-B15 readahead cache support
In-Reply-To: <20150317001056.GR8656@n2100.arm.linux.org.uk>
References: <1425689693-31034-1-git-send-email-f.fainelli@gmail.com>
 <1425689693-31034-3-git-send-email-f.fainelli@gmail.com>
 <20150316210251.GP8656@n2100.arm.linux.org.uk> <55074935.9020805@gmail.com>
 <20150317001056.GR8656@n2100.arm.linux.org.uk>
Message-ID: <55077602.1090908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/15 17:10, Russell King - ARM Linux wrote:
> On Mon, Mar 16, 2015 at 02:20:53PM -0700, Florian Fainelli wrote:
>> On 16/03/15 14:02, Russell King - ARM Linux wrote:
>>> On Fri, Mar 06, 2015 at 04:54:50PM -0800, Florian Fainelli wrote:
>>>> This patch adds support for the Broadcom Brahma-B15 CPU readahead cache
>>>> controller. This cache controller sits between the L2 and the memory bus
>>>> and its purpose is to provide a friendler burst size towards the DDR
>>>> interface than the native cache line size.
>>>>
>>>> The readahead cache is mostly transparent, except for
>>>> flush_kern_cache_all, flush_kern_cache_louis and flush_icache_all, which
>>>> is precisely what we are overriding here.
>>>>
>>>> The readahead cache only intercepts reads, not writes, as such, some
>>>> data can remain stale in any of its buffers, such that we need to flush
>>>> it, which is an operation that needs to happen in a particular order:
>>>>
>>>> - disable the readahead cache
>>>> - flush it
>>>> - call the appropriate cache-v7.S function
>>>> - re-enable
>>>>
>>>> This patch tries to minimize the impact to the cache-v7.S file by only
>>>> providing a stub in case CONFIG_CACHE_B15_RAC is enabled (default for
>>>> ARCH_BRCMSTB since it is the current user).
>>>>
>>>> Signed-off-by: Alamy Liu <alamyliu@broadcom.com>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> ---
>>
>> [snip]
>>
>>>> +/* Bitmask to enable instruction and data prefetching with a 256-bytes stride */
>>>> +#define RAC_DATA_INST_EN_MASK		(1 << RACPREFINST_SHIFT | \
>>>> +					 RACENPREF_MASK << RACENINST_SHIFT | \
>>>> +					 1 << RACPREFDATA_SHIFT | \
>>>> +					 RACENPREF_MASK << RACENDATA_SHIFT)
>>>> +
>>>> +#define RAC_ENABLED			(1 << 0)
>>>
>>> 					BIT(0) ?
>>>
>>> However, you don't use RAC_ENABLED as a bitmask, but a bit index, so
>>> shouldn't this be zero?
>>
>> In subsequent patches we have a need for distinguishing RAC_ENABLED from
>> RAC_SUSPENDED, so that's the primary reason for using it as a bitmask
>> (could make that clear somewhere).
> 
> However, test_bit() etc take a bit _number_ not a bit _mask_.  So:
> 
> Passing in 1 << 0 will test bit 1 rather than bit 0.
> Passing in 1 << 1 will test bit 2 rather than bit 1.
> Passing in 1 << 2 will test bit 4 rather than bit 2.
> Passing in 1 << 3 will test bit 8 rather than bit 3.
> etc.
> 
> This is not what you wanted.  Either use a mask directly, or use
> test_bit() with a bit number etc.  Don't try and do both together. :)

Fixed, thanks.

> 
>>> What happens when the system goes down (eg, for kexec?)  Does the RAC
>>> need to be disabled for that?
>>
>> Per boot convention, I would say so, yes, since this is another level of
>> instruction and data cache, we should turn it off. Can we register some
>> sort of notifier specifically for kexec?
> 
> The code at present doesn't expect there to be platform specific caches,
> so that probably isn't catered for yet.  I mentioned the point to raise
> the issue that there's an oversight here.

Since kexec goes through the usual suspend/resume path, it will suspend
the RAC by calling into syscore_suspend (patch 5), that's when
CONFIG_KERNEL_KEXEC_JUMP is set, which is not guaranteed.

kernel_restart_prepare() calls a reboot notifier with SYS_RESTART, so if
we disable the RAC at this point, we should be good, I will add that.
-- 
Florian
