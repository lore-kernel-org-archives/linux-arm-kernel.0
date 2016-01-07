From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jan 2016 22:25:38 +0100
Subject: [PATCH] ata: add AMD Seattle platform driver
In-Reply-To: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
Message-ID: <4652600.rUhSEOUPkl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 January 2016 14:53:22 Brijesh Singh wrote:
> AMD Seattle SATA controller mostly conforms to AHCI interface with some
> special register to control SGPIO interface. In the case of an AHCI
> controller, the SGPIO feature is ideally implemented using the
> "Enclosure Management" register of the AHCI controller, but those
> registeres are not implemented in the Seattle SoC. Instead SoC
> (Rev B0 onwards) provides a 32-bit SGPIO control register which should
> be programmed to control the activity, locate and fault LEDs.
> 
> The driver is based on ahci_platform driver.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> CC: robh+dt at kernel.org
> CC: pawel.moll at arm.com
> CC: mark.rutland at arm.com
> CC: ijc+devicetree at hellion.org.uk
> CC: galak at codeaurora.org
> CC: tj at kernel.org
> CC: devicetree at vger.kernel.org
> CC: linux-ide at vger.kernel.org
> ---
>  .../devicetree/bindings/ata/sata-seattle.txt       |  34 ++++
>  drivers/ata/Kconfig                                |   8 +
>  drivers/ata/Makefile                               |   1 +
>  drivers/ata/ahci_seattle.c                         | 226 +++++++++++++++++++++
>  4 files changed, 269 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/sata-seattle.txt
>  create mode 100644 drivers/ata/ahci_seattle.c
> 
> diff --git a/Documentation/devicetree/bindings/ata/sata-seattle.txt b/Documentation/devicetree/bindings/ata/sata-seattle.txt
> new file mode 100644
> index 0000000..5ad46b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/sata-seattle.txt
> @@ -0,0 +1,34 @@
> +* AHCI SATA Controller
> +
> +SATA nodes are defined to describe on-chip Serial ATA controllers.
> +The AMD Seattle SATA controller mostly conforms to the AHCI interface
> +with some special SGPIO register to contro activity LED interfaces.
> +
> +In the case of an AHCI controller, the SGPIO feature is ideally implemented
> +using the "Enclosure Management" register of the AHCI controller, but
> +those registeres are not implemented in the Seattle SoC.
> +
> +Each SATA controller should have its own node.
> +
> +
> +Required properties:
> +- compatible        : compatible string should be "amd,seattle-ahci".
> +- interrupts        : <interrupt mapping for SATA IRQ>
> +- reg               : <registers mapping>
> +
> +Optional properties:
> +- dma-coherent      : Present if dma operations are coherent
> +- clocks            : a list of phandle + clock specifier pairs
> +- target-supply     : regulator for SATA target power
> +- phys              : reference to the SATA PHY node
> +- phy-names         : must be "sata-phy"
> +
> +Examples:
> +        sata0 at e0300000 {
> +		compatible = "amd,seattle-ahci";
> +		reg = <0x0 0xe0300000 0x0 0xf0000>, <0x0 0xe0000078 0x0 0x1>;

Looking at the register values, I doubt that the SGPIO is actually part of the
sata device. More likely, you are pointing in the middle of an actual
GPIO controller.

If so, please implement a GPIO driver for that device, and use the gpio-leds
driver to drive the LEDs. IIRC there is already a generic way to communicate
with the LEDs interface from libata, if not you can implement that in order
to keep the special case out of the platform driver.

> +		interrupts = <0x0 0x163 0x4>;
> +		clocks = <0x2>

This is not a valid property.

> +/* SGPIO Control Register definition
> + *
> + * Bit		Type		Description
> + * 31		RW		OD7.2 (activity)
> + * 30		RW		OD7.1 (locate)
> + * 29		RW		OD7.0 (fault)
> + * 28...8	RW		OD6.2...OD0.0 (3bits per port, 1 bit per LED)
> + * 7		RO		SGPIO feature flag
> + * 6:4		RO		Reserved
> + * 3:0		RO		Number of ports (0 means no port supported)
> + */

The 'reg' property in your example is only 8 bits wide, the above lists
32 bits.

	Arnd
