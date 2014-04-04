From: treding@nvidia.com (Thierry Reding)
Date: Fri, 4 Apr 2014 16:49:24 +0200
Subject: [RFC 0/5] PCI: tegra: Overhaul regulator usage
Message-ID: <1396622969-17837-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current device tree binding for the regulator setup on Tegra PCIe is
not accurate. While it does work for current use-cases, that's likely by
accident rather than design. This series replaces the existing set of
power-supply properties with a new set that accurately describes the
inputs of the IP block (depending on SoC generation).

As a heads-up, this breaks backwards compatibility with prior versions
of the device tree bindings, but I don't see a reason why that should
keep us from fixing this properly. Not many people are currently using
these bindings and those who are are most likely tracking upstream
development closely enough not to be impacted by this.

I've aimed to keep the series bisectible, which has the downside of
interleaving patches to unrelated trees (ARM and PCI). I'm hoping that
perhaps we can find a way to merge this as a whole to keep it possible
to bisect across the series. Although again, I guess it wouldn't be all
that bad if that wasn't the case, given how little PCIe is actually
being used.

Thanks,
Thierry

Thierry Reding (5):
  PCI: tegra: Overhaul regulator usage
  ARM: tegra: Add new PCIe regulator properties
  PCI: tegra: Implement accurate power supply scheme
  PCI: tegra: Remove deprecated power supply properties
  ARM: tegra: Remove legacy PCIe power supply properties

 .../bindings/pci/nvidia,tegra20-pcie.txt           |  30 ++++-
 arch/arm/boot/dts/tegra20-harmony.dts              |   8 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |   7 +-
 arch/arm/boot/dts/tegra20-trimslice.dts            |   8 +-
 arch/arm/boot/dts/tegra30-beaver.dts               |  12 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |  11 +-
 drivers/pci/host/pci-tegra.c                       | 146 ++++++++++++---------
 7 files changed, 148 insertions(+), 74 deletions(-)

-- 
1.9.1
