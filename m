From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Tue, 26 Apr 2016 14:03:27 +0530
Subject: [PATCH 1/6] bus: Add shared MDIO bus framework
In-Reply-To: <20160425205650.GA31129@lunn.ch>
References: <1461230323-27891-1-git-send-email-pramod.kumar@broadcom.com>
 <1461230323-27891-2-git-send-email-pramod.kumar@broadcom.com>
 <20160425205650.GA31129@lunn.ch>
Message-ID: <666dffb41a922b0c8638f2f002a2de08@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Thanks for reviewing. I really appreciate your effort it.

I am already aware of MDIO mux framework but did not see it fit for our
use case due to below limitations:

1.  Current MDIO mux framework is Ethernet centric and it is only meant to
mux multiple MII buses using same MDIO controller.  This means it is only
meant for MII-compliant PHY devices (i.e. PHY devices having registers
as-per MII specs). This is not the case with Broadcom SATA PHYs, PCIe
PHYs, and USB PHYs even if we are sharing same MDIO controller for
accessing these PHYs.

2.  The MDIO mux framework registers each child bus as MII bus. The Linux
Ethernet MDIO framework will scan for all attached PHY devices on given
MII bus and try to read MII PHY_ID register which is not present in all
Broadcom non-ethernet PHYs.

3. Let's say we ignore point1 and point2 above and go ahead and use MDIO
mux framework then we will still have to emulated MII PHY_ID read for
non-ethernet PHYs. Let's say we also emulate MII PHY_ID read in
non-ethernet PHYs then next thing is non-ethernet PHYs don't follow MII
state machine so all other MII PHY register read/write will not work.

4. Apart from these, by using MDIO mux framework we are making our
non-ethernet PHYs dependent on Linux network drivers which is not
acceptable. What if some product line does not need network subsystem at
all?

As you can see from above points, trying to re-use Linux Ethernet MDIO mux
framework for non-Ethernet PHYs is not the right way. The sole reason
being Linux MDIO mux framework is not generic enough to be shared across
IO subsystems. Due to this reason we had to come-up with "Shared MDIO
framework" which is very simple, generic  and independent of I/O
subsystems.

I'll add PCIe PHYs driver based on Shared MDIO framework in next patch
revision to get a feel of its need.

Regards,
Pramod

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: 26 April 2016 02:27
> To: Pramod Kumar
> Cc: Rob Herring; Catalin Marinas; Will Deacon; Masahiro Yamada; Chen-Yu
Tsai;
> Mark Rutland; devicetree at vger.kernel.org; Pawel Moll; Arnd Bergmann;
Suzuki
> K Poulose; netdev at vger.kernel.org; Punit Agrawal; linux-
> kernel at vger.kernel.org; BCM Kernel Feedback; linux-arm-
> kernel at lists.infradead.org; Anup Patel
> Subject: Re: [PATCH 1/6] bus: Add shared MDIO bus framework
>
> Hi Pramod
>
> I took a closer look. I don't see why the current MDIO code should not
be used,
> rather than adding a new framework.
>
> What you need for your Non Ethernet PHYs is that they are somehow
probed.
> The current MDIO code will do that, based on the compatible string. An
mdio
> device gets passed a struct mdio_device * to its probe function, giving
you the
> bus and address on the bus for the device. Your PHY driver can then
register
> itself using devm_of_phy_provider_register(). The user of the PHY then
needs to
> use
> devm_phy_get() to get a handle on the phy, and can then use
> phy_power_on()/phy_power_off().
>
> There is a very simple example here for an MDIO device driver:
>
> http://thread.gmane.org/gmane.linux.network/393532
>
> The muxing of the MDIO busses looks a little tricky. At the moment you
have:
>
>     writel(cmd, base + MDIO_PARAM_OFFSET);
>
> which mixes together the muxing parameters and the write value. Can this
> register be accessed as two 16 bit registers? If it can be, you can
cleanly
> separate out the muxing.
>
> Take a look at mdio-mux-gpio.c and mdio-mux-mmioreg.c for examples of
> MDIO muxes.
>
>      Andrew
