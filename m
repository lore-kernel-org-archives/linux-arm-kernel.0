From: mturquette@ti.com (Mike Turquette)
Date: Wed, 3 Oct 2012 18:16:02 -0700
Subject: [PATCH 2/5] ARM: omap: introduce .get_voltage callback
In-Reply-To: <1349313365-5262-1-git-send-email-mturquette@ti.com>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Message-ID: <1349313365-5262-3-git-send-email-mturquette@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Turquette <mturquette@linaro.org>

Introduces a new callback to struct voltagedomain for retrieving the
voltage of the voltage domain from the hardware.  This will be used to
populate voltdm->nominal_volt during initialization of the voltage code
instead of waiting for the first call to voltdm_scale.

In the event of an error or the inability to determine voltage the
callback must return zero.  It is the callers responsibility to
gracefully degrade when presented with a voltage of zero.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 arch/arm/mach-omap2/voltage.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 0ac2caf..0ded54f 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -85,6 +85,7 @@ struct voltagedomain {
 		u32 rate;
 	} sys_clk;
 
+	unsigned long (*get_voltage) (struct voltagedomain *voltdm);
 	int (*scale) (struct voltagedomain *voltdm,
 		      unsigned long target_volt);
 
-- 
1.7.9.5
