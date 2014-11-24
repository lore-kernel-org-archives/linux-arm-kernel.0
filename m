From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Nov 2014 12:59:26 +0100
Subject: [RFC PATCH v2 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <1416605010-10442-4-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1416605010-10442-4-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <4080571.JcHDsAZ9EV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 November 2014 02:53:29 Ganapatrao Kulkarni wrote:
> +/ {
> +	model = "Cavium ThunderX CN88XX board";
> +	compatible = "cavium,thunder-88xx";

No wildcards in compatible strings or model names please. List the
exact chip that you are using.

> +	aliases {
> +		serial0 = &uaa0;
> +		serial1 = &uaa1;
> +	};
> +
> +	memory at 00c00000 {
> +		device_type = "memory";
> +		reg = <0x0 0x00000000 0x0 0x80000000>;
> +	};
> +
> +	memory at 10000000000 {
> +		device_type = "memory";
> +		reg = <0x100 0x00000000 0x0 0x80000000>;
> +	};
> +
> +	numa-map {
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		#node-count = <2>;
> +		mem-map = <0x0 0x00000000 0>,
> +		           <0x100 0x00000000 1>;
> +
> +               cpu-map = <0 47 0>,
> +			<48 95 1>;
> +
> +		node-matrix=    <0 0 10>,
> +				<0 1 20>,
> +				<1 0 20>,
> +				<1 1 10>;

I don't know how much history is behind this binding. Have you looked
at the sPAPR way of doing this? I don't remember exactly how that is
done, but we'd need a good reason to discard that and implement
something else for arm64.

If we create a new binding, I don't think the 'numa-map' node you
have here is the best solution. We already have device nodes for each
memory segment and each CPU in the system. Why not work with those
nodes directly?
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 13 0xff01>,
> +		             <1 14 0xff01>,
> +		             <1 11 0xff01>,
> +		             <1 10 0xff01>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		refclk50mhz: refclk50mhz {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <50000000>;
> +			clock-output-names = "refclk50mhz";
> +		};

Why is the timer outside of the soc and the refclk is inside?
I would have expected the opposite.

	Arnd 
