From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 11 Jun 2013 10:58:48 +0100
Subject: [RFC PATCH v2 0/2] ARM: MPIDR linearization
In-Reply-To: <1370532125-14322-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1370532125-14322-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130611095848.GD8164@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, all,

even though I think this set is ready to get merged, it would be great
if we can test it on as many platforms as possible since it touches core
suspend/resume operations on ARM platforms relying on CONFIG_ARM_CPU_SUSPEND,
and there are many.

I pushed out a branch:

git://linux-arm.org/linux-2.6-lp.git mpidr-linearization

if anyone has time to test the set that would be really great, thank you
very much.

Comments and further review appreciated.

Thanks a lot,
Lorenzo

On Thu, Jun 06, 2013 at 04:22:03PM +0100, Lorenzo Pieralisi wrote:
> This patchset is v2 of a previous posting:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/172873.html
> 
> v2 changes:
> 
> - rescheduled registers usage in compute_mpidr_hash macro
> 
> Cores in ARM SMP systems are identified through coprocessor registers,
> so that every core, by executing a coprocessor read, can detect its own
> identifier. The CPU identifier evolved from a simple CPU ID on ARM 11 MPcore
> SMP, where the CPU ID was split in two subfields (CPU ID and CLUSTER ID)
> to the v7 MPIDR, where the MPIDR[23:0] bits define three affinity levels
> that can describe thread, core, cluster topology identifiers.
> According to the ARM 11 MPcore TRM and for architecture versions later
> than v7 (MPIDR), to the ARM ARM, the identifier registers format is as follows:
> 
> NR: non-relevant for identification
> 
> ARM11 MPCORE: CPU ID register
> 
> 31                                    12 11          8 7       4 3        0
> ---------------------------------------------------------------------------
> |                 NR                    |  CLUSTER ID |    NR   |  CPU ID |
> --------------------------------------------------------------------------
> 
> ARM v7: MPIDR
> 
> 31       24 23                 16 15                 8 7                  0
> ---------------------------------------------------------------------------
> |   NR     |      AFFINITY 2     |     AFFINITY 1     |    AFFINITY 0     |
> ---------------------------------------------------------------------------
> 
> The split of CPU identifiers in multiple affinity levels implies that
> the CPU ID, and later the MPIDR, cannot be used as simple indexes, since
> the bit representation can contain holes:
> 
> eg 4 CPUs, in two separate clusters with two CPUs each:
> 
> CPU0: MPIDR = 0x0
> CPU1: MPIDR = 0x1
> CPU2: MPIDR = 0x100
> CPU3: MPIDR = 0x101
> 
> In order to carry out operations that rely on the HW CPUID/MPIDR (CCI
> disabling, context save/restore) the association of the CPU ID, or MPIDR
> to an index is needed so that the CPU can be associated with a set of
> resources. Resources look-up through the HW CPU ID is carried out in
> code paths usually executed in power down procedures, that have to be
> fast and look-up should be performed with few instructions that may be
> executing in physical address space, with the MMU off.
> In order to provide a fast conversion from [CPU ID, MPIDR] values to indexes
> this set provides methods to build a simple collision-free hash function based
> on shifting and OR'ing of CPU ID values, with shifts precomputed at boot by
> scanning the cpu_logical_map entries (that contain the CPUID/MPIDR) of
> possible CPUs.
> 
> By scanning the cpu_logical_map, the boot code detects how many bits are really
> required to represent HW identifiers in the system and map them to a set of
> buckets that actually represent the given index a HW id correspond to. The
> hashing algorithm inherently takes advantage of a-priori knowledge of the
> CPUIDs/MPIDRs allowed bits layout and it can be executed with few instructions
> even in code paths where caching and the MMU are turned off (e.g resuming from
> idle, S2R, hibernation).
> 
> One drawback of the current hashing algorithm is that it may result in a big
> number of buckets if the recommendations on the CPUID/MPIDR layout are not
> respected in the CPUID/MPIDR configuration; code warns on hash table
> sizes bigger than 4 times the number of possible CPUs, which is a
> symptom of a weird CPUID/MPIDR HW configuration and should be the exception
> not the rule.
> 
> The first patch in the series provides a function that precomputes all
> required hashing parameters by scanning the cpu_logical_map (that
> contains HW identifiers), computes and stashes the hash parameters in a
> structure exported to all kernel components for further usage.
> 
> The second patch fixes the current cpu_{suspend}/{resume} functionality,
> so that all levels of CPUID/MPIDR are supported and cpu_{suspend}/{resume}
> can be used on systems where affinity levels 1 and 2 are actually populated.
> The fix carries out dynamic allocation of the array used to save the context
> pointers, with size equal to the number of precomputed CPUID/MPIDR hash
> buckets. To access the array, the CPUID/MPIDR values are hashed through the
> algorithm built in patch 1 so that a hash value is retrieved and the array can
> be indexed properly through it.
> 
> Context pointer array is allocated through kmalloc, so that it is made
> up of a contiguous chunk of memory whose virtual address can be safely
> converted to physical address (used in the MMU off path) through a
> static mapping translation valid for all pages (if more than one) making
> up the context pointer array. Context pointer array base address is
> stashed in a structure easily retrieved in assembly through a pc relative
> load that provides both virtual and physical address so that address
> translation is not needed in the cpu_resume path, saving a few instructions.
> 
> Code will be improved later through dynamic patching so that the mask
> and shifts in the hashing algorithm will be embedded in the assembly
> instructions as immediates, removing the need for multiple loads to
> memory to retrieve them at every given cpu_{suspend}/{resume} cycle.
> 
> Tested on TC2 (dual cluster 2x3 A15/A7 system) through CPU idle deep C-states
> allowing A15 and A7 shutdown modes on both SMP and UP configurations.
> 
> Lorenzo Pieralisi (2):
>   ARM: kernel: build MPIDR hash function data structure
>   ARM: kernel: implement stack pointer save array through MPIDR hashing
> 
>  arch/arm/include/asm/smp_plat.h | 18 ++++++++
>  arch/arm/include/asm/suspend.h  |  5 +++
>  arch/arm/kernel/asm-offsets.c   |  6 +++
>  arch/arm/kernel/setup.c         | 67 ++++++++++++++++++++++++++++
>  arch/arm/kernel/sleep.S         | 97 +++++++++++++++++++++++++++++++++--------
>  arch/arm/kernel/suspend.c       | 20 +++++++++
>  6 files changed, 195 insertions(+), 18 deletions(-)
> 
> -- 
> 1.8.2.2
> 
