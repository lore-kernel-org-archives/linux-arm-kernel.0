From: nm@ti.com (Nishanth Menon)
Date: Tue, 30 Aug 2016 08:06:42 -0500
Subject: [PATCH V2 0/5] firmware: Add support for TI System Control Interface
 (TI-SCI) protocol driver
Message-ID: <20160830130647.6828-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for the reviews on the patches, here is v2 of the series.

Texas Instruments' Keystone generation System on Chips (SoC)
starting with 66AK2G02[1], now include a dedicated SoC System Control
entity called PMMC(Power Management Micro Controller) in line with
ARM architecture recommendations. The function of this module is
to integrate all system operations in a centralized location.
Communication with the SoC System Control entity from various
processing units like ARM/DSP occurs over Message Manager hardware
block.

This series adds the base support for TI System Control Interface
(TI-SCI) protocol[2]. The protocol is built on top of Texas
Instrument's Message Manager communication mechanism[3].

Overall architecture is very similar to SCPI[4] as follows:
+-------------+   +---------+     +------^-----+
| TI SCI GENPD|   |TISCI Clk|     |TISCI reset |
+------+------+   +----+----+     +------+-----+
       |               |                 |
       |          +----v--------------+  |
       +----------> TISCI Protocol(*) <--+
                  +----+--------------+
                       |
                   +---v-----------+
                   | MAILBOX  FWK  |
                   +---+-----------+
                       |
                   +---v-----------+
                   |  TI MSGMGR    |-> TISCI hardware block
                   +---------------+
(*) This series.

V2 of the series is based off v4.8-rc1 and is also available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.9/tisci-base-v2

V1 of the series: https://lkml.org/lkml/2016/8/19/768

Changes in V2 of the series:
	- Review comments incorporated from Lokesh and Rob
	- Minor cleanup of comments for debug interface.

[1] http://www.ti.com/product/66ak2g02
[2] http://processors.wiki.ti.com/index.php/TISCI
[3] Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
[4] Documentation/devicetree/bindings/arm/arm,scpi.txt

Related series (based on v1):

* https://lkml.org/lkml/2016/8/19/790 (GENPD for TISCI)
* https://lkml.org/lkml/2016/8/19/811 (Clock support for TISCI) 

Nishanth Menon (5):
  Documentation: Add support for TI System Control Interface (TI-SCI)
    protocol
  firmware: Add basic support for TI System Control Interface (TI-SCI)
    protocol
  firmware: ti_sci: Add support for Device control
  firmware: ti_sci: Add support for Clock control
  firmware: ti_sci: Add support for reboot core service

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |   66 +
 MAINTAINERS                                        |   10 +
 drivers/firmware/Kconfig                           |   15 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/ti_sci.c                          | 1997 ++++++++++++++++++++
 drivers/firmware/ti_sci.h                          |  492 +++++
 include/linux/soc/ti/ti_sci_protocol.h             |  249 +++
 7 files changed, 2830 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 create mode 100644 drivers/firmware/ti_sci.c
 create mode 100644 drivers/firmware/ti_sci.h
 create mode 100644 include/linux/soc/ti/ti_sci_protocol.h

-- 
2.9.1.200.gb1ec08f
