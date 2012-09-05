From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Sep 2012 09:32:14 +0200
Subject: [PATCH 1/4] net: mvneta: driver for Marvell Armada 370/XP
 network unit
In-Reply-To: <20120904183125.GB14683@lunn.ch>
References: <1346764004-16332-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1346764004-16332-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <201209041436.36430.arnd@arndb.de> <20120904175610.2c2934f1@skate>
 <20120904183125.GB14683@lunn.ch>
Message-ID: <20120905093214.379ef16c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

Le Tue, 4 Sep 2012 20:31:25 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> I've used Marvell switch chipsets, which have a phy polling unit,
> PPU. This sounds very similar. You can do a lot with the PPU, but when
> you want to configure subsets of auto-negotiation rates/duplex modes,
> or fixed speeds/duplex modes, the PPU could not do it. You had to
> disable the PPU and configure the PHY directly.
> 
> I see you have some of the ethtools API calls implemented, but not the
> ones needed for auto-neg and rates/duplex mode configurations. Does
> the neta PPU support this, or will you need to export the MDIO bus for
> these sorts of configuration options?

There's nothing named 'PPU' in the datasheet for Armada XP/370, but the
Ethernet controller registers indeed allow to change the
auto-negotiation, duplex and speed without talking to the PHY.

In addition to the GMAC_STATUS register (offset 0x2C10) that the driver
currently uses to find out the state of the link (up/down, speed,
duplex), there is a "Port Auto-Negotiation Configuration
Register" (offset 0x2C0C), which allows to set:

 * Manual duplex or auto duplex detection
 * If manual duplex, choose full/half
 * Manual or automatic detection of flow control
 * If manual flow control, decide the flow control value
 * Manual or automatic detection of speed
 * If manual speed, set the speed value

And a few other things. So indeed, we can configure the PHY parameters
without having to talk to the PHY directly.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
