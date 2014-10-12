From: jan.kardell@telliq.com (Jan Kardell)
Date: Sun, 12 Oct 2014 15:08:24 +0200
Subject: [PATCH] ARM: dts: am335x-boneblack: set dcdc1 regulator
 for 1.35v ddr3
In-Reply-To: <1412973219-3674-1-git-send-email-robertcnelson@gmail.com>
References: <1412973219-3674-1-git-send-email-robertcnelson@gmail.com>
Message-ID: <543A7D48.1080808@telliq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Nelson skrev:
> The TPS65217C used on the boneblack defaults to 1.5v on startup for dcdc1_reg.
> While 1.35v ddr3 memory is actually used. This was discovered by a user during
> a schematic review of his beaglebone-black clone, a u-boot patch will also also
> be submitted.
Isn't it dual voltage, 1,35 or 1,5 V?

And what happens when u-boot voltage does not match the kernel? Found this:

If the SDRAM is powered up and initialized for the 1.5V operating 
voltage range, voltage
can be reduced to the 1.35V operation range provided that:
? Just prior to reducing the 1.5V operating voltages, no further 
commands are issued,
other than NOPs or COMMAND INHIBITs, and all banks are in the precharge 
state.
? The 1.35V operating voltages are stable prior to issuing new commands, 
other than
NOPs or COMMAND INHIBITs.
? The DLL is reset and relocked after the 1.35V operating voltages are 
stable and prior to
any READ command.
? The ZQ calibration is performed. tZQinit must be satisfied after the 
1.35V operating
voltages are stable and prior to any READ command.

Actually I'm not sure what this means in practice, but maybe this is a 
problem?

//Jan
>
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Vagrant Cascadian <vagrant@debian.org>
> ---
>   arch/arm/boot/dts/am335x-boneblack.dts | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
> index 901739f..e7c8999 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -15,6 +15,13 @@
>   	compatible = "ti,am335x-bone-black", "ti,am335x-bone", "ti,am33xx";
>   };
>   
> +&dcdc1_reg {
> +	/* TPS65217C defaults to 1.5v on powerup while 1.35v DDR3 is used */
> +	regulator-min-microvolt = <1350000>;
> +	regulator-max-microvolt = <1350000>;
> +	regulator-boot-on;
> +};
> +
>   &ldo3_reg {
>   	regulator-min-microvolt = <1800000>;
>   	regulator-max-microvolt = <1800000>;


-- 

"I have always wished for my computer to be as easy to use as my telephone; my wish has come true because I can no longer figure out how to use my telephone."
- Bjarne Stroustrup
