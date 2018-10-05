From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Fri, 5 Oct 2018 09:20:09 -0600
Subject: [RFC PATCH 0/2] ACPI / PPTT: ids for caches
In-Reply-To: <20181005150235.13846-1-james.morse@arm.com>
References: <20181005150235.13846-1-james.morse@arm.com>
Message-ID: <da8a4ae0-b63c-d27f-1f54-af19f058881c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/5/2018 9:02 AM, James Morse wrote:
> Hi guys,
> 
> To get resctrl working on arm64, we need to generate 'id's for caches.
> This is this value that shows up in, e.g.:
> | /sys/devices/system/cpu/cpu0/cache/index3/id
> 
> This value needs to be unique for each level of cache, but doesn't
> need to be contiguous. (there may be gaps, it may not start at 0).
> Details in Documentation/x86/intel_rdt_ui.txt::Cache IDs
> 
> resctrl receives these values back via its schemata file. e.g.:
> | echo "L3:0=fff;1=fff" > /sys/fs/resctrl/p1/schemata
> Where 0 and 1 are the ids of two caches in the system.
> 
> These values become ABI, and are likely to be baked into shell scripts.
> We want a value that is the same over reboots, and should be the same
> on identical hardware, even if the PPTT is generated in a different
> order. The hardware doesn't give us any indication of which caches are
> shared, so this information must come from firmware tables.
> 
> This series generates an id from the PPTT topology, based on the lowest
> MPIDR of the cpus that share a cache.
> 
> The remaining problems with this approach are:
>   * the 32bit ID field is full of MPIDR.Aff{0-3}. We don't have space to
>     hide 'i/d/unified', so can only generate ids for unified caches. If we
>     ever get an Aff4 (plenty of RES0 space in there) we can no longer generate
>     an id. Having all these bits accounted for in the initial version doesn't
>     feel like a good ABI choice.
> 
> * Existing software is going to assume caches are numbered 0,1,2. This was
>    documented as not guaranteed, and its likely never going to be the case
>    if we generate ids like this.
> 
> * The table walk is recursive.
> 
> 
> Fixes for the first two require extra-code to compact the ID range, which would
> require us generating all the IDs up front, not from hotplug callbacks as has
> to happen today.
> 
> Alternatively, we could try and change the abi to provide a u64 as the
> cache id. The size isn't documented, and for resctrl userspace can treat
> it as a string.
> 
> Better ideas welcome!

I'm sorry, I'm not familiar with this resctrl, and therefore I don't 
quite feel like I have a handle on what we need out of the ids file (and 
the Documentation you pointed to doesn't seem to clarify it for me).

Lets assume we have a trivial 4 core system.  Each core has a private 
L1i and L1d cache.  Cores 0/1 and 2/3 share a L2.  Cores 0-3 share L3.

If we are assigning ids in the range 1-N, what might we expect the id of 
each cache to be?

Is this sane (each unique cache instance has a unique id), or have I 
misunderstood?
CPU0 L1i - 1
CPU0 L1d - 2
CPU1 L1i - 3
CPU1 L1d - 4
CPU2 L1i - 5
CPU2 L1d - 6
CPU3 L1i - 7
CPU3 L1d - 8
CPU0/1 L2 - 9
CPU2/3 L2 - 10
        L3 - 11

-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
