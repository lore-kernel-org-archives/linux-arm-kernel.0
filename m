From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 9 May 2018 14:38:32 +0100
Subject: [PATCH 1/4] amba: Export amba_bustype
In-Reply-To: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
References: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
Message-ID: <8c2648ec-1379-fb2a-35d2-b3fa8fc9f063@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kim,

On 08/05/18 20:06, Kim Phillips wrote:
> This patch is provided in the context of allowing the Coresight driver
> subsystem to be loaded as modules.  Coresight uses amba_bus in its call
> to bus_find_device() in of_coresight_get_endpoint_device() when
> searching for a configurable endpoint device.  This patch allows
> Coresight to reference amba_bustype when built as a module.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
> There was a prior patch submitted by Alex W. here:
> 
> https://lkml.org/lkml/2017/6/19/811
> 
> But I can't tell its fate - presume simply delayed?
> 
> Coresight uses amba_bus in its call to bus_find_device() here:
> 
> https://lxr.missinglinkelectronics.com/linux/drivers/hwtracing/coresight/of_coresight.c#L51
> 
> Grepping for bus_type and EXPORT shows other busses exporting their
> type, so I don't think this is the wrong approach.  If, OTOH, Coresight
> needs to do something differently, please comment.

Exposing raw bus_types is pretty ugly, but it is indeed the status quo, 
so this probably is the reasonable thing to do. I suppose an amba_bus 
equivalent of of_find_device_by_node() could be implemented, but for 
only a single potential user that doesn't seem particularly worthwhile, 
since unless some massive shake-up of how buses work comes along the 
bus_type will inevitably end up being exported for other reasons anyway. 
So, in the context of this series;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

However, as a wild idea for sidestepping the issue completely (or at 
least keeping it within the CoreSight framework), at first glance it 
appears something like the below might be feasible, although I may well 
be missing some obvious reason why not.

Thanks,
Robin.

----->8-----
diff --git a/drivers/hwtracing/coresight/of_coresight.c 
b/drivers/hwtracing/coresight/of_coresight.c
index 7c375443ede6..2c3fdc9b63e6 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -27,28 +27,13 @@

  static int of_dev_node_match(struct device *dev, void *data)
  {
-	return dev->of_node == data;
+	return dev->parent->of_node == data;
  }

  static struct device *
  of_coresight_get_endpoint_device(struct device_node *endpoint)
  {
-	struct device *dev = NULL;
-
-	/*
-	 * If we have a non-configurable replicator, it will be found on the
-	 * platform bus.
-	 */
-	dev = bus_find_device(&platform_bus_type, NULL,
-			      endpoint, of_dev_node_match);
-	if (dev)
-		return dev;
-
-	/*
-	 * We have a configurable component - circle through the AMBA bus
-	 * looking for the device that matches the endpoint node.
-	 */
-	return bus_find_device(&amba_bustype, NULL,
+	return bus_find_device(&coresight_bustype, NULL,
  			       endpoint, of_dev_node_match);
  }
