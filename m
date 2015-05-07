From: bintian.wang@huawei.com (Bintian)
Date: Thu, 7 May 2015 15:24:39 +0800
Subject: [PATCH v4 5/5] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <CAAS=xmi=vA7RGwZ6AeB-re9sebD+vwWXwSb-s+fF=z-xrfykrw@mail.gmail.com>
References: <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>	<20150505171349.GA30215@leverpostej>	<5549877C.10408@huawei.com>	<5549B9CC.1040709@huawei.com>	<20150506093022.GB31001@leverpostej>	<5549EE97.3020801@huawei.com>	<20150506104856.GC707@leverpostej>	<CAAS=xmh=tQRJymDCAevNC_gv+aCQnJH0tPjXX2L0BBhKbhZOYg@mail.gmail.com>	<20150506154406.GB2974@leverpostej>	<CAAS=xmjf+WYeZe7jPqVK26QWsv3tPqgdiy1TNUty6qWzZcsMkA@mail.gmail.com>	<20150506162301.GD2974@leverpostej>
 <CAAS=xmi=vA7RGwZ6AeB-re9sebD+vwWXwSb-s+fF=z-xrfykrw@mail.gmail.com>
Message-ID: <554B1337.6010209@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2015/5/7 1:15, Brent Wang wrote:
> Hi Mark,
>
> 2015-05-07 0:23 GMT+08:00, Mark Rutland <mark.rutland@arm.com>:
>> On Wed, May 06, 2015 at 05:03:29PM +0100, Brent Wang wrote:
>>> Hi Mark,
>>>
>>> 2015-05-06 23:44 GMT+08:00, Mark Rutland <mark.rutland@arm.com>:
>>>> Hi,
>>>>
>>>>> How about add the following binding rule to my 2/5 patch:
>>>>> ---------------------------
>>>>> *Hisilicon Enhanced ARM AMBA Primecell PL011 serial UART
>>>>>
>>>>> Required properties:
>>>>> - compatible: must be "hisilicon,hi6220-uart", "arm,primecell",
>>>>> "arm,pl011"
>>>>
>>>> "arm,primecell" should come last.
>>>>
>>>>> - reg: exactly one register range with length 0x1000
>>>>> - interrupts: exactly one interrupt specifier
>>>>>
>>>>> See also bindings/serial/pl011.txt
>>>>>
>>>>> Example:
>>>>>
>>>>> uart0: uart at f8015000 {
>>>>>          compatible = "hisilicon,hi6220-uart", "arm,pl011",
>>>>> "arm,primecell";
>>>>>          reg = <0x0 0xf8015000 0x0 0x1000>;
>>>>>          interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>>>>          clocks = <&ao_ctrl HI6220_UART0_PCLK>, <&ao_ctrl
>>>>> HI6220_UART0_PCLK>;
>>>>>          clock-names = "uartclk", "apb_pclk";
>>>>> };
>>>>
>>>> How about for the moment we just modify the existing pl011 binding
>>>> document to allow for the hi6220-specific string in addition to its
>>>> existing strings? We can always split it out later if the hi6220 UART
>>>> binding needs to be significantly divergent.
>>> How about adding the following rule to pl011.txt?
>>> ----------
>>> diff --git a/Documentation/devicetree/bindings/serial/pl011.txt
>>> b/Documentation/devicetree/bindings/serial/pl011.txt
>>> index ba3ecb8..1221ccb 100644
>>> --- a/Documentation/devicetree/bindings/serial/pl011.txt
>>> +++ b/Documentation/devicetree/bindings/serial/pl011.txt
>>> @@ -35,6 +35,10 @@ Optional properties:
>>>   - poll-timeout-ms:
>>>             Poll timeout when auto-poll is set, default
>>>             3000ms.
>>> +- compatible: "hisilicon,hi6220-uart":
>>> +          Hisilicon does some enhancements (e.g. larger FIFO length)
>>> +           based on PL011, so when using these UART hosts, this
>>> compatible
>>> +           string should be added.
>>
>> Up at the top of the document there's already a description of the
>> compatible property. Just change it into a list something like:
>>
>> - compatible: should contain one of the following sequences:
>>    * "arm,pl011", "arm,primecell"
>>    * "hisilicon,hi6220-pl011", "arm,pl011", "arm,primecell"
> OK, I will add in next version.
>
>>
>>>   See also bindings/arm/primecell.txt
>>> ------------
>>>>
>>>>>> Is UART 0 different from UART1 and UART2?
>>>>> Yes,  but my patch just includes UART0, we do some changements for
>>>>> UART1/2
>>>>> to improve performance.
>>>>
>>>> Sure, but we need to make sure we can choose a sane compatible string
>>>> for them, that won't clash with whatever we choose for UART0.
>>> OK, do I also need to add compatible ""hisilicon,hi6220-uart"," to UART0
>>> node?
>>
>> This depends on a number of factors. Questions below.
>>
>>>> Are they the same IP as UART0, or fundamentally different?
>>> The same IP.
>>>>
>>>> Are they also PL011 derived?
>>> Yes, just do some enhancements to improve performance.
>>
>> What exactly is different between UART0 and UART{1,2}, given they are
>> the same IP?
> I know they are the same IP, but UART{1,2} have larger FIFO length.
>
>>
>> Can UART{1,2} be used as if they are standard PL011 instances?
> Yes
>
>> Is the difference internal, or do they just have different
>> clocks/regulators/etc?
> The different FIFO length means internal?  Sure, they have different
> clocks/regualtors.
>>
>> Do they have feature control pins tied off differently?
> UART{1,2} have reset function, we must disable the reset before using
> them, is it the feature
> control pins you mentioned ?
>>
>> Are they simply programmed differently at reset by firmware?
> I think so.
>
> For hi6220 uart{1,2} , I think add one "struct vendor_data
> vendor_hisilicon" to "amba-pl011.c" may be a good solution in the
> future.
>
> I am not the uart driver developer and the Hisilicon engineer who
> develop it may have a deep
> discussion with you when upstreaming UART{1,2}.
>
> I suggest not add "hisilicon,hi6220-uart" to UART0;
How about not adding "hisilicon,hi6220-uart" to UART0, and just add this
compatible string for future use?  you know, the UART0 is PL011
compatible and I checked this with chip designer.

If there is no problem, I will send another version of this patch set
and add this compatible string to pl011.txt as you suggested.

Thanks,

Bintian

>
> Must go to bed, it's very late here :(
>
> Thanks,
>
> Bintian
>>
>> Thanks,
>> Mark.
>>
>
>
