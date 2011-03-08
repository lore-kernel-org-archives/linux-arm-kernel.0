From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 07 Mar 2011 19:15:46 -0700
Subject: [PATCH 0/3] OMAP2+: powerdomain: add fn to determine whether pwrdm is
	always on
Message-ID: <20110308021018.31946.29962.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this series adds an OMAP powerdomain API function that allows its
callers to determine whether a particular powerdomain can ever lose
register or memory bank context while the SoC is powered.  This is
intended for use by driver-subarch integration code (i.e.,
arch/arm/*omap*) to pass a flag to the driver to determine whether it
is necessary to save and restore driver context.

As part of this series, fix some long-standing bugs in the powerdomain
data.  These fixes are necessary for this function to work, and also
for OSWR support.

Tested on OMAP35xx BeagleBoard and OMAP44xx Pandaboard.


- Paul

pwrdm_add_can_lose_context_fns_2.6.39
   text	   data	    bss	    dec	    hex	filename
5795912	 501512	5598936	11896360	 b58628	vmlinux.omap2plus_defconfig.orig
5796064	 501512	5598936	11896512	 b586c0	vmlinux.omap2plus_defconfig

Paul Walmsley (3):
      OMAP2/3: WKUP powerdomain: mark as being always on
      OMAP2+: powerdomain: fix bank power state bitfields
      OMAP2+: powerdomain: add pwrdm_can_ever_lose_context()


 arch/arm/mach-omap2/powerdomain.c                |   43 +++++++++++
 arch/arm/mach-omap2/powerdomain.h                |   18 ++---
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    9 +-
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |   18 ++---
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   38 +++++-----
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   84 +++++++++++-----------
 6 files changed, 125 insertions(+), 85 deletions(-)
