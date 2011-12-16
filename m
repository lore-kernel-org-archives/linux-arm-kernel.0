From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 16 Dec 2011 15:12:23 -0700
Subject: [PATCH 0/9] arm/tegra: Various pinmux-related cleanups
Message-ID: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While working on switching Tegra to a new pinctrl-based pin mux driver,
I made a bunch of small pinmux-related fixes; this patch series.

This patch series will have a few small context conflicts with Peter
De Schrijver's Tegra30 support. Peter's patch series should have
priority over this one (i.e. be the one merged if it's difficult to
merge both).

In particular:
* My patch 3 "arm/tegra: Harmony PCIe: Don't touch pinmux" and Peter's
  patch "arm/tegra: prepare pinmux code for multiple tegra variants"
  will have context conflicts; I've described the best way to resolve
  this in my patch's commit description.
* This series edits board-dt.c whereas Peter's series renames that to
  board-dt-tegra20.c. I assume git will handle this without any issue.
* There may be other obvious context conflicts that should be trivial
  to resolve.

This series is based on next-20111215, but I don't think has any
dependencies on anything in any of the Tegra for-3.3 branches.

Following this series, I have 3 patches in my local tree:
  arm/tegra: Select PINMUX Kconfig variables
  arm/tegra: Switch to new pinctrl driver
  arm/tegra: Remove pre-pinctrl pinmux driver

(all work in DT and non-DT on all supported Tegra20 boards)

I need to rebase those on top of Peter's patches (the first patch needs
updates for Tegra30 support, the last patch needs to delete the new
Tegra30 pinmux driver that Peter's series adds). It will also depend on
the pinctrl subsystem, which is being merged for the first time in 3.3,
and probably also patches to pinctrl that may only show up in 3.4. So,
I'll probably hold off posting those patches for merge until after 3.3
is out, but will probably send them out as a preview before that.

Stephen Warren (9):
  arm/tegra: Split Seaboard GPIO table to allow for Ventana
  arm/tegra: Add AUXDATA for tegra-pinmux and tegra-gpio
  arm/tegra: Harmony PCIe: Don't touch pinmux
  arm/tegra: PCIe: Remove include of mach/pinmux.h
  arm/tegra: Remove useless entries from ventana_pinmux[]
  arm/tegra: Rework Seaboard-vs-Ventana pinmux table
  arm/tegra: Fix mistake in Trimslice's pinmux
  arm/tegra: Refactor board-*-pinmux.c to share code
  arm/tegra: Use bus notifiers to trigger pinmux setup

 arch/arm/mach-tegra/Makefile                 |    1 +
 arch/arm/mach-tegra/board-dt.c               |   16 ++--
 arch/arm/mach-tegra/board-harmony-pcie.c     |    9 --
 arch/arm/mach-tegra/board-harmony-pinmux.c   |   22 ++---
 arch/arm/mach-tegra/board-paz00-pinmux.c     |   22 ++---
 arch/arm/mach-tegra/board-pinmux.c           |  104 +++++++++++++++++++++++
 arch/arm/mach-tegra/board-pinmux.h           |   38 +++++++++
 arch/arm/mach-tegra/board-seaboard-pinmux.c  |  116 ++++++++++++--------------
 arch/arm/mach-tegra/board-trimslice-pinmux.c |   24 +++---
 arch/arm/mach-tegra/pcie.c                   |    1 -
 10 files changed, 235 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-pinmux.h
