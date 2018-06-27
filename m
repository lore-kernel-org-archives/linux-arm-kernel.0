From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Wed, 27 Jun 2018 11:05:36 +0530
Subject: [PATCH v2 0/7] arm64: numa/topology/smp: update the cpumasks
 for CPU hotplug
In-Reply-To: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
References: <1529327923-17911-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <5B332228.40204@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sudeep,

On 06/18/2018 06:48 PM, Sudeep Holla wrote:
>
> Hi,
>
> Commit 37c3ec2d810f ("arm64: topology: divorce MC scheduling domain from core_siblings")
> was reported to cause some hotplug and system suspend regressions when
> it was merged. On investigation, it was found that unlike x86/PPC,
> arm64 doesn't update the cpu and numa masks on CPU hotplug. That's
> somewhat expected from the scheduler.
>
> Since these changes were bit invasive as a solution to the above
> mentioned regression, as small change was temporarily applied as a fix.
> This series updates the cpu and numa masks on CPU hotplug and reverts
> that temporary fix.
>
> It would be good to get this tested(CPU hotplug - few and all CPUs in
> a socket) on multi-socket/NUMA systems from Cavium and Huawei/Hisilicon.

testing looks ok on Cavium's ThunderX2 system.
please feel free to add,

Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

root at B1SABER_2>sudeep>> lscpu
Architecture:          aarch64
Byte Order:            Little Endian
CPU(s):                224
On-line CPU(s) list:   0-223
Thread(s) per core:    4
Core(s) per socket:    28
Socket(s):             2
NUMA node(s):          2
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              32768K
NUMA node0 CPU(s):     0-111
NUMA node1 CPU(s):     112-223
root at B1SABER_2>sudeep>> sh hp.sh 0 111 0
root at B1SABER_2>sudeep>> lscpu
Architecture:          aarch64
Byte Order:            Little Endian
On-line CPU(s) list:   112-223
Off-line CPU(s) list:  0-111
Thread(s) per core:    4
Core(s) per socket:    28
Socket(s):             1
NUMA node(s):          2
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              32768K
NUMA node0 CPU(s):
NUMA node1 CPU(s):     112-223
root at B1SABER_2>sudeep>> sh hp.sh 0 111 1
root at B1SABER_2>sudeep>> lscpu
Architecture:          aarch64
Byte Order:            Little Endian
CPU(s):                224
On-line CPU(s) list:   0-223
Thread(s) per core:    4
Core(s) per socket:    28
Socket(s):             2
NUMA node(s):          2
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              32768K
NUMA node0 CPU(s):     0-111
NUMA node1 CPU(s):     112-223
root at B1SABER_2>sudeep>>

>
> Regards,
> Sudeep
>
> v1->v2:
>          - Rebased on v4.18-rc1 and hence do revert of the temporary fix
>            that was merged for v4.18
>          - Removed one of the wrong use of possible_mask
>
> Sudeep Holla (7):
>    arm64: topology: refactor reset_cpu_topology to add support for removing topology
>    arm64: numa: separate out updates to percpu nodeid and NUMA node cpumap
>    arm64: topology: add support to remove cpu topology sibling masks
>    arm64: topology: restrict updating siblings_masks to online cpus only
>    arm64: smp: remove cpu and numa topology information when hotplugging out CPU
>    arm64: topology: rename llc_siblings to align with other struct members
>    arm64: topology: re-introduce numa mask check for scheduler MC selection
>
>   arch/arm64/include/asm/numa.h     |  4 +++
>   arch/arm64/include/asm/topology.h |  3 +-
>   arch/arm64/kernel/smp.c           |  5 +++
>   arch/arm64/kernel/topology.c      | 69 ++++++++++++++++++++++++++-------------
>   arch/arm64/mm/numa.c              | 29 +++++++++++-----
>   5 files changed, 79 insertions(+), 31 deletions(-)
>
> --
> 2.7.4
>

thanks
Ganapat
