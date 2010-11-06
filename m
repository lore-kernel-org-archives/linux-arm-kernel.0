From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Fri,  5 Nov 2010 19:17:17 -0600
Subject: [PATCH v2 0/7] omap: mailbox: hwmod support and dependent cleanup
	patches
Message-ID: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hwmod support for omap2 and omap3 chips, plus cleanups.

Tested on 3430 and 3630

** v2 **
- Added omap4 hwmod support.
- Moved "mailbox_ick" from hwmod to hwmod_if (omap 2/3)
- Declared sysc classes for omap 2/3

** v1 **
1. omap: mailbox: initial hwmod support for omap3
Changes were made to:
- Rebase to latest code.
- Detect the hwmod by filling prcm union for omap2, without
  this it was unable to build the hwmod at runtime.
- Replace magic number for defines.
- Use ioremap again instead of relying on the one made by hwmod,
  as noted in http://patchwork.kernel.org/patch/101661/

2. omap: mailbox: initial hwmod support for omap2
Was only compiled tested!! Unfortunately I don't have the HW for it.

4. omap: mailbox: fix detection for previously supported chips
Original patch was using features framework, but when compiled as a module
it was breaking, this patch uses cpu_is_omap34xx macro instead. This is
meant as a short term solution until proper cleanup is done, as suggested in:

http://marc.info/?l=linux-arm-kernel&m=128534253231481&w=2

Benoit Cousson (1):
  OMAP4: hwmod data: add mailbox data

Felipe Contreras (3):
  OMAP3: hwmod data: add mailbox data
  omap: mailbox: initial hwmod support
  omap: mailbox: add omap_device latency information

Omar Ramirez Luna (3):
  OMAP2: hwmod data: add mailbox data
  omap: mailbox: fix detection for previously supported chips
  omap: mailbox: remove unreachable return

 arch/arm/mach-omap2/devices.c              |  104 +++++++---------------------
 arch/arm/mach-omap2/mailbox.c              |   39 +++++-----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   67 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   66 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   66 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   63 +++++++++++++++++
 arch/arm/plat-omap/include/plat/mailbox.h  |    6 ++
 7 files changed, 311 insertions(+), 100 deletions(-)
