From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 21 Jul 2016 10:56:44 +0100
Subject: [RFC 3/6] dt/bindings: Add bindings for Tegra20/30 NOR bus driver
In-Reply-To: <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
References: <1468935397-11926-1-git-send-email-mirza.krak@gmail.com>
 <1468935397-11926-4-git-send-email-mirza.krak@gmail.com>
Message-ID: <434561ec-510e-a3bf-c7b6-c961db299bd6@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 19/07/16 14:36, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
> 
> Document the devicetree bindings for NOR bus driver found on Tegra20 and
> Tegra30 SOCs
> 
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> ---
>  .../devicetree/bindings/bus/nvidia,tegra20-nor.txt | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt b/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
> new file mode 100644
> index 0000000..9ee4a66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/nvidia,tegra20-nor.txt
> @@ -0,0 +1,73 @@
> +Device tree bindings for NVIDIA Tegra20/30 NOR Bus
> +
> +The NOR controller supports a number of memory types, including synchronous NOR,
> +asynchronous NOR, and other flash memories with similar interfaces, such as
> +MuxOneNAND. One could also connect high speed devices like FPGAs, DSPs,
> +CAN chips, Wi-Fi chips etc.

Nit-pick ... the Tegra documentation refers to this controller as the
GMI (general memory interface) or SNOR (sync-NOR) controller because it
is not just limited to NOR as you mentioned. I see references to GMI in
the Tegra pinctrl driver and so may be we should use this name.

> +
> +The actual devices are instantiated from the child nodes of a NOR node.
> +
> +Required properties:
> +
> + - compatible: should be "nvidia,tegra20-nor", "nvidia,tegra30-nor"

I see at least one difference at the register level between Tegra20 and
Tegra30 and so I think this should be something like ...

 - compatible : Should contain one of the following:
	For Tegra20 must contain "nvidia,tegra20-gmi".
 	For Tegra30 must contain "nvidia,tegra30-gmi".

> + - reg: Should contain NOR controller registers location and length.
> + - clocks: Must contain one entry, for the module clock.
> +   See ../clocks/clock-bindings.txt for details.
> + - resets : Must contain an entry for each entry in reset-names.
> +   See ../reset/reset.txt for details.
> + - reset-names : Must include the following entries:
> +  - nor
> + - #address-cells: Must be set to 2 to allow memory address translation
> + - #size-cells:	Must be set to 1 to allow CS address passing
> + - ranges: Must be set up to reflect the memory layout with four integer
> + 		values for each chip-select line in use.
> + - nvidia,config: This property represents the SNOR_CONFIG_0 register.

There is also a SNOR_MIO_CONFIG for the MIO address space and so I think
that this should be nvidia,snor-config to be explicit. It might be nice
to also add a "nvidia,mio-config" while you are at it as well, however,
that could always be done later. If you do, then the
"nvidia,snor-config" becomes optional depending on whether you are using
the SNOR or MIO address space.

Thierry, Stephen, do prefer all the fields on the config registers are
broken out? There are quite a few but I am not sure what we typically
recommend here?

> +
> +Note that the NOR controller does not have any internal chip-select address
> +decoding and if you want to access multiple devices external chip-select
> +decoding must be provided.

Although it is true, you do have the MIO address space and so you could
support two devices via the SNOR address space and MIO address space
(assuming that the MIO can be used for the 2nd device).

Furthermore, if you do have external logic to support multiple devices
this would assume that the devices use the same timing and so are
probably the same type. It also assumes both can fit in the 256MB
address range. May be worth mentioning.

The GMI does have 8 chip selects and I believe the purpose of these is
to allow you to address more than the 256MB range. However, I believe to
do this it require software intervention to change the current CS that
is in use.

I wonder if it is worth mentioning that the chip-select specified in the
"nvidia,config" prop should match that in the "ranges" prop unless you
have some external decoding logic to provide an external chip-select.
Which raises a question, what does the chip-select in the ranges
actually represent? I am not sure if there is a common practice here for
device tree when boards have external logic to provide additional
chip-selects. I am sure this is quite common.

> +Optional properties:
> +
> + - nvidia,cs-timing: The timing array represents the SNOR_TIMING0_0 and
> +   SNOR_TIMING1_0 registers for the NOR controller. If unset reset-values will
> +   be used. See reference documentation for detailed description of the timing
> +   registers.
> +
> +Example with two SJA1000 CAN controllers connected to the NOR bus:
> +
> +	nor at 70009000 {
> +		status = "okay";
> +		compatible = "nvidia,tegra20-nor", "nvidia,tegra30-nor";
> +		reg = <0x70009000 0x1000>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		clocks = <&tegra_car TEGRA30_CLK_NOR>;
> +		resets = < &tegra_car 42>;
> +		reset-names = "nor";
> +		ranges = <
> +			0 0 0x48000000 0x00000100
> +			1 0 0x48040000 0x00000100
> +		>;

The "nvidia,config" appears to be missing here.

Cheers
Jon

-- 
nvpublic
