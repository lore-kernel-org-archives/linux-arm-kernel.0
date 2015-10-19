From: w-kwok2@ti.com (WingMan Kwok)
Date: Mon, 19 Oct 2015 14:57:18 -0400
Subject: [PATCH v2 0/2] Common SerDes driver for TI's Keystone Platforms
Message-ID: <1445281040-14742-1-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On TI's Keystone platforms, several peripherals such as the
gbe ethernet switch, 10gbe ethernet switch and PCIe controller
require the use of a SerDes for converting SoC parallel data into
serialized data that can be output over a high-speed electrical
interface, and also converting high-speed serial input data
into parallel data that can be processed by the SoC.  The
SerDeses used by those peripherals, though they may be different,
are largely similar in functionality and setup.

This patch series provides a SerDes phy driver implementation that can be
used by the above mentioned peripheral drivers to configure their
respective SerDeses.

As an example of the using the SerDes driver, this patch series also
updates the Keystone PCIe host driver to enable and use its SerDes block.

References:
[1] KeyStone II Architecture Serializer/Deserializer (SerDes) User's Guide
    (http://www.ti.com/lit/ug/spruho3a/spruho3a.pdf)

v2:
	- addresses the following review comments on v1:
		1. https://lkml.org/lkml/2015/10/15/896
			-- this does not address the question:
			   "The current code does not do this when compiled,
			    which might be a problem for distributors.
			    Can you clarify the license?"
			-- the question is still under discussion here:
			   https://lkml.org/lkml/2015/10/19/471
		2. https://lkml.org/lkml/2015/10/15/895

v1: 
	- addresses the following review comments
		1. https://lkml.org/lkml/2015/10/13/803
		2. https://lkml.org/lkml/2015/10/14/613
		3. https://lkml.org/lkml/2015/10/13/818

	- An update to PCIe dts bindings to enable the PCIe SerDes is
	  submitted in a separate patch.

WingMan Kwok (2):
  phy: keystone: serdes driver for gbe 10gbe and pcie
  PCI: keystone: update to use generic keystone serdes driver

 Documentation/devicetree/bindings/phy/ti-phy.txt |  239 +++
 drivers/pci/host/pci-keystone.c                  |   24 +-
 drivers/pci/host/pci-keystone.h                  |    1 +
 drivers/phy/Kconfig                              |    8 +
 drivers/phy/Makefile                             |    1 +
 drivers/phy/phy-keystone-serdes.c                | 2365 ++++++++++++++++++++++
 6 files changed, 2628 insertions(+), 10 deletions(-)
 create mode 100644 drivers/phy/phy-keystone-serdes.c

-- 
1.7.9.5
