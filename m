From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 22 Dec 2015 15:40:00 +0100
Subject: [PATCHv3] ARM: mvebu: use regulator-boot-on for SATA regulators
 on Armada 388 GP
In-Reply-To: <1450794522-16483-1-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Tue, 22 Dec 2015 15:28:42 +0100")
References: <1450794522-16483-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <877fk6r1hb.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On mar., d?c. 22 2015, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Really, what we meant by regulator-always-on is that the regulators
> are already turned on by the bootloader, for which regulator-boot-on
> is a better description.
>
> A net advantage of using regulator-boot-on is that the regulator is
> not touched at boot time by the kernel, which avoids having the hard
> drives spinning down and then up again, taking several (~5) seconds of
> additional boot time.
>
> In addition, there is no need to have such properties on the child
> regulators used for SATA. Having it on the parent regulator that
> really controls the GPIO is sufficient.
>
> Without the patch:
>
> [    3.945866] ata2: SATA link down (SStatus 0 SControl 300)
> [    3.995862] ata3: SATA link down (SStatus 0 SControl 300)
> [    4.005863] ata4: SATA link down (SStatus 0 SControl 300)
> [    9.125861] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    9.144575] ata1.00: ATA-8: WDC WD5003ABYX-01WERA1, 01.01S02, max UDMA/133
> [    9.151471] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>
>  (and you can hear the disk spinning down and up during this 5.1
>  seconds delay)
>
> With the patch:
>
> [    3.945988] ata2: SATA link down (SStatus 0 SControl 300)
> [    4.005980] ata4: SATA link down (SStatus 0 SControl 300)
> [    4.011404] ata3: SATA link down (SStatus 0 SControl 300)
> [    4.145978] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    4.153701] ata1.00: ATA-8: WDC WD5003ABYX-01WERA1, 01.01S02, max UDMA/133
> [    4.160597] ata1.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/dt

Thanks,

Gregory
> ---
> Changes since v2:
>  - Use regulator-boot-on only for SATA regulators, not for USB
>    regulators.
> ---
>  arch/arm/boot/dts/armada-388-gp.dts | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
> index d8dab0f..5e47291 100644
> --- a/arch/arm/boot/dts/armada-388-gp.dts
> +++ b/arch/arm/boot/dts/armada-388-gp.dts
> @@ -319,7 +319,7 @@
>  		regulator-min-microvolt = <12000000>;
>  		regulator-max-microvolt = <12000000>;
>  		enable-active-high;
> -		regulator-always-on;
> +		regulator-boot-on;
>  		gpio = <&expander0 2 GPIO_ACTIVE_HIGH>;
>  	};
>  
> @@ -328,7 +328,6 @@
>  		regulator-name = "v5.0-sata0";
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
>  		vin-supply = <&reg_sata0>;
>  	};
>  
> @@ -337,7 +336,6 @@
>  		regulator-name = "v12.0-sata0";
>  		regulator-min-microvolt = <12000000>;
>  		regulator-max-microvolt = <12000000>;
> -		regulator-always-on;
>  		vin-supply = <&reg_sata0>;
>  	};
>  
> @@ -347,7 +345,7 @@
>  		regulator-min-microvolt = <12000000>;
>  		regulator-max-microvolt = <12000000>;
>  		enable-active-high;
> -		regulator-always-on;
> +		regulator-boot-on;
>  		gpio = <&expander0 3 GPIO_ACTIVE_HIGH>;
>  	};
>  
> @@ -356,7 +354,6 @@
>  		regulator-name = "v5.0-sata1";
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
>  		vin-supply = <&reg_sata1>;
>  	};
>  
> @@ -365,7 +362,6 @@
>  		regulator-name = "v12.0-sata1";
>  		regulator-min-microvolt = <12000000>;
>  		regulator-max-microvolt = <12000000>;
> -		regulator-always-on;
>  		vin-supply = <&reg_sata1>;
>  	};
>  
> @@ -373,7 +369,7 @@
>  		compatible = "regulator-fixed";
>  		regulator-name = "pwr_en_sata2";
>  		enable-active-high;
> -		regulator-always-on;
> +		regulator-boot-on;
>  		gpio = <&expander0 11 GPIO_ACTIVE_HIGH>;
>  	};
>  
> @@ -382,7 +378,6 @@
>  		regulator-name = "v5.0-sata2";
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
>  		vin-supply = <&reg_sata2>;
>  	};
>  
> @@ -391,7 +386,6 @@
>  		regulator-name = "v12.0-sata2";
>  		regulator-min-microvolt = <12000000>;
>  		regulator-max-microvolt = <12000000>;
> -		regulator-always-on;
>  		vin-supply = <&reg_sata2>;
>  	};
>  
> @@ -399,7 +393,7 @@
>  		compatible = "regulator-fixed";
>  		regulator-name = "pwr_en_sata3";
>  		enable-active-high;
> -		regulator-always-on;
> +		regulator-boot-on;
>  		gpio = <&expander0 12 GPIO_ACTIVE_HIGH>;
>  	};
>  
> @@ -408,7 +402,6 @@
>  		regulator-name = "v5.0-sata3";
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
> -		regulator-always-on;
>  		vin-supply = <&reg_sata3>;
>  	};
>  
> @@ -417,7 +410,6 @@
>  		regulator-name = "v12.0-sata3";
>  		regulator-min-microvolt = <12000000>;
>  		regulator-max-microvolt = <12000000>;
> -		regulator-always-on;
>  		vin-supply = <&reg_sata3>;
>  	};
>  };
> -- 
> 2.6.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
