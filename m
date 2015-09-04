From: slash.tmp@free.fr (Mason)
Date: Fri, 04 Sep 2015 18:13:46 +0200
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <55E73971.8030406@free.fr>
References: <55E5CED8.7000408@free.fr>
 <55E5D945.3040504@gmail.com>	<55E722F2.50905@free.fr>
 <yw1xy4goyc3z.fsf@unicorn.mansr.com> <55E73971.8030406@free.fr>
Message-ID: <55E9C33A.2080801@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2015 20:01, Mason wrote:

> On 02/09/2015 19:17, M?ns Rullg?rd wrote:
> 
>> Use the latest DT from my tree.  It looks like you're missing some
>> changes.
> 
> Indeed, my repo is not up-to-date. (I was vaguely worried that you'd
> have made further changes that I'd have to revert when back-porting
> to 3.14)
> 
> I'll try upgrading and report back.
> 
> By the way, did you write the DT from scratch?
> 
> Are there people walking this earth that can write device tree like C?

No cigar :-(

There's just too much DT syntax that flies light-years over my head.
#address-cells, #size-cells, #interrupt-cells, ranges, aliases, etc.
Basically, all I understand is /dts-v1/;
(Anyone have links to good tutorials?)

I've attached the current version I'm playing with (I tried to make it
as small as possible). If some charitable soul spots an obvious problem...
(Commented blocks have been tested uncommented, of course.)

Regards

-------------- next part --------------
/dts-v1/;

/ {
	compatible = "sigma,tango4-soc";

	#address-cells = <1>;
	#size-cells = <1>;

	gic: interrupt-controller at 20001000 {
		compatible = "arm,cortex-a9-gic";
		interrupt-controller;
		#interrupt-cells = <3>;
		reg = <0x20001000 0x1000>,
		      <0x20000100 0x0100>;
	};

	soc {
		compatible = "simple-bus";
/*		interrupt-parent = <&irqintc>;	*/
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;

		uart0: uart at 10700 {
			compatible = "ns16550a";
			reg = <0x10700 0x100>;
			clock-frequency = <7372800>;
			reg-shift = <2>;
			no-loopback-test;
		};
	};

	cpublock: cpublock {
		compatible = "simple-bus";
		reg = <0x60000 0x10000>;
		ranges = <0x0 0x60000 0x10000>;
/*		interrupt-parent = <&irqintc>;	*/
		#address-cells = <1>;
		#size-cells = <1>;

		intc: intc at e000 {
			compatible = "sigma,tango-intc";
			reg = <0xe000 0x1000>;
			ranges = <0x0 0xe000 0x1000>;
			interrupt-parent = <&gic>;
			interrupt-controller;
			#address-cells = <1>;
			#size-cells = <1>;

			irqintc: irq at 000 {
				reg = <0x000 0x100>;
				interrupt-controller;
				#interrupt-cells = <2>;
				interrupts = <2>;
				label = "IRQ";
			};

/*
			fiqintc: fiq at 100 {
				reg = <0x100 0x100>;
				interrupt-controller;
				#interrupt-cells = <2>;
				interrupts = <3>;
				label = "FIQ";
			};

			iiqintc: iiq at 300 {
				reg = <0x300 0x100>;
				interrupt-controller;
				#interrupt-cells = <2>;
				interrupts = <4>;
				label = "IIQ";
			};
*/
		};
	};

};
