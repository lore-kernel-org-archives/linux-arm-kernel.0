From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Apr 2016 16:07:38 +0100
Subject: [PATCH v6 2/2] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <1461767754-12189-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1461767754-12189-1-git-send-email-boris.brezillon@free-electrons.com>
 <1461767754-12189-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160427150738.GA7359@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 04:35:54PM +0200, Boris Brezillon wrote:
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
>  .../bindings/memory-controllers/atmel,ebi.txt      | 146 +++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> new file mode 100644
> index 0000000..0f332d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/atmel,ebi.txt
> @@ -0,0 +1,146 @@
> +* Device tree bindings for Atmel EBI
> +
> +The External Bus Interface (EBI) controller is a bus where you can connect
> +asynchronous (NAND, NOR, SRAM, ....) and synchronous memories (SDR/DDR SDRAMs).
> +The EBI provides a glue-less interface to asynchronous memories though the SMC
> +(Static Memory Controller).
> +Synchronous memories (and some asynchronous memories like NANDs) can be
> +attached to specialized controllers which are responsible for configuring the
> +bus appropriately according to the connected device.
> +In the other hand, the bus interface can be automated for simple asynchronous
> +devices.
> +
> +Required properties:
> +
> +- compatible:		"atmel,at91sam9260-ebi"
> +			"atmel,at91sam9261-ebi"
> +			"atmel,at91sam9263-ebi0"
> +			"atmel,at91sam9263-ebi1"
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
> +Child chip-select (cs) nodes contain the memory devices nodes connected to
> +such as NOR (e.g. cfi-flash) and NAND.
> +There might be board specific devices like FPGAs.
> +You'll define you device requirements in these child nodes.
> +
> +Required child cs node properties:
> +
> +- #address-cells:	Must be 2.
> +
> +- #size-cells:		Must be 1.
> +
> +- ranges:		Empty property indicating that child nodes can inherit
> +			memory layout.
> +
> +Optional child cs node properties:
> +- atmel,bus-width:		width of the asynchronous device's data bus
> +				8, 16 or 32.
> +				8 if not present.
> +
> +- atmel,byte-access-type	"write" or "select" (see Atmel datasheet).
> +				"select" if not present.
> +
> +- atmel,read-mode		"nrd" or "ncs".
> +				"ncs" is not present.
> +
> +- atmel,write-mode		"nwe" or "ncs".
> +				"ncs" is not present.
> +
> +- atmel,exnw-mode		"disabled", "frozen" or "ready".
> +				"disabled" if not present.
> +
> +- atmel,page-mode		enable page mode if present. The provided value
> +				defines the page size (supported values: 4, 8,
> +				16 and 32).
> +
> +Optional device timings expressed in nanoseconds (if the property is not
> +present 0 is assumed):
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

I assume that these are defined in a datasheet. It may be worth noting
"see datasheet" above this collection of properties.

> +
> +- atmel,tdf-mode:		"normal" or "optimized". If set to "optimized"
> +				the data float time is optimized depending on
> +				the next device being accessed (next device
> +				setup time is subtracted to the current device
> +				data float time).
> +
> +
> +
> +Example:
> +
> +	ebi: ebi at 10000000 {
> +		compatible = "atmel,sama5d3-ebi", "simple-bus";

I don't believe that "simple-bus" should be here.

> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		atmel,smc = <&hsmc>;
> +		atmel,matrix = <&matrix>;
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
> +
> +		cs at 0 {

I suspect recent DTC will warn here, as the unit-address should match
the reg for the node (and no reg is defined). Here the reg would have to
be two cells, which means we have to make up an address, no?

We can either give the node a name without a unit-address (e.g. cs_0),
or define some reg format.

> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			ranges;
> +			atmel,generic-dev;

The cover letter mentioned this should go.

> +			atmel,read-mode = "nrd";
> +			atmel,write-mode = "nwe";
> +			atmel,bus-width = <16>;
> +			atmel,ncs-rd-setup-ns = <0>;
> +			atmel,ncs-wr-setup-ns = <0>;
> +			atmel,nwe-setup-ns = <8>;
> +			atmel,nrd-setup-ns = <16>;
> +			atmel,ncs-rd-pulse-ns = <84>;
> +			atmel,ncs-wr-pulse-ns = <84>;
> +			atmel,nrd-pulse-ns = <76>;
> +			atmel,nwe-pulse-ns = <76>;
> +			atmel,nrd-cycle-ns = <107>;
> +			atmel,nwe-cycle-ns = <84>;
> +			atmel,tdf-ns = <16>;
> +
> +			nor: flash at 0,0 {
> +				compatible = "cfi-flash";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				reg = <0x0 0x0 0x1000000>;

It feels odd that in the node for chipselect N, sub-devices have to
encode the chipselect number in their reg, when it's obvious from their
container. It may make more sense for the cs node to have a non-empty
reg (or somehow to make that translation/truncation implicit).

Thanks,
Mark,
