From: code@mmayer.net (Markus Mayer)
Date: Thu, 24 Aug 2017 16:36:24 -0700
Subject: [PATCH v3 0/2] SoC driver for Broadcom STB DPFE
Message-ID: <20170824233626.1343-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

This series introduces a driver to interact with the Broadcom STB DDR
PHY Front End (DPFE), specifically to communicate with the DCPU that is
part of the DDR PHY and which is running its own firmware.

The DCPU provides information such as DRAM refresh rate, which can be
used as indirect indicator for the DRAM temperature (the higher the
refresh rate, the hotter the RAM).

The series was previously submitted as HWMON driver[1]. It has been
removed from that subsystem, because it doesn't provide any standard
HWMON data due to hardware design properties, and is now implemented as
SoC driver.

Changes since v2:
  - moved driver from drivers/soc/bcm/brcmstb to drivers/memory
  - renamed the driver from dpfe.c to brcmstb_dpfe.c
  - added le32_to_cpu() in a few places (where be32_to_cpu() calls
    already existed)
  - added a little blurb what the le32_to_cpu()/be32_to_cpu() business
    is all about

Changes since v1:
  - binding simplified to use one node with three memory regions
    instead of three nodes with one region
  - no longer part of the HWMON subsystem
  - better error handling and error reporting to userland
  - uses [readl|writel]_relaxed() directly, since there is no need for
    wrappers doing endian conversion
  - re-download firmware upon "resume"
  - minor changes to improve clarity

[1] https://lkml.org/lkml/2017/4/18/640

Markus Mayer (2):
  dt/bindings: Add bindings for Broadcom STB DRAM Sensors
  memory: brcmstb: Add driver for DPFE

 .../bindings/memory-controllers/brcm,dpfe-cpu.txt  |  27 +
 MAINTAINERS                                        |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/brcmstb_dpfe.c                      | 701 +++++++++++++++++++++
 4 files changed, 737 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.txt
 create mode 100644 drivers/memory/brcmstb_dpfe.c

-- 
2.7.4
