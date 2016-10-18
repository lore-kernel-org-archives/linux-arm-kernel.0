From: nm@ti.com (Nishanth Menon)
Date: Tue, 18 Oct 2016 18:08:32 -0500
Subject: [PATCH V4 0/5] firmware: Add support for TI System Control Interface
 (TI-SCI) protocol driver
Message-ID: <20161018230837.6515-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Version 4 of the series is basically a rebase to v4.9-rc1, no functional
changes.

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


V4 of the series is based off v4.9-rc1 and is also available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.10/tisci-base-v4
Quick boot test: http://pastebin.ubuntu.com/23346183/

Changes since v3:
	- rebase to v4.9-rc1
	- minor checkpatch fixes

V3: https://lkml.org/lkml/2016/9/6/747
V2: https://lkml.org/lkml/2016/8/30/273
V1: https://lkml.org/lkml/2016/8/19/768

Nishanth Menon (5):
  Documentation: Add support for TI System Control Interface (TI-SCI)
    protocol
  firmware: Add basic support for TI System Control Interface (TI-SCI)
    protocol
  firmware: ti_sci: Add support for Device control
  firmware: ti_sci: Add support for Clock control
  firmware: ti_sci: Add support for reboot core service

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |   81 +
 MAINTAINERS                                        |   10 +
 drivers/firmware/Kconfig                           |   15 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/ti_sci.c                          | 1991 ++++++++++++++++++++
 drivers/firmware/ti_sci.h                          |  492 +++++
 include/linux/soc/ti/ti_sci_protocol.h             |  249 +++
 7 files changed, 2839 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
 create mode 100644 drivers/firmware/ti_sci.c
 create mode 100644 drivers/firmware/ti_sci.h
 create mode 100644 include/linux/soc/ti/ti_sci_protocol.h

-- 
2.10.0
