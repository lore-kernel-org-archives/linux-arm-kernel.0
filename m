From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 06 Sep 2013 21:42:42 +0100
Subject: [RFC PATCHv2 0/4] Add DT support for fixed PHYs
In-Reply-To: <1378480701-12908-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1378480701-12908-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <2916397.Vz9aZYzLyb@lenovo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

Le vendredi 6 septembre 2013 17:18:17 Thomas Petazzoni a ?crit :
> Hello,
> 
> Here is a second version of the patch set that adds a Device Tree
> binding and the related code to support fixed PHYs. Marked as RFC,
> this patch set is obviously not intended for merging in 3.12.

Thanks a lot for continuing on this work, I really like the state of it now.

> 
> Since the first version, the changes have been:
> 
>  * Instead of using a 'fixed-link' property inside the Ethernet device
>    DT node, with a fairly cryptic succession of integer values, we now
>    use a PHY subnode under the Ethernet device DT node, with explicit
>    properties to configure the duplex, speed, pause and other PHY
>    properties.
> 
>  * The PHY address is automatically allocated by the kernel and no
>    longer visible in the Device Tree binding.
> 
>  * The PHY device is created directly when the network driver calls
>    of_phy_connect_fixed_link(), and associated to the PHY DT node,
>    which allows the existing of_phy_connect() function to work,
>    without the need to use the deprecated of_phy_connect_fixed_link().
> 
> The things I am not entirely happy with yet are:
> 
>  * The PHY ID is hardcoded to 0xdeadbeef. Ideally, it should be a
>    properly reserved vendor/device identifier, but it isn't clear how
>    to get one allocated for this purpose.

Right, we should try to get something better, but we obviously cannot use an 
already allocated OUI for this. Can we ask the Linux foundation or a Linux-
friendly company to allocate one maybe?

> 
>  * The fixed_phy_register() function in drivers/net/phy/fixed.c has
>    some OF references. So ideally, I would have preferred to put this
>    code in drivers/of/of_mdio.c, but to call get_phy_device(), we need
>    a reference to the mii_bus structure that represents the fixed MDIO
>    bus.

This is not a big deal, not everything in drivers/ is consistent with this, 
and making the fixed MDIO bus globally accessible does not sound too great.

> 
>  * There is some error management missing in fixed_phy_register(), but
>    it can certainly be added easily. This RFC is meant to sort out the
>    general idea.

Do you think you could add these to got beyond the RFC state? The patchset as 
it currently is fine with me if you can address these.
-- 
Florian
