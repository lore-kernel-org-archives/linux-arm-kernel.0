From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 11 Mar 2016 22:35:16 +0100
Subject: [PATCH 1/3] net: thunderx: Cleanup PHY probing code.
In-Reply-To: <56E330E4.9090800@gmail.com>
References: <1457714822-5754-1-git-send-email-ddaney.cavm@gmail.com>
 <1457714822-5754-2-git-send-email-ddaney.cavm@gmail.com>
 <20160311173125.GI3153@lunn.ch>
 <56E30332.7060003@caviumnetworks.com>
 <20160311180030.GB19277@lunn.ch>
 <56E30DDF.5040506@caviumnetworks.com>
 <20160311190627.GC19277@lunn.ch> <56E31E7A.6080905@gmail.com>
 <56E330E4.9090800@gmail.com>
Message-ID: <20160311213516.GE19277@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> For this phy, we have:
> 
>   compatible = "cortina,cs4223-slice";

That actually means something else is happening, i think.

of_mdiobus_register() looks at the children, and decides if each child
is a phy or an mdio device, by calling of_mdiobus_child_is_phy().
Since this compatible string is not in whitelist_phys[], it will
return false. of_mdiobus_register() will then do a
of_mdiobus_register_device(). This compatible means it is an MDIO
device, not a PHY. So when you later call of_phy_find_device() it is
always going to return NULL, because there is no PHY there, only an
MDIO device.

How usable is the hardware without a PHY driver? Is a better solution
that your write a very minimal PHY driver?

     Andrew
