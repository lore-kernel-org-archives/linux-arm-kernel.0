From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Jan 2015 13:40:53 -0800
Subject: [PATCH 12/13] ARM: dts: omap3-gta04: uart4 is not connected, so
 mark it "disabled"
In-Reply-To: <1421959099-28319-13-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
 <1421959099-28319-13-git-send-email-marek@goldelico.com>
Message-ID: <20150122214052.GY7718@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [150122 12:42]:
> From: NeilBrown <neil@brown.name>
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 228e79b..8d2b0a1 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -357,6 +357,10 @@
>  	pinctrl-0 = <&uart3_pins>;
>  };
>  
> +&uart4 {
> +	status = "disabled";
> +};
> +

This you probably want to avoid from PM point of view. Depending on
bootloader state of uart4, Linux may or may not be able to hit any
deeper power states.

Marking something with status = "disabled" in dts causes the device
entry not even to be created. That means hwmod won't be able to reset
and idle this device during boot.

The uart4 device is there for sure even if not muxed and in incomplete
state. You may want to also check other places where you're using
status = "disabled" for the same reasons.

Regards,

Tony
