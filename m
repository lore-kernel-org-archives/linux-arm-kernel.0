From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 11 Dec 2014 21:21:39 +0100
Subject: [RFC 0/3] SoCFPGA: Add HPS bridges
Message-ID: <1418329302-20813-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series adds support for the SoCFPGA bridges.

>From the datasheet:

	The HPS-FPGA bridges allow masters in the FPGA fabric to
	communicate with slaves in the HPS logic and vice versa.
	For example, you can instantiate additional memories or
	peripherals in the FPGA fabric, and master interfaces
	belonging to components in the HPS logic can access them.
	You can also instantiate components such as a NiosII
	processor in the FPGA fabric and their master interfaces
	can access memories or peripherals in the HPS logic

This does only work with the driver from my other series

	SoCFPGA: L3 NIC driver

As the binding, although simple, is still in debate and the
outcome may have impact on this series, this is a just an RFC
for now.

Also, the drivers beg for the DT overlay series which is floating
around, but this shouldn't have any effect on the current binding.
The driver part can be changed later.

Lastly, the bridges have an optional dependency on the fpgamgr
series from Alan Tull. I have added this to the binding, the drivers
don't do anything with this yet.
My idea here would be:
	1. probe bridge
	2. check if fpgamgr phandle is given
	 2a. if yes: defer till fpgamgr is done
	 2b. if no: continue
	3. probe subnodes with the help of DT overlays

I have only tested the HPS and LWHPS drivers, as I don't have any
bitstreams that use the FPGA2HPS bridge; here be dragons.

Regards,
Steffen

Steffen Trumtrar (3):
  devicetree: bindings: Add SoCFpga HPS bridges
  ARM: socfpga: Add drivers for the SoC-to-FPGA bridges
  ARM: dts: socfpga: Add AXI bridges

 .../soc/socfpga/altr,fpga2hps-axi-bridge.txt       |  32 +++
 .../soc/socfpga/altr,hps2fpga-axi-bridge.txt       |  54 +++++
 .../soc/socfpga/altr,lwhps2fpga-axi-bridge.txt     |  31 +++
 arch/arm/boot/dts/socfpga.dtsi                     |  48 ++++
 drivers/soc/socfpga/Kconfig                        |  43 ++++
 drivers/soc/socfpga/Makefile                       |   4 +
 drivers/soc/socfpga/bridges-common.c               |  84 +++++++
 drivers/soc/socfpga/bridges-common.h               |  28 +++
 drivers/soc/socfpga/fpga2hps-bridge.c              |  97 ++++++++
 drivers/soc/socfpga/hps2fpga-bridge.c              | 258 +++++++++++++++++++++
 drivers/soc/socfpga/lwhps2fpga-bridge.c            | 141 +++++++++++
 drivers/soc/socfpga/lwhps2fpga.h                   |  31 +++
 include/soc/socfpga/bridge.h                       |  65 ++++++
 13 files changed, 916 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socfpga/altr,fpga2hps-axi-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/soc/socfpga/altr,hps2fpga-axi-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/soc/socfpga/altr,lwhps2fpga-axi-bridge.txt
 create mode 100644 drivers/soc/socfpga/Kconfig
 create mode 100644 drivers/soc/socfpga/Makefile
 create mode 100644 drivers/soc/socfpga/bridges-common.c
 create mode 100644 drivers/soc/socfpga/bridges-common.h
 create mode 100644 drivers/soc/socfpga/fpga2hps-bridge.c
 create mode 100644 drivers/soc/socfpga/hps2fpga-bridge.c
 create mode 100644 drivers/soc/socfpga/lwhps2fpga-bridge.c
 create mode 100644 drivers/soc/socfpga/lwhps2fpga.h
 create mode 100644 include/soc/socfpga/bridge.h

-- 
2.1.3
