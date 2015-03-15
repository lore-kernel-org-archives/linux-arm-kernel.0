From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 16 Mar 2015 08:03:07 +0900
Subject: [GIT PULL] Renesas ARM Based SoC da9063/da9210 Regulator Quirk for
 v4.1
Message-ID: <cover.1426456462.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC da9063/da9210 regulator quirk
for v4.1.


The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-da9063-da9210-quirk-for-v4.1

for you to fetch changes up to 46dd8a809effdc7ebe6ec760e3e421d5ac2a40f1:

  ARM: shmobile: lager: Add da9063 PMIC device node for system restart (2015-03-11 09:52:21 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC da9063/da9210 Regulator Quirk for v4.1

The r8a7790/lager and r8a7791/koelsch development boards have da9063 and
da9210 regulators.  Both regulators have their interrupt request lines
tied to the same interrupt pin (IRQ2) on the SoC.

After cold boot or da9063-induced restart, both the da9063 and da9210
seem to assert their interrupt request lines.  Hence as soon as one
driver requests this irq, it gets stuck in an interrupt storm, as it
only manages to deassert its own interrupt request line, and the other
driver hasn't installed an interrupt handler yet.

To handle this, install a quirk that masks the interrupts in both the
da9063 and da9210.  This quirk has to run after the i2c master driver
has been initialized, but before the i2c slave drivers are initialized.
As it depends on i2c, select I2C if one of the affected platforms is
enabled in the kernel config.

----------------------------------------------------------------
Geert Uytterhoeven (5):
      ARM: shmobile: R-Car Gen2: Add da9063/da9210 regulator quirk
      ARM: shmobile: koelsch dts: Add da9210 regulator interrupt
      ARM: shmobile: koelsch: Add da9063 PMIC device node for system restart
      ARM: shmobile: lager dts: Add da9210 regulator interrupt
      ARM: shmobile: lager: Add da9063 PMIC device node for system restart

 arch/arm/boot/dts/r8a7790-lager.dts                |  18 +++
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  18 +++
 arch/arm/mach-shmobile/Kconfig                     |   2 +
 arch/arm/mach-shmobile/Makefile                    |   2 +
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 147 +++++++++++++++++++++
 5 files changed, 187 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
