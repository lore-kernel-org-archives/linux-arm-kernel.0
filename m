From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 19 May 2011 17:39:58 -0600
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <4DD5A80F.5020807@gmail.com>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<1305829704-11774-3-git-send-email-robherring2@gmail.com>
	<20110519200158.GW5109@ponder.secretlab.ca>
	<4DD5A80F.5020807@gmail.com>
Message-ID: <20110519233958.GB18181@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 06:30:23PM -0500, Rob Herring wrote:
> Grant,
> 
> On 05/19/2011 03:01 PM, Grant Likely wrote:
> >On Thu, May 19, 2011 at 01:28:24PM -0500, Rob Herring wrote:
> >>From: Rob Herring<rob.herring@calxeda.com>
> >>
> >>Add functions to parse the AMBA bus through the device tree.
> >>
> >>Based on the original version by Jeremy Kerr. This reworks the original amba
> >>bus device tree probing to be more inline with how platform bus probing via
> >>device tree is done using a match table.
> >>
> >>Cc: Jeremy Kerr<jeremy.kerr@canonical.com>
> >>Cc: Grant Likely<grant.likely@secretlab.ca>
> >>Signed-off-by: Rob Herring<rob.herring@calxeda.com>
> >>---
> >>  drivers/amba/bus.c       |  133 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/amba/bus.h |    7 +++
> >>  2 files changed, 140 insertions(+), 0 deletions(-)
> >>
> >>diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> >>index 7025593..8e55754 100644
> >>--- a/drivers/amba/bus.c
> >>+++ b/drivers/amba/bus.c
> >>@@ -13,6 +13,11 @@
> >>  #include<linux/string.h>
> >>  #include<linux/slab.h>
> >>  #include<linux/io.h>
> >>+#include<linux/of.h>
> >>+#include<linux/of_irq.h>
> >>+#include<linux/of_address.h>
> >>+#include<linux/of_device.h>
> >>+#include<linux/of_platform.h>
> >>  #include<linux/pm.h>
> >>  #include<linux/pm_runtime.h>
> >>  #include<linux/amba/bus.h>
> >>@@ -780,3 +785,131 @@ EXPORT_SYMBOL(amba_device_unregister);
> >>  EXPORT_SYMBOL(amba_find_device);
> >>  EXPORT_SYMBOL(amba_request_regions);
> >>  EXPORT_SYMBOL(amba_release_regions);
> >>+
> >>+#ifdef CONFIG_OF
> >>+int of_amba_device_create(struct device_node *node,struct device *parent)
> >>+{
> >>+	struct amba_device *dev;
> >>+	const void *prop;
> >>+	int i, ret;
> >>+
> >>+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> >>+	if (!dev)
> >>+		return -ENOMEM;
> >>+
> >>+	/* setup generic device info */
> >>+	dev->dev.coherent_dma_mask = ~0;
> >>+	dev->dev.of_node = node;
> >>+	dev->dev.parent = parent;
> >>+	of_device_make_bus_id(&dev->dev);
> >>+
> >>+	/* setup amba-specific device info */
> >>+	dev->dma_mask = ~0;
> >>+
> >>+	/* Decode the IRQs and address ranges */
> >>+	for (i = 0; i<  AMBA_NR_IRQS; i++)
> >>+		dev->irq[i] = irq_of_parse_and_map(node, i);
> >>+
> >>+	ret = of_address_to_resource(node, 0,&dev->res);
> >>+	if (ret)
> >>+		goto err_free;
> >>+
> >>+	ret = amba_device_register(dev,&iomem_resource);
> >>+	if (ret)
> >>+		goto err_free;
> >>+
> >>+	/* Sanity check the arm,amba-deviceid value */
> >>+	prop = of_get_property(node, "arm,amba-deviceid", NULL);
> >>+	if (!prop)
> >>+		dev_warn(&dev->dev, "arm,amba-deviceid property missing; "
> >>+				    "probe gives 0x%08x.\n", dev->periphid);
> >>+
> >>+	if (prop&&  (dev->periphid != of_read_ulong(prop, 1)))
> >>+		dev_warn(&dev->dev, "arm,amba-deviceid value (0x%08lx) and "
> >>+				    "probed value (0x%08x) don't agree.",
> >>+				    of_read_ulong(prop, 1), dev->periphid);
> >>+
> >>+	return 0;
> >>+
> >>+err_free:
> >>+	kfree(dev);
> >>+	return ret;
> >>+}
> >>+
> >>+/**
> >>+ * of_amba_bus_create() - Create a device for a node and its children.
> >>+ * @bus: device node of the bus to instantiate
> >>+ * @matches: match table for bus nodes
> >>+ * disallow recursive creation of child buses
> >>+ * @parent: parent for new device, or NULL for top level.
> >>+ *
> >>+ * Recursively create devices for all the child nodes.
> >>+ */
> >>+static int of_amba_bus_create(struct device_node *bus,
> >>+			      const struct of_device_id *matches,
> >>+			      struct device *parent)
> >>+{
> >>+	struct of_platform_prepare_data *prep;
> >>+	struct device_node *child;
> >>+	struct platform_device *dev;
> >>+	int rc = 0;
> >>+
> >>+	/* Make sure it has a compatible property */
> >>+	if (!of_get_property(bus, "compatible", NULL)) {
> >>+		pr_debug("%s() - skipping %s, no compatible prop\n",
> >>+			 __func__, bus->full_name);
> >>+		return 0;
> >>+	}
> >>+
> >>+	if (!of_match_node(matches, bus))
> >>+		return 0;
> >>+
> >>+	dev = of_platform_device_create(bus, NULL, parent);
> >>+	if (!dev)
> >>+		return 0;
> >
> >Hahaha, I think I see where we're getting our models crossed.
> >
> >The use-case of of_amba_bus_populate should be that the device
> >representing the amba bus (which will be a platform device) should
> >have already been created before calling of_amba_bus_populate().
> >of_amba_bus_populate should then be responsible for creating all the
> >child devices that are on the AMBA bus.
> >
> 
> That was one option I had thought about. I happened to put amba call
> first so I hit the issue. It's a bit fragile to require a certain
> calling order.

Yes, so the goal is not to require a calling order.

> 
> >of_platform_populate does the same thing, except it has some added and
> >*optional* helper logic that allows the populate code to dive deeper
> >into the device hierarchy for any nodes that match the passed in
> >device table.
> >
> That's a bit of an orthogonal problem. In my case, all devices are
> created from the DT. This issue is scanning the devicetree multiple
> times.
> 
> >I'd actually like to be able to integrate AMBA population in
> >of_platform_populate() when it encounters an AMBA bus, but I'm not
> >sure the result will be pretty.  I haven't had a chance to try it.
> >
> 
> That seems like a bad idea to me. It's fine with 1 other bus type,
> but if you had 10 others it would get messy.
> 
> Perhaps scanning the tree for buses first and then scanning for
> devices is a better solution.

However, it would all work with one call if the match table passed
into of_platform_populate() also included a populate hook for each bus
type.  That way it still is up to the platform as to which bus types
to probe.  Or a default list of bus types could be provided too.

g.
