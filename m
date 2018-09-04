From: shuah@kernel.org (Shuah Khan)
Date: Tue, 4 Sep 2018 15:59:34 -0600
Subject: [PATCH] arm64: add NUMA emulation support
In-Reply-To: <20180829110802.GD10349@dhcp22.suse.cz>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
 <20180829110802.GD10349@dhcp22.suse.cz>
Message-ID: <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

Sorry for the delay in responding. I was traveling last week.

On 08/29/2018 05:08 AM, Michal Hocko wrote:
> On Tue 28-08-18 12:09:53, Shuah Khan wrote:
> [...]
>> The main intent is to use numa emulation in conjunction with cpusets for coarse
>> memory management similar to x86_64 use-case for the same.
> 
> Could you be more specific please? Why would you want a hack like this
> when you have a full featured memory cgroup controller to limit the
> amount of memory?
> 

I should have given more details about the nature of memory management use-case
this patch addresses.

Memory cgroup allows specifying memory limits and controls memory footprint of
tasks in a cgroup.

However, there are some limitations

- Memory isn't reserved for the cgroup and there is no guarantee that the memory will
  be available when it needs it.

- cgroups allocate from the same system memory pool and is shared with other cgroups.
  Since root cgroup doesn?t have limits, it could potentially impact performance on
  other cgroups in high memory pressure situations.

- Allocating entire memory blocks to a cgroup to ensure reservation and isolation isn't
  possible. Pages can be re-allocated to another processes.

With NUMA emulation, memory blocks can be split and assigned to emulated nodes, both
reservation and isolation can be supported.

This will support the following workload requirements:

- reserving one or more NUMA memory nodes for class of critical tasks that require
  guaranteed memory availability.
- isolate memory blocks with a guaranteed exclusive access.

NUMA emulation to split the flat machine into "x" number of nodes, combined with
cpuset cgroup with the following example configuration will make it possible to
support the above workloads on non-NUMA platforms.

numa=fake=4

cpuset.mems=2
cpuset.cpus=2
cpuset.mem_exclusive=1 (enabling exclusive use of the memory nodes by a CPU set)
cpuset.mem_hardwall=1  (separate the memory nodes that are allocated to different cgroups)

thanks,
-- Shuah
