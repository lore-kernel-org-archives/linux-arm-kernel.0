From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Aug 2014 10:34:24 -0600
Subject: [PATCH] ARM: tegra: remove pinmux setup from Tegra124 boards
In-Reply-To: <1407921548.5835.20.camel@weser.hi.pengutronix.de>
References: <1403563506-6461-1-git-send-email-swarren@wwwdotorg.org>
 <1407921548.5835.20.camel@weser.hi.pengutronix.de>
Message-ID: <53F22B10.1010106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2014 03:19 AM, Lucas Stach wrote:
> Hi Stephen,
>
> sorry for getting on this late, I completely missed this and only now
> stumbled upon this.
>
> I'm not really fond of this change. The barebox bootloader completely
> probes itself from DT, including the pinmux. We try to stay as close as
> possible to the upstream kernel DTs and only introduce minimal changes.
> Removing the pinmux from the DTS will completely break barebox, as we
> don't have any static pinmux tables there.
>
> In order to not break the bootloader use-case I strongly advocate to
> keep the static pinmux in the DT. Can't we just rename the the state to
> something like "initial", so Linux won't try to set it by default? This
> way we could still keep the information in the DT, while being able to
> say "if you are going to program the initial pinmux state you need to
> follow the sequence defined by NVIDIA syseng".
>
> This obviously would make the naming of the state part of the binding,
> but I think this may be acceptable.

Linus, what do you think of Lucas's proposal?

As background, the Tegra HW design implies that all initial pinmux setup 
should be applied one time early during boot before peripherals are 
used. That means it should happen early in boot code, not once an OS 
like Linux has been loaded, since loading the OS requires use of at 
least some peripheral(s). Hence, there's no point the kernel re-applying 
the same configuration.

I had suggested (in this patch) removing the pinmux completely from the 
DT, since no OS should need it. However, the Barebox bootloader is 
configured via DT, and so wants to keep the pinmux configuration in the 
DT, rather than embedding the pinmux tables into the bootloader's board 
support code. Lucas has suggested simply changing the pinmux state name 
in the DT so that the kernel won't apply the pinmux configuration yet 
it's still there for the bootloader to use if it wants.

I'd suggest "boot" rather than "initial" myself for the new state name, 
but that's just bike-shedding.

> Regards,
> Lucas
>
> Am Montag, den 23.06.2014, 16:45 -0600 schrieb Stephen Warren:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The defined mechanism for programming the Tegra pinmux is to perform all
>> of the following at once:
>>
>> - Set the CLAMP_INPUTS_WHEN_TRISTATED PMC register bit.
>> - Set up any GPIO pins to their "initial" state.
>> - Program all pinmux settings in one go.
>>
>> Other methods such as:
>>
>> - Not setting CLAMP_INPUTS_WHEN_TRISTATED.
>> - Not setting GPIOs to their "initial" state before programming the
>>    pinmux settings of the related pin, in particular the mux function.
>> - Not programming the entire pinmux at once, in order to avoid
>>    possible conflicting settings.
>>
>> ... are not qualified or supported by NVIDIA ASIC/syseng. They could
>> cause glitches or undesired output levels on some pins, or controller
>> malfunction.
>>
>> While we've been getting away with doing something different on many
>> Tegra boards without issue, I believe we've just been getting lucky.
>> I'd like to switch all Tegra124 systems to the correct scheme now so
>> they provide the right example to follow, and require that any new
>> boards we support upstream work in the same fashion.
>>
>> While it would be nice to update boards containing older SoCs for
>> consistency, I don't anticipate doing so. It's too much churn to change
>> at this time. At least with all Tegra124 boards converted, the most
>> recent boards provide the correct example.
>>
>> Since the bootloader needs to reprogram the pinmux to access certain
>> peripherals, it must program the entire pinmux due to the supported
>> rules above. As such, there is no need to program any part of the pinmux
>> from the kernel, unless dynamic pinmuxing is used. Hence, this change
>> removes all static pinmux from all Tegra124 board DTs.
>>
>> The following U-Boot commits fully initialize the pinmux:
>>
>> Jetson TK1: 4ff213b8e478 ARM: tegra: clamp inputs on Jetson TK1
>>
>> Venice2: 3365479ce78a ARM: tegra: Venice2 pinmux spreadsheet updates
>>
>> Without those commits, the only fallout I see from this change is that
>> HDMI on Venice2 no longer works. Given the very small user-base of this
>> platform, I feel that requiring a bootloader update is reasonable.
>>
>> Cc: Andrew Bresticker <abrestic@chromium.org>
>> Cc: Doug Anderson <dianders@chromium.org>
>> Cc: Dylan Reid <dgreid@chromium.org>
>> Cc: Laxman Dewangan <ldewangan@nvidia.com>
>> Cc: Thierry Reding <treding@nvidia.com>
>> Cc: Olof Johansson <olof@lixom.net>
>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>   arch/arm/boot/dts/tegra124-jetson-tk1.dts | 1320 -----------------------------
>>   arch/arm/boot/dts/tegra124-venice2.dts    |  541 ------------
>>   2 files changed, 1861 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> index 16082c0bdaca..4935910b16e2 100644
>> --- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> +++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
>> @@ -30,1326 +30,6 @@
>>   		};
>>   	};
>>
>> -	pinmux: pinmux at 0,70000868 {
>> -		pinctrl-names = "default";
>> -		pinctrl-0 = <&state_default>;
>> -
>> -		state_default: pinmux {
>> -			clk_32k_out_pa0 {
>> -				nvidia,pins = "clk_32k_out_pa0";
>> -				nvidia,function = "soc";
>> -				nvidia,pull = <TEGRA_PIN_PULL_UP>;
>> -				nvidia,tristate = <TEGRA_PIN_DISABLE>;
>> -				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
>> -			};
...
>> -			jtag_rtck {
>> -				nvidia,pins = "jtag_rtck";
>> -				nvidia,function = "rtck";
>> -				nvidia,pull = <TEGRA_PIN_PULL_UP>;
>> -				nvidia,tristate = <TEGRA_PIN_DISABLE>;
>> -				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
>> -			};
>> -		};
>> -	};

>> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts

>> -	pinmux: pinmux at 0,70000868 {
>> -		pinctrl-names = "default";
>> -		pinctrl-0 = <&pinmux_default>;
>> -
>> -		pinmux_default: common {
>> -			dap_mclk1_pw4 {
>> -				nvidia,pins = "dap_mclk1_pw4";
>> -				nvidia,function = "extperiph1";
>> -				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
>> -				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
>> -				nvidia,tristate = <TEGRA_PIN_DISABLE>;
>> -			};
...
>> -			hp_det_l {
>> -				nvidia,pins = "ulpi_data1_po2";
>> -				nvidia,function = "spi3";
>> -				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
>> -				nvidia,tristate = <TEGRA_PIN_DISABLE>;
>> -				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
>> -			};
>> -		};
>> -	};
