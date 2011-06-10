From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 10 Jun 2011 17:11:46 -0600
Subject: [PATCH v4 3/4] drivers/amba: create devices from device tree
In-Reply-To: <4DF29CB1.9070701@gmail.com>
References: <1307738923-7564-1-git-send-email-robherring2@gmail.com>
	<1307738923-7564-4-git-send-email-robherring2@gmail.com>
	<20110610222236.GD28994@ponder.secretlab.ca>
	<4DF29CB1.9070701@gmail.com>
Message-ID: <20110610231146.GG28994@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 05:37:37PM -0500, Rob Herring wrote:
> On 06/10/2011 05:22 PM, Grant Likely wrote:
> >On Fri, Jun 10, 2011 at 03:48:42PM -0500, Rob Herring wrote:
> >>From: Rob Herring<rob.herring@calxeda.com>
> >>
> >>Add a function to create amba bus devices (i.e. primecell peripherals) from
> >>device tree nodes. The device tree scanning is done by
> >>of_platform_probe/populate functions which can call of_amba_device_create
> >>based on a match table entry.
> >>
> >>Nodes with a "arm,amba-deviceid" property can override the h/w peripheral id
> >>value.
> >>
> >>Based on the original work by Jeremy Kerr.
> >>
> >>Cc: Jeremy Kerr<jeremy.kerr@canonical.com>
> >>Cc: Grant Likely<grant.likely@secretlab.ca>
> >>Cc: linux at arm.linux.org.uk
> >>Cc: arnd at arndb.de
> >>Acked-by: Linus Walleij<linus.walleij@linaro.org>
> >>Signed-off-by: Rob Herring<rob.herring@calxeda.com>
> >>---
> >>  Documentation/devicetree/bindings/arm/amba.txt |   21 ++++++++++
> >>  drivers/amba/bus.c                             |   51 ++++++++++++++++++++++++
> >>  include/linux/amba/bus.h                       |   18 ++++++++
> >>  3 files changed, 90 insertions(+), 0 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/amba.txt
> >>
> >>diff --git a/Documentation/devicetree/bindings/arm/amba.txt b/Documentation/devicetree/bindings/arm/amba.txt
> >>new file mode 100644
> >>index 0000000..23fde7f
> >>--- /dev/null
> >>+++ b/Documentation/devicetree/bindings/arm/amba.txt
> >>@@ -0,0 +1,21 @@
> >>+* ARM Primecell Peripherals
> >>+
> >>+ARM, Ltd. Primecell peripherals have a standard id register that can be used to
> >>+identify the peripheral type, vendor, and revision. This value can be used for
> >>+driver matching.
> >>+
> >>+Required properties:
> >>+
> >>+- compatible : should be a specific value for peripheral and "arm,amba-device"
> >
> >After recent conversations, I'd like to change this to
> >"arm,primecell" to better reflect the kind of devices it models.
> 
> That did cross my mind as I was writing the doc...
> 
> >
> >>+
> >>+Optional properties:
> >>+
> >>+- arm,amba-deviceid : Value to override the h/w value with
> >
> >Similarly, based on the primecell device documents, this should
> >probabaly be arm,primecell-periphid.
> >
> >>+
> >>+Example:
> >>+
> >>+serial at fff36000 {
> >>+	compatible = "arm,pl011", "arm,amba-device";
> >>+	arm,amba-deviceid =<0x00341011>;
> >>+};
> >>+
> >>diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> >>index d74926e..19f712b 100644
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
> >>@@ -785,3 +790,49 @@ EXPORT_SYMBOL(amba_device_unregister);
> >>  EXPORT_SYMBOL(amba_find_device);
> >>  EXPORT_SYMBOL(amba_request_regions);
> >>  EXPORT_SYMBOL(amba_release_regions);
> >>+
> >>+#ifdef CONFIG_OF
> >>+int of_amba_device_create(struct device_node *node, struct device *parent)
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
> >>+	/* Allow the arm,amba-deviceid value to override the h/w value */
> >>+	prop = of_get_property(node, "arm,amba-deviceid", NULL);
> >>+	if (prop)
> >>+		dev->periphid = of_read_ulong(prop, 1);
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
> >>+	return 0;
> >>+
> >>+err_free:
> >>+	kfree(dev);
> >>+	return ret;
> >>+}
> >>+
> >
> >Yeah, I think this looks like the right thing to do.  I'll pick it up
> >into devicetree/test and probably move it to devicetree/arm in the
> >near future after testing a bit.
> 
> Okay, I'll respin with your and Arnd's comments.

Actually, hold off.  I'm working on it right now so I can get it into
my tree.  I'll take care of the respin.

g.
