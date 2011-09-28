From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 28 Sep 2011 11:41:37 +0100
Subject: [PATCHv2 00/10] VIC DT binding and MULTI_IRQ_HANDLER
Message-ID: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds a device tree binding for the VIC and support for
a generic VIC MULTI_IRQ_HANDLER.  The MULTI_IRQ_HANDLER is a step
towards a single image kernel, removing the need for mach specific entry
handlers for platforms using the VIC as the primary interrupt
controller.

This has dependencies on:

	- of/irq: introduce of_irq_init
	http://lists.infradead.org/pipermail/linux-arm-kernel/2011-September/066844.html

	- irq: add declaration of irq_domain_simple_ops to irqdomain.h
	https://lkml.org/lkml/2011/9/14/189

from Rob Herring, and

	- ARM: Make global handler and CONFIG_MULTI_IRQ_HANDLER mutually
	exclusive
	http://www.spinics.net/lists/arm-kernel/msg141948.html

from Marc Zyngier.

Tested on picoxcell and build tested for all defconfigs.

Jamie Iles (10):
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

 Documentation/devicetree/bindings/arm/vic.txt      |   29 ++++
 arch/arm/Kconfig                                   |   10 ++
 arch/arm/common/Kconfig                            |    1 +
 arch/arm/common/vic.c                              |  135 ++++++++++++++++----
 arch/arm/include/asm/hardware/vic.h                |   14 ++-
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
 arch/arm/mach-nomadik/include/mach/entry-macro.S   |   30 -----
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
 arch/arm/mach-s5pv210/include/mach/entry-macro.S   |   37 ------
 arch/arm/mach-s5pv210/mach-aquila.c                |    2 +
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 +
 arch/arm/mach-s5pv210/mach-smdkc110.c              |    2 +
 arch/arm/mach-s5pv210/mach-smdkv210.c              |    2 +
 arch/arm/mach-s5pv210/mach-torbreck.c              |    2 +
 arch/arm/mach-spear3xx/include/mach/entry-macro.S  |   27 ----
 arch/arm/mach-spear3xx/spear300_evb.c              |    2 +
 arch/arm/mach-spear3xx/spear310_evb.c              |    2 +
 arch/arm/mach-spear3xx/spear320_evb.c              |    2 +
 arch/arm/mach-spear6xx/include/mach/entry-macro.S  |   36 -----
 arch/arm/mach-spear6xx/spear600_evb.c              |    2 +
 arch/arm/mach-u300/include/mach/entry-macro.S      |   24 ----
 arch/arm/mach-u300/u300.c                          |    2 +
 arch/arm/mach-versatile/include/mach/entry-macro.S |   30 -----
 arch/arm/mach-versatile/versatile_ab.c             |    2 +
 arch/arm/mach-versatile/versatile_dt.c             |    2 +
 arch/arm/mach-versatile/versatile_pb.c             |    2 +
 53 files changed, 252 insertions(+), 299 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vic.txt

-- 
1.7.4.1
