From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 03 Dec 2009 06:49:54 -0700
Subject: [PATCH 07/10] OMAP: omap_device: use read_persistent_clock() instead
	of getnstimeofday()
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Message-ID: <20091203134952.17146.59330.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@deeprootsystems.com>

During suspend and resume, when omap_device deactivation and
activation is happening, the timekeeping subsystem has likely already
been suspended.  Thus getnstimeofday() will fail and trigger a WARN().

Use read_persistent_clock() instead of getnstimeofday() to avoid this.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 54fe0a2..9a502af 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -134,12 +134,12 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		    (od->dev_wakeup_lat <= od->_dev_wakeup_lat_limit))
 			break;
 
-		getnstimeofday(&a);
+		read_persistent_clock(&a);
 
 		/* XXX check return code */
 		odpl->activate_func(od);
 
-		getnstimeofday(&b);
+		read_persistent_clock(&b);
 
 		c = timespec_sub(b, a);
 		act_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
@@ -190,12 +190,12 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		     od->_dev_wakeup_lat_limit))
 			break;
 
-		getnstimeofday(&a);
+		read_persistent_clock(&a);
 
 		/* XXX check return code */
 		odpl->deactivate_func(od);
 
-		getnstimeofday(&b);
+		read_persistent_clock(&b);
 
 		c = timespec_sub(b, a);
 		deact_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
