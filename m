From: ddaney.cavm@gmail.com (David Daney)
Date: Tue, 25 Oct 2016 14:31:01 -0700
Subject: [PATCH 2/2] arm64,
 numa: Force of_node_to_nid to return NUMA_NO_NODE when numa=off.
In-Reply-To: <1477431061-7258-1-git-send-email-ddaney.cavm@gmail.com>
References: <1477431061-7258-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <1477431061-7258-3-git-send-email-ddaney.cavm@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <david.daney@cavium.com>

When "numa=off" is passed on the command line, of_node_to_nid() still
returns the node number (which can be greater than zero).  However, in
this case all the memory is associated with the dummy node zero.  This
causes OOPS in kernel/irq/irqdomain.c:

    domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
                  GFP_KERNEL, of_node_to_nid(of_node));
...

which in my case then caused the kernel to OOPS for the IRQ controller
on node 1:

[    0.000000] [<fffffc00081bba84>] __alloc_pages_nodemask+0xa4/0xe68
[    0.000000] [<fffffc00082163a8>] new_slab+0xd0/0x57c
[    0.000000] [<fffffc000821879c>] ___slab_alloc+0x2e4/0x514
[    0.000000] [<fffffc000823882c>] __slab_alloc+0x48/0x58
[    0.000000] [<fffffc00082195a0>] __kmalloc_node+0xd0/0x2e0
[    0.000000] [<fffffc00081119b8>] __irq_domain_add+0x7c/0x164
[    0.000000] [<fffffc0008b75d30>] its_probe+0x784/0x81c
[    0.000000] [<fffffc0008b75e10>] its_init+0x48/0x1b0

Fix by forcing of_node_to_nid() to return NUMA_NO_NODE when numa=off.
The kmalloc_node() family is perfectly happy when the node is
specified as NUMA_NO_NODE.

Reported-by: Gilbert Netzer <noname@pdc.kth.se>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/arm64/mm/numa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
index 778a985..6d34ebb 100644
--- a/arch/arm64/mm/numa.c
+++ b/arch/arm64/mm/numa.c
@@ -41,8 +41,10 @@ static __init int numa_parse_early_param(char *opt)
 {
 	if (!opt)
 		return -EINVAL;
-	if (!strncmp(opt, "off", 3))
+	if (!strncmp(opt, "off", 3)) {
+		__of_force_no_numa();
 		numa_off = true;
+	}
 
 	return 0;
 }
@@ -432,6 +434,7 @@ static int __init dummy_numa_init(void)
 		return ret;
 	}
 
+	__of_force_no_numa();
 	numa_off = true;
 	return 0;
 }
-- 
1.8.3.1
