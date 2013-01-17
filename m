From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 17 Jan 2013 23:24:47 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2: Fix missing omap2xxx_clkt_vps_xxx function
 calls
In-Reply-To: <alpine.DEB.2.00.1301172230250.14118@utopia.booyaka.com>
References: <1357851209-5332-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1301171848490.14118@utopia.booyaka.com>
 <50F85087.3060507@ti.com>
 <alpine.DEB.2.00.1301172230250.14118@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1301172320460.14118@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here's the updated version (at the bottom of this message). Seems to work 
based on a quick test on 2430SDP.

# shutdown -r -n now
shutdown: sending all processes the TERM signal...
shutdown: sending all processes the KILL signal.
shutdown: turning off swap
shutdown: unmounting all file systems
umount: /debug: not mounted
umount: /run/shm: not mounted
umount: /dev: not mounted
umount: /tmp: not mounted
umount: /run/lock: not mounted
umount: /run: not mounted
umount: /lib/init/rw: not found
Please stand by while rebooting the system.
[   79.635925] Disabling non-boot CPUs ...
[   79.640197] Restarting system.


U-Boot 1.1.4 (Mar 18 2007 - 12:22:00)

OMAP2430C-GP revision 3, PRCM #5A
TI 2430SDP 1.1 Version + mDDR (Boot NOR)
DRAM:  128 MB
Flash: 192 MB
NAND:64 MB
In:    serial
Out:   serial
Err:   serial
Hit any key to stop autoboot:  0 


... etc. ...


- Paul


From: Jon Hunter <jon-hunter@ti.com>
Date: Thu, 10 Jan 2013 14:53:29 -0600
Subject: [PATCH] ARM: OMAP2: Fix missing omap2xxx_clkt_vps_late_init function
 calls

During the migration to the common clock framework, calls to the
functions omap2xxx_clkt_vps_late_init() were not preserved for
OMAP2420 and OMAP2430. This causes the variables "sys_ck_rate" and
"curr_prcm_set" to be uninitialised on boot. On reboot, this causes the
following error message to be displayed because the appropriate MPU
clock frequency (derived from sys_ck_rate) cannot be found.

"Could not set MPU rate to 4294MHz"

Fix this by adding back calls to omap2xxx_clkt_vps_late_init() in the
OMAP2420 and OMAP2430 clock initialisation code.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
[paul at pwsan.com: dropped the duplicated call to
 omap2xxx_clkt_vps_check_bootloader_rates() after consultation with Jon;
 updated patch description]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cclock2420_data.c |    2 ++
 arch/arm/mach-omap2/cclock2430_data.c |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock2420_data.c b/arch/arm/mach-omap2/cclock2420_data.c
index 7e5febe..ab7e952 100644
--- a/arch/arm/mach-omap2/cclock2420_data.c
+++ b/arch/arm/mach-omap2/cclock2420_data.c
@@ -1935,6 +1935,8 @@ int __init omap2420_clk_init(void)
 			omap2_init_clk_hw_omap_clocks(c->lk.clk);
 	}
 
+	omap2xxx_clkt_vps_late_init();
+
 	omap2_clk_disable_autoidle_all();
 
 	omap2_clk_enable_init_clocks(enable_init_clks,
diff --git a/arch/arm/mach-omap2/cclock2430_data.c b/arch/arm/mach-omap2/cclock2430_data.c
index eda079b..eb3dab6 100644
--- a/arch/arm/mach-omap2/cclock2430_data.c
+++ b/arch/arm/mach-omap2/cclock2430_data.c
@@ -2050,6 +2050,8 @@ int __init omap2430_clk_init(void)
 			omap2_init_clk_hw_omap_clocks(c->lk.clk);
 	}
 
+	omap2xxx_clkt_vps_late_init();
+
 	omap2_clk_disable_autoidle_all();
 
 	omap2_clk_enable_init_clocks(enable_init_clks,
-- 
1.7.10.4
