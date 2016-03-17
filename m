From: nm@ti.com (Nishanth Menon)
Date: Wed, 16 Mar 2016 19:23:12 -0500
Subject: [PATCH V3 0/2] mailbox: Introduce Texas Instrument's message manager
 driver
Message-ID: <1458174194-22320-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following v2 of the series provides a base driver for the support
of TI's message manager hardware block which facilitates communication
between multiple compute engines(or processors) with a central system
controller (called PMMC in K2G SoC). Keystone family of TI processors
incorporate this solution starting with K2G[1].

The hardware specification is available here:
http://www.ti.com/lit/ug/spruhy8/spruhy8.pdf Chapter 8.1 (Message
Manager - NOTE: complete chapter update is estimated to be somewhere
in March '16 - This does not seem done as of this writing).

Starting with K2G SoC, TI Keystone architecture is moving towards an
architecture similar to ARM Juno platform with a centralized system
controller where all system control takes place - all power management
and system control functions are now centralized in this system
controller. A protocol called TI-SCI (TI System Control Interface)
is built on top of this mailbox driver providing for communication
protocol (similar to SCPI drivers/firmware/arm_scpi.c) Follow on
patches (once the message manager is accepted) will enable the same.
However, an 4.1 kernel based vendor kernel implementation is available
at [2].

The following series is functional in TI vendor kernel, however, was
tested on K2G EVM using the following test fragment:
http://pastebin.ubuntu.com/15209502/

Boot log: http://pastebin.ubuntu.com/15405132/

baseline: next-20160316

Changes since v2:
	- driver update for review comments from Jassi.

v2: http://marc.info/?l=linux-kernel&m=145652549004201&w=2
v1: http://marc.info/?l=devicetree&m=145469015018996&w=2

Nishanth Menon (2):
  Documentation: dt: mailbox: Add TI Message Manager
  mailbox: Introduce TI message manager driver

 .../bindings/mailbox/ti,message-manager.txt        |  50 ++
 drivers/mailbox/Kconfig                            |  11 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/ti-msgmgr.c                        | 639 +++++++++++++++++++++
 include/linux/soc/ti/ti-msgmgr.h                   |  35 ++
 5 files changed, 737 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/ti,message-manager.txt
 create mode 100644 drivers/mailbox/ti-msgmgr.c
 create mode 100644 include/linux/soc/ti/ti-msgmgr.h


[1] K2G support
https://patchwork.kernel.org/patch/8196481/
https://patchwork.kernel.org/patch/8196491/
https://patchwork.kernel.org/patch/8196471/

[2] TISCI support(for reference): (mailbox client driver)
http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-lsk-linux-4.1.y/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-lsk-linux-4.1.y/drivers/firmware/ti_sci.c
http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-lsk-linux-4.1.y/drivers/firmware/ti_sci.h
http://git.ti.com/ti-linux-kernel/ti-linux-kernel/blobs/ti-lsk-linux-4.1.y/include/linux/ti_sci_protocol.h
The above protocol is used for clock, generic powerdomain, reset etc..

-- 
2.8.0.rc3
