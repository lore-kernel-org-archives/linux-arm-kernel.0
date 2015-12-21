From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 21 Dec 2015 17:39:43 +0100
Subject: [PATCH 0/5] add missing of_node_put
Message-ID: <1450715988-4770-1-git-send-email-Julia.Lawall@lip6.fr>
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

 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    1 +
 drivers/pinctrl/pinctrl-rockchip.c            |    5 ++++-
 drivers/pinctrl/pinctrl-tegra-xusb.c          |    4 +++-
 drivers/pinctrl/pinctrl-tegra.c               |    1 +
 drivers/pinctrl/sh-pfc/pinctrl.c              |    4 +++-
 drivers/pinctrl/sirf/pinctrl-sirf.c           |    8 ++++++--
 6 files changed, 18 insertions(+), 5 deletions(-)
