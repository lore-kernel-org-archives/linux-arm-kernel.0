From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 7 Jul 2017 15:35:46 +0100
Subject: [PATCH 2/8] dt-bindings: mailbox: add binding doc for the ARM
 SMC mailbox
In-Reply-To: <20170630095608.24943-3-andre.przywara@arm.com>
References: <20170630095608.24943-1-andre.przywara@arm.com>
 <20170630095608.24943-3-andre.przywara@arm.com>
Message-ID: <20170707143546.GD3425@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

As a nit, please post bindings before drivers, as per
Documentation/devicetree/bindings/submitting-patches.txt.

On Fri, Jun 30, 2017 at 10:56:02AM +0100, Andre Przywara wrote:
> Add binding documentation for the generic ARM SMC mailbox.
> This is not describing hardware, but a firmware interface.

Is this following some standard, or is this something that you have
invented? If the latter, why are we inventing a new standard? |How does
this relate to SCPI and/or SCMI? 

What exactly is "the generic ARM SMC mailbox"?

> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/mailbox/arm-smc.txt        | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> new file mode 100644
> index 0000000..90c5926
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> @@ -0,0 +1,61 @@
> +ARM SMC Mailbox Driver

Bindings do not document drivers. As Rob said, s/Driver/Interface/.

> +======================
> +
> +This mailbox uses the ARM smc (secure monitor call) instruction to
> +trigger a mailbox-connected activity in firmware, executing on the very same
> +core as the caller. By nature this operation is synchronous and this
> +mailbox provides no way for asynchronous messages to be delivered the other
> +way round, from firmware to the OS. However the value of r0/w0/x0 the firmware
> +returns after the smc call is delivered as a received message to the
> +mailbox framework, so a synchronous communication can be established.

... where those values are what specifically, under what circumstances?

> +One use case of this mailbox is the SCP interface, which uses shared memory
> +to transfer commands and parameters, and a mailbox to trigger a function
> +call. This allows SoCs without a separate management processor (or
> +when such a processor is not available or used) to use this standardized
> +interface anyway.
> +
> +This binding describes no hardware, but establishes a firmware interface.
> +The communication follows the ARM SMC calling convention[1].
> +Any core which supports the SMC or HVC instruction can be used, as long as
> +a firmware component running in EL3 or EL2 is handling these calls.
> +
> +Mailbox Device Node:
> +====================
> +
> +Required properties:
> +--------------------
> +- compatible:		Shall be "arm,smc-mbox"
> +- #mbox-cells		Shall be 1 - the index of the channel needed.
> +- arm,smc-func-ids	An array of 32-bit values specifying the function
> +			IDs used by each mailbox channel. Those function IDs
> +			follow the ARM SMC calling convention standard [1].
> +			There is one identifier per channel and the number
> +			of supported channels is determined by the length
> +			of this array.

What does each function do? I guess it signal that FW should look at a
particular mailbox, but the binding doesn't actually say.

If this is following the SMCCC, what is the function prototype?

What arguments are taken, and what return values are required under
which conditions?

Are they fast calls, or are they pre-emptible? When does the FW return?

If we're inventing a standard, why have multiple function IDs rather
than passing a channel ID in as a paarameter?

This needs a more rigorous definition.

> +
> +Optional properties:
> +--------------------
> +- method:		A string, either:
> +			"hvc": if the driver shall use an HVC call, or
> +			"smc": if the driver shall use an SMC call
> +			If omitted, defaults to an SMC call.

Make this property mandatory, don't guess. Please follow the wording
used by ther PSCI binding.

Given one can use HVC, the "arm,smc-func-ids" property is misleading,
and would be better as something like "func-ids".

Thanks,
Mark.
