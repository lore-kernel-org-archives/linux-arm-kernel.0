From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 17 Dec 2015 07:49:55 -0600
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <20151217023118.GA3793@shlinux2>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
 <3023844.AYbAYqvHUZ@wuerfel>
 <CAL_Jsq+KAF6FGyOyC0JzODsSVoK4+V6umpj=cANywgui_wOKMg@mail.gmail.com>
 <1827708.e1pfN6rEID@wuerfel> <20151217023118.GA3793@shlinux2>
Message-ID: <CAL_Jsq+t6NBh-zzwPH14MYBp6PGFaVv3540Urdn8q6D+erQkLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2015 at 8:31 PM, Peter Chen <peter.chen@freescale.com> wrote:
> On Thu, Dec 17, 2015 at 12:13:07AM +0100, Arnd Bergmann wrote:
>> On Wednesday 16 December 2015 16:59:39 Rob Herring wrote:
>> > On Mon, Dec 14, 2015 at 3:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > > On Monday 14 December 2015 15:26:11 Peter Chen wrote:
>> >
>> > I agree on doing it properly, but am not sure that pwrseq binding for
>> > MMC is proper. The pwrseq binding is fairly limited and working around
>> > the driver model IMO. Hubs may also need I2C setup which I don't think
>> > could be done generically other than some defined sequence of i2c
>> > transactions. The current project I'm working on needs to use I2C to
>> > configure the hub to use HSIC mode for example. I really think we need
>> > a pre-probe driver hook to handle this. That would allow device
>> > specific setup to live in the driver.
>> >
>> > Perhaps a more simple approach would be just forcing driver probe if a
>> > DT node is present. I'm not all that familiar with USB drivers, but
>> > presumably there is some setup before probe like setting the USB
>> > device address. We'd have to allow doing that later during probe.
>>
>> Yes, good idea. I was also advocating that approach for MMC at some
>> point, but the power sequencing made it in the end.
>>
>
> Currently, my design is much like Rob proposal's. I will populate all
> children device under HUB's node (controller = 1st level hub), and
> each special onboard USB device needs a platform driver, it can be
> probed according to compatible string, and at its probe, it can register
> itself as usb device if needed, and handle properties described at
> its node. Sample code like below:

It is not like my proposal because I don't think the design should be
using a platform driver.

> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 8263fc1..7451f7d 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -590,6 +590,16 @@
>  &usbh1 {
>         vbus-supply = <&reg_usb_h1_vbus>;
>         status = "okay";
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       hub: usb2415 at 01 {
> +               compatible = "generic-onboard-hub";

Please follow the already defined naming scheme for USB devices.

Rob
