From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Feb 2013 10:47:39 -0700
Subject: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
In-Reply-To: <CAAwP0s3oNaALFfLvEQnZ1m90BXh5pF2_-8FUyi6pQMzb0_FSVQ@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-4-git-send-email-b-cousson@ti.com>
 <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com>
 <4F452484.5080503@gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
 <4F47AD08.4030504@ti.com>
 <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com>
 <CAAwP0s3oNaALFfLvEQnZ1m90BXh5pF2_-8FUyi6pQMzb0_FSVQ@mail.gmail.com>
Message-ID: <512E46BB.907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 08:33 PM, Javier Martinez Canillas wrote:
...
> Yes, I realized that requesting the gpio was necessary so what I did
> is to use the "regulator-fixed" optional property "gpio" and define
> the GPIO used as an IRQ in a regulator used by the SMSC chip. So, I
> have this on my board DT:
> 
> vddvario: regulator-vddvario {
> 	compatible = "regulator-fixed";
> 	regulator-name = "vddvario";
> 	regulator-always-on;
> 	gpio = <&gpio6 16 8>;  /* gpio line 176 */
> 	enable-active-high;
> 	gpio-open-drain;

While admittedly it's configured as open-drain, that will configure the
GPIO to be an output, whereas for usage as an interrupt, it really
should be configured as an input... Perhaps it makes no difference on
OMAP HW since the I/O paths are separate, but I can easily imagine HW
where this hack wouldn't work.

> 	regulator-boot-on;
> };
> 
> &gpmc {
> 	ethernet at 5,0 {
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&smsc911x_pins>;
> 		compatible = "smsc,lan9221", "smsc,lan9115";
> 		reg = <5 0 0xff>;
> 		interrupt-parent = <&gpio6>;
> 		interrupts = <16 8>; /* gpio line 176 */
> 		interrupt-names = "smsc911x irq";
> 		vmmc-supply = <&vddvario>;
> 		vmmc_aux-supply = <&vdd33a>;
> 		reg-io-width = <4>;
> 
> 		smsc,save-mac-address;
>       };
> };
> 
> That way a call to gpio_request_one() is made and the GPIO is requested.
> 
> This look a little hack-ish for me but I've seen this in other
> DeviceTrees like omap4-sdp.dts so I thought it was a common DT
> pattern.

Indeed; the GPIO is in no way a regulator, so while the above is fine
for testing, it's in no way a solution that can actually be used and
checked in.
