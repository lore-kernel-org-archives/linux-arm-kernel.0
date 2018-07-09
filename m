From: martin@lucina.net (Martin Lucina)
Date: Mon, 9 Jul 2018 13:54:26 +0200
Subject: [linux-sunxi] Re: [PATCH 05/10] arm64: dts: allwinner: a64:
 Olinuxino: enable USB
In-Reply-To: <1d2c3a9f-ec57-ebd2-a8d1-fcd7a84e0e91@arm.com>
References: <20180706085210.17952-1-andre.przywara@arm.com>
 <20180706085210.17952-6-andre.przywara@arm.com>
 <20180706150401.mhqse677vdqtxdzy@nodbug.lucina.net>
 <548f2eb5-b457-8fcd-c043-b897a447d96c@arm.com>
 <52713A44-E2BB-4388-A98F-D49AA3B6EAC3@aosc.io>
 <4b4d1662-4266-593c-79a9-39eea8fb668c@arm.com>
 <373C4D2E-E2CF-4AE9-9AC4-69AD4AF95AF4@aosc.io>
 <5b9a0818-b28e-76de-17b9-721c0950b64b@arm.com>
 <20180709101509.pg2p5kompy35hc3k@nodbug.lucina.net>
 <1d2c3a9f-ec57-ebd2-a8d1-fcd7a84e0e91@arm.com>
Message-ID: <20180709115426.6r42bxqcypxvikep@nodbug.lucina.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday, 09.07.2018 at?12:30, Andre Przywara wrote:
> >>> You wrongly bound the regulator to USB0, not USB1.
> >>
> >> Oh dear ...
> >>
> >>> USB0 regulator should be AXP's drivevbus if it's OTG in generic
> >>> design based on AW reference.
> >>
> >> Yes, it is.
> >> So, like this?
> >>
> >> --------------
> >> 	reg_usb0_vbus: usb0-vbus { ....
> >> 		(unchanged)
> >> 	};
> >> };
> >> ....
> >> &reg_drivevbus {
> >> 	regulator-name = "usb0-vbus";
> >> 	status = "okay";
> >> };
> >>
> >> &usb_otg {
> >> 	dr_mode = "otg";
> >> 	status = "okay";
> >> };
> >>
> >> &usbphy {
> >> 	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
> >> 	usb0_vbus-supply = <&reg_drivevbus>;
> >> 	usb1_vbus-supply = <&reg_usb0_vbus>;
> >> };
> >> --------------
> >>
> >> Martin, can you please give this a try? (It's PH9, not PH6 as in the
> >> original patch).
> > 
> > I presume you mean all the above changes. This does not work, I see no USB
> > busses apart from the kernel's internal ones:
> 
> Bummer!
> 
> I just saw that I forgot: 'status = "okay";' in the usbphy node. Can you
> add this and recheck?
> 
> > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > 
> > and dmesg mentions "usb0-vbus: disabling", but no other complaints I can
> > see.
> > 
> > For completeness, with your original patch, I have the following "lsusb"
> > output (but non-working both ports):
> > 
> > Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > 
> > With the addition of "dr_mode = "host"", I have the following (and working
> > ports):
> 
> Well, yes, but as Icenowy pointed out, dr_mode = "host" and the original
> patch are wrong and just happen to work by chance:
> Adding dr_mode makes the OTG part work, which now *didn't disable* the
> usb0_vbus-supply, which actually drives USB1. The actual USB0 supply was
> not touched (because Linux didn't know about it in the first place). So
> both ports happened to work.
> 
> Can you please try using the .dts I attached?

The .dts you attached does not compile, you've added a "&simplefb_hdmi"
node, did you mean something else?

...if I remove that node, then I get:

[    0.289065] sun4i-usb-phy 1c19400.phy: Couldn't request ID GPIO
...
[    1.554921] sun4i-usb-phy 1c19400.phy: Couldn't get regulator usb0_vbus... Deferring probe
...
[    1.659943] sun4i-usb-phy 1c19400.phy: Couldn't get regulator usb0_vbus... Deferring probe

and no USB.

(guessing) Did you mean to add a &usb1_vbus?

Martin
