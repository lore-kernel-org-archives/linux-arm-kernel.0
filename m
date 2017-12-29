From: mw@semihalf.com (Marcin Wojtas)
Date: Fri, 29 Dec 2017 12:12:15 +0100
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
 fourth network interface
In-Reply-To: <20171228184642.GV10595@n2100.armlinux.org.uk>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-6-antoine.tenart@free-electrons.com>
 <20171227222401.GT10595@n2100.armlinux.org.uk>
 <20171228074623.GA28444@lunn.ch>
 <20171228100519.GE2626@kwain> <462da70b-ba7d-6299-3e21-b619d3c4c7e6@gmail.com>
 <20171228182739.GH2626@kwain> <20171228184642.GV10595@n2100.armlinux.org.uk>
Message-ID: <CAPv3WKdNCOB=1BqGXw7gXZNX+bBhOXVfheYPjC4CFZjfiOXyHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

2017-12-28 19:46 GMT+01:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> On Thu, Dec 28, 2017 at 07:27:39PM +0100, Antoine Tenart wrote:
>> Hi Florian,
>>
>> On Thu, Dec 28, 2017 at 07:02:09AM -0800, Florian Fainelli wrote:
>> > On 12/28/2017 02:05 AM, Antoine Tenart wrote:
>> > > On Thu, Dec 28, 2017 at 08:46:23AM +0100, Andrew Lunn wrote:
>> > >> On Wed, Dec 27, 2017 at 10:24:01PM +0000, Russell King - ARM Linux wrote:
>> > >>> On Wed, Dec 27, 2017 at 11:14:45PM +0100, Antoine Tenart wrote:
>> > >>>>
>> > >>>> +&cps_eth2 {
>> > >>>> +      /* CPS Lane 5 */
>> > >>>> +      status = "okay";
>> > >>>> +      phy-mode = "2500base-x";
>> > >>>> +      /* Generic PHY, providing serdes lanes */
>> > >>>> +      phys = <&cps_comphy5 2>;
>> > >>>> +};
>> > >>>> +
>> > >>>
>> > >>> This is wrong.  This lane is connected to a SFP cage which can support
>> > >>> more than just 2500base-X.  Tying it in this way to 2500base-X means
>> > >>> that this port does not support conenctions at 1000base-X, despite
>> > >>> that's one of the most popular and more standardised speeds.
>> > >>>
>> > >>
>> > >> I agree with Russell here. SFP modules are hot pluggable, and support
>> > >> a range of interface modes. You need to query what the SFP module is
>> > >> in order to know how to configure the SERDES interface. The phylink
>> > >> infrastructure does that for you.
>> > >
>> > > Sure, I understand. We'll be able to support such interfaces only when
>> > > the phylink PPv2 support lands in.
>> >
>> > Should we expect PHYLINK support to make it as the first patch in your
>> > v2 of this patch series, or is someone else doing that?
>>
>> No, the phylink patch conflicts with Marcin's ACPI series and we agreed
>> to let him get his series merged first. And I will probably work on a
>> few other topics before having the chance to work on it. So it'll
>> probably be me doing that, but not right now.
>
> ACPI is going to be a problem with phylink for a while.  There's patches
> queued in net-next which convert phylink and SFP mostly to the fwnode
> and property based systems, but phylib and i2c do not seem to have the
> necessary bits to be able to deal with those.
>
> Specifically, in DT we have "of_find_i2c_adapter_by_node()" but afaics
> there is no equivalent in ACPI - which means in an ACPI based system
> we have no way to determine the I2C bus associated with a SFP socket,
> which is a rather fundamental issue for SFP modules.
>
> For phylib side, there's "of_phy_attach()" but again there is no
> equivalent in ACPI. This should not be that much of a problem, because
> network drivers using the DT phylib calls (eg, "of_phy_connect()") are
> already restricted by this. That may have been solved by Marcin's
> series, but I've not seen it to know.
>

I see that I misspelled your email address, hence the series remained unnoticed:
https://lkml.org/lkml/2017/12/18/216

In terms of the phylink support, I think the most important are:
* 3/8
https://lkml.org/lkml/2017/12/18/211
* 7/8
https://lkml.org/lkml/2017/12/18/207

I think the way of obtaining PHY fwnode and connecting it from the
latter patch could be incorporated to the phylink code. Although I
didn't get much feedback, the whole ACPI-handling of MDIO bus and the
PHYs touch ACPI specification and I expect it a slower to get merged.
Hence my idea is following:
* Send v2 with ACPI supporting link-irq only in mvpp2.c
* Extract MDIO bus handling for ACPI and propose PHY handling
modifications in phylink.

This way we may push the two things forwards in more efficient way.
I'm looking forward to your opinion.

Best regards,
Marcin
