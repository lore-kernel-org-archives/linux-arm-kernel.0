From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 5 Sep 2018 08:42:52 +0200
Subject: [PATCH] arm64: add NUMA emulation support
In-Reply-To: <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
References: <20180824230559.32336-1-shuah@kernel.org>
 <20180828174011.GE20375@arm.com>
 <a58ad11f-3c22-ed7f-a0cd-938aabc4adaf@kernel.org>
 <20180829110802.GD10349@dhcp22.suse.cz>
 <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
Message-ID: <20180905064252.GW14951@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 04-09-18 15:59:34, Shuah Khan wrote:
[...]
> This will support the following workload requirements:
> 
> - reserving one or more NUMA memory nodes for class of critical tasks that require
>   guaranteed memory availability.
> - isolate memory blocks with a guaranteed exclusive access.

How do you enforce kernel doesn't allocate from those reserved nodes?
They will be in a fallback zonelists so once the memory gets used on all
other ones then the kernel happily spills over to your reserved node.

> NUMA emulation to split the flat machine into "x" number of nodes, combined with
> cpuset cgroup with the following example configuration will make it possible to
> support the above workloads on non-NUMA platforms.
> 
> numa=fake=4
> 
> cpuset.mems=2
> cpuset.cpus=2
> cpuset.mem_exclusive=1 (enabling exclusive use of the memory nodes by a CPU set)
> cpuset.mem_hardwall=1  (separate the memory nodes that are allocated to different cgroups)

This will only enforce userspace to follow and I strongly suspect that
tasks in the root cgroup will be allowed to allocate as well.
-- 
Michal Hocko
SUSE Labs
