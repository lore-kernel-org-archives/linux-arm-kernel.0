From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu,  1 Sep 2016 00:21:23 +0200
Subject: [PATCH 5/5] net: axienet: constify ethtool_ops structures
In-Reply-To: <1472682083-5219-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1472682083-5219-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1472682083-5219-6-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for ethtool_ops structures that are only stored in the ethtool_ops
field of a net_device structure or passed as the second argument to
netdev_set_default_ethtool_ops.  These contexts are declared const, so
ethtool_ops structures that have these properties can be declared as const
also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct ethtool_ops i at p = { ... };

@ok1@
identifier r.i;
struct net_device e;
position p;
@@
e.ethtool_ops = &i at p;

@ok2@
identifier r.i;
expression e;
position p;
@@
netdev_set_default_ethtool_ops(e, &i at p)

@bad@
position p != {r.p,ok1.p,ok2.p};
identifier r.i;
@@
i at p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct ethtool_ops i = { ... };
// </smpl>

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 36ee7ab..69e2a83 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1297,7 +1297,7 @@ static int axienet_ethtools_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static struct ethtool_ops axienet_ethtool_ops = {
+static const struct ethtool_ops axienet_ethtool_ops = {
 	.get_drvinfo    = axienet_ethtools_get_drvinfo,
 	.get_regs_len   = axienet_ethtools_get_regs_len,
 	.get_regs       = axienet_ethtools_get_regs,
