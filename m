From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Aug 2014 09:51:08 -0700
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <20140813085304.GE7735@ulmo>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>
 <20140813085304.GE7735@ulmo>
Message-ID: <CAOesGMg2uZ8-ypeuSXJoSN3mz6jBjNwLbTo9EiXOf2D7iVCfiQ@mail.gmail.com>
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
> Presumably the HD systems will have a different compatible? Is it only
> the panel that's different or are there other changes?
>
>> There is also an issue on reboot because the TPM isn't reset.  It will
>> cause the stock firmware to enter recovery mode.  This can be worked
>> around by an EC-reset, press refresh and power at the same time.
>
> It's not clear to me what exactly this implies. Does it mean the system
> won't boot unless you manually press "refresh" and "power"? Are those
> keyboard buttons or keys on some debug board?
>
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
>
>> +     compatible = "google,nyan-big", "nvidia,tegra124";
>
> What's "nyan"? Are there other variants of "big" other than "nyan"?
>
>> +     pinmux: pinmux at 0,70000868 {
>> +             pinctrl-names = "default";
>> +             pinctrl-0 = <&pinmux_default>;
>> +
>> +             pinmux_default: common {
>> +                     dap_mclk1_pw4 {
>> +                             nvidia,pins = "dap_mclk1_pw4";
>> +                             nvidia,function = "extperiph1";
>> +                             nvidia,enable-input = <TEGRA_PIN_DISABLE>;
>> +                             nvidia,pull = <TEGRA_PIN_PULL_NONE>;
>> +                             nvidia,tristate = <TEGRA_PIN_DISABLE>;
>> +                     };
>
> Stephen proposed a patch not so long ago that removes the static pinmux
> settings from DTS files[0]. I'd expect he'll have objections to this DTS
> providing the static settings.
>
> The assumption with that patch is that the bootloader will have to set
> up the entire pinmux anyway (to prevent conflicting settings), therefore
> there'd be no need to do it in the kernel. Is this something that your
> bootloader already does (or could be modified to do)?

It's extra work to switch it over since the assumption is brand new.
It's something we can consider for future platforms but Stephen
dropped that patch like a bomb from a blue sky _after_ the final
versions of firmware had been cut -- or more importantly, tested. So,
we should have this in the kernel at this time.

We've always been developing the linux kernel on embedded platforms
with the mindset that firmware will usually get things wrong at some
point, so the safe thing is to not make assumptions about how it has
configured the hardware and do most of it from scratch in the kernel.
It's how we have handled all tegra pinmux up until now, and doing a
180-degree turn on this now, when there has been no _new_ concerns
that caused this, seems like a complication that is just throwing
everybody in a loop.

The same concerns about conflicting pinmux settings surely exists on
any platform that does muxing. Tegra isn't unique in this way, so I
wonder what is causing the need to remove this functionality from the
kernel?

I'll be happy to discuss this more off-list w.r.t. future projects
that we can cut over to rely more on firmware pinmux, but the public
mailing list is not the right place for that.


-Olof
