From: slash.tmp@free.fr (Mason)
Date: Thu, 06 Aug 2015 18:14:46 +0200
Subject: IRQ setup on multicore systems (routing, balancing, etc)
In-Reply-To: <20150806152654.GF7557@n2100.arm.linux.org.uk>
References: <55C0C102.7050600@free.fr> <55C37A72.2090507@free.fr>
 <20150806152654.GF7557@n2100.arm.linux.org.uk>
Message-ID: <55C387F6.8090708@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 17:26, Russell King - ARM Linux wrote:
> On Thu, Aug 06, 2015 at 05:17:06PM +0200, Mason wrote:
>> On 04/08/2015 15:41, Mason wrote:
>>
>>> I have a few very naive questions about [snip]
>>
>> [META]
>>
>> Are there perhaps more suitable mailing lists than this one
>> for such beginner questions?
> 
> I thought your message yesterday indicated you'd found the answer.

I have so many questions, I could write a (very boring) book.

> You don't setup any kind of routing between CPU cores and devices.
> At boot, initially CPU 0 will "own" all interrupts.

OK.

It doesn't help that the port I'm working on doesn't follow
"established guidelines". In this case, interrupt routing is
hard-coded in the platform code:

static inline void tangox_enable(struct irq_data *data)
{
	int bit = data->irq - IRQ_CONTROLLER_IRQ_BASE;
#ifdef ENABLE_INTERRUPT_ON_CPU1
	if(route_interrupt_to_cpu1(bit))
		tangox_fiq_enable(bit);
	else
#endif
		tangox_irq_enable(bit);
}

(tangox_enable is called in the .irq_startup struct irq_chip callback.)

Throw weird naming in the mix (I thought FIQ was reserved for
the secure world, and my Linux runs in non-secure) and my
confusion level is up to 11.

> You then run a (fixed) version of irqbalanced (preferably the older
> version which is not so x86-centric, eg, 0.56) which then distributes
> the interrupts between the cores according to what the interrupt is
> used for and the load it is imposing on the system.

OK. Thanks for pointing that out.

Unfortunately, I guess I should have asked the more fundamental
questions first. Balancing IRQs only makes sense once IRQs are
working.

I don't understand how to convert my board file mess into the
equivalent device tree, and the platform IRQ code is ugly.

I still haven't found a good reference explaining "DT for dummies".
I don't know how the GIC and platform INTC interact.

I tried randomly copy/pasting DT snippets, but unsurprisingly,
nothing has worked so far.

(I use Mans Rullgard's port as a reference as much as I can.)
https://github.com/mansr/linux-tangox

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

		eth0: emac at 26000 {
			compatible = "sigma,smp8640-emac";
			reg = <0x26000 0x800>;
			interrupts = <38>;
			clocks = <396000000>;
		};
	};

	cpublock: cpublock {
		compatible = "simple-bus";
		reg = <0x60000 0x10000>;
		ranges = <0x0 0x60000 0x10000>;
		interrupt-parent = <&irqintc>;
		#address-cells = <1>;
		#size-cells = <1>;

		intc: intc at e000 {
			compatible = "sigma,smp8640-intc";
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

Bleh! I need a break. Be back in a few weeks.

Regards.
