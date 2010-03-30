From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Mar 2010 01:56:45 -0600
Subject: [PATCH 1/4] OMAP: HWMOD: Adding clockdomain check
In-Reply-To: <20100330074801.11629.61888.stgit@localhost.localdomain>
References: <20100330074801.11629.61888.stgit@localhost.localdomain>
Message-ID: <20100330075638.11629.98717.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thara Gopinath <thara@ti.com>

This patch adds check for presence of clockdomain structure in the API
omap_hwmod_get_pwrdm before trying to access the powerdomain structure.
This will prevent unnecessary crashing of the system in case of a
clock node with out an associated clockdomain.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index c664947..e436dcb 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1511,6 +1511,9 @@ struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh)
 		c = oh->slaves[oh->_mpu_port_index]->_clk;
 	}
 
+	if (!c->clkdm)
+		return NULL;
+
 	return c->clkdm->pwrdm.ptr;
 
 }
