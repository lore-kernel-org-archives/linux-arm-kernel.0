From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 22 Feb 2014 20:10:54 +0100
Subject: [PATCH v6 17/18] ARM: sun4i: dt: Add ahci / sata support
In-Reply-To: <20140222171516.GA3610@lukather>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-18-git-send-email-hdegoede@redhat.com>
 <20140221181519.GC3931@lukather> <53087755.3090608@redhat.com>
 <20140222171516.GA3610@lukather>
Message-ID: <5308F63E.3070300@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 02/22/2014 06:15 PM, Maxime Ripard wrote:
> On Sat, Feb 22, 2014 at 11:09:25AM +0100, Hans de Goede wrote:
>> Hi Maxime,
>> 
>> On 02/21/2014 07:15 PM, Maxime Ripard wrote:
>>> Hi Hans,
>>> 
>>> On Wed, Feb 19, 2014 at 01:01:59PM +0100, Hans de Goede wrote:
>>>> From: Oliver Schinagl <oliver@schinagl.nl>
>>>> 
>>>> This patch adds sunxi sata support to A10 boards that have such a connector. Some boards also feature a regulator via a GPIO and support for this is also added.
>>>> 
>>>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl> Signed-off-by: Hans de Goede <hdegoede@redhat.com> --- arch/arm/boot/dts/sun4i-a10-a1000.dts      |  4 ++++ arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++++ arch/arm/boot/dts/sun4i-a10.dtsi           |  8 +++++++ arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 36 ++++++++++++++++++++++++++++++ 4 files changed, 54 insertions(+) create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>>>> 
>>>> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts index cbd2e13..d6ec839 100644 --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts @@ -35,6 +35,10 @@ }; };
>>>> 
>>>> +		ahci: sata at 01c18000 { +			status = "okay"; +		}; + pinctrl at 01c20800 { emac_power_pin_a1000: emac_power_pin at 0 { allwinner,pins = "PH15"; diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts index b139ee6..6df237d8 100644 --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts @@ -12,6 +12,7 @@
>>>> 
>>>> /dts-v1/; /include/ "sun4i-a10.dtsi" +/include/ "sunxi-ahci-reg.dtsi"
>>>> 
>>>> / { model = "Cubietech Cubieboard"; @@ -33,6 +34,11 @@ }; };
>>>> 
>>>> +		ahci: sata at 01c18000 { +			target-supply = <&reg_ahci_5v>; +			status = "okay"; +		}; + pinctrl at 01c20800 { led_pins_cubieboard: led_pins at 0 { allwinner,pins = "PH20", "PH21"; diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi index 336dbec..454077a 100644 --- a/arch/arm/boot/dts/sun4i-a10.dtsi +++ b/arch/arm/boot/dts/sun4i-a10.dtsi @@ -338,6 +338,14 @@ #size-cells = <0>; };
>>>> 
>>>> +		ahci: sata at 01c18000 { +			compatible = "allwinner,sun4i-a10-ahci"; +			reg = <0x01c18000 0x1000>; +			interrupts = <56>; +			clocks = <&pll6 0>, <&ahb_gates 25>; +			status = "disabled"; +		}; + intc: interrupt-controller at 01c20400 { compatible = "allwinner,sun4i-ic"; reg = <0x01c20400 0x400>; diff --git a/arch/arm/boot/dts/sunxi-ahci-reg.dtsi b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi new file mode 100644 index 0000000..7072af1 --- /dev/null +++ b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi @@ -0,0 +1,36 @@ +/* + * sunxi boards sata target power supply common code
>>> 
>>> 
>>> Since IIRC we have pretty much the same needs for the USB, can't we just drop the SATA specific mention and use it as the common DTSI for the usual regulators?
>> 
>> On most boards with sata, there will also be 1 or 2 usb regulators, so we need differently named regulator nodes for all 3 of ahci, usb1 and usb2 vbus. On some boards how ever we may only need the usb regulators.
> 
> Yes, obviously...
> 
>> So if you look in my current personal sunxi-devel tree you will see separate dtsi files for both ahci and usb regulators,
> 
> And this is precisely what I don't understand. Why do you *need* different DTSI files. If there's common regulators, that are used on most boards, fine, create a common regulators files. But why do you have to create a DTSI to define only one regulator.
> 
>> another advantage of having these separate is that the gpio controlling the regulator can be pre-populated with the reference design gpio which is used in most boards, so that the ahci specific code in the dts becomes only the ahci: sata at ... node.
> 
> I understand very well the advantages of what having a reference regulators bring. What I don't understand is the benefits of having "topics" regulators DTSI.

Ok, so let me try to explain:

With topics regulator files, the ahci bits look something like this
for a board using the reference design gpio:

/include/ "sunxi-ahci-reg.dtsi"

...

		ahci: sata at 01c18000 {
			target-supply = <&reg_ahci_5v>;
			status = "okay";
		};

If we put all regulators in one file, then the ahci regulator cannot
be enabled (so it will have status = "disabled) by default since most
boards don't have it, so things would change into:

/include/ "sunxi-common-regulators.dtsi"

...

		ahci: sata at 01c18000 {
			target-supply = <&reg_ahci_5v>;
			status = "okay";
		};

...

        reg_ahci_5v: ahci-5v {
		status = "okay";
        };

Notice the addition of the 2nd node. This is why I ended up doing
2 separate dtsi files for the ahci and for the usb regulators.

To me saying:

/include/ "sunxi-ahci-reg.dtsi"

Makes it clear to the reader that the board has a ahci target-supply
regulator, so enabling it separately seems being overly verbose.

Of course of we change it to:

/include/ "sunxi-common-regulators.dtsi"

Then the verbosity / explicit enabling of various regulators becomes a
good thing, as it is not directly clear what the include does.

But if we do this, then for many boards we end up replacing:

/include/ "sunxi-ahci-reg.dtsi"
/include/ "sun4i-a10-usb-vbus-reg.dtsi"

With:

/include/ "sunxi-common-regulators.dtsi"

        reg_ahci_5v: ahci-5v {
		status = "okay";
        };

        reg_usb1_vbus: usb1-vbus {
		status = "okay";
        };

        reg_usb2_vbus: usb2-vbus {
		status = "okay";
        };

I prefer the shorter version, but I can completely understand if
you prefer the slightly more verbose version, this would also
get rid of having different usb regulator dtsi files for sun4i /
sun5i (as sun5i only has 1 usb host).

I hope this helps explain my reasoning, as said I'm fine with
either way, if you want to change over to a single file +
explicit enabling, let me know and I'll respin the ahci dts
patches.  Note I'm going on vacation for a week starting Monday,
so you likely won't get a new version until next weekend.

Regards,

Hans


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMI9jgACgkQF3VEtJrzE/tkEQCgm1V2Nga+RxsTELQUJxIl2Go3
4dkAnRK0CjK1YEapqN0anp2iltgp7smc
=fBXT
-----END PGP SIGNATURE-----
