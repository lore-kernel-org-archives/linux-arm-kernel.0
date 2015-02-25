From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 09:26:57 +0000
Subject: [BUG] ARM: socfpga: L2 cache init
In-Reply-To: <CADhT+wcpWcfca6JWLAfpQm_yPHOpTRRbCpiikUEs0ha1NHq3TQ@mail.gmail.com>
References: <20150206110557.GY8656@n2100.arm.linux.org.uk>
 <20150209155314.GA7994@pengutronix.de>
 <54D8E3BB.3060505@opensource.altera.com>
 <20150209185820.GB7994@pengutronix.de>
 <20150209213017.GC7994@pengutronix.de>
 <54DD2BB3.3090507@opensource.altera.com>
 <20150213080106.GD7994@pengutronix.de>
 <CADhT+wfbZb+u7a-aCi71rh9xFMuphOvqiyEgEYpmmTQtujLcVg@mail.gmail.com>
 <20150217222817.GS8656@n2100.arm.linux.org.uk>
 <CADhT+wcpWcfca6JWLAfpQm_yPHOpTRRbCpiikUEs0ha1NHq3TQ@mail.gmail.com>
Message-ID: <20150225092657.GU8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 05:55:05PM -0600, Dinh Nguyen wrote:
> Do you have a recommendation on what should be done?

Please try this:

 arch/arm/mach-socfpga/socfpga.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 383d61e138af..f5e597c207b9 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -23,6 +23,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/cacheflush.h>
 
 #include "core.h"
 
@@ -73,6 +74,10 @@ void __init socfpga_sysmgr_init(void)
 			(u32 *) &socfpga_cpu1start_addr))
 		pr_err("SMP: Need cpu1-start-addr in device tree.\n");
 
+	/* Ensure that socfpga_cpu1start_addr is visible to other CPUs */
+	smp_wmb();
+	sync_cache_w(&socfpga_cpu1start_addr);
+
 	sys_manager_base_addr = of_iomap(np, 0);
 
 	np = of_find_compatible_node(NULL, NULL, "altr,rst-mgr");

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
