From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 13 Dec 2010 23:34:53 -0700
Subject: [PATCH 10/12] OMAP3: clock: fix incorrect rate display when switching
	MPU rate at boot
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Message-ID: <20101214063452.21555.26259.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP3 clock code contains some legacy code to allow the MPU rate
to be specified as a kernel command line parameter.  If the 'mpurate'
parameter is specified, the kernel will attempt to switch the MPU rate
to this rate during boot.  As part of this process, a short message
"Switched to new clocking rate" is generated -- and in this message,
the "Core" clock rate and "MPU" clock rate are transposed.

This patch ensures that the clock rates are displayed in the correct
order.

Thanks to Bruno Guerin <br_guerin@free.fr> for reporting this bug and
proposing a fix.  Thanks to Richard Woodruff <r-woodruff2@ti.com> for
reviewing the problem and passing the report on.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Bruno Guerin <br.guerin@free.fr>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/clock3xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index a447c4d..90b9477 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -94,7 +94,7 @@ static int __init omap3xxx_clk_arch_init(void)
 
 	ret = omap2_clk_switch_mpurate_at_boot("dpll1_ck");
 	if (!ret)
-		omap2_clk_print_new_rates("osc_sys_ck", "arm_fck", "core_ck");
+		omap2_clk_print_new_rates("osc_sys_ck", "core_ck", "arm_fck");
 
 	return ret;
 }
