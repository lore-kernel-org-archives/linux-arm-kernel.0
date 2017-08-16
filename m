From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 16 Aug 2017 14:24:55 +0200
Subject: [PATCHv2 0/3] arm64 xilinx zynqmp firmware interface
Message-ID: <cover.1502886277.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

xilinx is using this interface for very long time and we can't merge our
driver changes to Linux because of missing communication layer with
firmware. This interface was developed before scpi and scmi was
available. In connection to power management scpi and scmi are missing
pieces which we already use. There is a separate discussion how to
extend scmi to support all our use cases.
This simply patch is not adding any power management features but only
adding minimum functionality which are needed for drivers.

Edgar's comment on having HVC:
"We have patches for Xen that implement a power-management mediator.
That implementation handles PM calls over both SMC and HVC insns.
Patches are on the Xen mailing list.

Other hypervisors may work differently.

I think we should support both but I don't have a strong opinion on
it."

Thanks,
Michal

Changes in v2:
- Move to bindings/firmware and also add it to firmware node
  Reported-by Rob
- Add zynqmp firmware node to firmware node
- Change commit message
- Make zynqmp_pm_ret_code, invoke_pm_fn static
  Reported by Arnd
- Remove pm_api_version function - no need for interface
- Move driver to drivers/firmware/
  Reported by Arnd and Rob

Michal Simek (1):
  soc: xilinx: zynqmp: Add firmware interface

Soren Brinkmann (2):
  dt: xilinx: zynqmp: Add bindings for PM firmware
  arm64: zynqmp: dt: Add PM firmware node

 .../bindings/firmware/xlnx,zynqmp-pm.txt           |  22 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   9 +
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/xilinx/Kconfig                    |   6 +
 drivers/firmware/xilinx/Makefile                   |   1 +
 drivers/firmware/xilinx/zynqmp/firmware.c          | 382 +++++++++++++++++++++
 include/linux/firmware/xilinx/zynqmp/firmware.h    | 232 +++++++++++++
 8 files changed, 654 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xlnx,zynqmp-pm.txt
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
 create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h

-- 
1.9.1
