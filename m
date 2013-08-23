From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 23 Aug 2013 14:20:44 +0530
Subject: [PATCH v3 1/2] rtc: omap: update of_device_id to reflect latest
 ip revisions
In-Reply-To: <520E5444.1000700@baylibre.com>
References: <1376653017-21935-1-git-send-email-gururaja.hebbar@ti.com>
 <1376653017-21935-2-git-send-email-gururaja.hebbar@ti.com>
 <520E341D.4080206@baylibre.com> <520E482A.1070504@ti.com>
 <520E5444.1000700@baylibre.com>
Message-ID: <52172264.3070000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

Did you get a chance to think about this, I have provided some replies
below.

On Friday 16 August 2013 10:03 PM, Benoit Cousson wrote:
> Hi Sekhar,
> 
> On 16/08/2013 17:41, Sekhar Nori wrote:
>>
>> On 8/16/2013 7:45 PM, Benoit Cousson wrote:
>>> Hi Gururaja,
>>>
>>> On 16/08/2013 13:36, Hebbar, Gururaja wrote:
>>>> The syntax of compatible property in DT is to mention the Most specific
>>>> match to most generic match.
>>>>
>>>> Since AM335x is the platform with latest IP revision, add it 1st in
>>>> the device id table.
>>>
>>> I don't understand why? The order should not matter at all.
>>
>> Yes, it should not. We are trying to work around a bug in the kernel
>> where the compatible order is not honored (instead the order in
>> of_match[] array matters). There were patches being discussed to fix this.
>>
>>>
>>> I've tried to follow the thread you had with Mark on the v2, but AFAIK,
>>> you've never answered to his latest question.
>>>
>>> Moreover, checking the differences between the Davinci and the am3352
>>> RTC IP, I would not claim that both are compatible.
>>>
>>> Sure you can use the am3352 with the Davinci driver, but you will lose
>>> the wakeup functionality without even being notify about that.
>>
>> When the kernel is fixed for the bug pointed out above, this should not
>> happen with properly defined compatible property.
>>
>>>
>>> For my point of view, compatible mean that the HW will still be fully
>>> functional with both versions of the driver, which is not the case here.
>>
>> I do not think that's the interpretation of compatible. Its goes from
>> most specific to most generic per the ePAPR spec. That in itself says
>> that 100% functionality is not expected if you don't find a match for
>> the more specific property.
> 
> Well, to be honest I checked as well the official documentation, and this is far from being clear:
> 
> page 21 of the ePAPR:
> 
> "
> Property: compatible
> Value type: <stringlist>
> 
> Description:
>  The compatible property value consists of one or more strings that define the specific 
>  programming model for the device. This list of strings should be used by a client program for
>  device driver selection. The property value consists of a concatenated list of null terminated
>  strings, from most specific to most general. They allow a device to express its compatibility
>  with a family of similar devices, potentially allowing a single device driver to match against
>  several devices.
>  
>  The recommended format is ?manufacturer,model?, where manufacturer is a
>  string describing the name of the manufacturer (such as a stock ticker symbol), and model
>  specifies the model number.
> 
> Example:
>  compatible = ?fsl,mpc8641-uart?, ?ns16550";
>  In this example, an operating system would first try to locate a device driver that supported
>  fsl,mpc8641-uart. If a driver was not found, it would then try to locate a driver that supported
>  the more general ns16550 device type.
> "
> 
> In this example, the generic vs specific is just about the driver. You could have one driver that manage 10 different UARTs or a specific one that manage only your HW. 

Right, the assumption is that a specific driver is written because there
are parts of the hardware that cannot be serviced by generic driver. So
ultimately its all driven by changes in hardware.

> 
> There is no assumption about the lost of functionality by using the generic version of the driver. How the user is supposed to know the amount of functionality he will lose, and if this is acceptable to him.

I suppose the generic driver would return some error code like -ENOTSUP
for the functionality it cannot provide.

> I'd rather have an error at boot saying that the driver is not compatible with the HW and thus I will have to upgrade the kernel, than booting a kernel that will not work as expected because some functionality are missing for that specific HW.

If you have an update available, you can always upgrade to it. But what
if there is no update available? Would you rather not have the user use
the available functionality in the meanwhile while he waits for the
kernel support to be developed.

> 
> Claiming that a piece of HW is compatible with an other one that is just a subset in term of functionality is wrong. You can claim that the ti,da830-rtc is compatible with the ti,am3352-rtc driver, but not the opposite.

If this is wrong, then what is the use of compatible property? Why would
someone write a driver supporting ?fsl,mpc8641-uart? if 100% of its
hardware features are also supported by ?ns16550" driver?

>>> am3352 DTS must use the ti,am3352-rtc to have the expected behavior.
>>
>> Yes, that's what patch 2/2 does.
>>
>>> Using the ti,da830-rtc version will not make the board working as
>>> expected. So we cannot claim the compatibility.
>>
>> Ideally, the DT file was *always* written as
>>
>> 	compatible = "ti,am3352-rtc", "ti,da830-rtc";
>>
>> even when there was no kernel support for AM3352 RTC.
> 
> You could do that only for the davinci DTS, because it is a subset of the am3352 but you cannot do that for the am3352 as explained before.

DaVinci DTS will use compatible = "ti,da830-rtc"; Thats not changing
with this patchset.

> 
>> That way, there is no need to update the .dts[i] file. As kernel gains
>> functionality, more features (like rtc wake) is available to users.
> 
> Well, you cannot anticipate the HW evolution anyway and you did not know when Davinci DTS was done that an am3352 will exist in the future and reuse the same IP.

Yeah, I am not claiming DaVinci DTS should be updated. But when
am335x.dtsi was written, there was knowledge that a (potentially) new
version of RTC IP is available and therefore the .dtsi should have been
written as

	compatible = "ti,am3352-rtc", "ti,da830-rtc";

instead of

	compatible = "ti,da830-rtc";

that it is today. Thing is, you can never know if the IP needs any
additional handling even after reading the spec. We keep discovering new
features/quirks. So, when writing <new-soc>.dtsi its safer to always use

	compatible = "ti,<new-soc>-rtc", "ti,<compatible-soc>-rtc";

even though _today_ you may not have code that specifically handles
"ti,<new-soc>-rtc".

> Moreover DT is a ABI, so extending it according to the HW feature evolution is absolutely normal.

You mean the DT bindings and not specifically the .dts[i], right? Then I
agree. Ideally the .dts[i] is written once per hardware. I know its
almost impossible to get that right.

> 
> Every SoC that are using a RTC with the same programing model than the da830 can claim the compatibility. A SoC that is using a newer version of the IP with an extended programming model cannot claim that.

We differ here. As long as programming model is _extended_, new IP is
still compatible with old. If the programming model is _changed_ then
its not.

> 
>> Otherwise they get plain RTC functionality - but at least they get
>> something instead of no RTC.
> 
> Because you assume that this feature is not important and thus you can use the plain RTC, but what if someone is buying that HW because of this new feature. Without that feature his system will just not work properly.

Right, but thats not a problem DT can solve. He/she needs to hassle TI
for updated drivers. But there could be 10 other customers who are just
okay with plain RTC. So till the time driver is updated to use
ti,am3352-rtc", are you saying no one should be able to use the RTC on
the SoC at all even though 90% features are available?

> Saying that this is compatible whereas you lost functionality is lying to the customer for my point of view.

If 100% functionality is required for compatibility then I am afraid
there is nothing like "compatibility". There are just different isolated
versions.

Thanks,
Sekhar
