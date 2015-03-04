From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 4 Mar 2015 15:57:36 +0000
Subject: [PATCH 4/5] arm64: juno: Add APB registers and LEDs using syscon
In-Reply-To: <1425375148-4369-5-git-send-email-linus.walleij@linaro.org>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-5-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150304155736.GC16268@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 09:32:27AM +0000, Linus Walleij wrote:
> This defines the Juno "APB system registers" as a syscon device,
> and all the LEDs controlled by the APB system registers right
> below it using the syscon LEDs driver on top of syscon. Define
> LED0 for heartbeat, LED1 for MMC0 activity and the following
> four LEDs indicating CPU activity using the Linux-specific
> DT bindings for triggers.
> 
> This is the pattern and same drivers as used on the legacy
> platform device trees for the ARM Integrators and the RealView
> PB1176.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Tested-by: Liviu Dudau <Liviu.Dudau@arm.com>

KITT test shell script working beautifully. :)

Best regards,
Liviu

> ---
> ChangeLog v1->v2:
> - Use "simple-mfd" so that the syscon LEDs get spawned from the
>   syscon as sub-platform devices.
> ---
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 68 +++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> index c138b95a8356..5ce111dcf16d 100644
> --- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> @@ -66,6 +66,74 @@
>  				#size-cells = <1>;
>  				ranges = <0 3 0 0x200000>;
>  
> +				apbregs at 010000 {
> +					compatible = "syscon", "simple-mfd";
> +					reg = <0x010000 0x1000>;
> +
> +					led at 08.0 {
> +						compatible = "register-bit-led";
> +						offset = <0x08>;
> +						mask = <0x01>;
> +						label = "vexpress:0";
> +						linux,default-trigger = "heartbeat";
> +						default-state = "on";
> +					};
> +					led at 08.1 {
> +						compatible = "register-bit-led";
> +						offset = <0x08>;
> +						mask = <0x02>;
> +						label = "vexpress:1";
> +						linux,default-trigger = "mmc0";
> +						default-state = "off";
> +					};
> +					led at 08.2 {
> +						compatible = "register-bit-led";
> +						offset = <0x08>;
> +						mask = <0x04>;
> +						label = "vexpress:2";
> +						linux,default-trigger = "cpu0";
> +						default-state = "off";
> +					};
> +					led at 08.3 {
> +						compatible = "register-bit-led";
> +						offset = <0x08>;
> +						mask = <0x08>;
> +						label = "vexpress:3";
> +						linux,default-trigger = "cpu1";
> +						default-state = "off";
> +					};
> +					led at 08.4 {
> +						compatible = "register-bit-led";
> +						offset = <0x08>;
> +						mask = <0x10>;
> +						label = "vexpress:4";
> +						linux,default-trigger = "cpu2";
> +						default-state = "off";
> +					};
> +					led at 08.5 {
> +						compatible = "register-bit-led";
> +						offset = <0x08>;
> +						mask = <0x20>;
> +						label = "vexpress:5";
> +						linux,default-trigger = "cpu3";
> +						default-state = "off";
> +					};
> +					led at 08.6 {
> +						compatible = "register-bit-led";
> +						offset = <0x08>;
> +						mask = <0x40>;
> +						label = "vexpress:6";
> +						default-state = "off";
> +					};
> +					led at 08.7 {
> +						compatible = "register-bit-led";
> +						offset = <0x08>;
> +						mask = <0x80>;
> +						label = "vexpress:7";
> +						default-state = "off";
> +					};
> +				};
> +
>  				mmci at 050000 {
>  					compatible = "arm,pl180", "arm,primecell";
>  					reg = <0x050000 0x1000>;
> -- 
> 1.9.3
> 
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
