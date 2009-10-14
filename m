From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 14 Oct 2009 16:31:45 -0600
Subject: [PATCH 2/2] OMAP2xxx clock: set up clockdomain pointer in struct clk
In-Reply-To: <20091014222609.5545.7736.stgit@localhost.localdomain>
References: <20091014222609.5545.7736.stgit@localhost.localdomain>
Message-ID: <20091014223140.5545.77829.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clock24xx.c is missing a omap2_init_clk_clkdm() in its
omap2_clk_init() function.  Among other bad effects, this causes the
OMAP hwmod layer to oops on boot.

Thanks to Carlos Aguiar <carlos.aguiar@indt.org.br> and Stefano
Panella <Stefano.Panella@csr.com> for reporting this bug.  Thanks to Tony
Lindgren <tony@atomide.com> for N800 booting advice.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: Stefano Panella <Stefano.Panella@csr.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock24xx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index bc5d3ac..e2dbedd 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -769,6 +769,7 @@ int __init omap2_clk_init(void)
 		if (c->cpu & cpu_mask) {
 			clkdev_add(&c->lk);
 			clk_register(c->lk.clk);
+			omap2_init_clk_clkdm(c->lk.clk);
 		}
 
 	/* Check the MPU rate set by bootloader */
