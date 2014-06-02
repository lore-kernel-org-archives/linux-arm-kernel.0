From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Mon, 02 Jun 2014 22:18:16 +0200
Subject: [PATCH 3/3] arm: tegra: initial support for apalis t30
In-Reply-To: <538CA5C3.5050709@wwwdotorg.org>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <b470c9c8631a6ef021d140192eb07006de3cfd93.1401665237.git.marcel@ziswiler.com>
 <538CA5C3.5050709@wwwdotorg.org>
Message-ID: <538CDC08.7020106@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2014 06:26 PM, Stephen Warren wrote:
>> +  toradex,colibri_t30
>> +  toradex,colibri_t30-eval-v3
>
> Those don't seem to be related to Apalis support.

Yes, that's why I mentioned it in the commit message as follows:

 >> While at it also add the device tree binding documentation for Apalis
 >> T30 as well as the previously missing one for the recently added
 >> Colibri T30.

If it is preferred having this as a separate commit I can ask Stefan to 
submit one once he returns from his vacation next week.

>> diff --git a/arch/arm/boot/dts/tegra30-apalis-eval.dts b/arch/arm/boot/dts/tegra30-apalis-eval.dts
>> +	host1x at 50000000 {
>> +		dc at 54200000 {
>> +			rgb {
>> +				status = "okay";
>> +				nvidia,panel = <&panel>;
>> +			};
>> +		};
>> +		hdmi at 54280000 {
>
> Nit: Add a blank line between the nodes. Check elsewhere too.

Sure, I actually checked elsewhere as it is 1-to-1 how it got accepted 
for the Colibri T30.

>> +	serial at 70006040 {
>> +		compatible = "nvidia,tegra30-hsuart";
>> +		status = "okay";
>> +	};
>
> Nit: Put the status property first followed by new/overridden
> properties, to be consistent with other Tegra DTs. Check elsewhere too.

Dito.

>> +	/* SPI1: Apalis SPI1 */
>> +	spi at 7000d400 {
>> +		status = "okay";
>> +		spi-max-frequency = <25000000>;
>> +		spidev0: spidev at 1 {
>
> Nit: Add a blank line between properties and nodes. Check elsewhere too.

Dito.

Please excuse our ignorance. I will fix it and ask Stefan to do the same 
for the Colibri T30 DT.

>> +	sd1: sdhci at 78000000 {
> ...
>> +	mmc1: sdhci at 78000400 {
>
> Do those nodes really need labels? Nothing appears to reference them,
> and I can't see why anything would.

Yes, you are absolutely right. This is a remnant of our tries to use 
aliases thereof to solve the predominant MMC block device ordering 
issue. I will remove them.

> Should the mmc1 node be non-removable? It seems a bit odd for a
> removable device to have an 8-bit data bus.

No, not odd at all. Our Apalis Evaluation Board does actually feature an 
8-bit MMCplus socket which while such cards are rather rare can be used 
to test this functionality in preparation of maybe designing an 
additional albeit then non-removable eMMC onto their custom carrier 
boards. So nothing wrong with that I believe.

>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +
>> +		/* PWM0 */
>
> Nit: No need for a blank line between a bunch of related properties.
> Check elsewhere too.

Sure, dito Colibri T30 DT again.

>> +	pwmleds {
>> +		compatible = "pwm-leds";
>> +
>> +		pwm3 {
>> +			label = "PWM3";
>> +			pwms = <&pwm 1 19600>;
>> +			max-brightness = <255>;
>> +		};
>> +		pwm2 {
>> +			label = "PWM2";
>> +			pwms = <&pwm 2 19600>;
>> +			max-brightness = <255>;
>> +		};
>> +		pwm1 {
>> +			label = "PWM1";
>> +			pwms = <&pwm 3 19600>;
>> +			max-brightness = <255>;
>> +		};
>
> Nit: Why not sort those nodes in numerical order?

Sure, the only question is ordering based on what. I choose the actual 
Tegra PWM instance while you propose to use our Apalis instance 
numbering which in this particular case turns out to be the opposite but 
makes us even more happy to comply.

>> +	regulators {
>> +		sys_5v0_reg: regulator at 1 {
>
> Nit: Why not start the numbering at 0?

Good question which I asked Stefan earlier as well. He proposed to start 
with 101 in the module dtsi while starting with 1 in the board dts. But 
I guess starting with 100 resp. 0 might be more C programmer friendly.

>> diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
>
>> +	pinmux at 70000868 {
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&state_default>;
>> +
>> +		state_default: pinmux {
>
> It might make sense to add all the pinmux data to
> https://github.com/NVIDIA/tegra-pinmux-scripts, so that both the kernel
> and U-Boot pinmux initialization tables can be auto-generated from a
> single data-structure. I think that'll get a small amount of
> error-/consistency-checking of the data too.

Yes, that makes sense. Please understand that our current mainlining 
effort started long before we even learned about the existence of those 
scripts. Let me look into adding this there as well.
