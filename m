From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Aug 2014 10:10:06 -0600
Subject: [PATCH v2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <53EF76CF.9050808@suse.de>
References: <1407957267-3258-1-git-send-email-dgreid@chromium.org>
 <53EF76CF.9050808@suse.de>
Message-ID: <53F2255E.7090208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2014 09:20 AM, Andreas F?rber wrote:
> Hi,
>
> Am 13.08.2014 21:14, schrieb Dylan Reid:
>> The Acer Chromebook 13, codenamed Big, contains an NVIDIA tegra124
>> processor and is similar to the Venice2 reference platform.
>>
>> The keyboard, USB 2, audio, HDMI, sdcard, and emmc have been tested
>> and work on the 1266x768 models.  The HD models haven't yet been
>> tested.
>>
>> WiFi does not work yet, it needs at least some PMIC changes to enable
>> the 32k clock.
>>
>> The elan trackpad is not yet functional but hopefully will be soon as
>> there are patches under review.
>>
>> There is also an issue on reboot because the TPM isn't reset.  It will
>> cause the stock firmware to enter recovery mode.  This can be worked
>> around by an EC-reset, press the refresh and power keys at the same
>> time.

>> diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts
>> new file mode 100644
>> index 0000000..79f1852
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
>> @@ -0,0 +1,1136 @@
>> +/dts-v1/;
>> +
>> +#include <dt-bindings/input/input.h>
>> +#include "tegra124.dtsi"
>> +
>> +/ {
>> +	model = "Acer Chromebook 13";
>> +	compatible = "google,nyan-big", "nvidia,tegra124";
>
> In light of v1 and the above commit message referring to this as Google
> Big, shouldn't this be "google,big", "nvidia,tegra124" and optionally
> "google,nyan" as secondary string, independent of the new file name?

Despite this board having been derived from Nyan, it isn't Nyan, so I 
don't think Nyan should be part of any compatible value, nor a separate 
compatible value.

>> +	pinmux: pinmux at 0,70000868 {
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinmux_default>;
>> +
>> +		pinmux_default: common {
>> +			dap_mclk1_pw4 {
>
> Any need to have the nodes this way? Shouldn't this rather be
> dap-mclk1-pw4 as node name by conventions, with a dap_mclk1_pw4 label
> for referencing if needed? Same below, obviously.

Underscores are consistent with at least all the other Tegra DTs, so I 
think this is best as is.

>> +	pwm: pwm at 0,7000a000 {
>
> Add the label to the .dtsi where the node is first declared? Then you
> can override it the safer &pwm { ... }; way. Same for all other nodes
> being extended/overridden here - that's what your colleagues requested
> for Spring. It'll help with the 80 char limit further below by reducing
> indentation.

We certainly do have the pwm label in *.dtsi for other SoCs, so we 
should probably move the label there.

Using the &pwm {} syntax would be inconsistent with all the other Tegra 
DTs, and isn't really any safer; the HW isn't going to change, so once 
this is written, it should continue to "just work".
