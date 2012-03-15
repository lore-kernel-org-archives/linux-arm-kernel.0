From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Thu, 15 Mar 2012 16:36:23 +0530
Subject: [PATCH-V3 0/3] ARM: OMAP2+: Add powerdomain & PRM support for AM33XX
 device
Message-ID: <1331809586-24652-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After going round-n-round on how to add support for AM33XX family
of device into kernel, especially for PRM and CM support, we have
decided to handle it separately; as AM33XX-PRCM module is different
than OMAP3 and OMAP4 architecture.

The difference becomes very interesting/weird when it comes to
the consistency for register offsets in PRM address space and
bit-field offsets inside PRM registers,
So along with Powerdomain data and PRM api's required for AM33XX
device, this patch series adds,

 - XXX_RSTST register offset to "struct omap_hwmod_omap4_prcm"
 - PWRSTCTRL & PWRSTST register offsets to "struct powerdomain"
 - Logicretstate and mem_on/ret/pwrst/retst mask to "struct powerdomain"


Testing: This patch series has been boot tested on AM37xEVM and AM335x
         based BeagleBone community board.

THANKS TO PAUL HERE...for helping and concluding on this, soon I will
have similar patch for CM support, then clock-tree and hwmod will follow...

Changes from V1 & V2:
	- Rolled back to my original approach, where AM33xx device was
	  handled separately (RFC version).
	- As per Paul's comments, added Register offsets & bit-fields
	  masks.

Vaibhav Hiremath (3):
  ARM: OMAP3/4: omap_hwmod: Add rstst_off field to struct
    omap_hwmod_omap4_prcm
  ARM: OMAP2+: powerdomain: Add offset & mask fields to struct
    powerdomain
  ARM: OMAP3+: am33xx: Add power domain data

 arch/arm/mach-omap2/Makefile                 |    4 +
 arch/arm/mach-omap2/io.c                     |    1 +
 arch/arm/mach-omap2/omap_hwmod.c             |   32 ++-
 arch/arm/mach-omap2/powerdomain.h            |   23 ++-
 arch/arm/mach-omap2/powerdomain33xx.c        |  230 +++++++++++++++++
 arch/arm/mach-omap2/powerdomains33xx_data.c  |  185 +++++++++++++
 arch/arm/mach-omap2/prm-regbits-33xx.h       |  357 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm33xx.c                |  134 ++++++++++
 arch/arm/mach-omap2/prm33xx.h                |  129 +++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 10 files changed, 1092 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/prm33xx.c
 create mode 100644 arch/arm/mach-omap2/prm33xx.h
