From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Mar 2014 10:33:15 +0100
Subject: [PATCH v6 17/18] ARM: sun4i: dt: Add ahci / sata support
In-Reply-To: <5308F63E.3070300@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-18-git-send-email-hdegoede@redhat.com>
 <20140221181519.GC3931@lukather> <53087755.3090608@redhat.com>
 <20140222171516.GA3610@lukather> <5308F63E.3070300@redhat.com>
Message-ID: <20140303093315.GS607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Sat, Feb 22, 2014 at 08:10:54PM +0100, Hans de Goede wrote:
> >>> Since IIRC we have pretty much the same needs for the USB, can't
> >>> we just drop the SATA specific mention and use it as the common
> >>> DTSI for the usual regulators?
> >> 
> >> On most boards with sata, there will also be 1 or 2 usb
> >> regulators, so we need differently named regulator nodes for all
> >> 3 of ahci, usb1 and usb2 vbus. On some boards how ever we may
> >> only need the usb regulators.
> > 
> > Yes, obviously...
> > 
> >> So if you look in my current personal sunxi-devel tree you will
> >> see separate dtsi files for both ahci and usb regulators,
> > 
> > And this is precisely what I don't understand. Why do you *need*
> > different DTSI files. If there's common regulators, that are used
> > on most boards, fine, create a common regulators files. But why do
> > you have to create a DTSI to define only one regulator.
> > 
> >> another advantage of having these separate is that the gpio
> >> controlling the regulator can be pre-populated with the reference
> >> design gpio which is used in most boards, so that the ahci
> >> specific code in the dts becomes only the ahci: sata at ... node.
> > 
> > I understand very well the advantages of what having a reference
> > regulators bring. What I don't understand is the benefits of
> > having "topics" regulators DTSI.
> 
> Ok, so let me try to explain:
> 
> With topics regulator files, the ahci bits look something like this
> for a board using the reference design gpio:
> 
> /include/ "sunxi-ahci-reg.dtsi"
> 
> ...
> 
> 		ahci: sata at 01c18000 {
> 			target-supply = <&reg_ahci_5v>;
> 			status = "okay";
> 		};
> 
> If we put all regulators in one file, then the ahci regulator cannot
> be enabled (so it will have status = "disabled) by default since most
> boards don't have it, so things would change into:
> 
> /include/ "sunxi-common-regulators.dtsi"
> 
> ...
> 
> 		ahci: sata at 01c18000 {
> 			target-supply = <&reg_ahci_5v>;
> 			status = "okay";
> 		};
> 
> ...
> 
>         reg_ahci_5v: ahci-5v {
> 		status = "okay";
>         };
> 
> Notice the addition of the 2nd node. This is why I ended up doing
> 2 separate dtsi files for the ahci and for the usb regulators.
> 
> To me saying:
> 
> /include/ "sunxi-ahci-reg.dtsi"
> 
> Makes it clear to the reader that the board has a ahci target-supply
> regulator, so enabling it separately seems being overly verbose.
> 
> Of course of we change it to:
> 
> /include/ "sunxi-common-regulators.dtsi"
> 
> Then the verbosity / explicit enabling of various regulators becomes a
> good thing, as it is not directly clear what the include does.
> 
> But if we do this, then for many boards we end up replacing:
> 
> /include/ "sunxi-ahci-reg.dtsi"
> /include/ "sun4i-a10-usb-vbus-reg.dtsi"
> 
> With:
> 
> /include/ "sunxi-common-regulators.dtsi"
> 
>         reg_ahci_5v: ahci-5v {
> 		status = "okay";
>         };
> 
>         reg_usb1_vbus: usb1-vbus {
> 		status = "okay";
>         };
> 
>         reg_usb2_vbus: usb2-vbus {
> 		status = "okay";
>         };
> 
> I prefer the shorter version, but I can completely understand if
> you prefer the slightly more verbose version, this would also
> get rid of having different usb regulator dtsi files for sun4i /
> sun5i (as sun5i only has 1 usb host).
> 
> I hope this helps explain my reasoning, as said I'm fine with
> either way, if you want to change over to a single file +
> explicit enabling, let me know and I'll respin the ahci dts
> patches.  Note I'm going on vacation for a week starting Monday,
> so you likely won't get a new version until next weekend.

Yes, I strongly prefer the second case. That allows to have a
good-enough degree of factorisation, while not having anything
happening behind the scenes.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/b4d9317d/attachment.sig>
