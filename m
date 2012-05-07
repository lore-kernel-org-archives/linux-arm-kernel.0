From: rob.lee@linaro.org (Robert Lee)
Date: Mon,  7 May 2012 16:16:44 -0500
Subject: [PATCH v3 0/3] Add imx cpuidle
Message-ID: <1336425407-20308-1-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add common imx cpuidle initialization functionality and add a i.MX5 and i.MX6Q
platform cpuidle implementation.

Based on v3.4-rc6 plus recently submitted device tree late_initcall patch:
 http://www.spinics.net/lists/arm-kernel/msg171620.html

v3 changes:
 * removed file introduced in v1 no longer needed after v2 [per Shawn Guo]
 * re-ordered added #includes in alphabetical order [per Shawn Guo]
 * Remove if(!drv) check to allow handling by stack trace [per Sascha Hauer]
 * Added missing return value in error meesage [per Shawn Guo]
 * fixed (void *) casting problem pointed out Sasha Hauer.  Used a different
   type of casting to properly give warning on improper casting:
   	arm_pm_idle = (void (*)(void))imx5_idle;
   Used this casting instead of adding a dummy caller function because
   adding the dummy function appears to unnecessarily introduce the following
   additional operations:
	static void imx5_pm_idle(void)
	{
	  a0:	e1a0c00d 	mov	ip, sp
	  a4:	e92dd800 	push	{fp, ip, lr, pc}
	  a8:	e24cb004 	sub	fp, ip, #4
		imx5_idle();
	  ac:	ebffffd3 	bl	0 <imx5_idle>
	}
	  b0:	e89da800 	ldm	sp, {fp, sp, pc}

v2 changes:
 * Removed some unnecessary  spaces [per Jess Juhl]
 * Added return value for an error message [per Sascha Hauer]
 * Reworked init scheme to use device tree late_initcall [per Sascha and Shawn]
 * Moved imx6q and imx5 cpuidle functionality to existing files.

https://lkml.org/lkml/2012/5/1/363

v1 initial submission:

https://lkml.org/lkml/2012/4/16/644

Robert Lee (3):
  ARM: imx: Add common imx cpuidle init functionality.
  ARM: imx: Add imx5 cpuidle driver
  ARM: imx: Add imx6q cpuidle driver

 arch/arm/mach-imx/mach-imx6q.c           |   19 +++++++
 arch/arm/mach-imx/mm-imx5.c              |   42 ++++++++++++++--
 arch/arm/plat-mxc/Makefile               |    1 +
 arch/arm/plat-mxc/cpuidle.c              |   80 ++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/cpuidle.h |   22 ++++++++
 5 files changed, 161 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-mxc/cpuidle.c
 create mode 100644 arch/arm/plat-mxc/include/mach/cpuidle.h

-- 
1.7.10
