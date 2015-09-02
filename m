From: slash.tmp@free.fr (Mason)
Date: Wed, 02 Sep 2015 18:25:22 +0200
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <55E5D945.3040504@gmail.com>
References: <55E5CED8.7000408@free.fr> <55E5D945.3040504@gmail.com>
Message-ID: <55E722F2.50905@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2015 18:58, Florian Fainelli wrote:

> On 01/09/15 09:14, Mason wrote:
>
>> I'm trying to port to my ARM platform: IRQ handling code written for MIPS.
>> https://github.com/mansr/linux-tangox/blob/master/drivers/irqchip/irq-tangox.c
> 
> Calling clear_c0_status() and write_c0_status() in tangox_irq_handler()
> sounds like a layering violation here, this should be taken care of by
> the interrupt code once proper parenting between the MIPS IRQ controller
> and your tangox controller is established.

Following Mans' suggestion, I deleted the arch-specific code, and
the driver now compiles and links.

Unfortunately, I still can't get it to work, and I've been banging
my head against the wall over this device tree monstrosity.

tangox_irq_init() fails in irq_of_parse_and_map()

I see that
irqchip_init is called
gic_of_init is called
but of_irq_parse_one(dev, index, &oirq) fails... :-(

Also, it makes no sense to me that an "interrupt-parent" specifies
"downstream" controllers. Parent relationship usually moves closer
to the "source" (like clk IIRC).

I've attached my (lame) attempt at a device tree.

If anyone can help me, I'd be eternally grateful. It doesn't help
that device tree syntax looks like Klingon to me. My eyes have been
glazing over [1] for days, but nothing is sinking in, and I find
myself unscientifically hacking random bits with 0 success.

[1] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

Regards.

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
		interrupt-parent = <&irqintc>;
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;

		uart0: serial at 10700 {
			compatible = "ns16550a";
			reg = <0x10700 0x100>;
			clock-frequency = <7372800>;
			reg-shift = <2>;
			no-loopback-test;
		};

/*		eth0: emac at 26000 {
			compatible = "sigma,smp8640-emac";
			reg = <0x26000 0x800>;
			interrupts = <38>;
			clocks = <396000000>;
		}; */
	};

	cpublock: cpublock {
		compatible = "simple-bus";
		reg = <0x60000 0x10000>;
		ranges = <0x0 0x60000 0x10000>;
		interrupt-parent = <&irqintc>;
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
				#interrupt-cells = <2>;
				interrupts = <2>;
				label = "IRQ";
			};

			fiqintc: fiq at 100 {
				reg = <0x100 0x100>;
				#interrupt-cells = <2>;
				interrupts = <3>;
				label = "FIQ";
			};

			iiqintc: iiq at 300 {
				reg = <0x300 0x100>;
				#interrupt-cells = <2>;
				interrupts = <4>;
				label = "IIQ";
			};
		};
	};

};
