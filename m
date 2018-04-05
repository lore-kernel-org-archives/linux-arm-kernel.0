From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 5 Apr 2018 09:54:13 +0100
Subject: Extending the Marvell ICU support
In-Reply-To: <20180404160425.49fc620d@windsurf>
References: <20180404160425.49fc620d@windsurf>
Message-ID: <93739952-190c-0cdd-042e-95125f2d644d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 04/04/18 15:04, Thomas Petazzoni wrote:
> Hello Marc,
> 
> Back in June 2017, you helped me designing the ICU irqchip driver (in
> drivers/irqchip/irq-mvebu-icu.c), and we now need to extend it to
> support new functionality, and it would be useful to have your insight
> on how to implement this new functionality.
> 
> Recap of what we have today
> ===========================
> 
> Marvell Armada 7K/8K are split in two parts: the AP side (with the CPU
> core, GIC, and a few peripherals) and the CP side (with most
> high-performance I/Os).
> 
> The GIC on the AP side has 2 ranges of 64 SPIs that are reserved from
> interrupts coming from devices in the CP. The AP has a piece of
> hardware that Marvell calls the GICP, which provides two registers to
> set/clear an interrupt within those two ranges of 64 SPIs.
> 
> Each CP has an ICU unit, which turns the wired interrupts coming from
> the devices inside the CP into message interrupts, that are signaled to
> the AP by writing to the GICP registers, in the end triggering a SPI at
> the GIC level.
> 
> In Linux, we have modeled the gicp as an MSI provider, and the ICU as a
> MSI consumer.
> 
> Thanks to this, we handle all the NSR (Non Secured) interrupts from
> devices in the CP.
> 
> What we need now
> ================
> 
> In addition to handling NSRs, the ICU also handles SEIs, which stands
> for System Error Interrupt. Some devices in the CP raise SEIs instead
> of NSRs.
> 
> On the AP side, 64 SEIs can be handled. Whenever one SEI is pending,
> there is a single GIC interrupt that gets raised. Then 2 32-bit
> registers called GICP_SECR0 and GICP_SECR1 can be used to find out
> which SEI interrupt was raised.
> 
> Among those 64 SEIs, the first 21 are reserved for interrupts coming
> from the AP, while the remaining ones are available for SEI interrupts
> coming from the CPs. The ICU can be configured to write to a register
> called GICP_SET_SEI register to raise a SEI.
> 
> Contrary to the NSR interrupts where there is a 1:1 mapping between one
> ICU interrupt and one SPI interrupt in the GIC, for the SEI interrupts
> there is a single GIC interrupt, and a de-multiplexing to find out
> which specific SEI was raised.

That's pretty annoying. Having such a mix of different structures makes
you wonder what's going on in the head of the guy doing the system
integration...

> 
> The diagram at https://bootlin.com/~thomas/icu.pdf should hopefully
> help understand a bit the situation. I hope you'll enjoy my drawing
> skills :-)
> 
> Our question is how to model this in the irqchip/irqdomain world.
> 
> We were thinking of creating a gicp-sei Device Tree node, and a
> corresponding irqchip driver. This irqchip would provide 21 wired
> interrupts for the devices in the AP, and a MSI domain of 64-21
> interrupts available for the CP.
> 
> Then, the ICU would have two msi-parents: the gicp used for NSR
> interrupts, and the gicp-sei for the SEI interrupts. However, having
> multiple MSI parents is currently not supported, and this is probably a
> hint that we're going in the wrong direction.
> 
> Here is what the DT representation could look like:
> 
> ap {
> 	interrupt-parent = <&gic>;
> 
> 	gic: interrupt-controller at ... { ... };
> 
> 	gicp: interrupt-controller at ... {
> 		compatible = "marvell,ap806-gicp";
> 		reg = <0x3f0040 0x10>;
> 		marvell,spi-ranges = <64 64>, <288 64>;
> 		msi-controller;
> 	};
> 
> 	gicp_sei: interrupt-controller at ... {
> 		compatible = "marvell,ap806-gicp-sei";
> 		reg = <...>;
> 		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> 		interrupt-controller;
> 		msi-controller;
> 	};
> 
> 	device {
> 		... some random device in the AP that uses a SEI ...
> 		interrupt-extended = <&gicp_sei 12>;
> 	};
> };
> 
> cp {
> 	interrupt-parent = <&icu>;
> 
> 	icu: interrupt-controller at ... {
> 		compatible = "marvell,cp110-icu";
> 		reg = <...>;
> 		#interrupt-cells = <3>;
> 		interrupt-controller;
> 		msi-parent = <&gicp>, <&gicp_sei>;
> 	};
> 
> 	/* This device uses a NSR */
> 	rtc {
> 		reg = <...>;
> 		interrupts = <ICU_GRP_NSR 77 IRQ_TYPE_LEVEL_HIGH>;
> 	};
> 
> 	some-other-device {
> 		reg = <...>;
> 		interrupts = <ICU_GRP_SEI 12 IRQ_TYPE_LEVEL_HIGH>;
> 	};
> };
> 
> However, as explained above, having multiple msi-parents is currently
> not supported. Should we add support for that ? Do you see a
> different/better way of supporting our use case ?
> 
> It is worth mentioning that the ICU also support REIs, which work like
> the SEIs: there is a single GIC interrupt (n?33), one register to raise
> a REI (GICP_SET_REI) and two 32-bits registers (GICP_RECR0/GICP_RECR1)
> to find which REI was raised. So we might have to support this in the
> future as well. REI stands for RAM Error Interrupt.
> 
> As usual, I'm available on IRC to discuss this live. I'm sure there are
> some bits of information that I forgot, and that will be needed to
> fully understand what our situation is.

To sum up the discussion we had yesterday on IRC:

Multiple MSI parents, despite being easy to express in DT, are a real
pain in the kernel, because each device allocates its MSIs from a
single, implicit name-space (its directly attached msi_domain). Having
more than one means redesigning the whole generic MSI API to deal with
multiple domains. It then raises the question of how you access a
domain. How do you get a reference to it? Do we keep the additional
domains at the device level, or somewhere else? What's the notion of a
default MSI domain? This turns the whole logic upside down, and I'm not
even adding ACPI to the mix...

I'm not saying this is impossible to achieve, but that's so disruptive
that this may not be easy to achieve within a reasonable time frame.

On the other hand, wired interrupts are just as easy to express in DT,
and because everything is explicit (domain, interrupt number,
configuration), you can actually implement something that works both in
DT and in the kernel.

What I'm suggesting is the following:

ap {
	[...]
};

cp {
	interrupt-parent = <&icu>;

	icu: interrupt-controller at ... {
		compatible = "marvell,cp110-icu";
		reg = <...>;

		icu-nsr: icu-nsr {
			#interrupt-cells = <2>;
			interrupt-controller;
			msi-parent = <&gicp>;
		};

		icu-sei: icu-sei {
			#interrupt-cells = <2>;
			interrupt-controller;
			msi-parent = <&gicp-sei>;
		};
	};

	/* This device uses a NSR */
	rtc {
		reg = <...>;
		interrupts-extended = <&icu-nsr 77 IRQ_TYPE_LEVEL_HIGH>;
	};

	some-other-device {
		reg = <...>;
		interrupts-extended = <&icu-sei 12 IRQ_TYPE_LEVEL_HIGH>;
	};
};

which should make things work in a pretty obvious way.

Of course, the main issue is that it completely breaks DT compatibility.
You can probably make a new kernel work with an old DT, but a new DT on
an older kernel is just going to catch fire.

I guess that's the price to pay for HW that wasn't completely described
on day-1.

Hope this helps,

	M.
-- 
Jazz is not dead. It just smells funny...
