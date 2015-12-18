From: hzpeterchen@gmail.com (Peter Chen)
Date: Fri, 18 Dec 2015 15:38:22 +0800
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <CAL_Jsq+t6NBh-zzwPH14MYBp6PGFaVv3540Urdn8q6D+erQkLA@mail.gmail.com>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
 <3023844.AYbAYqvHUZ@wuerfel>
 <CAL_Jsq+KAF6FGyOyC0JzODsSVoK4+V6umpj=cANywgui_wOKMg@mail.gmail.com>
 <1827708.e1pfN6rEID@wuerfel> <20151217023118.GA3793@shlinux2>
 <CAL_Jsq+t6NBh-zzwPH14MYBp6PGFaVv3540Urdn8q6D+erQkLA@mail.gmail.com>
Message-ID: <CAL411-qWj4jwPW98gourzg2A+6HtbENyqRZPmam4z2mvdMXT6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 9:49 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Wed, Dec 16, 2015 at 8:31 PM, Peter Chen <peter.chen@freescale.com> wrote:
>> On Thu, Dec 17, 2015 at 12:13:07AM +0100, Arnd Bergmann wrote:
>>> On Wednesday 16 December 2015 16:59:39 Rob Herring wrote:
>>> > On Mon, Dec 14, 2015 at 3:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> > > On Monday 14 December 2015 15:26:11 Peter Chen wrote:
>>> >
>>> > I agree on doing it properly, but am not sure that pwrseq binding for
>>> > MMC is proper. The pwrseq binding is fairly limited and working around
>>> > the driver model IMO. Hubs may also need I2C setup which I don't think
>>> > could be done generically other than some defined sequence of i2c
>>> > transactions. The current project I'm working on needs to use I2C to
>>> > configure the hub to use HSIC mode for example. I really think we need
>>> > a pre-probe driver hook to handle this. That would allow device
>>> > specific setup to live in the driver.
>>> >
>>> > Perhaps a more simple approach would be just forcing driver probe if a
>>> > DT node is present. I'm not all that familiar with USB drivers, but
>>> > presumably there is some setup before probe like setting the USB
>>> > device address. We'd have to allow doing that later during probe.
>>>
>>> Yes, good idea. I was also advocating that approach for MMC at some
>>> point, but the power sequencing made it in the end.
>>>
>>
>> Currently, my design is much like Rob proposal's. I will populate all
>> children device under HUB's node (controller = 1st level hub), and
>> each special onboard USB device needs a platform driver, it can be
>> probed according to compatible string, and at its probe, it can register
>> itself as usb device if needed, and handle properties described at
>> its node. Sample code like below:
>
> It is not like my proposal because I don't think the design should be
> using a platform driver.
>

FSL email is migrating with NXP's, it is unavailable now, I use my
gmail account.

If I understand correct, you would like use current USB class driver to handle
its related device. Yes, it can work only the device can be discovered without
any pre-setup, like reset, clock setting, etc. The related class driver's probe
is only called when this kinds of classes (hid, mass storage, ethernet, etc)
is discovered by USB bus.

Besides this, we need pre-setup code to let the USB device can be discovered
if needed. There is no place to put this pre-setup code at related
class driver,
->probe will be called after discovered, at its init, we have no
struct device *,
even we can create an API for this purpose, and call it at its parent's driver,
this class driver may be not loaded at all.

If not use platform driver, we had to use the way MMC power code does that
is have this pre-setup code as library, and build together with USB core.

>> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
>> index 8263fc1..7451f7d 100644
>> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
>> @@ -590,6 +590,16 @@
>>  &usbh1 {
>>         vbus-supply = <&reg_usb_h1_vbus>;
>>         status = "okay";
>> +
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       hub: usb2415 at 01 {
>> +               compatible = "generic-onboard-hub";
>
> Please follow the already defined naming scheme for USB devices.
>
> Rob
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
BR,
Peter Chen
