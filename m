From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 24 Jul 2017 07:56:19 +0200
Subject: [PATCH v1 1/2] remoteproc: dt: Provide bindings for iMX6SX/7D
 Remote Processor Controller driver
In-Reply-To: <20170718163814.GD20973@minitux>
References: <20170710144220.31594-1-o.rempel@pengutronix.de>
 <20170710144220.31594-2-o.rempel@pengutronix.de>
 <20170710221408.GD1618@tuxbook>
 <91bfe236-0410-b26e-7ef6-73d14ebf120d@pengutronix.de>
 <20170718163814.GD20973@minitux>
Message-ID: <ebaaf7ba-e177-0b90-bb0a-9371923bce44@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 18.07.2017 um 18:38 schrieb Bjorn Andersson:
> On Tue 18 Jul 01:45 PDT 2017, Oleksij Rempel wrote:
> 
>> Hallo Bjorn,
>>
>> On 11.07.2017 00:14, Bjorn Andersson wrote:
>>> On Mon 10 Jul 07:42 PDT 2017, Oleksij Rempel wrote:
>>>
>>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>>> ---
>>>>  .../devicetree/bindings/remoteproc/imx-rproc.txt   | 44 ++++++++++++++++++++++
>>>>  1 file changed, 44 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt b/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
>>>> new file mode 100644
>>>> index 000000000000..e7c61993e1b8
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/imx-rproc.txt
>>>> @@ -0,0 +1,44 @@
>>>> +NXP iMX6SX/iMX7D Co-Processor Bindings
>>>> +----------------------------------------
>>>> +
>>>> +This binding provides support for ARM Cortex M4 Co-processor found on some
>>>> +NXP iMX SoCs.
>>>> +
>>>> +Required properties:
>>>> +- compatible		Should be one of:
>>>> +				"fsl,imx7d-rproc"
>>>> +				"fsl,imx6sx-rproc"
>>>> +- clocks		Clock for co-processor (See: ../clock/clock-bindings.txt)
>>>> +- syscfg		Phandle to syscon block which provide access to
>>>
>>> This is called "syscon" in the code and the example.
>>
>> done.
>>
>>>> +			System Reset Controller
>>>> +
>>>> +Optional properties:
>>>> +- reg:			Should contain the address ranges for some of internal
>>>> +			memory regions.
>>>
>>> Something less hand-wavy, like: "Should list the memory regions for the
>>> remoteproc"
>>>
>>>> +- reg-names:		Contains the corresponding names for the memory
>>>> +			regions. These should be named "ddr", "ocram", "ocram-s",
>>>> +			"ocram-epdc" or "ocram-pxp".
>>>
>>> Make this comment define which memory regions are required for each of
>>> the systems.
>>
>> done.
>>
>>>> +Fallowing memory ranges are expected:
>>>> +- For "fsl,imx7d-rproc"
>>>> +	<0x00900000 0x00020000> - "ocram"
>>>> +	<0x00920000 0x00020000> - "ocram-epdc"
>>>> +	<0x00940000 0x00008000> - "ocram-pxp"
>>>> +	<0x80000000 0x0FFF0000> - "ddr" (code area)
>>>> +	<0x80000000 0x60000000> - "ddr" (data area)
>>>
>>> There's no reason to list the actual regions in the binding
>>> document. Just list the requires regions for each system.
>>>
>>>> +- For "fsl,imx6sx-rproc"
>>>> +	<0x008F8000 0x00004000> - "ocram-s"
>>>> +	<0x80000000 0x0FFF8000> - "ddr" (code area)
>>>> +	<0x80000000 0x60000000> - "ddr" (data area)
>>>> +
>>>> +Note: the "ddr" code and data ranges are overlapping. Code area is smaller
>>>> +than data area.  So this range should be carefully chosen according to your
>>>> +system and application requirements.
>>>> +
>>>
>>> This is a source of future issues as this indicates that I should have
>>> reg-names list "ddr" twice.
>>
>> Then I will name it:
>> "ddri" (incstruction/code area),
>> "ddrd" (data area)
>>
>> unless there are other suggestions.
>>
> 
> But are you saying that it's correct that these two memory regions
> should overlap?

Yes, from Cortex-m4 the same memory regions are aliased to different
address ranges to provide different cache optimizations.
>From Cortex-A7 side - not. But on this side we don't care about meaning
of it, it is just some memory region.


>>> Also, as you warn about the user needing to pick the values for "ddr",
>>> does that mean that it's a carveout of System RAM?
>>
>> Yes, it is a part of System RAM.
>>
> 
> Then there will be an associated reserved-memory region for the
> region(s), you should add a label to this and use "memory-region" to get
> hold of the addresses instead.

Ok. Should only system memory region be assigned over reserved-memory or
all of named regions?

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170724/536bdd4b/attachment.sig>
