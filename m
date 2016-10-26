From: rric@kernel.org (Robert Richter)
Date: Wed, 26 Oct 2016 15:43:01 +0200
Subject: [PATCH 1/2] of, numa: Add function to disable of_node_to_nid().
In-Reply-To: <1477431061-7258-2-git-send-email-ddaney.cavm@gmail.com>
References: <1477431061-7258-1-git-send-email-ddaney.cavm@gmail.com>
 <1477431061-7258-2-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20161026134301.GV25086@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.10.16 14:31:00, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> On arm64 NUMA kernels we can pass "numa=off" on the command line to
> disable NUMA.  A side effect of this is that kmalloc_node() calls to
> non-zero nodes will crash the system with an OOPS:
> 
> [    0.000000] [<fffffc00081bba84>] __alloc_pages_nodemask+0xa4/0xe68
> [    0.000000] [<fffffc00082163a8>] new_slab+0xd0/0x57c
> [    0.000000] [<fffffc000821879c>] ___slab_alloc+0x2e4/0x514
> [    0.000000] [<fffffc000823882c>] __slab_alloc+0x48/0x58
> [    0.000000] [<fffffc00082195a0>] __kmalloc_node+0xd0/0x2e0
> [    0.000000] [<fffffc00081119b8>] __irq_domain_add+0x7c/0x164
> [    0.000000] [<fffffc0008b75d30>] its_probe+0x784/0x81c
> [    0.000000] [<fffffc0008b75e10>] its_init+0x48/0x1b0
> .
> .
> .
> 
> This is caused by code like this in kernel/irq/irqdomain.c
> 
>     domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
>                   GFP_KERNEL, of_node_to_nid(of_node));
> 
> When NUMA is disabled, the concept of a node is really undefined, so
> of_node_to_nid() should unconditionally return NUMA_NO_NODE.
> 
> Add __of_force_no_numa() to allow of_node_to_nid() to be forced to
> return NUMA_NO_NODE.
> 
> The follow on patch will call this new function from the arm64 numa
> code.

Didn't that work before? numa=off just maps all mem to node 0. If mem
allocation is requested for another node it should just fall back to a
node with mem (node 0 then). I suspect there is something wrong with
the page initialization, see:

 http://www.spinics.net/lists/arm-kernel/msg535191.html
 https://bugzilla.redhat.com/show_bug.cgi?id=1387793

What is the complete oops?

So I think k*alloc_node() must be able to handle requests to
non-existing nodes. Otherwise your fix is incomplete, assume a failed
of_numa_init() causing a dummy init but still some devices reporting a
node.

-Robert
