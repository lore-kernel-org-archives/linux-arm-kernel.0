From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 09:13:43 +0200
Subject: [RFC PATCHv2 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA  Cyclone 5 HW
In-Reply-To: <1342113976-27140-3-git-send-email-dinguyen@altera.com>
References: <1342113976-27140-1-git-send-email-dinguyen@altera.com>
 <1342113976-27140-3-git-send-email-dinguyen@altera.com>
Message-ID: <20120717091343.1eb8939d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le Thu, 12 Jul 2012 12:26:16 -0500,
<dinguyen@altera.com> a ?crit :

> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
> new file mode 100644
> index 0000000..710c773
> --- /dev/null
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
> @@ -0,0 +1,118 @@
> +/*
> + *  Copyright (C) 2012 Altera Corporation <www.altera.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/dts-v1/;
> +/include/ "socfpga.dtsi"
> +
> +/ {
> +	model = "Altera SOCFPGA Cyclone V";
> +	compatible = "altr,socfpga-cyclone5";
> +
> +	aliases {
> +		ethernet0 = &gmac0;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,57600";
> +	};
> +
> +	memory {
> +		name = "memory";
> +		device_type = "memory";
> +		reg = <0x0 0x10000000>; /* 256MB */
> +	};
> +
> +	soc {
> +		amba {
> +			compatible = "arm,amba-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			pdma: pdma at ffe01000 {
> +				compatible = "arm,pl330", "arm,primecell";
> +				reg = <0xffe01000 0x1000>;
> +				interrupts = <0 180 4>;
> +			};
> +		};
> +
> +		apb_periphs {
> +			compatible = "simple-bus";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			uart0: uart at ffc02000 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0xffc02000 0x1000>;
> +				clock-frequency = <7372800>;
> +				interrupts = <0 162 4>;
> +				reg-shift = <2>;
> +				reg-io-width = <4>;
> +			};
> +
> +		timer0: timer at ffc08000 {
> +				compatible = "snps,dw-apb-timer-sp";
> +				interrupts = <0 167 4>;
> +				clock-frequency = <200000000>;
> +				reg = <0xffc08000 0x1000>;
> +			};

There is an indentation problem here, the timer0 (and the following)
should be at the same level as uart0.

Also, are all those peripherals (uarts, timers) really board-specific?
I.e, are they synthesized on the FPGA part, or are they part of the ARM
SoC, in which case they should be listed in the .dtsi and not in
the .dts.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
