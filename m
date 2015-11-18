From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 18 Nov 2015 23:04:10 +0100
Subject: [PATCH 0/4] add missing of_node_put
Message-ID: <1447884254-26336-1-git-send-email-Julia.Lawall@lip6.fr>
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

 drivers/iio/adc/qcom-spmi-vadc.c     |    4 +++-
 drivers/mtd/nand/brcmnand/brcmnand.c |   14 ++++++++++----
 drivers/mtd/nand/sunxi_nand.c        |    4 +++-
 drivers/power/reset/at91-reset.c     |    1 +
 4 files changed, 17 insertions(+), 6 deletions(-)
