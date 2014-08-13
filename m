From: abrestic@chromium.org (Andrew Bresticker)
Date: Wed, 13 Aug 2014 09:23:16 -0700
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <20140813085304.GE7735@ulmo>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
 <20140813085304.GE7735@ulmo>
Message-ID: <CAL1qeaFW2LCETWCy6WduNRCGAonaaAwmoaDRHEtQJmkbpybDiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 1:53 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Aug 12, 2014 at 06:56:07PM -0700, Dylan Reid wrote:
>> The Acer Chromebook 13, codenamed "Big", contains an NVIDIA tegra124
>> processor and is similar to the Venice2 reference platform.
>>
>> The keyboard, USB 2, audio, HDMI, sdcard and emmc have been tested
>> and work on the 1366x768 models.  I haven't tried on the HD systems
>> yet.
>
> Presumably the HD systems will have a different compatible?

They do not.  ChromeOS kernels just parse the EDID, so I suppose we'll
need something similar here to support the HD panel.

> Is it only the panel that's different or are there other changes?

Only the panel is different.

>> There is also an issue on reboot because the TPM isn't reset.  It will
>> cause the stock firmware to enter recovery mode.  This can be worked
>> around by an EC-reset, press refresh and power at the same time.
>
> It's not clear to me what exactly this implies. Does it mean the system
> won't boot unless you manually press "refresh" and "power"? Are those
> keyboard buttons or keys on some debug board?

The system will enter recovery mode (and thus won't boot) unless you
do an EC reset.  Refresh and power are keys on the keyboard.

>> diff --git a/arch/arm/boot/dts/tegra124-big.dts b/arch/arm/boot/dts/tegra124-big.dts
>> new file mode 100644
>> index 0000000..aa0cd9f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/tegra124-big.dts
>> @@ -0,0 +1,1137 @@
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/input/input.h>
>> +#include "tegra124.dtsi"
>> +
>> +/ {
>> +     model = "Google Big";
>
> Perhaps this should at least mention that it's the Acer Chromebook 13.
> Otherwise this could just as well be some random development board.

The convention for other Chromebooks so far (see
exynos5420-peach-pit.dts for example) has just been to include the
Google board name.

>> +     compatible = "google,nyan-big", "nvidia,tegra124";
>
> What's "nyan"? Are there other variants of "big" other than "nyan"?

Nyan is the name for our Tegra124 reference platform.  Big is derived
from this and there are other variants of Nyan other than Big.

>> +     serial at 0,70006000 {
>> +             status = "okay";
>> +     };
>
> We've started to annotate some of these nodes in other DTS files to make
> it easier for people to match them to connectors on the board (or the
> schematics). This isn't necessarily important for things like PWM, since
> their use is fairly obvious and usually in-kernel only (with perhaps an
> exception of a PWM routed to some expansion header on some development
> board). For generic interfaces it's good to know what they map to on the
> device.
>
> Is this serial available as an accessible connector? Or is it some debug
> serial that's only available on a (non-equipped) header on the board?

There is a debug connector on the board which provides the serial
lines.  It is similar to Venice2, but in a different form factor.

>> +     i2c at 0,7000c400 {
>> +             status = "okay";
>> +             clock-frequency = <100000>;
>> +     };
>> +
>> +     i2c at 0,7000c500 {
>> +             status = "okay";
>> +             clock-frequency = <400000>;
>> +
>> +             tpm at 20 {
>> +                     compatible = "infineon,slb9645tt";
>> +                     reg = <0x20>;
>> +             };
>
> I presume this is the TPM that you said isn't reset on reboot? Do you
> know the reason for why it isn't being reset? What's needed to reset
> this module? I assume it's something that can (and will eventually) be
> fixed?

Tegra SoCs are normally reset via the PMC, however that does not reset
any external peripherals.  In order to reset the TPM at the same time
as the SoC, the GPIO I5 must be driven low.  Something like the
gpio-poweroff driver, but instead for restart could be used to do
this.

>> +                             battery: sbs-battery at b {
>> +                                     compatible = "sbs,sbs-battery";
>> +                                     reg = <0xb>;
>> +                                     sbs,i2c-retry-count = <2>;
>> +                                     sbs,poll-retry-count = <10>;
>> +                                     power-supplies = <&charger>;
>
> The sbs-battery binding doesn't define a power-supplies property.

It does, but it's not specific to sbs-battery.  All power supplies
have an optional power-supplies property, see
Documentation/devicetree/bindings/power_supply/power_supply.txt.
