From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Sun, 13 Oct 2013 19:17:09 +0200
Subject: [RFC PATCH RESEND 0/2] clk: add clk accuracy support
Message-ID: <1381684631-10835-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Sorry for the noise, but I didn't get any feedback on this patch series.

This patch series is a proposal to add clock accuracy retrieval support to the
common clk framework.

The support of accuracy retrieval may benefit to the at91 platform (I explain
why in the following paragraphs).

I don't know if other platforms may benefit from this accuracy support. This
series is here to get feedbacks from other developpers/maintainers, and see if
this can be integrated in the clk framework.

Here is why at91 platform may need the clk accuracy informations:

AT91 SoCs provide a slow clock (32 KHz clock) which can be used as a clock
source for some peripherals (USART, TC blocks, ...).

This slow clock can be generated from 2 sources:
- a 32KHz internal RC with a poor accuracy (50000 ppm)
- a 32KHz external crystal oscillator

Most of the supported at91 boards (if not all) use the external 32KHz crystal
source except for the kizbox (the board I'm working with :)).
It probably comes from a bad hardware design (hardware team should have
connected a crystal oscillator to the SoC instead of relying on the unaccurate
internal RC).
Anyway, I can't change the hardware as it is already widely deployed.

What I'm proposing is to give clock users the ability to retrieve clocks
accuracies in order to choose the most accurate source (or at least discard
clocks with poor accuracy).

Could you tell me if this approach is right, and if other platforms/boards have
similar issues and would be interrested by this series ?

Best Regards,

Boris

Boris BREZILLON (2):
  clk: add clk accuracy retrieval support
  clk: add accuracy support for fixed clock

 Documentation/clk.txt                              |    4 +
 .../devicetree/bindings/clock/fixed-clock.txt      |    3 +
 drivers/clk/Kconfig                                |    4 +
 drivers/clk/clk-fixed-rate.c                       |   43 +++++++--
 drivers/clk/clk.c                                  |   92 +++++++++++++++++++-
 include/linux/clk-private.h                        |    1 +
 include/linux/clk-provider.h                       |   14 +++
 include/linux/clk.h                                |   17 ++++
 8 files changed, 168 insertions(+), 10 deletions(-)

-- 
1.7.9.5
