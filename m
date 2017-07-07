From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 7 Jul 2017 17:06:39 +0100
Subject: [PATCH 2/8] dt-bindings: mailbox: add binding doc for the ARM SMC
 mailbox
In-Reply-To: <20170707143546.GD3425@leverpostej>
References: <20170630095608.24943-1-andre.przywara@arm.com>
 <20170630095608.24943-3-andre.przywara@arm.com>
 <20170707143546.GD3425@leverpostej>
Message-ID: <8897a028-64b4-da2a-603f-b0b56228e8bb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/07/17 15:35, Mark Rutland wrote:
> Hi Andre,
> 
> As a nit, please post bindings before drivers, as per
> Documentation/devicetree/bindings/submitting-patches.txt.

Sure.

> On Fri, Jun 30, 2017 at 10:56:02AM +0100, Andre Przywara wrote:
>> Add binding documentation for the generic ARM SMC mailbox.
>> This is not describing hardware, but a firmware interface.
> 
> Is this following some standard, or is this something that you have
> invented?

The idea was that we don't need a "full featured standard", but rather
just a contract between currently running firmware and the OS. Since I
consider the DT as being provided as part of the firmware, I don't see
how this would need to be "standardized" beyond that. This is just a
"single bit signalling channel" to implement a "poor man's mailbox", if
you like.
If firmware implements this, it adds the respective node, if not, there
is nothing in the DT.
Do you see any way this would clash with existing standards or would
need to standardized beyond this document? I would believe the SMCCC
covers the bits that would need to standardized already (as in to make
sure to not call any other service tied to a particular smc call).

> If the latter, why are we inventing a new standard? |How does
> this relate to SCPI and/or SCMI?

Both SCPI and SCMI build upon a shared memory region for transferring
arguments and a mailbox channel to signal that there is "work to do".
So this is not competing with those standards, but rather complementing
them and making them more widely usable (in cases where you don't have
an actual mailbox).
SCMI introduced a notion of multiple transport protocols for signalling,
but so far only specifies a mailbox (and does the respective proposed
binding).

Actually this driver is more of a drop-in replacement for an ARM MHU
mailbox (for instance to implement SCPI), so this driver and binding
actually promotes existing standards.

> What exactly is "the generic ARM SMC mailbox"?

That's a bridge between the requirements of having a mailbox (which the
SCPI *binding* requires, for instance) and some firmware parts being
implemented in an EL3 runtime on the APs (instead of running on some
separate management processors).
I am happy to change the name if that sounds presumptuous, the naming
comes from "generic" as in: does not require specific hardware. The
"ARM" in there is just to give context to "SMC", which, as every TLA, is
probably overloaded and confusing to the casual reader.

>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  .../devicetree/bindings/mailbox/arm-smc.txt        | 61 ++++++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm-smc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/arm-smc.txt b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
>> new file mode 100644
>> index 0000000..90c5926
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/arm-smc.txt
>> @@ -0,0 +1,61 @@
>> +ARM SMC Mailbox Driver
> 
> Bindings do not document drivers. As Rob said, s/Driver/Interface/.

Right, badly copied from arm-mhu.txt ;-)

>> +======================
>> +
>> +This mailbox uses the ARM smc (secure monitor call) instruction to
>> +trigger a mailbox-connected activity in firmware, executing on the very same
>> +core as the caller. By nature this operation is synchronous and this
>> +mailbox provides no way for asynchronous messages to be delivered the other
>> +way round, from firmware to the OS. However the value of r0/w0/x0 the firmware
>> +returns after the smc call is delivered as a received message to the
>> +mailbox framework, so a synchronous communication can be established.
> 
> ... where those values are what specifically, under what circumstances?

OK, I will look into how far this needs to be specified in this document
here or how much we can delegate to the actual mailbox users.

>> +One use case of this mailbox is the SCP interface, which uses shared memory
>> +to transfer commands and parameters, and a mailbox to trigger a function
>> +call. This allows SoCs without a separate management processor (or
>> +when such a processor is not available or used) to use this standardized
>> +interface anyway.
>> +
>> +This binding describes no hardware, but establishes a firmware interface.
>> +The communication follows the ARM SMC calling convention[1].
>> +Any core which supports the SMC or HVC instruction can be used, as long as
>> +a firmware component running in EL3 or EL2 is handling these calls.
>> +
>> +Mailbox Device Node:
>> +====================
>> +
>> +Required properties:
>> +--------------------
>> +- compatible:		Shall be "arm,smc-mbox"
>> +- #mbox-cells		Shall be 1 - the index of the channel needed.
>> +- arm,smc-func-ids	An array of 32-bit values specifying the function
>> +			IDs used by each mailbox channel. Those function IDs
>> +			follow the ARM SMC calling convention standard [1].
>> +			There is one identifier per channel and the number
>> +			of supported channels is determined by the length
>> +			of this array.
> 
> What does each function do? I guess it signal that FW should look at a
> particular mailbox, but the binding doesn't actually say.

Calling the smc instruction with that function ID triggers the
associated mailbox (in the somewhat Linux/DT meaning of "mailbox").
Basically very much like the ARM MHU mailbox, for instance.

I believe the term mailbox is a bit fuzzy here. I think the least common
denominator just signals a single bit condition (like a doorbell), which
is the only thing that SCPI (for instance) requires. And the actual
mailbox content is then somewhere else, for instance in shared memory.
Which is beyond the scope of the mailbox itself.

> If this is following the SMCCC, what is the function prototype?

> What arguments are taken, and what return values are required under
> which conditions?

Good point, I can describe this one.

> Are they fast calls, or are they pre-emptible? When does the FW return?

Naturally I would expect fast calls, but I am not sure we need to
restrict it here. The SMCCC function ID encodes the type already. And I
couldn't find anything more detailed in the SMCCC to require me to ban
standard calls, so it would be up to the actual firmware implementation
to decide.

> If we're inventing a standard, why have multiple function IDs rather
> than passing a channel ID in as a paarameter?

What would be the advantage of doing so? I found it necessary to have
the SMCCC IDs in the DT anyway and also useful to support multiple
channels, so just having a list of SMCCC IDs sounded like a natural choice.
Do you reckon we need a combination of SMCCC ID and mailbox ID (as a
second parameter to the SMCCC call), to support cases where we only have
one SMCCC ID available, but need multiple mailboxes?

> This needs a more rigorous definition.
> 
>> +
>> +Optional properties:
>> +--------------------
>> +- method:		A string, either:
>> +			"hvc": if the driver shall use an HVC call, or
>> +			"smc": if the driver shall use an SMC call
>> +			If omitted, defaults to an SMC call.
> 
> Make this property mandatory, don't guess. Please follow the wording
> used by ther PSCI binding.

Sure.

> Given one can use HVC, the "arm,smc-func-ids" property is misleading,
> and would be better as something like "func-ids".

Right, will fix this.

Cheers,
Andre.
