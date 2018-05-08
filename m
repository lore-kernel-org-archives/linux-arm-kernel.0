From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 8 May 2018 14:06:28 -0500
Subject: [PATCH 1/4] amba: Export amba_bustype
Message-ID: <20180508140628.f30774c70c4c481bff3f8000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is provided in the context of allowing the Coresight driver
subsystem to be loaded as modules.  Coresight uses amba_bus in its call
to bus_find_device() in of_coresight_get_endpoint_device() when
searching for a configurable endpoint device.  This patch allows
Coresight to reference amba_bustype when built as a module.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Todd Kjos <tkjos@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
There was a prior patch submitted by Alex W. here:

https://lkml.org/lkml/2017/6/19/811

But I can't tell its fate - presume simply delayed?

Coresight uses amba_bus in its call to bus_find_device() here:

https://lxr.missinglinkelectronics.com/linux/drivers/hwtracing/coresight/of_coresight.c#L51

Grepping for bus_type and EXPORT shows other busses exporting their
type, so I don't think this is the wrong approach.  If, OTOH, Coresight
needs to do something differently, please comment.

 drivers/amba/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 594c228d2f02..12283bd06733 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -197,6 +197,7 @@ struct bus_type amba_bustype = {
 	.pm		= &amba_pm,
 	.force_dma	= true,
 };
+EXPORT_SYMBOL_GPL(amba_bustype);
 
 static int __init amba_init(void)
 {
-- 
2.16.2
