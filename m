From: avinashhm@ti.com (Avinash.H.M)
Date: Tue,  5 Apr 2011 21:10:13 +0530
Subject: [PATCH 0/2 v2] OMAP2/3: fix the i2c,gpio reset timeouts during boot.
Message-ID: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ,

The patches solve the reset timeouts seen in i2c and gpio modules while
booting omap2 and omap3.

version: v2
* For discussion on v1, please refer 
 	http://www.spinics.net/lists/linux-omap/msg49483.html
* changes from v1:
	- moved i2c specific things from hwmod files to i2c files.
	- fixed comments from Paul.

Baseline:
The patches are based on 
* git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
* master branch.
* v2.6.39-rc1 commit (0ce790e)

Testing:
* build tested omap2plus_defconfig for warnings and errors. none introduced.
* boot tested on 2430. 
* tested for 'core off' in suspend resume on 3430 sdp. core off counters
  increment after suspend resume. Core off works with below commands,

echo 1 > /debug/pm_debug/enable_off_mode
echo mem > /sys/power/state
cat /debug/pm_debug/count | grep ^core

Dependencies:
* need patch "OMAP2+: hwmod data: Set hwmod flags to only allow 16-bit
  accesses to i2c" from Andry Green for accessing i2c_sysc. Without this even
  with this patch, we will see i2c reset timeouts.

br ,
- Avinash

---

Avinash.H.M (2):
  OMAP2/3: hwmod: fix the i2c-reset timeout during bootup
  OMAP2/3: hwmod: fix gpio-reset timeouts seen during bootup.

 arch/arm/mach-omap2/i2c.c                  |   58 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    5 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 +++
 arch/arm/plat-omap/include/plat/i2c.h      |    3 +
 5 files changed, 79 insertions(+), 0 deletions(-)
