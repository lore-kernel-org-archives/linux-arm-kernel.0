From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 26 Oct 2016 11:31:52 +0200
Subject: [PATCH 1/2] mm/memblock: prepare a capability to support
 memblock near alloc
In-Reply-To: <58101EB4.2080305@huawei.com>
References: <1477364358-10620-1-git-send-email-thunder.leizhen@huawei.com>
 <1477364358-10620-2-git-send-email-thunder.leizhen@huawei.com>
 <20161025132338.GA31239@dhcp22.suse.cz>
 <58101EB4.2080305@huawei.com>
Message-ID: <20161026093152.GE18382@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 26-10-16 11:10:44, Leizhen (ThunderTown) wrote:
> 
> 
> On 2016/10/25 21:23, Michal Hocko wrote:
> > On Tue 25-10-16 10:59:17, Zhen Lei wrote:
> >> If HAVE_MEMORYLESS_NODES is selected, and some memoryless numa nodes are
> >> actually exist. The percpu variable areas and numa control blocks of that
> >> memoryless numa nodes need to be allocated from the nearest available
> >> node to improve performance.
> >>
> >> Although memblock_alloc_try_nid and memblock_virt_alloc_try_nid try the
> >> specified nid at the first time, but if that allocation failed it will
> >> directly drop to use NUMA_NO_NODE. This mean any nodes maybe possible at
> >> the second time.
> >>
> >> To compatible the above old scene, I use a marco node_distance_ready to
> >> control it. By default, the marco node_distance_ready is not defined in
> >> any platforms, the above mentioned functions will work as normal as
> >> before. Otherwise, they will try the nearest node first.
> > 
> > I am sorry but it is absolutely unclear to me _what_ is the motivation
> > of the patch. Is this a performance optimization, correctness issue or
> > something else? Could you please restate what is the problem, why do you
> > think it has to be fixed at memblock layer and describe what the actual
> > fix is please?
>
> This is a performance optimization.

Do you have any numbers to back the improvements?

> The problem is if some memoryless numa nodes are
> actually exist, for example: there are total 4 nodes, 0,1,2,3, node 1 has no memory,
> and the node distances is as below:
>                     ---------board-------
> 		    |                   |
>                     |                   |
>                  socket0             socket1
>                    / \                 / \
>                   /   \               /   \
>                node0 node1         node2 node3
> distance[1][0] is nearer than distance[1][2] and distance[1][3]. CPUs on node1 access
> the memory of node0 is faster than node2 or node3.
> 
> Linux defines a lot of percpu variables, each cpu has a copy of it and most of the time
> only to access their own percpu area. In this example, we hope the percpu area of CPUs
> on node1 allocated from node0. But without these patches, it's not sure that.

I am not familiar with the percpu allocator much so I might be
completely missig a point but why cannot this be solved in the percpu
allocator directly e.g. by using cpu_to_mem which should already be
memoryless aware.

Generating a new API while we have means to use an existing one sounds
just not right to me.
-- 
Michal Hocko
SUSE Labs
