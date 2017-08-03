From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 11:46:40 -0500
Subject: [PATCH v2 1/3] DT: mailbox: add binding doc for the ARM SMC
 mailbox
In-Reply-To: <1500852206-28771-2-git-send-email-andre.przywara@arm.com>
References: <1500852206-28771-1-git-send-email-andre.przywara@arm.com>
 <1500852206-28771-2-git-send-email-andre.przywara@arm.com>
Message-ID: <20170803164640.gbx7yr7viktvg4dt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 12:23:24AM +0100, Andre Przywara wrote:
> The ARM SMC mailbox binding describes a firmware interface to trigger
> actions in software layers running in the EL2 or EL3 exception levels.
> The term "ARM" here relates to the SMC instruction as part of the ARM
> instruction set, not as a standard endorsed by ARM Ltd.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/mailbox/arm-smc.txt        | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> new file mode 100644
> index 0000000..d9de57b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
> @@ -0,0 +1,76 @@
> +ARM SMC Mailbox Interface
> +=========================
> +
> +This mailbox uses the ARM smc (secure monitor call) instruction to
> +trigger a mailbox-connected activity in firmware, executing on the very same
> +core as the caller. By nature this operation is synchronous and this
> +mailbox provides no way for asynchronous messages to be delivered the other
> +way round, from firmware to the OS. However the value of r0/w0/x0 the firmware
> +returns after the smc call is delivered as a received message to the
> +mailbox framework, so a synchronous communication can be established.
> +The exact meaning of both the action the mailbox triggers as well as the
> +return value is defined by their users and is not subject to this binding.
> +
> +One use case of this mailbox is the SCP interface, which uses shared memory
> +to transfer commands and parameters, and a mailbox to trigger a function
> +call. This allows SoCs without a separate management processor (or
> +when such a processor is not available or used) to use this standardized
> +interface anyway.
> +
> +This binding describes no hardware, but establishes a firmware interface.
> +Upon receiving an SMC using one of the described SMC function identifiers,
> +the firmware is expected to trigger some mailbox connected functionality.
> +The communication follows the ARM SMC calling convention[1]:
> +Firmware expects an SMC function identifier in r0 or w0 to identify a
> +particular mailbox. The supported identifiers are listed in the the
> +arm,func-ids properties, as described below.
> +Apart from those mandatory SMC function identifier there are no further
> +arguments handled by the receiving end.
> +The firmware can return one value in the first SMC result register, it
> +is expected to be an error value, which shall be propagated to the mailbox
> +client.
> +The C prototype of the function would be:
> +	unsigned long smc_mailbox_call(unsigned long mailbox_identifier);
> +The SMC function call is expected to be a fast call and could be from
> +any of the defined function ranges.
> +
> +Any core which supports the SMC or HVC instruction can be used, as long as
> +a firmware component running in EL3 or EL2 is handling these calls.
> +
> +Mailbox Device Node:
> +====================
> +
> +This node is expected to be a child of the /firmware node.
> +
> +Required properties:
> +--------------------
> +- compatible:		Shall be "arm,smc-mbox"
> +- #mbox-cells		Shall be 1 - the index of the channel needed.
> +- arm,func-ids		An array of 32-bit values specifying the function
> +			IDs used by each mailbox channel. Those function IDs
> +			follow the ARM SMC calling convention standard [1].
> +			There is one identifier per channel and the number
> +			of supported channels is determined by the length
> +			of this array.

I agree with Jassi's comment on making these a client cell and just 
define the number of channels here. 

> +- method:		A string, either:
> +			"hvc": if the driver shall use an HVC call, or
> +			"smc": if the driver shall use an SMC call.
> +
> +Example:
> +--------
> +
> +	smc_mbox: mailbox {
> +		#mbox-cells = <1>;
> +		compatible = "arm,smc-mbox";
> +		arm,func-ids = <0x82000001>, <0x82000002>;
> +	};
> +
> +	scpi {
> +		compatible = "arm,scpi";
> +		mboxes = <&mailbox 0>;
> +		shmem = <&cpu_scp_shmem>;
> +	};
> +
> +
> +[1]
> +http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0028a/index.html
> -- 
> 2.8.2
> 
