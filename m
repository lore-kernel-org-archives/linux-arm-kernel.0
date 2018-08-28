From: shuah@kernel.org (Shuah Khan)
Date: Tue, 28 Aug 2018 12:09:53 -0600
Subject: [PATCH] arm64: add NUMA emulation support
In-Reply-To: <20180828174011.GE20375@arm.com>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
Message-ID: <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/28/2018 11:40 AM, Will Deacon wrote:
> On Fri, Aug 24, 2018 at 05:05:59PM -0600, Shuah Khan (Samsung OSG) wrote:
>> Add NUMA emulation support to emulate NUMA on non-NUMA platforms. A new
>> CONFIG_NUMA_EMU option enables NUMA emulation and a new kernel command
>> line option "numa=fake=N" allows users to specify the configuration for
>> emulation.
>>
>> When NUMA emulation is enabled, a flat (non-NUMA) machine will be split
>> into virtual NUMA nodes when booted with "numa=fake=N", where N is the
>> number of nodes, the system RAM will be split into N equal chunks and
>> assigned to each node.
>>
>> Emulated nodes are bounded by MAX_NUMNODES and the number of memory block
>> count to avoid splitting memory blocks across NUMA nodes.
>>
>> If NUMA emulation init fails, it will fall back to dummy NUMA init.
>>
>> This is tested on Raspberry Pi3b+ with ltp NUMA test suite, numactl, and
>> numastat tools. In addition, tested in conjunction with cpuset cgroup to
>> verify cpuset.cpus and cpuset.mems assignments.
>>
>> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
>> ---
>>  arch/arm64/Kconfig            |   9 +++
>>  arch/arm64/include/asm/numa.h |   8 +++
>>  arch/arm64/mm/Makefile        |   1 +
>>  arch/arm64/mm/numa.c          |   4 ++
>>  arch/arm64/mm/numa_emu.c      | 109 ++++++++++++++++++++++++++++++++++
>>  5 files changed, 131 insertions(+)
>>  create mode 100644 arch/arm64/mm/numa_emu.c
> 
> Hmm, is this just for debugging and kernel development? If so, it's quite a
> lot of code just for that. Can't you achieve the same thing by faking up the
> firmware tables?
> 
> Will
> 

The main intent is to use numa emulation in conjunction with cpusets for coarse
memory management similar to x86_64 use-case for the same.

I verified the restricted/unrestricted using cpuset cgroup to verify cpuset.cpus
and cpuset.mems assignments. I could see the Restricted/Unrestricted case memory
usage differences. Using this it will be possible to restrict memory usage by a
class of processes or a workload or set aside memory for a workload.

This adds the same feature supported by x86_64 as described in

x86/x86_64/fake-numa-for-cpusets
Using numa=fake and CPUSets for Resource Management

I could see the Restricted/Unrestricted case memory usage differences with this
patch on Raspberry Pi3b+.

This can also be used to regression test higher level NUMA changes on non-NUMA
as well without firmware changes. This will also provide a way to expand NUMA
regression testing in kernel rings.

I was able to run ltp NUMA tests on this and verify NUMA policy code on non-NUMA
platform. Results below.

numa01 1 TINFO: The system contains 4 nodes: 
numa01 1 TPASS: NUMA local node and memory affinity
numa01 2 TPASS: NUMA preferred node policy
numa01 3 TPASS: NUMA share memory allocated in preferred node
numa01 4 TPASS: NUMA interleave policy
numa01 5 TPASS: NUMA interleave policy on shared memory
numa01 6 TPASS: NUMA phycpubind policy
numa01 7 TPASS: NUMA local node allocation
numa01 8 TPASS: NUMA MEMHOG policy
numa01 9 TPASS: NUMA policy on lib NUMA_NODE_SIZE API
numa01 10 TPASS: NUMA MIGRATEPAGES policy
numa01 11 TCONF: hugepage is not supported
grep: /sys/kernel/mm/transparent_hugepage/enabled: No such file or directory
numa01 12 TCONF: THP is not supported/enabled

Summary:
passed   10
failed   0
skipped  2
warnings 0

thanks,
-- Shuah
