From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Nov 2016 17:04:47 +0100
Subject: [PATCH v4 0/5] firmware: Add Tegra IVC and BPMP support
Message-ID: <20161115160452.27183-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Hi everyone,

This is the fourth revision of the Tegra IVC and BPMP support patches.
It incorporates all of the comments from earlier postings with some
fixes on top, primarily to make the driver use the mmio-sram bindings
via the misc/sram driver and genalloc rather than duplicate moste of
that code. This has the side-effect of removing many sparse warnings
about incompatible address modifiers.

Another small change is that IVC now always maps buffers to the peer
device if any. This avoids potential confusion when a peer device is
given along with physical addresses.

The interdependencies of IVC/BPMP and other low-level drivers such as
clocks, resets and power domains are fairly complicated and the dead-
line for v4.10 submissions is coming up fast, so my plan is to take
this into linux-next tonight and submit for v4.10 by the end of the
week, barring any serious objections.

For completeness I've also included some patches from Stephen that
amend the BPMP DT bindings.

Thierry

Joseph Lo (1):
  dt-bindings: firmware: Add bindings for Tegra BPMP

Stephen Warren (2):
  dt-bindings: Add power domains to Tegra BPMP firmware
  dt-bindings: firmware: Allow child nodes inside the Tegra BPMP

Thierry Reding (2):
  firmware: tegra: Add IVC library
  firmware: tegra: Add BPMP support

 .../bindings/firmware/nvidia,tegra186-bpmp.txt     |  108 ++
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/tegra/Kconfig                     |   25 +
 drivers/firmware/tegra/Makefile                    |    2 +
 drivers/firmware/tegra/bpmp.c                      |  868 +++++++++++
 drivers/firmware/tegra/ivc.c                       |  695 +++++++++
 include/dt-bindings/clock/tegra186-clock.h         |  940 ++++++++++++
 include/dt-bindings/power/tegra186-powergate.h     |   39 +
 include/dt-bindings/reset/tegra186-reset.h         |  217 +++
 include/soc/tegra/bpmp-abi.h                       | 1601 ++++++++++++++++++++
 include/soc/tegra/bpmp.h                           |  139 ++
 include/soc/tegra/ivc.h                            |  109 ++
 13 files changed, 4745 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.txt
 create mode 100644 drivers/firmware/tegra/Kconfig
 create mode 100644 drivers/firmware/tegra/Makefile
 create mode 100644 drivers/firmware/tegra/bpmp.c
 create mode 100644 drivers/firmware/tegra/ivc.c
 create mode 100644 include/dt-bindings/clock/tegra186-clock.h
 create mode 100644 include/dt-bindings/power/tegra186-powergate.h
 create mode 100644 include/dt-bindings/reset/tegra186-reset.h
 create mode 100644 include/soc/tegra/bpmp-abi.h
 create mode 100644 include/soc/tegra/bpmp.h
 create mode 100644 include/soc/tegra/ivc.h

-- 
2.10.2
