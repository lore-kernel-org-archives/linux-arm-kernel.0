From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 May 2013 16:50:45 -0600
Subject: [GIT PULL] ARM: tegra: DT-related fixes needed by the USB tree
Message-ID: <1368831045-19105-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe, (and Alan, Greg),

These are the changes from the Tegra tree that need to be merged
before the Tegra USB driver patches 4-8 from Venu can be applied. Recall
that we had previously agreed on this approach for v3.9, but Venu's
patches didn't end up being ready until now, unfortunately. I note
that Venu's patches affect both the Tegra USB and PHY drivers.

Following this, I will soon send some patches that fix up some ARM multi-
platform issues in the Tegra EHCI driver. Those won't affect the Tegra
USB PHY driver, but I do expect I'll want to rebase them on top of Venu's
series, since they will probably interact a bit with Venu's patches.

I also soon hope to see patches to:
* Convert the Tegra USB and PHY drivers from the vbus-gpios DT property
  to the new vbus-supply regulator. This will affect both drivers, and
  I really hope will happen soon.
* Add support for Tegra30 and Tegra114 SoCs. I expect this would touch
  both the USB and PHY drivers. This may or may not happen in 3.11.

As such, there will be quite a lot of interaction between the Tegra USB
and PHY drivers in 3.10. I'll let you decide if it's better for them to
go through the main USB tree or the USB PHY tree, and hence who should
pull in this pull request.

----------------------------------------------------------------

Tag description:

The Tegra USB bindings were in bad shape. The patches in this branch
fix the binding definitions, and make all the necessary additions to
the DT files. Stale nodes/properties will be removed early in 3.12
once the USB driver has been updated for the new binding.

These changes are needed in both the USB tree, to allow the driver to
be updated to handle them, and the Tegra tree, so that various tree-
wide DT changes (e.g. conversion of IRQ/GPIO/clock constants to defines)
can be applied on top of them.

----------------------------------------------------------------

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.11-deps-for-usb

for you to fetch changes up to 4c94c8b5b3cc38b0d0b1ec79642f5710e19a3e01:

  ARM: tegra: update device trees for USB binding rework

----------------------------------------------------------------

Venu Byravarasu (3):
      ARM: tegra: finalize USB EHCI and PHY bindings
      ARM: tegra: modify ULPI reset GPIO properties
      ARM: tegra: update device trees for USB binding rework

 .../bindings/usb/nvidia,tegra20-ehci.txt        |   27 ++--------
 .../bindings/usb/nvidia,tegra20-usb-phy.txt     |   41 +++++++++++++--
 arch/arm/boot/dts/tegra20-colibri-512.dtsi      |    6 ++-
 arch/arm/boot/dts/tegra20-harmony.dts           |   15 ++++--
 arch/arm/boot/dts/tegra20-iris-512.dts          |    9 +++-
 arch/arm/boot/dts/tegra20-paz00.dts             |   15 ++++--
 arch/arm/boot/dts/tegra20-seaboard.dts          |   26 ++++++++--
 arch/arm/boot/dts/tegra20-tamonten.dtsi         |    4 ++
 arch/arm/boot/dts/tegra20-trimslice.dts         |   25 +++++++--
 arch/arm/boot/dts/tegra20-ventana.dts           |   15 ++++--
 arch/arm/boot/dts/tegra20-whistler.dts          |   28 ++++++++++
 arch/arm/boot/dts/tegra20.dtsi                  |   49 +++++++++++++-----
 12 files changed, 206 insertions(+), 54 deletions(-)
