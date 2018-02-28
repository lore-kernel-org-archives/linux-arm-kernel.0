From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 28 Feb 2018 17:17:03 +0000
Subject: [PATCH 1/3] dt-bindings: Add a binding for the sunxi message box
In-Reply-To: <20180228082843.fga47gfrv2g5kmiz@flea>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-2-samuel@sholland.org>
 <20180228082843.fga47gfrv2g5kmiz@flea>
Message-ID: <d124c54f-7ac1-2305-0e69-94bc33c6eafe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

thank you very much for writing and posting this!

On 28/02/18 08:28, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Feb 27, 2018 at 08:27:12PM -0600, Samuel Holland wrote:
>> This mailbox hardware is present in several Allwinner sun8i and sun50i
>> SoCs. Add a device tree binding for it.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  .../devicetree/bindings/mailbox/sunxi-msgbox.txt   | 40 ++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
>> new file mode 100644
>> index 000000000000..3b3ed7f870a0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
>> @@ -0,0 +1,40 @@
>> +Allwinner sunxi Message Box
>> +===========================
>> +
>> +The hardware message box on sunxi SoCs is a two-user mailbox controller
>> +containing 8 unidirectional FIFOs bonded into 4 bidirectional mailbox channels.
>> +An interrupt is raised for received messages, but software must poll to know
>> +when a transmitted message has been acknowledged by the remote user.
>> +
>> +Refer to ./mailbox.txt for generic information about mailbox device-tree
>> +bindings.
>> +
>> +Mailbox Device Node:
>> +====================
>> +
>> +Required properties:
>> +--------------------
>> +- compatible:		Must be "allwinner,sunxi-msgbox".
> 
> The IP change quite often in the Allwinner SoCs, so it would be better
> to use a more specific compatible there. IIRC that IP was introduced
> with the A31, so what about sun6i-a31-msgbox?

As much as I like generic compatible strings ;-) I agree with Maxime
here. Can you change this to something like:

- compatible: Must contain at least "allwinner,sun6i-a31-msgbox".
              Should also contain one of the more specific strings, when
	      used on other SoCs which are compatible:

And then list the strings for the SoCs which we know of, ideally have
been tested also?

The rationale behind this is that by listing those strings here we
reserve them, to cover for future extensions or bugs found in those
SoCs. So even though the driver would only match on
"allwinner,sun6i-a31-msgbox" right now, we can extend it in the future.
The actual DTs would always use:
	compatible = "allwinner,sun50i-a64-msgbox",
		     "allwinner,sun6i-a31-msgbox";
Right now the first string would not match anything, but the second
would. The driver would use the generic driver functionality.
Should we find a bug or speciality in the A64, we can add the a64 string
to the driver and connect it to the workaround, and the actual DTs would
not need to be touched.
Does this make sense?

>> +- reg:			Contains the mailbox register address range (base
>> +			address and length).
>> +- clocks:		phandle for the clock controller and specifier.
>> +- clock-names:		Must be "bus".

Maxime:
Out of curiosity: There is only one clock, and just to gate the APB
clock to the MMIO registers. So do we need clock-names? Or is this good
practise these days to allow extending the clocks later in a compatible
manner? (Thinking of the sunxi pinctrl here.)
And is "bus" the correct naming? I see "apb" being used as well, is this
legacy?

Samuel: can you briefly add the purpose of the clock?

>> +- resets:		phandle for the reset controller and specifier.
>> +- reset-names:		Must be "bus".
>> +- interrupts:		Contains interrupt information for the mailbox.
>> +- #mbox-cells		Must be 2 - the indexes of the transmit and receive
>> +			channels, respectively.
> 
> That would prevent any unidirectional communication, wouldn't it?
> Other mailboxes driver seem to have two mbox channels, one for each
> direction, which also seem to mimic our DMA bindings (where we are in
> pretty much the same situation).

I also believe that this should be "1" here, just listing the channel
ID. It would be up to the DT/firmware author to put the right channel
(RX or TX) in the consumer node.

Cheers,
Andre.
