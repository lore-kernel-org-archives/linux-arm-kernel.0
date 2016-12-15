From: labbott@redhat.com (Laura Abbott)
Date: Wed, 14 Dec 2016 16:56:40 -0800
Subject: [PATCH] arm: Adjust memory boundaries after reservations
In-Reply-To: <20161214235827.GI14217@n2100.armlinux.org.uk>
References: <1481681501-13788-1-git-send-email-labbott@redhat.com>
 <20161214235827.GI14217@n2100.armlinux.org.uk>
Message-ID: <5c60b53f-c4a1-8649-45d6-4aab6e0f32c5@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2016 03:58 PM, Russell King - ARM Linux wrote:
> On Tue, Dec 13, 2016 at 06:11:41PM -0800, Laura Abbott wrote:
>> The poorly named sanity_check_meminfo is responsible for setting up the
>> boundary for lowmem/highmem. This needs to be set up before memblock
>> reservations can occur. At the time memblock reservations can occur,
>> memory can also be removed from the system. This can throw off the
>> calculation of the lowmem/highmem boundary. On some systems this may be
>> harmless, on others this may result in incorrect ranges being passed to
>> the main memory allocator. Correct this by recalcuating the
>> lowmem/highmem boundary after all reservations have been made.
>> As part of this, rename sanity_check_meminfo to actually refect what the
>> function is doing.
> 
> I think this needs more explanation - after reading that, I'm left
> wondering wtf is going on...
> 
> Let's say that the memory boundary was at 0x30000000.  Memory from
> 0x2f000000 to 0x30000000 is stolen, which reserves it and removes
> it from the available memory.
> 
> Since the memory is no longer available, why would the stolen range
> end up being passed to the main memory allocator?
> 
> How is this any different from the boot loader omitting the memory
> range in the first place?
> 

The issue ends up coming in with find_limits

static void __init find_limits(unsigned long *min, unsigned long *max_low,
                               unsigned long *max_high)
{
        *max_low = PFN_DOWN(memblock_get_current_limit());
        *min = PFN_UP(memblock_start_of_DRAM());
        *max_high = PFN_DOWN(memblock_end_of_DRAM());
}


the memblock limit never gets updated after removal but memblock_end_of_DRAM
does. When the last block of ram is removed, the end of DRAM ends up being
lower than the limit. On the i.MX system with a small amount of ram but
CONFIG_HIGHMEM enabled, this ends up with an incorrect calculation for
the amount of ram to go in the highmem zone in zone_sizes_init.

Thanks,
Laura
