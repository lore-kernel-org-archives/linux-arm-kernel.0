From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 11 Apr 2016 12:23:18 -0700
Subject: [PATCH RFC 2/5] net: phy: sun8i-h3-ephy: Add driver for Allwinner
 H3 Ethernet PHY
In-Reply-To: <1459786954-12649-3-git-send-email-wens@csie.org>
References: <1459786954-12649-1-git-send-email-wens@csie.org>
 <1459786954-12649-3-git-send-email-wens@csie.org>
Message-ID: <570BF9A6.2040109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/16 09:22, Chen-Yu Tsai wrote:
> The Allwinner H3 SoC incorporates an Ethernet PHY. This is enabled and
> configured through a memory mapped hardware register.
> 
> This same register also configures the MAC interface mode and TX clock
> source. Also covered by the register, but not supported in this driver,
> are TX/RX clock delay chains and inverters, and an RMII module.

This is not really a PHY driver, more a driver for a special piece of
hardware responsible for properly configuring a more standard integrated
PHY which is then driven via standard MDIO accesses, right?

The intention to make this driver re-usable is fine, but still makes me
wonder if it should not be put in a file which is linked into the
Ethernet MAC driver, and utilized by this one in a way that may be more
"ad-hoc" than what you are proposing here.

One thing that is not obvious here, is how is the device parenting done?
Are we able to associate a phy_device to this SUN8I_H3_EPHY platform
device here?

Another thing is that the Ethernet MAC driver is fully aware of when
putting an Ethernet PHY into suspend, shutdown, or fully functional
power state should occur, if you have a separate platform driver here
which does not listen for such kinds of events (hint: none are generated
right now), then you cannot implement a working power state interface
between the MAC, SHIM and PHY here, even though you would want that.
-- 
Florian
