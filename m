From: christian.gmeiner@gmail.com (Christian Gmeiner)
Date: Wed, 25 Sep 2013 09:12:35 +0200
Subject: [RFC PATCHv2 0/4] Add DT support for fixed PHYs
In-Reply-To: <20130911064248.GI30088@pengutronix.de>
References: <1378480701-12908-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130911064248.GI30088@pengutronix.de>
Message-ID: <CAH9NwWfBGHmZ+HfUndeh18NW+HyZ=c82W=O_4hJSOH-oZuM9jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

>> Hello,
>>
>> Here is a second version of the patch set that adds a Device Tree
>> binding and the related code to support fixed PHYs. Marked as RFC,
>> this patch set is obviously not intended for merging in 3.12.
>>
>> Since the first version, the changes have been:
>>
>>  * Instead of using a 'fixed-link' property inside the Ethernet device
>>    DT node, with a fairly cryptic succession of integer values, we now
>>    use a PHY subnode under the Ethernet device DT node, with explicit
>>    properties to configure the duplex, speed, pause and other PHY
>>    properties.
>>
>>  * The PHY address is automatically allocated by the kernel and no
>>    longer visible in the Device Tree binding.
>>
>>  * The PHY device is created directly when the network driver calls
>>    of_phy_connect_fixed_link(), and associated to the PHY DT node,
>>    which allows the existing of_phy_connect() function to work,
>>    without the need to use the deprecated of_phy_connect_fixed_link().
>>
>> The things I am not entirely happy with yet are:
>>
>>  * The PHY ID is hardcoded to 0xdeadbeef. Ideally, it should be a
>>    properly reserved vendor/device identifier, but it isn't clear how
>>    to get one allocated for this purpose.
>>
>>  * The fixed_phy_register() function in drivers/net/phy/fixed.c has
>>    some OF references. So ideally, I would have preferred to put this
>>    code in drivers/of/of_mdio.c, but to call get_phy_device(), we need
>>    a reference to the mii_bus structure that represents the fixed MDIO
>>    bus.
>>
>>  * There is some error management missing in fixed_phy_register(), but
>>    it can certainly be added easily. This RFC is meant to sort out the
>>    general idea.
>
> +1 for the general idea. This really looks good now. I've not much more
> to say. Maybe someone from the devicetree corner has a few words for the
> binding?
>

I tested the whole series with an I.MX6D board with the FEC driver:
fec 2188000.ethernet eth0: Freescale FEC PHY driver [Generic PHY]
(mii_bus:phy_addr=fixed-0:00, irq=-1)

For me binding looks nice and I hope to see this patch series in 3.13.

Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>
--
Christian Gmeiner, MSc
