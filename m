From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 03 Dec 2009 06:49:57 -0700
Subject: [PATCH 09/10] OMAP: omap_device: fix nsec/usec conversion in latency
	calculations
In-Reply-To: <20091203134852.17146.81997.stgit@localhost.localdomain>
References: <20091203134852.17146.81997.stgit@localhost.localdomain>
Message-ID: <20091203134955.17146.60626.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Use

   usecs = nsecs / NSEC_PER_USEC;

instead of

   usecs = nsecs * NSEC_PER_USEC;

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9a502af..51c9d56 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -142,7 +142,7 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 		read_persistent_clock(&b);
 
 		c = timespec_sub(b, a);
-		act_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
+		act_lat = timespec_to_ns(&c) / NSEC_PER_USEC;
 
 		pr_debug("omap_device: %s: pm_lat %d: activate: elapsed time "
 			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
@@ -198,7 +198,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 		read_persistent_clock(&b);
 
 		c = timespec_sub(b, a);
-		deact_lat = timespec_to_ns(&c) * NSEC_PER_USEC;
+		deact_lat = timespec_to_ns(&c) / NSEC_PER_USEC;
 
 		pr_debug("omap_device: %s: pm_lat %d: deactivate: elapsed time "
 			 "%llu usec\n", od->pdev.name, od->pm_lat_level,
