From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 25 May 2016 11:29:38 -0500
Subject: [PATCH 0/5] Set Arria10 ECC Manager IRQ Controller
Message-ID: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

The Arria10 IRQs for each peripheral ECC block funnel into 2 IRQs
[1 for single bit errors (SBERR) and 1 for double bit errors (DBERR)]
which are better handled by the IRQ controller and IRQ domain
framework than the IRQ handler in the current implementation.

The IRQ numbers (hwirq) in each peripheral ECC block (currently L2
and OCRAM) device tree node cannot be parsed using of_ functions
in the current implementation because these functions attach the
IRQ to an IRQ domain.

This patch set adds the IRQ controller/IRQ domain framework but
requires some device tree and binding changes as a result.

Thor Thayer (5):
  Documentation: dt: socfpga: Add interrupt-controller to ecc-manager
  EDAC, altera: ECC Manager IRQ controller support
  EDAC, altera: Handle Arria10 SDRAM child node.
  ARM: dts: Arria10 ECC Manager IRQ controller changes
  ARM: dts: Move Arria10 SDRAM as child of ECC Manager

 .../bindings/arm/altera/socfpga-eccmgr.txt         |   14 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   19 +-
 drivers/edac/altera_edac.c                         |  182 +++++++++++++++-----
 drivers/edac/altera_edac.h                         |    5 +-
 4 files changed, 168 insertions(+), 52 deletions(-)

-- 
1.7.9.5
