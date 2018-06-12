From: marek.behun@nic.cz (Marek =?ISO-8859-1?Q?Beh=FAn?=)
Date: Tue, 12 Jun 2018 16:09:26 +0200
Subject: armada 37xx comphy driver DTS question
Message-ID: <20180612160926.3300730a@dellmb.labs.office.nic.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am writing a driver for the comphy found on armada 37xx, basing it a
little on the driver from linux-marvell.

There are 3 phy lanes on armada 37xx. In the functional specification
these there are 3 memory areas for those (usb3_gbe1, pcie_gbe0 and
sata_usb3), and one memory area called "South Bridge PHY Configuration
Registers".

In linux-marvell they have written it so that in DTS, this is
configured this way:

  comphy {
    compatible = "...";
    reg = <PHY_CONF regs>,
          <pcie_gbe0 regs>,
          <usb3_gbe1 regs>,
          <sata indirect access regs>;
    ...
  };

Then when other node is referencing a phy, it has to do it this way:
  phys = <&comphy LANE_ID TYPE>;
for example
  phys = <&comphy 1 COMPHY_PCIE0>;

I was wondering whether to do this the same way in my driver.

Rather I am inclined to create a separate node for each phy, and a
syscon node for PHY_CONF regs, ie:

  pcie_gbe0_comphy {
    compatible = "...";
    reg = <pcie_gbe0 regs>;
    marvell,comphy_conf = <&...>;
  };
  usb3_gbe1_comphy {
    compatible = "...";
    reg = <usb3_gbe1 regs>;
    marvell,comphy_conf = <&...>;
  };

What is your opinion?

Thanks.

Marek Behun
