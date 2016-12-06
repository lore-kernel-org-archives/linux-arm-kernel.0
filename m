From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue,  6 Dec 2016 13:53:15 +1100
Subject: [PATCH v3 0/6] mfd: dt: Add bindings for the Aspeed MFDs
Message-ID: <20161206025321.1792-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Here's a series describing the bindings for some MFDs in the Aspeed SoCs. I
expect there will be discussion about how I've gone about this with adding a
ranges property to the MFD bindings: The motivation here is to allow re-use of
the standard regs property to describe resources used inside the MFD. This is
partly driven by wanting to avoid modifying the existing IPMI Block Transfer
bindings which were written prior to sorting out how we were going to represent
the Aspeed LPC controller, but also because the register layout for sub-devices
of the LPC controller is quite esoteric. Further, the pinmux state depends on
bits in the Low Pin Count (LPC) bus controller, which is the motivation for
exposing a part of the LPC space as a syscon.

These issues were described in the comments of a small RFC patch, and the
implementation provided here is an extension of those thoughts:

    https://lkml.org/lkml/2016/11/17/24

Some of the patches in this MFD series has been split from the v2 of Aspeed
pinmux patches posted below:

    https://lkml.org/lkml/2016/11/2/263

and to address your comments on relevant patches in the v2 above I've created a
syscon directory under mfd. The Aspeed SoC Display Controller is the first
bindings document to live there (and is otherwise unchanged), and a subsequent
patch moves all documents whose compatible contains "syscon" but not
"simple-mfd".

Andrew Jeffery (6):
  mfd: dt: Fix "indicates" typo in mfd bindings document
  mfd: dt: ranges, #address-cells and #size-cells as optional properties
  mfd: dt: Add Aspeed Low Pin Count Controller bindings
  mfd: dt: Add bindings for the Aspeed LPC Host Controller (LHC)
  mfd: dt: Add bindings for the Aspeed SoC Display Controller (GFX)
  mfd: dt: Move syscon bindings to syscon subdirectory

 .../devicetree/bindings/mfd/aspeed-lpc.txt         | 133 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/mfd.txt      |  12 +-
 .../devicetree/bindings/mfd/syscon/aspeed-gfx.txt  |  17 +++
 .../bindings/mfd/{ => syscon}/aspeed-scu.txt       |   0
 .../bindings/mfd/{ => syscon}/atmel-gpbr.txt       |   0
 .../bindings/mfd/{ => syscon}/atmel-matrix.txt     |   0
 .../bindings/mfd/{ => syscon}/atmel-smc.txt        |   0
 .../bindings/mfd/{ => syscon}/qcom,tcsr.txt        |   0
 .../bindings/mfd/{ => syscon}/syscon.txt           |   0
 .../mfd/{ => syscon}/ti-keystone-devctrl.txt       |   0
 10 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/syscon/aspeed-gfx.txt
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/aspeed-scu.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-gpbr.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-matrix.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-smc.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/qcom,tcsr.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/syscon.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/ti-keystone-devctrl.txt (100%)

-- 
2.9.3
