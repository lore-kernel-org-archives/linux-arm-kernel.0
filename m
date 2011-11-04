From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  4 Nov 2011 01:09:57 +0000
Subject: [PATCHv4 00/13] VIC DT binding and MULTI_IRQ_HANDLER
Message-ID: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the last revision I've updated the handling loop as suggested by
Linus and Russell, added a patch for picoxcell and added a final patch
to remove the non MULTI_IRQ_HANDLER support for VIC.  The final patch
assumes that all VIC users will be converted to MULTI_IRQ_HANDLER which
I would hope would be the case but this could be dropped if not.

I've also included Marc's patch for reference as the mach patches are
dependent on it.

Jamie Iles (12):
  ARM: vic: device tree binding
  ARM: vic: MULTI_IRQ_HANDLER handler
  ARM: ep93xx: convert to MULTI_IRQ_HANDLER
  ARM: netx: convert to MULTI_IRQ_HANDLER
  ARM: nomadik: convert to MULTI_IRQ_HANDLER
  ARM: s3c64xx: convert to MULTI_IRQ_HANDLER
  ARM: spear: convert to MULTI_IRQ_HANDLER
  ARM: u300: convert to MULTI_IRQ_HANDLER
  ARM: versatile: convert to MULTI_IRQ_HANDLER
  ARM: samsung: convert to MULTI_IRQ_HANDLER
  ARM: picoxcell: convert to MULTI_IRQ_HANDLER
  ARM: VIC: remove non MULTI_IRQ_HANDLER support

Marc Zyngier (1):
  ARM: Make global handler and CONFIG_MULTI_IRQ_HANDLER mutually
    exclusive

 Documentation/devicetree/bindings/arm/vic.txt      |   29 ++++
 arch/arm/common/Kconfig                            |    2 +
 arch/arm/common/vic.c                              |  142 ++++++++++++++++----
 arch/arm/include/asm/entry-macro-vic2.S            |   57 --------
 arch/arm/include/asm/hardware/vic.h                |   10 ++-
 arch/arm/kernel/entry-armv.S                       |    7 +-
 arch/arm/mach-ep93xx/adssphere.c                   |    2 +
 arch/arm/mach-ep93xx/edb93xx.c                     |    9 ++
 arch/arm/mach-ep93xx/gesbc9312.c                   |    2 +
 arch/arm/mach-ep93xx/include/mach/entry-macro.S    |   42 ------
 arch/arm/mach-ep93xx/micro9.c                      |    5 +
 arch/arm/mach-ep93xx/simone.c                      |    2 +
 arch/arm/mach-ep93xx/snappercl15.c                 |    2 +
 arch/arm/mach-ep93xx/ts72xx.c                      |    2 +
 arch/arm/mach-netx/include/mach/entry-macro.S      |   13 --
 arch/arm/mach-netx/nxdb500.c                       |    2 +
 arch/arm/mach-netx/nxdkn.c                         |    2 +
 arch/arm/mach-netx/nxeb500hmi.c                    |    2 +
 arch/arm/mach-nomadik/board-nhk8815.c              |    2 +
 arch/arm/mach-nomadik/include/mach/entry-macro.S   |   30 ----
 arch/arm/mach-picoxcell/common.c                   |    9 +-
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   11 +-
 arch/arm/mach-pxa/include/mach/entry-macro.S       |   36 -----
 arch/arm/mach-s3c64xx/include/mach/entry-macro.S   |    7 +-
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    2 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +
 arch/arm/mach-s3c64xx/mach-hmt.c                   |    2 +
 arch/arm/mach-s3c64xx/mach-mini6410.c              |    2 +
 arch/arm/mach-s3c64xx/mach-ncp.c                   |    2 +
 arch/arm/mach-s3c64xx/mach-real6410.c              |    2 +
 arch/arm/mach-s3c64xx/mach-smartq5.c               |    2 +
 arch/arm/mach-s3c64xx/mach-smartq7.c               |    2 +
 arch/arm/mach-s3c64xx/mach-smdk6400.c              |    2 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    2 +
 arch/arm/mach-s5p64x0/include/mach/entry-macro.S   |    7 +-
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |    2 +
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |    2 +
 arch/arm/mach-s5pc100/include/mach/entry-macro.S   |   25 ----
 arch/arm/mach-s5pc100/mach-smdkc100.c              |    2 +
 arch/arm/mach-s5pv210/include/mach/entry-macro.S   |   37 -----
 arch/arm/mach-s5pv210/mach-aquila.c                |    2 +
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 +
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    2 +
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +
 arch/arm/mach-s5pv210/mach-torbreck.c              |    2 +
 arch/arm/mach-shmobile/include/mach/entry-macro.S  |    9 --
 arch/arm/mach-spear3xx/include/mach/entry-macro.S  |   27 ----
 arch/arm/mach-spear3xx/spear300_evb.c              |    2 +
 arch/arm/mach-spear3xx/spear310_evb.c              |    2 +
 arch/arm/mach-spear3xx/spear320_evb.c              |    2 +
 arch/arm/mach-spear6xx/include/mach/entry-macro.S  |   36 -----
 arch/arm/mach-spear6xx/spear600_evb.c              |    2 +
 arch/arm/mach-u300/include/mach/entry-macro.S      |   24 ----
 arch/arm/mach-u300/u300.c                          |    2 +
 arch/arm/mach-versatile/include/mach/entry-macro.S |   30 ----
 arch/arm/mach-versatile/versatile_ab.c             |    2 +
 arch/arm/mach-versatile/versatile_dt.c             |    2 +
 arch/arm/mach-versatile/versatile_pb.c             |    2 +
 58 files changed, 257 insertions(+), 417 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vic.txt
 delete mode 100644 arch/arm/include/asm/entry-macro-vic2.S

-- 
1.7.5.4
