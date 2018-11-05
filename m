From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 5 Nov 2018 12:14:16 +0000
Subject: [PATCH 0/7] arm64: capabilities: Optimize checking and enabling
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <0ea1330a-685c-b7b3-1424-1cc521a672e8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On 05/11/18 11:55, Suzuki K Poulose wrote:
> We maintain two separate tables (i.e, arm64_features and arm64_errata) of
> struct arm64_cpu_capabilities which decide the capabilities of the system.
> We iterate over the two tables for detecting/verifying/enabling the capabilities.
> e.g, this_cpu_has_cap() needs to iterate over the two tables one by one to
> find the "capability" structure corresponding to the cap number and then
> check it on the CPU.
> 
> Also, we enable all the non-boot scoped capabilities after all the SMP cpus
> are brought up by the kernel, using stop_machine() for each available
> capability. We could batch all the "enabling" activity to a single
> stop_machine() callback. But that implies you need a way to map
> a given capability number to the corresponding capability entry
> to finish the operation quickly.
> 
> So we need a quicker way to access the entry for a given capability.
> We have two choices :
> 
>  1) Unify both the tables to a static/dynamic sorted entry based on
>     the capability number. This has the following drawbacks :
>      a) The entries must be unique. i.e, no duplicate entries for a
>         capability.
>      b) Looses the separation of "features" vs. "errata" classification
>      c) Statically sorting the list is error prone. Runtime sorting the
>         array means more time for booting.
> 
>  2) Keep an array of pointers to the capability sorted at boot time
>     based on the capability.
>      a) As for (1), the entries must be unique for a capability.
> 
> This series implements (2) and uses the new list for optimizing the
> operations on the entries. As a prepatory step, we remove the
> duplicate entries for the same capabilities (Patch 1-3).
> 

Thanks a lot for getting it sorted out! In case it'd help:

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>

Cheers
Vladimir

> 
> Suzuki K Poulose (7):
>   arm64: capabilities: Merge entries for ARM64_WORKAROUND_CLEAN_CACHE
>   arm64: capabilities: Merge duplicate Cavium erratum entries
>   arm64: capabilities: Merge duplicate entries for Qualcomm erratum 1003
>   arm64: capabilities: Speed up capability lookup
>   arm64: capabilities: Optimize this_cpu_has_cap
>   arm64: capabilities: Use linear array for detection and verification
>   arm64: capabilities: Batch cpu_enable callbacks
> 
>  arch/arm64/include/asm/cpufeature.h |   3 +
>  arch/arm64/include/asm/cputype.h    |   2 +
>  arch/arm64/kernel/cpu_errata.c      |  94 ++++++++++----------
>  arch/arm64/kernel/cpufeature.c      | 165 ++++++++++++++++++++----------------
>  4 files changed, 145 insertions(+), 119 deletions(-)
> 
