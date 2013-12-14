From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Dec 2013 22:03:45 +0100
Subject: [PATCH v2 00/16] ARM: support for ICP DAS LP-8x4x (with dts)
In-Reply-To: <1386901645-28895-1-git-send-email-ynvich@gmail.com>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <1386901645-28895-1-git-send-email-ynvich@gmail.com>
Message-ID: <201312142203.45740.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 December 2013, Sergei Ianovich wrote:
> Fixed most review requirements. Details in respective patches.
> 
> I've completely met the requirement for using dmaengine-based DMA
> in patch v2-03/16. Tests showed new DMA was underperforming. It added
> on top of a pre-existing problem with MMC bus width and made the system
> barely usable. However, the new code in this patch work correctly with
> both the existing and the new DMA. Even if the new DMA is compiled into
> the kernel, the exisitng DMA initializes first.

As mentioned, I think this is a good approach, as long as it's coordinated
with Daniel's patches for the dmaengine. I would expect that once we
get to the bottom of this, there will only be a small overhead from
not directly using the dma registers but going through the dmaengine
API.

> I've also decided not to create a single mfd device for
> machine-specific devices. Instead each type is supported by a separate
> driver in respective subsystem. It was tempting to hardcode all the
> constants in one source file, but that requires ugly initialization.
> The taken way produces much cleaner code.

I think you should at least change the DT representation for the FPGA
to show one device as the actual FPGA and attach children to that,
multiple indirection levels if necessary.

I suspect that the fpga is on some external-bus port with a specific
chip-select, so I would model this as

	extbus {
		compatible = "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		/* bus addresses 0-0xfffff mapped to 0x17000000 */
		ranges = <0 0x17000000 0x100000>;
		interrupt-parent = <&fpga-irq>;

		fpga-irq: irq at 6 {
			regs = <6 16>; /* translated addresses
			...
		};

		fgpa-bus {
			#address-cells = <1>;
			#size-cells = <1>;
			ranges;

			serial at 9050 {
				...
			};
		};
	};

I also think you don't need to make the devices quite as fine-grained
here but instead group things together more. I would probably indeed
put everything that is not on one of the slots into a common device,
including the irqchip.

	Arnd
