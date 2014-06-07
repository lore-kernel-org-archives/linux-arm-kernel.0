From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  7 Jun 2014 20:18:23 +0200
Subject: [RFC PATCH 0/3] First step to transition PXA to clock framework
Message-ID: <1402165106-16534-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As discussed before, this is my preliminary work to transition the PXA
architecture to clock framework, and more widely to devicetree.

This RFC if for me to ensure I'm going in the right direction, for Mike, Arnd
and Haojian to comment.

There is still work to do before posting this serie :
 1) the pxa27x.c requires a dummy clock to be declared

   This is because just after it the gpio driver is probed, and it needs the
   clock to be available. As both gpio driver and pxa27xx_init are fired at
   postcore initcall level, I have no ordering guarantee, hence the dummy
   clock. If anybody comes up with a better idea, please step forward.
   NB: This is for non-DT boards.

 2) in devicetree build, the clk-pxa27x.c is still needed
   This is because of the system bus rate calculation.
   This requires a bit of work for me to declare the clk-divider accordingly in
   the device tree based on the CCCR register. Once that is done, I hope
   clk-pxa-dt.c will be the only clock source coded needed for PXA devicetree
   based boards.

 3) lack of pxa25x and pxa3xx CPUs in non-DT setups
   This is something that should be added, just as pxa27x was. As I'm lacking of
   any board to test, I will need testers here (or Marvell can send me a
   development board :))
   This particulary gets ugly in the arch/arm/Kconfig ...

 4) DT setup non tested
   This is my next step actually, on pxa27x only.

Well, I would appreciate some comments to not engage too far on the wrong path.

Cheers.

--
Robert

Robert Jarzmik (3):
  clk: add pxa27x clock drivers
  dts: add devicetree bindings for pxa27x clocks
  arm/pxa: Transition pxa27x to clk framework

 .../devicetree/bindings/clock/pxa-clock.txt        |  23 +++
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/pxa27x.dtsi                      | 116 ++++++++++-
 arch/arm/mach-pxa/Makefile                         |   8 +-
 arch/arm/mach-pxa/pxa27x.c                         | 186 ++----------------
 drivers/clk/Makefile                               |   1 +
 drivers/clk/pxa/Makefile                           |   4 +
 drivers/clk/pxa/clk-pxa-dt.c                       |  56 ++++++
 drivers/clk/pxa/clk-pxa27x.c                       | 211 +++++++++++++++++++++
 drivers/clk/pxa/clk-pxa2xx.c                       |  75 ++++++++
 drivers/clk/pxa/clk-pxa2xx.h                       |  47 +++++
 include/dt-bindings/clock/pxa2xx-clock.h           |  45 +++++
 12 files changed, 594 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/pxa-clock.txt
 create mode 100644 drivers/clk/pxa/Makefile
 create mode 100644 drivers/clk/pxa/clk-pxa-dt.c
 create mode 100644 drivers/clk/pxa/clk-pxa27x.c
 create mode 100644 drivers/clk/pxa/clk-pxa2xx.c
 create mode 100644 drivers/clk/pxa/clk-pxa2xx.h
 create mode 100644 include/dt-bindings/clock/pxa2xx-clock.h

-- 
2.0.0.rc2
