From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 08 Mar 2017 10:15:21 +0100
Subject: [PATCH v3 3/3] arm64: dts: marvell: add RTC description for
 Armada 7K/8K
In-Reply-To: <20170220173850.8640-4-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Mon, 20 Feb 2017 18:38:50 +0100")
References: <20170220173850.8640-1-gregory.clement@free-electrons.com>
 <20170220173850.8640-4-gregory.clement@free-electrons.com>
Message-ID: <87y3wgm8nq.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On lun., f?vr. 20 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> This RTC IP is found in the CP110 master and slave which are part of the
> Armada 8K SoCs and of the subset family the Armada 7K.
>
> There is one RTC in each CP but the RTC requires an external
> oscillator. However on the Armada 80x0, the RTC clock in CP master is not
> connected (by package) to the oscillator. So this one is disabled for the
> Armada 8020 and the Armada 8040.
>
> As the RTC clock in CP slave is connected to the oscillator this one is
> let enabled. and will be used on these SoCs (80x0).
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Applied on mvebu/dt64

Gregory


> ---
>  arch/arm64/boot/dts/marvell/armada-8020.dtsi         | 10 ++++++++++
>  arch/arm64/boot/dts/marvell/armada-8040.dtsi         |  9 +++++++++
>  arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi |  7 +++++++
>  arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |  7 +++++++
>  4 files changed, 33 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8020.dtsi b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
> index 048e5cf5160e..7c08f1f28d9e 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8020.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8020.dtsi
> @@ -54,3 +54,13 @@
>  	compatible = "marvell,armada8020", "marvell,armada-ap806-dual",
>  		     "marvell,armada-ap806";
>  };
> +
> +/* The RTC requires external oscillator. But on Aramda 80x0, the RTC clock
> + * in CP master is not connected (by package) to the oscillator. So
> + * disable it. However, the RTC clock in CP slave is connected to the
> + * oscillator so this one is let enabled.
> + */
> +
> +&cpm_rtc {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040.dtsi b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> index 9c1b28c47683..33813a75bc30 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-8040.dtsi
> @@ -54,3 +54,12 @@
>  	compatible = "marvell,armada8040", "marvell,armada-ap806-quad",
>  		     "marvell,armada-ap806";
>  };
> +
> +/* The RTC requires external oscillator. But on Aramda 80x0, the RTC clock
> + * in CP master is not connected (by package) to the oscillator. So
> + * disable it. However, the RTC clock in CP slave is connected to the
> + * oscillator so this one is let enabled.
> + */
> +&cpm_rtc {
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> index 3a99c36433d6..d12741414009 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
> @@ -79,6 +79,13 @@
>  					"cpm-usb3dev", "cpm-eip150", "cpm-eip197";
>  			};
>  
> +			cpm_rtc: rtc at 284000 {
> +				compatible = "marvell,armada-8k-rtc";
> +				reg = <0x284000 0x20>, <0x284080 0x24>;
> +				reg-names = "rtc", "rtc-soc";
> +				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
>  			cpm_sata0: sata at 540000 {
>  				compatible = "marvell,armada-8k-ahci",
>  					     "generic-ahci";
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> index 9e09c4d3b6bd..d51eb2db6df7 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
> @@ -59,6 +59,13 @@
>  			interrupt-parent = <&gic>;
>  			ranges = <0x0 0x0 0xf4000000 0x2000000>;
>  
> +			cps_rtc: rtc at 284000 {
> +				compatible = "marvell,armada-8k-rtc";
> +				reg = <0x284000 0x20>, <0x284080 0x24>;
> +				reg-names = "rtc", "rtc-soc";
> +				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
>  			cps_syscon0: system-controller at 440000 {
>  				compatible = "marvell,cp110-system-controller0",
>  					     "syscon";
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
