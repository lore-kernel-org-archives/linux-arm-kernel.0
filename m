From: martin@lucina.net (Martin Lucina)
Date: Mon, 9 Jul 2018 12:15:09 +0200
Subject: [linux-sunxi] Re: [PATCH 05/10] arm64: dts: allwinner: a64:
 Olinuxino: enable USB
In-Reply-To: <5b9a0818-b28e-76de-17b9-721c0950b64b@arm.com>
References: <20180706085210.17952-1-andre.przywara@arm.com>
 <20180706085210.17952-6-andre.przywara@arm.com>
 <20180706150401.mhqse677vdqtxdzy@nodbug.lucina.net>
 <548f2eb5-b457-8fcd-c043-b897a447d96c@arm.com>
 <52713A44-E2BB-4388-A98F-D49AA3B6EAC3@aosc.io>
 <4b4d1662-4266-593c-79a9-39eea8fb668c@arm.com>
 <373C4D2E-E2CF-4AE9-9AC4-69AD4AF95AF4@aosc.io>
 <5b9a0818-b28e-76de-17b9-721c0950b64b@arm.com>
Message-ID: <20180709101509.pg2p5kompy35hc3k@nodbug.lucina.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday, 06.07.2018 at?17:17, Andre Przywara wrote:
> Hi,
> 
> On 06/07/18 16:50, Icenowy Zheng wrote:
> > 
> > 
> > ? 2018?7?6? GMT+08:00 ??11:46:08, Andre Przywara <andre.przywara@arm.com> ??:
> >> Hi,
> >>
> >> On 06/07/18 16:36, Icenowy Zheng wrote:
> >>>
> >>>
> >>> ? 2018?7?6? GMT+08:00 ??11:35:38, Andre Przywara
> >> <andre.przywara@arm.com> ??:
> >>>> Hi,
> >>>>
> >>>> On 06/07/18 16:04, Martin Lucina wrote:
> >>>>> On Friday, 06.07.2018 at?09:52, Andre Przywara wrote:
> >>>>>> The Olinuxino has two USB socket:
> >>>>>> USB0 is connected to a micro B socket. As it has the ID pin wired,
> >>>> we
> >>>>>> describe it as a proper OTG socket, which switches between host
> >> and
> >>>>>> device automatically.
> >>>>>> USB1 is connected to a normal USB A socket. PG9 enables the power
> >>>> line,
> >>>>>> so add the required regulator as well.
> >>>>>>
> >>>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >>>>>> ---
> >>>>>
> >>>>> This is not sufficient. Booting with this change results in the
> >>>> following
> >>>>> in dmesg:
> >>>>>
> >>>>> musb-sunxi 1c19000.usb: Invalid or missing 'dr_mode' property
> >>>>> musb-sunxi: probe of 1c19000.usb failed with error -22
> >>>>> [...]
> >>>>> usb0-vbus: disabling
> >>>>>
> >>>>> ... and neither of the USB ports work.
> >>>>>
> >>>>> Adding
> >>>>>
> >>>>>     dr_mode = "host";
> >>>>
> >>>> Argh, right, I remember you mentioned this before.
> >>>> Still it should not affect the other USB port, and actually it is a
> >>>> proper OTG port, so host is not right here. So this points to some
> >>>> other
> >>>> oddity or incorrect description. I need to go back to the schematics
> >>>> and
> >>>> our previous thread.
> >>>
> >>> OTG needs dr_mode = "otg"; and a ID pin.
> >>
> >> Yes, and we have the ID pin in the usbphy node.
> >> Martin, can you please check if dr_mode = "otg"; works for you?
> >>
> >> Icenowy: still, how does it affect USB1? I mean, even if MUSB does not
> >> initialise, it should leave the other host controller working? Is that
> >> related to them sharing the usbphy? And this one gives up and tears
> >> *everything* down, including the power for USB1?
> > 
> > You wrongly bound the regulator to USB0, not USB1.
> 
> Oh dear ...
> 
> > USB0 regulator should be AXP's drivevbus if it's OTG in generic
> > design based on AW reference.
> 
> Yes, it is.
> So, like this?
> 
> --------------
> 	reg_usb0_vbus: usb0-vbus { ....
> 		(unchanged)
> 	};
> };
> ....
> &reg_drivevbus {
> 	regulator-name = "usb0-vbus";
> 	status = "okay";
> };
> 
> &usb_otg {
> 	dr_mode = "otg";
> 	status = "okay";
> };
> 
> &usbphy {
> 	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
> 	usb0_vbus-supply = <&reg_drivevbus>;
> 	usb1_vbus-supply = <&reg_usb0_vbus>;
> };
> --------------
> 
> Martin, can you please give this a try? (It's PH9, not PH6 as in the
> original patch).

I presume you mean all the above changes. This does not work, I see no USB
busses apart from the kernel's internal ones:

Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

and dmesg mentions "usb0-vbus: disabling", but no other complaints I can
see.

For completeness, with your original patch, I have the following "lsusb"
output (but non-working both ports):

Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

With the addition of "dr_mode = "host"", I have the following (and working
ports):

Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 005 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Cheers,

Martin
