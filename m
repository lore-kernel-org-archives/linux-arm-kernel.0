From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 13 Aug 2012 17:22:39 +0300
Subject: [PATCH v2 0/9] ARM/ASoC: OMAP McBSP device tree support
Message-ID: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Changes since v1:
- ICLK workaround for the sidetone module has been kept for legacy mode.

Intro mail ffrom v1 (updated):

in order to be able to add DT support for the McBSP driver which is used on all
OMAP platforms (OMAP1/2/3/4/5) I needed to make some cleanups to the stack:
- Removing callbacks used by the driver for
 - clock re-parenting (code moved to sound driver)
 - FSR/CLKR mux configuration (from now on it need to be done at board level)
   This mux is board specific and depends on the wiring.
- Replaced the cpu_is_omap* checks with future proof check.
- The FIFO was not enabled on OMAP2430 SoC

It has been tested on BeagleBoard (with legacy and DT boot).

The series changes McBSP related files mostly. It would be great if the whole
series could go via audio tree (if the patches are OK and it is fine by Tony).

For DT booted kernel on OMAP3 proper ICLK woraround need to be implemented. At
the moment I don't see this as a stopper since we can not properly boot OMAP3
devices (especially rx51 which is using the ST). Other OMAP revisions does not
have ST block so the missing workaround is not going to hurt them.
I'm working on a solution which can replace the current workaround with a
generic implementation to support DT and non DT booted kernels.

Regards,
Peter
---
Peter Ujfalusi (9):
  ARM/ASoC: omap-mcbsp: Move OMAP2+ clock parenting code to ASoC driver
  ARM: OMAP: mcbsp: Enable FIFO use for OMAP2430
  ARM: OMAP: board-am3517evm: Configure McBSP1 CLKR/FSR signal source
  ASoC: am3517evm: Do not configure McBSP1 CLKR/FSR signal muxing
  ARM/ASoC: omap-mcbsp: Remove CLKR/FSR mux configuration code
  ASoC: omap-mcbsp: Remove unused defines
  ASoC: omap-mcbsp: Remove cpu_is_omap* checks from the code
  ARM: OMAP2+: McBSP: Do not create legacy devices when booting with DT
    data
  ASoC: omap-mcbsp: Add device tree bindings

 .../devicetree/bindings/sound/omap-mcbsp.txt       |   45 +++++++
 arch/arm/mach-omap2/board-am3517evm.c              |   13 ++
 arch/arm/mach-omap2/mcbsp.c                        |  126 +------------------
 arch/arm/plat-omap/include/plat/mcbsp.h            |    2 -
 sound/soc/omap/am3517evm.c                         |   20 +---
 sound/soc/omap/mcbsp.c                             |   54 ++++-----
 sound/soc/omap/mcbsp.h                             |    3 -
 sound/soc/omap/omap-mcbsp.c                        |  106 +++++++++++-----
 sound/soc/omap/omap-mcbsp.h                        |   20 ---
 9 files changed, 162 insertions(+), 227 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-mcbsp.txt

-- 
1.7.8.6
