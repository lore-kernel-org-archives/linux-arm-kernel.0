From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 20 Sep 2012 11:06:03 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1348135563.11116.94.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Morning,

On Wed, 2012-09-19 at 18:44 +0100, Stefano Stabellini wrote:
> +/dts-v1/;
> +
> +/include/ "skeleton.dtsi"

Any particular reason to include skeleton? And I think it would be
better to use #address-cells = <2> and #size-cells = <2>, to be ready
for LPAE addresses...

> +/ {
> +	model = "XENVM-4.2";
> +	compatible = "xen,xenvm-4.2", "arm,vexpress";
> +	interrupt-parent = <&gic>;
> +
> +	chosen {
> +		bootargs = "earlyprintk console=hvc0 root=/dev/xvda init=/sbin/init";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a15";
> +			reg = <0>;
> +		};
> +	};
> +
> +	memory {

Formally, it should be memory at 80000000, not that I have any strong
feelings about it :-)

> +		device_type = "memory";
> +		reg = <0x80000000 0x08000000>;
> +	};
> +
> +	gic: interrupt-controller at 2c001000 {
> +		compatible = "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0x2c001000 0x1000>,
> +		      <0x2c002000 0x100>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <1 13 0xf08>,
> +			     <1 14 0xf08>,
> +			     <1 11 0xf08>,
> +			     <1 10 0xf08>;
> +	};
> +
> +	hypervisor {
> +		compatible = "xen,xen-4.2", "xen,xen";
> +		reg = <0xb0000000 0x20000>;
> +		interrupts = <1 15 0xf08>;
> +	};

Is this binding documented somewhere - I mean in
Documentation/devicetree/bindings?

> +	motherboard {
> +		arm,v2m-memory-map = "rs1";
> +		ranges = <0 0 0x08000000 0x04000000>,
> +			 <1 0 0x14000000 0x04000000>,
> +			 <2 0 0x18000000 0x04000000>,
> +			 <3 0 0x1c000000 0x04000000>,
> +			 <4 0 0x0c000000 0x04000000>,
> +			 <5 0 0x10000000 0x04000000>;
> +
> +		interrupt-map-mask = <0 0 63>;
> +		interrupt-map = <0 0  0 &gic 0  0 4>,
> +				<0 0  1 &gic 0  1 4>,
> +				<0 0  2 &gic 0  2 4>,
> +				<0 0  3 &gic 0  3 4>,
> +				<0 0  4 &gic 0  4 4>,
> +				<0 0  5 &gic 0  5 4>,
> +				<0 0  6 &gic 0  6 4>,
> +				<0 0  7 &gic 0  7 4>,
> +				<0 0  8 &gic 0  8 4>,
> +				<0 0  9 &gic 0  9 4>,
> +				<0 0 10 &gic 0 10 4>,
> +				<0 0 11 &gic 0 11 4>,
> +				<0 0 12 &gic 0 12 4>,
> +				<0 0 13 &gic 0 13 4>,
> +				<0 0 14 &gic 0 14 4>,
> +				<0 0 15 &gic 0 15 4>,
> +				<0 0 16 &gic 0 16 4>,
> +				<0 0 17 &gic 0 17 4>,
> +				<0 0 18 &gic 0 18 4>,
> +				<0 0 19 &gic 0 19 4>,
> +				<0 0 20 &gic 0 20 4>,
> +				<0 0 21 &gic 0 21 4>,
> +				<0 0 22 &gic 0 22 4>,
> +				<0 0 23 &gic 0 23 4>,
> +				<0 0 24 &gic 0 24 4>,
> +				<0 0 25 &gic 0 25 4>,
> +				<0 0 26 &gic 0 26 4>,
> +				<0 0 27 &gic 0 27 4>,
> +				<0 0 28 &gic 0 28 4>,
> +				<0 0 29 &gic 0 29 4>,
> +				<0 0 30 &gic 0 30 4>,
> +				<0 0 31 &gic 0 31 4>,
> +				<0 0 32 &gic 0 32 4>,
> +				<0 0 33 &gic 0 33 4>,
> +				<0 0 34 &gic 0 34 4>,
> +				<0 0 35 &gic 0 35 4>,
> +				<0 0 36 &gic 0 36 4>,
> +				<0 0 37 &gic 0 37 4>,
> +				<0 0 38 &gic 0 38 4>,
> +				<0 0 39 &gic 0 39 4>,
> +				<0 0 40 &gic 0 40 4>,
> +				<0 0 41 &gic 0 41 4>,
> +				<0 0 42 &gic 0 42 4>;
> +	};
> +};

You've lost me here... You have ranges and interrupt map, but don't
include motherboard file. Is it a mistake? If not, you could remove the
ranges and interrupt-map, but where do you get your peripherals from
then?

> diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
> index 318d308..5c633c5 100644
> --- a/arch/arm/mach-vexpress/Makefile.boot
> +++ b/arch/arm/mach-vexpress/Makefile.boot
> @@ -7,4 +7,5 @@ initrd_phys-y	:= 0x60800000
>  dtb-$(CONFIG_ARCH_VEXPRESS_DT)	+= vexpress-v2p-ca5s.dtb \
>  				   vexpress-v2p-ca9.dtb \
>  				   vexpress-v2p-ca15-tc1.dtb \
> -				   vexpress-v2p-ca15_a7.dtb
> +				   vexpress-v2p-ca15_a7.dtb \
> +				   vexpress-xenvm-4.2.dtb

Cheers!

Pawel
