From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 25 Oct 2015 14:56:59 +0100
Subject: [PATCH 0/8] add missing of_node_put
Message-ID: <1445781427-7110-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The various for_each device_node iterators performs an of_node_get on each
iteration, so a break out of the loop requires an of_node_put.

The complete semantic patch that fixes this problem is
(http://coccinelle.lip6.fr):

// <smpl>
@r@
local idexpression n;
expression e1,e2;
iterator name for_each_node_by_name, for_each_node_by_type,
for_each_compatible_node, for_each_matching_node,
for_each_matching_node_and_match, for_each_child_of_node,
for_each_available_child_of_node, for_each_node_with_property;
iterator i;
statement S;
expression list [n1] es;
@@

(
(
for_each_node_by_name(n,e1) S
|
for_each_node_by_type(n,e1) S
|
for_each_compatible_node(n,e1,e2) S
|
for_each_matching_node(n,e1) S
|
for_each_matching_node_and_match(n,e1,e2) S
|
for_each_child_of_node(e1,n) S
|
for_each_available_child_of_node(e1,n) S
|
for_each_node_with_property(n,e1) S
)
&
i(es,n,...) S
)

@@
local idexpression r.n;
iterator r.i;
expression e;
expression list [r.n1] es;
@@

 i(es,n,...) {
   ...
(
   of_node_put(n);
|
   e = n
|
   return n;
|
+  of_node_put(n);
?  return ...;
)
   ...
 }

@@
local idexpression r.n;
iterator r.i;
expression e;
expression list [r.n1] es;
@@

 i(es,n,...) {
   ...
(
   of_node_put(n);
|
   e = n
|
+  of_node_put(n);
?  break;
)
   ...
 }
... when != n

@@
local idexpression r.n;
iterator r.i;
expression e;
identifier l;
expression list [r.n1] es;
@@

 i(es,n,...) {
   ...
(
   of_node_put(n);
|
   e = n
|
+  of_node_put(n);
?  goto l;
)
   ...
 }
...
l: ... when != n// </smpl>

---

 drivers/media/platform/xilinx/xilinx-tpg.c        |    2 ++
 drivers/media/platform/xilinx/xilinx-vipp.c       |    4 +++-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c |    4 +++-
 drivers/net/ethernet/marvell/mv643xx_eth.c        |    4 +++-
 drivers/net/ethernet/ti/netcp_ethss.c             |    8 ++++++--
 drivers/net/phy/mdio-mux-mmioreg.c                |    2 ++
 drivers/net/phy/mdio-mux.c                        |    1 +
 drivers/net/wireless/ath/ath6kl/init.c            |    1 +
 8 files changed, 21 insertions(+), 5 deletions(-)
