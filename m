From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Aug 2018 18:40:12 +0100
Subject: [PATCH] arm64: add NUMA emulation support
In-Reply-To: <20180824230559.32336-1-shuah@kernel.org>
References: <20180824230559.32336-1-shuah@kernel.org>
Message-ID: <20180828174011.GE20375@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 05:05:59PM -0600, Shuah Khan (Samsung OSG) wrote:
> Add NUMA emulation support to emulate NUMA on non-NUMA platforms. A new
> CONFIG_NUMA_EMU option enables NUMA emulation and a new kernel command
> line option "numa=fake=N" allows users to specify the configuration for
> emulation.
> 
> When NUMA emulation is enabled, a flat (non-NUMA) machine will be split
> into virtual NUMA nodes when booted with "numa=fake=N", where N is the
> number of nodes, the system RAM will be split into N equal chunks and
> assigned to each node.
> 
> Emulated nodes are bounded by MAX_NUMNODES and the number of memory block
> count to avoid splitting memory blocks across NUMA nodes.
> 
> If NUMA emulation init fails, it will fall back to dummy NUMA init.
> 
> This is tested on Raspberry Pi3b+ with ltp NUMA test suite, numactl, and
> numastat tools. In addition, tested in conjunction with cpuset cgroup to
> verify cpuset.cpus and cpuset.mems assignments.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> ---
>  arch/arm64/Kconfig            |   9 +++
>  arch/arm64/include/asm/numa.h |   8 +++
>  arch/arm64/mm/Makefile        |   1 +
>  arch/arm64/mm/numa.c          |   4 ++
>  arch/arm64/mm/numa_emu.c      | 109 ++++++++++++++++++++++++++++++++++
>  5 files changed, 131 insertions(+)
>  create mode 100644 arch/arm64/mm/numa_emu.c

Hmm, is this just for debugging and kernel development? If so, it's quite a
lot of code just for that. Can't you achieve the same thing by faking up the
firmware tables?

Will
