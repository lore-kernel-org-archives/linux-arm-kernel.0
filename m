From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 16 Nov 2015 17:38:30 -0800
Subject: [PATCH 1/7] phy: brcmstb-sata: add missing of_node_put
In-Reply-To: <1447673600-8881-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1447673600-8881-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447673600-8881-2-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20151117013830.GV8456@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 12:33:14PM +0100, Julia Lawall wrote:
> for_each_available_child_of_node performs an of_node_get on each iteration,
> so a return from the middle of the loop requires an of_node_put.
> 
> A simplified version of the semantic patch that finds this problem is as
> follows (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> expression root,e;
> local idexpression child;
> @@
> 
>  for_each_available_child_of_node(root, child) {
>    ... when != of_node_put(child)
>        when != e = child
> (
>    return child;
> |
> *  return ...;
> )
>    ...
>  }
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---

For this patch:

Acked-by: Brian Norris <computersforpeace@gmail.com>

>  drivers/phy/phy-brcmstb-sata.c |   17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

[snip patch, which fixes of_node_put() handling for
for_each_available_child_of_node() loop, which creates PHY devices with
devm_phy_create()]

This reminds me of a potential problem I'm looking at in other
subsystems: from code reading (I haven't seen any issues in practice,
probably because I don't use OF_DYNAMIC) it looks like device-creating
infrastructure like the PHY subsystem should be acquiring a reference to
the device_node when they stash it away. But drivers/phy/phy-core.c does
not do this, AFAICT.

See phy_create(), which does

	phy->dev.of_node = node ?: dev->of_node;

and later might reuse this of_node pointer, even though it never called
of_node_get() on this node.

Potential patch to fix this (not tested).

Signed-off-by: Brian Norris <computersforpeace@gmail.com>

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index fc48fac003a6..8df29caeeef9 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -697,6 +697,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 	phy->dev.class = phy_class;
 	phy->dev.parent = dev;
 	phy->dev.of_node = node ?: dev->of_node;
+	of_node_get(phy->dev.of_node);
 	phy->id = id;
 	phy->ops = ops;
 
@@ -726,6 +727,7 @@ struct phy *phy_create(struct device *dev, struct device_node *node,
 	return phy;
 
 put_dev:
+	of_node_put(phy->dev.of_node);
 	put_device(&phy->dev);  /* calls phy_release() which frees resources */
 	return ERR_PTR(ret);
 
@@ -775,6 +777,7 @@ EXPORT_SYMBOL_GPL(devm_phy_create);
  */
 void phy_destroy(struct phy *phy)
 {
+	of_node_put(phy->dev.of_node);
 	pm_runtime_disable(&phy->dev);
 	device_unregister(&phy->dev);
 }
