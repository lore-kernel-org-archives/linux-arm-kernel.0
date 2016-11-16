From: scott.wood@nxp.com (Scott Wood)
Date: Wed, 16 Nov 2016 21:07:57 +0000
Subject: [upstream-release] [PATCH 1/2] drivers: usb: phy: Add qoriq usb
 3.0	phy driver support
References: <1479101215-26954-1-git-send-email-sriram.dash@nxp.com>
 <1479101215-26954-2-git-send-email-sriram.dash@nxp.com>
 <DB5PR0401MB1928CA058CC01243457F124791BC0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <DB5PR0401MB1925FB1FE45C15B0671E46D1F5BF0@DB5PR0401MB1925.eurprd04.prod.outlook.com>
 <HE1PR0401MB1931C92287A8E92BC6B52B1991BE0@HE1PR0401MB1931.eurprd04.prod.outlook.com>
 <DB5PR0401MB1925E935B4E7F5D1D1E521D5F5BE0@DB5PR0401MB1925.eurprd04.prod.outlook.com>
Message-ID: <DB5PR0401MB1928036AB363B251821975CB91BE0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2016 05:33 AM, Sriram Dash wrote:
>> From: Scott Wood
>> On 11/15/2016 06:39 AM, Sriram Dash wrote:
>>>> From: Scott Wood
>>>> On 11/13/2016 11:27 PM, Sriram Dash wrote:
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>>>>> b/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>>>>> new file mode 100644
>>>>> index 0000000..d934c80
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/phy/phy-qoriq-usb3.txt
>>>>> @@ -0,0 +1,36 @@
>>>>> +Driver for Freescale USB 3.0 PHY
>>>>> +
>>>>> +Required properties:
>>>>> +
>>>>> +- compatible :	fsl,qoriq-usb3-phy
>>>>
>>>
>>> Hi Scott,
>>>
>>>> This is a very vague compatible.  Are there versioning registers
>>>> within this register block?
>>>>
>>>
>>> There are versioning registers for the phy (1.0 and 1.1). But the
>>> current erratum
>>> A008751 does not require the mentioning of the version numbers. Was
>>> planning to take care of the versioning when there is code diversity
>>> on the basis of the version number.
>>
>> That is not how device tree bindings work.  The describe the hardware, not the
>> driver.
>>
>> That said, is the block version sufficient to tell whether a given chip has this
>> erratum? If so, you don't need a special property for the erratum.  If not, what is
>> different about the PHY that is not described by the versioning?

Can you find out the answer to this?

>> In any case, it would be nice to mention the version register and its offset in the
>> binding, just so that it becomes part of the definition of this compatible string, and
>> if we come out with some QorIQ chip with a
>> USB3 PHY that is totally different and doesn't have that version register, it'll be
>> clear that it needs a different compatible.
>>
> 
> Okay. Will include version number in the next rev for Documentation and dt.

I'm not asking you to put the version number in the dt if it can be read
from a register.  I'm asking you to have the binding describe the
version register, as part of the definition of what "fsl,qoriq-usb3-phy"
means.

>>> The only reason for __raw_writel is to make the code faster.
>>
>> Does that really matter here?
>>
>>> However, shall I use writel(with both barriers and byte swap) instead
>>
>> Yes, if the registers are little-endian on all chips.
>>
> 
> The endianness is not same for all Socs. But for most Socs, it is big-endian.
> Is "iowrite32be" better instead? 

Then the device tree node needs to say what endian it is, and you need
to choose the appropriate accessor at runtime.

But is it really big endian for most or even any SoCs?  This hardware
isn't present on our PPC chips, right (I checked a couple of the most
recent PPC RMs and it shows USB 2.0 only)?  So it'd just be the few ARM
chips that made almost everything big endian, and even there the couple
RMs I checked (ls1021a and ls1043a) have these registers described as
little-endian.

>>> and then make appropriate changes in the value 32'h27672B2A?
>>
>> Not sure what you mean here.
>>
>>> In my knowledge, there are more than 5 errata in pipeline,
>>
>> Then please get all of these errata described in the device tree ASAP (unless their
>> presence can be reliably inferred from the block version, as discussed above).
>>
> 
> Yes. We will push the errata asap.

My point is that the device tree node should be complete when you submit
it.  Don't wait for the implementation of a workaround to advertise the
existence of an erratum in the device tree.

-Scott
