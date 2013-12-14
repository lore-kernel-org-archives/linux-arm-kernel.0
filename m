From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 13 Dec 2013 19:52:42 -0500
Subject: [PATCH v3 08/23] mm/memblock: Add memblock memory allocation apis
In-Reply-To: <20131213213735.GM27070@htj.dyndns.org>
References: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
 <1386625856-12942-9-git-send-email-santosh.shilimkar@ti.com>
 <20131213213735.GM27070@htj.dyndns.org>
Message-ID: <52ABABDA.4020808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 December 2013 04:37 PM, Tejun Heo wrote:
> On Mon, Dec 09, 2013 at 04:50:41PM -0500, Santosh Shilimkar wrote:
>> Introduce memblock memory allocation APIs which allow to support
>> PAE or LPAE extension on 32 bits archs where the physical memory
>> start address can be beyond 4GB. In such cases, existing bootmem
>> APIs which operate on 32 bit addresses won't work and needs
>> memblock layer which operates on 64 bit addresses.
> 
> The overall API looks good to me.  Thanks for doing this!
> 
>> +static void * __init memblock_virt_alloc_internal(
>> +				phys_addr_t size, phys_addr_t align,
>> +				phys_addr_t min_addr, phys_addr_t max_addr,
>> +				int nid)
>> +{
>> +	phys_addr_t alloc;
>> +	void *ptr;
>> +
>> +	if (nid == MAX_NUMNODES)
>> +		pr_warn("%s: usage of MAX_NUMNODES is depricated. Use NUMA_NO_NODE\n",
>> +			__func__);
> 
> Why not use WARN_ONCE()?  Also, shouldn't nid be set to NUMA_NO_NODE
> here?
> 
You want all the users using MAX_NUMNODES to know about it so that
the wrong usage can be fixed. WARN_ONCE will hide that.

> ...
>> +	if (nid != NUMA_NO_NODE) {
> 
> Otherwise, the above test is broken.
> 
So the idea was just to warn the users and allow them to fix
the code. Well we are just allowing the existing users of using
either MAX_NUMNODES or NUMA_NO_NODE continue to work. Thats what
we discussed, right ?
