From: horms@verge.net.au (Simon Horman)
Date: Mon, 19 Nov 2012 14:13:12 +0900
Subject: [RFC 00/15 v4] shmobile DT initialisation of INTC and GIC
Message-ID: <1353302007-31045-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is an updated series that is still very much work-in-progress.
So far contributions bave been made by Magnus Damm, Iwamatsu-san and myself.

The aims of this series are:

* Adding DT support to INTC
* Allowing relevant ARM shmobile SoCs to use DT to initialise INTC
* Allowing relevant ARM shmobile boards to use DT to initialise INTC
* Allowing the sh73a0 SoC use DT to initialise GIC
* Allowing the sh73a0 SoC use DT to initialise GIC, which in
  turn allows the kzm9g board to use DT to initialise GIC

Oustanding work includes:

* Work has been done on the sh7372 to consolidate the C code,
  minimise #ifdefs and make use of a common compatibility string.
  This work should be reflected in the r8a7740 and sh73a0 SoCs which
  this series already modifies.

* Evaluate why the following, as described by Magnus Damm, doesn't work.

  "I tried using the INTC DT interrupt controller code with external
   interrupt pins on the sh7372 mackerel board with DT, but for some
   reason the following network device refuses to probe due to some
   interrupt issue.
                
       lan9220 at 14000000 {
               compatible = "smsc,lan9220", "smsc,lan9115";
               reg = <0x14000000 0x2000000>;
               phy-mode = "mii";
               interrupt-parent = <&intca_irq_pins_lo>;
               interrupts = <0x2c0>;
               reg-io-width = <4>;
               smsc,irq-push-pull;
       };

   The above snippet is nicked and adjusted from my earlier prototype patches:
   [PATCH] sh: INTC IRQ domain and DT support prototype
   [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype

   I wonder, is there any outstanding INTC work related to IRQ domains?"


Diffstat and git information is provided to aid review.
Please consider making any changes on top of the branch mentioned below
or as modified versions of patches in this series.

----------------------------------------------------------------
The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git devel/of

for you to fetch changes up to 2a19ffff9917a62df50ceee565e55237bb175bc3:

  ARM: shmobile: sh73a0: Use DT for GIC (2012-11-19 13:56:34 +0900)

----------------------------------------------------------------
Nobuhiro Iwamatsu (12):
      ARM: mach-shmobile: Add support OF for INTC of shmobile
      SH: intc: Add support OF of IRQ
      ARM: mach-shmobile: Add support OF of INTC for r8a7740
      ARM: mach-shmobile: Add support OF of INTC for sh73a0
      ARM: mach-shmobile: Add support OF of INTC for sh7372
      ARM: mach-shmobile: Add DT table of INTC for sh73a0
      ARM: mach-shmobile: Add DT table of INTC for sh7372
      ARM: mach-shmobile: Add DT table of INTC for r8a7740
      ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva
      ARM: shmobile: Include DTSI of sh73a0 to kzm9g board
      ARM: shmobile: r8a7740: Use DT initialisation of INTC
      ARM: shmobile: sh7372: Use DT initialisation of INTC

Simon Horman (3):
      ARM: shmobile: kzm9g: Use DT initialisation of INTC
      ARM: shmobile: Add DT table of GIC for sh73a0
      ARM: shmobile: sh73a0: Use DT for GIC

 Documentation/devicetree/bindings/sh/intc.txt |  163 ++++
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |    2 +-
 arch/arm/boot/dts/r8a7740.dtsi                |  965 ++++++++++++++++++++-
 arch/arm/boot/dts/sh7372.dtsi                 | 1138 +++++++++++++++++++++++++
 arch/arm/boot/dts/sh73a0-kzm9g.dts            |    2 +-
 arch/arm/boot/dts/sh73a0.dtsi                 |  819 ++++++++++++++++++
 arch/arm/mach-shmobile/board-kzm9g.c          |    2 +-
 arch/arm/mach-shmobile/include/mach/common.h  |    3 +
 arch/arm/mach-shmobile/intc-r8a7740.c         |  136 ++-
 arch/arm/mach-shmobile/intc-sh7372.c          |  112 ++-
 arch/arm/mach-shmobile/intc-sh73a0.c          |  248 +++++-
 arch/arm/mach-shmobile/setup-r8a7740.c        |    2 +-
 arch/arm/mach-shmobile/setup-sh7372.c         |    2 +-
 drivers/sh/intc/Makefile                      |    1 +
 drivers/sh/intc/core.c                        |    2 +-
 drivers/sh/intc/internals.h                   |    3 +-
 drivers/sh/intc/irqdomain.c                   |    6 +-
 drivers/sh/intc/of_intc.c                     |  646 ++++++++++++++
 include/linux/sh_intc.h                       |   84 ++
 19 files changed, 4252 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sh/intc.txt
 create mode 100644 arch/arm/boot/dts/sh73a0.dtsi
 create mode 100644 drivers/sh/intc/of_intc.c
