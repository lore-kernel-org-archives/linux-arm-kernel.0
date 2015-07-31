From: bonbons@linux-vserver.org (Bruno =?UTF-8?B?UHLDqW1vbnQ=?=)
Date: Fri, 31 Jul 2015 08:35:41 +0200
Subject: [linux-sunxi] [PATCH 6/8] ARM: dts: axp209: Add
 usb_power_supply child node to the ax209 node
In-Reply-To: <CAGb2v67nM7pauyjyhBdfgX7p_Rud6TEsNqphB+gx4ROekVqtbw@mail.gmail.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-7-git-send-email-hdegoede@redhat.com>
 <CAGb2v66X79dK84hG8NVTho-kPPMNcKXQspvT2pCM8Zbmnme53A@mail.gmail.com>
 <20150731075104.48c467e6@pluto.restena.lu>
 <CAGb2v67nM7pauyjyhBdfgX7p_Rud6TEsNqphB+gx4ROekVqtbw@mail.gmail.com>
Message-ID: <20150731083541.5f2c683a@pluto.restena.lu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Jul 2015 14:14:28 +0800 Chen-Yu Tsai wrote:
> On Fri, Jul 31, 2015 at 1:51 PM, Bruno Pr?mont wrote:
> > Hi ChenYu,
> >
> > On Fri, 31 Jul 2015 13:31:53 +0800 Chen-Yu Tsai wrote:
> >> Hi Hans,
> >>
> >> On Wed, Jun 10, 2015 at 5:37 AM, Hans de Goede wrote:
> >> > Add a node representing the usb power supply part of the axp209 pmic, note
> >> > that the usb power supply and the (to be added later) ac power supply will
> >> > each have their own child-node, so that they can be separately specified
> >> > as power-supply for other nodes using a power-supply property with a
> >> > phandle pointing to the right axp209 child-node.
> >> >
> >> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> > ---
> >> >  arch/arm/boot/dts/axp209.dtsi | 5 +++++
> >> >  1 file changed, 5 insertions(+)
> >> >
> >> > diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> >> > index 24c935c..051ab3b 100644
> >> > --- a/arch/arm/boot/dts/axp209.dtsi
> >> > +++ b/arch/arm/boot/dts/axp209.dtsi
> >> > @@ -89,4 +89,9 @@
> >> >                         regulator-name = "ldo5";
> >> >                 };
> >> >         };
> >> > +
> >> > +       usb_power_supply: usb_power_supply {
> >> > +               compatible = "x-powers,axp202-usb-power-supply";
> >> > +               status = "disabled";
> >>
> >> Is there any reason to have this disabled by default?
> >> AFAIK this is not something configurable in hardware,
> >> and the driver just gives readouts and status updates.
> >
> > There are some devices that only have 'AC-IN' instead of usb/otg power
> > (set-top boxes) so having the devices tell what power sources they
> > have makes sense (otherwise those that have ac-in instead of otg would
> > have to disable usb_power_supply) and avoids confusion by explicitly
> > stating presence in device dts.
> 
> That's true. But this is a bit of hardware inside the AXP.
> If it's power isn't routed, it should report it, shouldn't it?

If the device does not use the input there are two cases:
- ac-in and usb/otg in short-circuited (there is a bit in AXP registers
  to provide this indication)
- the unused one is just not connected/connectable

In either case the voltage of the unused/unusable branch is not really
useful, nor is it useful to have it show up in sysfs.

> And normal users would probably expect to read the input
> voltage/current/status through sysfs (or maybe hwmon?),
> instead of not finding the device and having to look through
> the DTS.

Only those supplies effectively present (in-use or with connectors
to eventually use them) should be visible in sysfs.
Having more of them will just confuse the users, they would be searching
how they can connect the supply while there is no means to do so
except soldering to the tiny AXP pins.

hwmon makes more sense for output voltages of the AXP or temperature
of AXP chip itself, not so much for the input side if that side is
covered by power_supply devices (otherwise the information is being
duplicated and if so should only be via power_supply class, not
individual drivers).

> If you're using a distro, you might not have the kernel sources
> around, and digging through the in-system device tree isn't that
> straightforward if you don't know where to look.

If the dts is incomplete that's another issue.

> > NB: I should hopefully get my battery supply driver ported this WE,
> > ac-in/rtc are done, this WE. I'm going to default-off for them as well
> > (note that for some extra details should be provided in dts).
> 
> I'm guessing we won't be using the axp288 one?

In a first step I won't be using it.

There are a few reasons for that:
- axp288 is based on ACPI/platform to provide configuration information
  instead of dts
- it makes extensive use of OCV and registers that are possibly present
  on axp20x but undocumented there.

Bruno
