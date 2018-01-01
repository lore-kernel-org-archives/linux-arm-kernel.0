From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 1 Jan 2018 11:18:19 +0100
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
 fourth network interface
In-Reply-To: <20171230173157.GC10595@n2100.armlinux.org.uk>
References: <20171227221446.18459-6-antoine.tenart@free-electrons.com>
 <20171227222401.GT10595@n2100.armlinux.org.uk>
 <20171228074623.GA28444@lunn.ch>
 <20171228100519.GE2626@kwain> <462da70b-ba7d-6299-3e21-b619d3c4c7e6@gmail.com>
 <20171228182739.GH2626@kwain> <20171228184642.GV10595@n2100.armlinux.org.uk>
 <CAPv3WKdNCOB=1BqGXw7gXZNX+bBhOXVfheYPjC4CFZjfiOXyHQ@mail.gmail.com>
 <20171229113850.GX10595@n2100.armlinux.org.uk>
 <CAPv3WKcFT5YgvwEk9QNB5=O0j23ds1jCxaBYnMVhxDHeBZzbDA@mail.gmail.com>
 <20171230173157.GC10595@n2100.armlinux.org.uk>
Message-ID: <CAPv3WKfn0=51CVtC8V5nWeiM+UV0BhqwFNewwRWUV3wy-9MtUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

2017-12-30 18:31 GMT+01:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> Hi Marcin,
>
> On Sat, Dec 30, 2017 at 05:34:23PM +0100, Marcin Wojtas wrote:
>> Yes, I already split the series and will send first one right away. I
>> will be followed by MDIO bus / PHY handling proposal, including the
>> bits related to phylink. I'm looking forward to your opinion on that
>> once sent.
>
> I'm looking forward to the patches. :)
>
>> This my understanding of how the PP2 HW works in terms of signalling
>> the link interrupt:
>>
>> The full in-band management, similar to mvneta is supported only in
>> the SGMII mode (1G, not sure how it looks like in 2.5G mode). Such
>> handling is not yet implemented in the mvpp2.c
>>
>> 10G:
>> The XGMII MAC (XLG) is capable of generating link status change
>> interrupt upon information provided from the reconciliation layer (RS)
>> of the interface.
>>
>> 2.5G/1G SGMII:
>> Apart from the in-band management, the MAC is also capable of
>> generating IRQ during link-status change.
>>
>> 1G RGMII:
>> I was a bit surprised, but checked on my own - the link change IRQ can
>> be generated here as well.
>>
>> In addition to above the clause 22 PHYs can be automatically polled
>> via SMI bus and provide complete information about link status, speed,
>> etc., reflecting it directly in GMAC status registers. However, this
>> feature had to be disabled, in order not to conflict with SW PHY
>> management of the phylib.
>>
>> Stefan, is above correct?
>
> This sounds very much like mvneta's 'managed = "in-band"' mode.

Indeed. RGMII MAC behaves same way, although it shouldn't be named as
'in-band' to be on par with the specifications. Anyway - this one is
rather a stub for being able to work with ACPI, so once the MDIO bus
works there, this will be out of any concerns.

>
> Having done some research earlier this month on the "2.5G SGMII" I have
> a number of comments about this:
>
> 1. Beware of "SGMII" being used as a generic term for single lane serdes
>    based ethernet. Marvell seem to use this for 802.3z BASE-X in their
>    code, but it is not. SGMII is a modification of 802.3z BASE-X by
>    Cisco.  This leads to some confusion!
>
> 2. For Cisco SGMII running at 2.5G, PHYs such as those from Xilinx do not
>    support the speed bits, because the speed is defined to be 2.5G.  IOW,
>    they do not support 250Mbps or 25Mbps speeds by data replication as is
>    done with 100Mbps and 10Mbps over 1G SGMII.
>
> 3. There is also 1000BASE-X upclocked to 2.5G speeds, which mvneta and
>    mvpp2 both support by appropriate configuration of the comphy.  I've
>    already tested this with 4.3Mbps Fiberchannel SFPs between clearfog
>    and mcbin - but needing devmem2 to reconfigure the clearfog comphy.

As for 3. I tested 2.5G link on Clearfog (FreeBSD) and Armada 8040
(UEFI), so yes - the comphy is a crucial component here.

>
>> > If my guessing is correct, I have to wonder why mvpp2 invented a
>> > different way to represent this from mvneta?  This makes it much more
>> > difficult to convert mvpp2 to phylink, and it also makes it difficult
>> > to add SFP support ignoring the phylink issue (since there is no phy
>> > handle there either.)
>>
>> Doesn't SFP require the fwnode handle to the sfp node? This is what I
>> understand at least from the phylink_register_sfp.
>
> Yes, internally within phylink.  What I'm concerned about is the
> following disparity between mvneta and mvpp2 - I'll try to explain it
> more clearly with DT examples:
>
> 1.1. mvneta phy
>         &eth {
>                 phy = <&phy>;
>                 phy-mode = "whatever";
>         };
> 1.2. mvneta fixed-link
>         &eth {
>                 fixed-link {
>                         speed = <1000>;
>                         full-duplex;
>                 };
>         };
> 1.3. mvneta in-band
>         &eth {
>                 phy-mode = "sgmii";
>                 managed = "in-band-status";
>         };
> 2.1. mvpp2 phy
>         &eth {
>                 phy = <&phy>;
>                 phy-mode = "whatever";
>         };
> 2.2. mvpp2 fixed-link
>         &eth {
>                 fixed-link {
>                         speed = <1000>;
>                         full-duplex;
>                 };
>         };
> 2.3. mvpp2 in-band (guess)
>         &eth {
>                 phy-mode = "sgmii";
>         };
>
> In both cases, the representation for phy and fixed-link mode are the
> same, but the in-band are different.  In mvneta in-band, the generic
> "managed" property must be specified as specified by
> Documentation/devicetree/bindings/net/ethernet.txt.  However, for mvpp2,
> this mode is currently selected by omission of both a "phy" property and
> a "fixed-link" sub-node/property - and that goes against the description
> of the "managed" property in the ethernet.txt binding doc.
>
> Phylink won't recognise the mvpp2's style of "in-band" because phylink,
> being a piece of generic code, is written to follow the generic binding
> documentation, rather than accomodating driver's individual quirks.
>
> So, if what I think is correct (basically what I've said above) there is
> a problem converting mvpp2 to use phylink - any existing DT files that
> use the "2.3 mvpp2 in-band" method instantly break, and I think that's
> what Antoine referred to when I picked out that the previous patches
> avoided using phylink when there was no "phy" node present.
>
> However, I haven't spotted anything using the 2.3 method, but it's not
> that easy to find the lack of a property amongst the maze of .dts*
> files - trying to track down which use mvpp2 and which do not specify
> a phy or fixed-link node can't be done by grep alone due to the
> includes etc.  I think the only possible way would be to build all DT
> files, then reverse them back to dts and search those for the mvpp2
> compatible strings, and then manually check each one.
>

Thanks for detailed explanation. I agree with you - for the link IRQ,
the 'managed' property should be used. IMO this change should be a
part of mvpp2 -> phylink conversion patchset.

Best regards,
Marcin

>> Anyway, once the phylink is introduced in mvpp2.c, its presence will
>> simply be detected by port->phylink pointer. In such case the link IRQ
>> will no be used. In longer perspective, link IRQ should be used only
>> by ACPI and once MDIO bus is supported in generic way in this world,
>> it could remain as the 'last resort' option.
>
> It's not though - there are SFP modules that are SGMII and we have no
> access to the PHY onboard, so the only way we know what they're doing
> is from the inband status sent as part of the SGMII in-band
> configuration.  So, even when using phylink, we need the in-band
> stuff to work, and so we need those link IRQs.
>
> There's also additional complexities around Cisco SGMII and "extended"
> SGMII concerning the flow control settings - in Cisco SGMII, there
> are no bits in the 16-bit control word for communicating the flow
> control to the MAC.  In extended SGMII (which appears in some Marvell
> devices) you can configure flow control to appear in the 16-bit
> control word, and in some cases, also EEE.  When implemented correctly
> by the MAC, phylink supports the "Cisco" method when it knows that
> in-band AN is being used along with a PHY - it knows to read the
> settings from the MAC but combine the flow control with what has been
> read from the PHY.  If this is not done, we're likely to end up with
> the link partner believing that FC is supported (eg, because the PHY
> has defaulted to advertising FC) but the local MAC having FC disabled.
>
> Note that there's another quirk as far as SGMII goes - some PHYs will
> not pass data until their "negotiation" (iow, passing and acknowledgement
> of the SGMII control word by the MAC) has completed.  Disabling SGMII
> "AN" on the MAC causes some SGMII PHYs to apparently be in "link up"
> state but with no traffic flow possible in either direction.  This is
> a particularly important point if using phylib - the temptation is to
> use phylib to pass the results of AN to the MAC for SGMII and disable
> AN on the MAC, but this is, in fact, wrong for the reason set out in
> this paragraph.
>
> There are bits present that allow AN bypass if it doesn't complete in
> a certain time, but that's an entirely separate issue - especially
> when there's SGMII PHYs that we have no access to!
>
> Sorting out these nuances over the life of phylink so far has been
> "interesting".
>

There's ton of quirks here and there, thanks for the efforts, which
help to sort them out.

Marcin
