From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Feb 2013 14:33:09 -0700
Subject: [PATCH 0/9] ARM: tegra: use new dtc+cpp feature
Message-ID: <1360791198-29462-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

This series converts the Tegra device tree files to use the new feature
of running cpp over .dts files before compiling them with dtc. This
allows GPIOs and other GPIO/IRQ specifier cells to be named for example.

As far as merging goes, I'd anticipate the first 3 patches being useful
to any other ARM sub-arch that wants to convert; perhaps they could go
through some arm-soc common branch. The next 2 patches are Tegra-specific
cleanup that I'd anticipate applying to Tegra's for-3.10/cleanup. The
rest of the patches depend on those 5 previous patches, so would need to
go into a Tegra branch that merges in the previous patches; I'd anticipate
calling it for-3.10/dtc-cpp say.

One issue this raises: The first 2 patches aren't ARM-specific. I put the
files they create into arch/arm/boot/dts, but I wonder if they wouldn't be
better in some arch-agnostic include directory, or even right with the
binding documentation in Documentation/devicetree/bindings. Moving the
files would require adjusting the cpp include path.

Stephen Warren (9):
  ARM: dt: add header to define GPIO flags
  ARM: dt: add header to define IRQ flags
  ARM: dt: create a DT header for the GIC
  ARM: tegra: device tree whitespace cleanup
  ARM: tegra: fix sort order of USB PHY nodes
  ARM: tegra: use pre-processor for all device trees
  ARM: tegra: create a DT header defining GPIO IDs
  ARM: tegra: convert device tree files to use GPIO defines
  ARM: tegra: convert device tree files to use IRQ defines

 arch/arm/boot/dts/arm-gic.h                 |   17 +
 arch/arm/boot/dts/gpio.h                    |   10 +
 arch/arm/boot/dts/irq.h                     |   14 +
 arch/arm/boot/dts/tegra-gpio.h              |   45 ++
 arch/arm/boot/dts/tegra114-dalmore.dts      |   21 -
 arch/arm/boot/dts/tegra114-dalmore.dtsp     |   21 +
 arch/arm/boot/dts/tegra114-pluto.dts        |   21 -
 arch/arm/boot/dts/tegra114-pluto.dtsp       |   21 +
 arch/arm/boot/dts/tegra114.dtsi             |  153 -----
 arch/arm/boot/dts/tegra114.dtsip            |  161 ++++++
 arch/arm/boot/dts/tegra20-colibri-512.dtsi  |  491 ----------------
 arch/arm/boot/dts/tegra20-colibri-512.dtsip |  495 ++++++++++++++++
 arch/arm/boot/dts/tegra20-harmony.dts       |  660 ----------------------
 arch/arm/boot/dts/tegra20-harmony.dtsp      |  666 ++++++++++++++++++++++
 arch/arm/boot/dts/tegra20-iris-512.dts      |   89 ---
 arch/arm/boot/dts/tegra20-iris-512.dtsp     |   89 +++
 arch/arm/boot/dts/tegra20-medcom-wide.dts   |   58 --
 arch/arm/boot/dts/tegra20-medcom-wide.dtsp  |   58 ++
 arch/arm/boot/dts/tegra20-paz00.dts         |  505 -----------------
 arch/arm/boot/dts/tegra20-paz00.dtsp        |  509 +++++++++++++++++
 arch/arm/boot/dts/tegra20-plutux.dts        |   56 --
 arch/arm/boot/dts/tegra20-plutux.dtsp       |   56 ++
 arch/arm/boot/dts/tegra20-seaboard.dts      |  812 --------------------------
 arch/arm/boot/dts/tegra20-seaboard.dtsp     |  815 +++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra20-tamonten.dtsi     |  489 ----------------
 arch/arm/boot/dts/tegra20-tamonten.dtsip    |  490 ++++++++++++++++
 arch/arm/boot/dts/tegra20-tec.dts           |   56 --
 arch/arm/boot/dts/tegra20-tec.dtsp          |   57 ++
 arch/arm/boot/dts/tegra20-trimslice.dts     |  367 ------------
 arch/arm/boot/dts/tegra20-trimslice.dtsp    |  370 ++++++++++++
 arch/arm/boot/dts/tegra20-ventana.dts       |  611 --------------------
 arch/arm/boot/dts/tegra20-ventana.dtsp      |  616 ++++++++++++++++++++
 arch/arm/boot/dts/tegra20-whistler.dts      |  563 ------------------
 arch/arm/boot/dts/tegra20-whistler.dtsp     |  564 ++++++++++++++++++
 arch/arm/boot/dts/tegra20.dtsi              |  556 ------------------
 arch/arm/boot/dts/tegra20.dtsip             |  559 ++++++++++++++++++
 arch/arm/boot/dts/tegra30-beaver.dts        |  373 ------------
 arch/arm/boot/dts/tegra30-beaver.dtsp       |  373 ++++++++++++
 arch/arm/boot/dts/tegra30-cardhu-a02.dts    |   93 ---
 arch/arm/boot/dts/tegra30-cardhu-a02.dtsp   |   93 +++
 arch/arm/boot/dts/tegra30-cardhu-a04.dts    |  104 ----
 arch/arm/boot/dts/tegra30-cardhu-a04.dtsp   |  104 ++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi       |  500 ----------------
 arch/arm/boot/dts/tegra30-cardhu.dtsip      |  501 ++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi              |  579 -------------------
 arch/arm/boot/dts/tegra30.dtsip             |  582 +++++++++++++++++++
 46 files changed, 7286 insertions(+), 7157 deletions(-)
 create mode 100644 arch/arm/boot/dts/arm-gic.h
 create mode 100644 arch/arm/boot/dts/gpio.h
 create mode 100644 arch/arm/boot/dts/irq.h
 create mode 100644 arch/arm/boot/dts/tegra-gpio.h
 delete mode 100644 arch/arm/boot/dts/tegra114-dalmore.dts
 create mode 100644 arch/arm/boot/dts/tegra114-dalmore.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra114-pluto.dts
 create mode 100644 arch/arm/boot/dts/tegra114-pluto.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra114.dtsi
 create mode 100644 arch/arm/boot/dts/tegra114.dtsip
 delete mode 100644 arch/arm/boot/dts/tegra20-colibri-512.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-colibri-512.dtsip
 delete mode 100644 arch/arm/boot/dts/tegra20-harmony.dts
 create mode 100644 arch/arm/boot/dts/tegra20-harmony.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra20-iris-512.dts
 create mode 100644 arch/arm/boot/dts/tegra20-iris-512.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra20-medcom-wide.dts
 create mode 100644 arch/arm/boot/dts/tegra20-medcom-wide.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra20-paz00.dts
 create mode 100644 arch/arm/boot/dts/tegra20-paz00.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra20-plutux.dts
 create mode 100644 arch/arm/boot/dts/tegra20-plutux.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra20-seaboard.dts
 create mode 100644 arch/arm/boot/dts/tegra20-seaboard.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra20-tamonten.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-tamonten.dtsip
 delete mode 100644 arch/arm/boot/dts/tegra20-tec.dts
 create mode 100644 arch/arm/boot/dts/tegra20-tec.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra20-trimslice.dts
 create mode 100644 arch/arm/boot/dts/tegra20-trimslice.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra20-ventana.dts
 create mode 100644 arch/arm/boot/dts/tegra20-ventana.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra20-whistler.dts
 create mode 100644 arch/arm/boot/dts/tegra20-whistler.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra20.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20.dtsip
 delete mode 100644 arch/arm/boot/dts/tegra30-beaver.dts
 create mode 100644 arch/arm/boot/dts/tegra30-beaver.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra30-cardhu-a02.dts
 create mode 100644 arch/arm/boot/dts/tegra30-cardhu-a02.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra30-cardhu-a04.dts
 create mode 100644 arch/arm/boot/dts/tegra30-cardhu-a04.dtsp
 delete mode 100644 arch/arm/boot/dts/tegra30-cardhu.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-cardhu.dtsip
 delete mode 100644 arch/arm/boot/dts/tegra30.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30.dtsip

-- 
1.7.10.4
