From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 21 Dec 2017 16:20:34 -0800
Subject: [PATCH 4/4] ARM: dts: vf610-zii-dev-rev-b: add interrupts for
 88e1545 PHY
In-Reply-To: <20171222001407.GL10595@n2100.armlinux.org.uk>
References: <20171220231108.GJ10595@n2100.armlinux.org.uk>
 <E1eRnWr-0006VS-1m@rmk-PC.armlinux.org.uk>
 <CACRpkdas5JJ4KHE4g=sPXag=3vQt4TS5EcZBsy=LRfw8tqcgOw@mail.gmail.com>
 <20171221134058.GA15416@lunn.ch>
 <20171221173235.GK10595@n2100.armlinux.org.uk>
 <CACRpkdarS+tPv5CG4bmFcPvc+=SJJcC1pbO7WSbsS5+yCuxh_Q@mail.gmail.com>
 <20171222001407.GL10595@n2100.armlinux.org.uk>
Message-ID: <4322b18f-636f-6904-4d43-3860681050af@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/2017 04:14 PM, Russell King - ARM Linux wrote:
> On Thu, Dec 21, 2017 at 11:53:47PM +0100, Linus Walleij wrote:
>> On Thu, Dec 21, 2017 at 6:32 PM, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>>
>>> What we have here is _really_ a shared interrupt between four
>>> separate devices, and we need a way to sanely describe resources
>>> shared between several device instances to pinmux.  Unfortunately,
>>> it seems pinmux is designed around one device having exclusive use
>>> of a resource, which makes it hard to describe shared interrupts in
>>> DT.
>>>
>>> Given that DT should be a description of the hardware, and should be
>>> independent of the OS implementation, I'd say this is a pinmux bug,
>>> because pinmux gets in the way of describing the hardware correctly.
>>> ;)
>>
>> Hm that would be annoying. But when I look at it I think it would
>> actually work. Did you try just assigning the same pin control
>> state to all the PHY's and see what happens?
>>
>> Just set
>> pinctrl-names = "default";
>> pinctrl-0 = <&pinctrl_mv88e1545>;
>>
>> on all of them?
> 
> It was tried, DT was happy, but the kernel on boot complained because
> pinctrl objected, which caused the drivers to fail to bind:
> 
> libphy: mdio: probed
> vf610-pinctrl 40048000.iomuxc: pin VF610_PAD_PTB0 already requested by !mdio-mux!mdio at 4!switch at 0!mdio:00; cannot claim for !mdio-mux!mdio at 4!switch at 0!mdio:01
> vf610-pinctrl 40048000.iomuxc: pin-22 (!mdio-mux!mdio at 4!switch at 0!mdio:01) status -22
> vf610-pinctrl 40048000.iomuxc: could not request pin 22 (VF610_PAD_PTB0) from group pinctrl-mv88e1545  on device 40048000.iomuxc
> Marvell 88E1545 !mdio-mux!mdio at 4!switch at 0!mdio:01: Error applying setting, reverse things back
> Marvell 88E1545: probe of !mdio-mux!mdio at 4!switch at 0!mdio:01 failed with error -22
> vf610-pinctrl 40048000.iomuxc: pin VF610_PAD_PTB0 already requested by !mdio-mux!mdio at 4!switch at 0!mdio:00; cannot claim for !mdio-mux!mdio at 4!switch at 0!mdio:02
> vf610-pinctrl 40048000.iomuxc: pin-22 (!mdio-mux!mdio at 4!switch at 0!mdio:02) status -22
> vf610-pinctrl 40048000.iomuxc: could not request pin 22 (VF610_PAD_PTB0) from group pinctrl-mv88e1545  on device 40048000.iomuxc
> Marvell 88E1545 !mdio-mux!mdio at 4!switch at 0!mdio:02: Error applying setting, reverse things back
> Marvell 88E1545: probe of !mdio-mux!mdio at 4!switch at 0!mdio:02 failed with error -22
> 

You could also see it another way, because this is a quad PHY in a
single package, you could theoretically have a representation that
exposes a node container for the 4 PHYs, and that container node
requests the pinmux/pinctrl. Of course, this would not work with the
MDIO code which would not go one level down, and would expect the PHYs
to be at the same level as the container node...

Oh well.
-- 
Florian
