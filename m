From: robh@kernel.org (Rob Herring)
Date: Tue, 3 May 2016 11:40:19 -0500
Subject: [PATCH v7 2/2] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <1461845007-23139-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1461845007-23139-1-git-send-email-boris.brezillon@free-electrons.com>
 <1461845007-23139-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160503164019.GA1604@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 02:03:27PM +0200, Boris Brezillon wrote:
> The EBI (External Bus Interface) is used to access external peripherals
> (NOR, SRAM, NAND, and other specific devices like ethernet controllers).
> Each device is assigned a CS line and an address range and can have its
> own configuration (timings, access mode, bus width, ...).
> This driver provides a generic DT binding to configure a device according
> to its requirements.
> For specific device controllers (like the NAND one) the SMC timings
> should be configured by the controller driver through the matrix and smc
> syscon regmaps.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../bindings/memory-controllers/atmel,ebi.txt      | 136 +++++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> new file mode 100644
> index 0000000..a6dca5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> @@ -0,0 +1,136 @@
> +* Device tree bindings for Atmel EBI
> +
> +The External Bus Interface (EBI) controller is a bus where you can connect
> +asynchronous (NAND, NOR, SRAM, ....) and synchronous memories (SDR/DDR SDRAMs).
> +The EBI provides a glue-less interface to asynchronous memories through the SMC
> +(Static Memory Controller).
> +
> +Required properties:
> +
> +- compatible:		"atmel,at91sam9260-ebi"
> +			"atmel,at91sam9261-ebi"
> +			"atmel,at91sam9263-ebi0"
> +			"atmel,at91sam9263-ebi1"

What are the differences between 0 and 1?

> +			"atmel,at91sam9rl-ebi"
> +			"atmel,at91sam9g45-ebi"
> +			"atmel,at91sam9x5-ebi"
> +			"atmel,sama5d3-ebi"
> +
> +- reg:			Contains offset/length value for EBI memory mapping.
> +			This property might contain several entries if the EBI
> +			memory range is not contiguous
> +
> +- #address-cells:	Must be 2.
> +			The first cell encodes the CS.
> +			The second cell encode the offset into the CS memory
> +			range.
> +
> +- #size-cells:		Must be set to 1.
> +
> +- ranges:		Encodes CS to memory region association.
> +
> +- clocks:		Clock feeding the EBI controller.
> +			See clock-bindings.txt
> +
> +Children device nodes are representing device connected to the EBI bus.
> +
> +Required device node properties:
> +
> +- #reg:			Contains the chip-select id, the offset and the length

s/#reg/reg/

> +			of the memory region requested by the device.
> +
> +EBI bus configuration associated with specific chip-select will be defined in
> +the configs subnode. This configs node will in turn contain several subnodes
> +named config-<cs-id>, each of them containing the following properties.

This is a bit unusual. Why not just part of the child device nodes?

> +
> +Optional config-<cs-id> node properties:
> +
> +- atmel,bus-width:		width of the asynchronous device's data bus
> +				8, 16 or 32.
> +				Default to 8 when undefined.
> +
> +- atmel,byte-access-type	"write" or "select" (see Atmel datasheet).
> +				Default to "select" when undefined.
> +
> +- atmel,read-mode		"nrd" or "ncs".
> +				Default to "ncs" when undefined.
> +
> +- atmel,write-mode		"nwe" or "ncs".
> +				Default to "ncs" when undefined.
> +
> +- atmel,exnw-mode		"disabled", "frozen" or "ready".
> +				Default to "disabled" when undefined.
> +
> +- atmel,page-mode		enable page mode if present. The provided value
> +				defines the page size (supported values: 4, 8,
> +				16 and 32).
> +
> +- atmel,tdf-mode:		"normal" or "optimized". When set to

This should be boolean.

> +				"optimized" the data float time is optimized
> +				depending on the next device being accessed
> +				(next device setup time is subtracted to the
> +				current device data float time).
> +				Default to "normal" when undefined.
> +
> +Mandatory timings expressed in nanoseconds (see Atmel datasheet for a full
> +description).

Required first, then optional properties please.

> +
> +- atmel,ncs-rd-setup-ns
> +- atmel,nrd-setup-ns
> +- atmel,ncs-wr-setup-ns
> +- atmel,nwe-setup-ns
> +- atmel,ncs-rd-pulse-ns
> +- atmel,nrd-pulse-ns
> +- atmel,ncs-wr-pulse-ns
> +- atmel,nwe-pulse-ns
> +- atmel,nwe-cycle-ns
> +- atmel,nrd-cycle-ns
> +- atmel,tdf-ns
> +
> +Example:
> +
> +	ebi: ebi at 10000000 {
> +		compatible = "atmel,sama5d3-ebi";
> +		#address-cells = <2>;
> +		#size-cells = <1>;

> +		atmel,smc = <&hsmc>;
> +		atmel,matrix = <&matrix>;

What are these? 

> +		reg = <0x10000000 0x10000000
> +		       0x40000000 0x30000000>;
> +		ranges = <0x0 0x0 0x10000000 0x10000000
> +			  0x1 0x0 0x40000000 0x10000000
> +			  0x2 0x0 0x50000000 0x10000000
> +			  0x3 0x0 0x60000000 0x10000000>;
> +		clocks = <&mck>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ebi_addr>;

Not documented.

> +
> +		configs {
> +			config-0 {
> +				atmel,read-mode = "nrd";
> +				atmel,write-mode = "nwe";
> +				atmel,bus-width = <16>;
> +				atmel,ncs-rd-setup-ns = <0>;
> +				atmel,ncs-wr-setup-ns = <0>;
> +				atmel,nwe-setup-ns = <8>;
> +				atmel,nrd-setup-ns = <16>;
> +				atmel,ncs-rd-pulse-ns = <84>;
> +				atmel,ncs-wr-pulse-ns = <84>;
> +				atmel,nrd-pulse-ns = <76>;
> +				atmel,nwe-pulse-ns = <76>;
> +				atmel,nrd-cycle-ns = <107>;
> +				atmel,nwe-cycle-ns = <84>;
> +				atmel,tdf-ns = <16>;
> +			};
> +		};
> +
> +		nor: flash at 0,0 {
> +			compatible = "cfi-flash";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			reg = <0x0 0x0 0x1000000>;
> +			bank-width = <2>;
> +		};
> +	};
> +
> -- 
> 2.7.4
> 
