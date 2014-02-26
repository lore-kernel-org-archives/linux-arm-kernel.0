From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 26 Feb 2014 11:38:07 +0100
Subject: [PATCH v3 0/2] ARM: OMAP4+: Fix gpmc_fck clock
Message-ID: <1393411089-9550-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Trying to get my SMSC9221 working on OMAP4 with DT,
I faced a misconfigured gpmc_fck (dummy clock set to 0)
resulting in serveral division-by-zero, misconfigured
timings and driver lost in the La La Land.

To solve this, patch 1 removes gpmc_fck from the dummy
clocks, and patch 2 adds the gpmc_fck DT node and
reference it from the gpmc node.

*Note*: For DRA7, there is no DTS node for the GPMC, so I
was unable to set the corresponding clock. And without
a public TRM, I cannot do much more.

Tested on DuoVero/Parlor (OMAP4430) with SMSC9221 (DTS
was posted on the OMAP ML [1]).

Regards,
Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/110801
---
Since v2:
- Added OMAP5 and DRA7
Since v1:
- Removed the gpmc_fck clock node, and reference directly l3_ick

Florian Vaussard (2):
  CLK: TI: OMAP4/5/DRA7: Remove gpmc_fck from dummy clocks
  ARM: DTS: OMAP4/5: Use l3_ick for the gpmc node

 arch/arm/boot/dts/omap4.dtsi | 2 ++
 arch/arm/boot/dts/omap5.dtsi | 2 ++
 drivers/clk/ti/clk-44xx.c    | 1 -
 drivers/clk/ti/clk-54xx.c    | 1 -
 drivers/clk/ti/clk-7xx.c     | 1 -
 5 files changed, 4 insertions(+), 3 deletions(-)

-- 
1.8.1.2
