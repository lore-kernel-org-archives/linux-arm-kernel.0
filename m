From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 25 Apr 2016 22:56:50 +0200
Subject: [PATCH 1/6] bus: Add shared MDIO bus framework
In-Reply-To: <1461230323-27891-2-git-send-email-pramod.kumar@broadcom.com>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
 <1461230323-27891-2-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160425205650.GA31129@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pramod

I took a closer look. I don't see why the current MDIO code should not
be used, rather than adding a new framework.

What you need for your Non Ethernet PHYs is that they are somehow
probed. The current MDIO code will do that, based on the compatible
string. An mdio device gets passed a struct mdio_device * to its probe
function, giving you the bus and address on the bus for the
device. Your PHY driver can then register itself using
devm_of_phy_provider_register(). The user of the PHY then needs to use
devm_phy_get() to get a handle on the phy, and can then use
phy_power_on()/phy_power_off().

There is a very simple example here for an MDIO device driver:

http://thread.gmane.org/gmane.linux.network/393532

The muxing of the MDIO busses looks a little tricky. At the moment you have:

    writel(cmd, base + MDIO_PARAM_OFFSET);

which mixes together the muxing parameters and the write value. Can
this register be accessed as two 16 bit registers? If it can be, you
can cleanly separate out the muxing.

Take a look at mdio-mux-gpio.c and mdio-mux-mmioreg.c for examples of
MDIO muxes.

     Andrew
