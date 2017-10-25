From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 25 Oct 2017 10:05:12 +0200
Subject: [PATCH 1/3] dt-bindings: iio: adc: stm32: add support for diff
 channels
In-Reply-To: <D8F820CC-9AC1-4C78-9237-C43A47D3328F@jic23.retrosnub.co.uk>
References: <1508246145-19417-1-git-send-email-fabrice.gasnier@st.com>
 <1508246145-19417-2-git-send-email-fabrice.gasnier@st.com>
 <20171024164138.arnjrlw4pmk5xaqy@rob-hp-laptop>
 <D8F820CC-9AC1-4C78-9237-C43A47D3328F@jic23.retrosnub.co.uk>
Message-ID: <f8fdf585-d967-fa32-ba00-af73cb4cf282@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2017 08:42 PM, Jonathan Cameron wrote:
> 
> 
> On 24 October 2017 17:41:38 BST, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Oct 17, 2017 at 03:15:43PM +0200, Fabrice Gasnier wrote:
>>> STM32H7 ADC channels may be configured either as single-ended or
>>> differential.
>>> Add 'st,adc-diff-channels' property to support differential channels.
>>> Differential channels are defined as a pair of positive and negative
>>> inputs: vinp & vinn.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>> ---
>>>  Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt | 6
>> ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>> b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>> index 48bfcaa3..c3c8de1 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
>>> @@ -62,6 +62,12 @@ Required properties:
>>>  - st,adc-channels: List of single-ended channels muxed for this ADC.
>>>    It can have up to 16 channels on stm32f4 or 20 channels on
>> stm32h7, numbered
>>>    from 0 to 15 or 19 (resp. for in0..in15 or in0..in19).
>>> +- st,adc-diff-channels: List of differential channels muxed for this
>> ADC.
>>> +  Depending on part used, some channels can be configured as
>> differential
>>> +  instead of single-ended (e.g. stm32h7). List here positive and
>> negative
>>> +  inputs pairs as <vinp vinn>, <vinp vinn>,... vinp and vinn are
>> numbered
>>> +  from 0 to 19 on stm32h7)
>>> +  Note: At least one of "st,adc-channels" or "st,adc-diff-channels"
>> is required.
>>
>> Wouldn't both present be invalid?
>>
> 
Hi Rob, Jonathan,

> Probably invalid to have a number in both but some channels in each would be fine.

Yes, both properties can be used together. Some channels can be used as
single-ended and some other ones as differential (mixed). But channels
can't be configured both as single-ended and differential (invalid).

I'll mention this in the note, and also update differential channels
example:

Example to setup:
- channel 1 as single-ended
- channels 2 & 3 as differential (with resp. 6 & 7 negative inputs)

	adc: adc at 40022000 {
		compatible = "st,stm32h7-adc-core";
		...
		adc1: adc at 0 {
			compatible = "st,stm32h7-adc";
			...
			st,adc-channels = <1>;
			st,adc-diff-channels = <2 6>, <3 7>;
		};
	};

I will send V2 with these updates.

Thanks,
Best Regards,
Fabrice
> 
>>>  - #io-channel-cells = <1>: See the IIO bindings section "IIO
>> consumers" in
>>>    Documentation/devicetree/bindings/iio/iio-bindings.txt
>>>  
>>> -- 
>>> 1.9.1
>>>
> 
