From: xuejiancheng@huawei.com (xuejiancheng)
Date: Tue, 8 Dec 2015 11:54:51 +0800
Subject: [PATCH v2 4/9] ARM: dts: add dts files for hi3519-demb board
In-Reply-To: <56652912.80308@huawei.com>
References: <1449110668-23647-1-git-send-email-xuejiancheng@huawei.com>
 <1728470.0OiiXMcl88@wuerfel> <5660FA2E.6040601@huawei.com>
 <3047121.2z9SCS5Au2@wuerfel> <56652912.80308@huawei.com>
Message-ID: <5666548B.90502@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/7 14:37, xuejiancheng wrote:
> 
> On 2015/12/4 18:49, Arnd Bergmann wrote:
>> On Friday 04 December 2015 10:27:58 xuejiancheng wrote:
>>>>
>>>>> +            sysctrl: system-controller at 12020000 {
>>>>> +                    compatible = "hisilicon,sysctrl";
>>>>> +                    reg = <0x12020000 0x1000>;
>>>>> +                    reboot-offset = <0x4>;
>>>>> +            };
>>>>
>>>> Is this one identical to the one in hip04?
>>>>
>>>> If not, pick a new unique compatible string
>>>
>>> Yes. It's compatible with the one in hip04.
>>
>> Ok, we should add a compatible string for that then, as the hip04 apparently
>> has a slightly different layout from hip01.
>>
>> Can you add a separate patch to clarify the existing hisilicon,sysctrl nodes?
>>
>> It look like hi3620 accidentally uses the same string as hip04 already
>> but is actually a bit different.
>>
>> Maybe split out the sysctrl binding from
>> Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt, as it has
>> you already have a couple of those, and it's not clear how they relate
>> to one another.
>>
>> If we introduce a string for all hip04 compatible sysctrl devices, we should
>> document that and use it consistently, so hi3519 becomes
>>
>> 	compatible = "hisilicon,hi3519-sysctrl", "hisilicon,hip04-sysctrl", "hisilicon,sysctrl";
>>
>> but I'd clarify in the binding documentation that "hisilicon,sysctrl" should
>> only be used for hip04 and hi3519 but not the others.
>>
>> As this seems to be a standard part, we can also think about making a
>> high-level driver for in in drivers/soc rather than relying on the syscon
>> driver which we tend to use more for one-off devices with random register
>> layouts.
>>
>    Sorry. I didn't understand your meaning well and maybe I gave you a wrong description.
> Please allow me to clarify it again.
>    The "sysctrl" nodes here is just used for the "reboot" function. It is corresponding to
> the driver "drivers/power/reset/hisi-reboot.c". The compatible string in the driver is
> "hisilicon,sysctrl".
>    The layout of this block is also different from the one in HiP04.

I'll use "syscon" as the compatible value for sysctrl node and "syscon-reboot" for a new reboot node.

Thank you.

> 
>>>>> +
>>>>> +            crg: crg at 12010000 {
>>>>> +                    compatible = "hisilicon,hi3519-crg";
>>>>
>>>>
>>>> what is a "crg"? Is there a standard name for these?
>>>
>>> The "crg" means Clock and Reset Generator. It's a block which supplies clock
>>> and reset signals for other modules in the chip. I used "hi3519-clock"
>>> in last version patch. Rob Herring suggested that it's better to use "hi3519-crg"
>>> as the compatible string if it's a whole block.
>>>
>>> what about writing like this?
>>>
>>> crg: clock-reset-controller at 12010000 {
>>>         compatible = "hisilicon,hi3519-crg";
>>>         }
>>>
>>
>> Ok, that's better.
>>
>> 	Arnd
>>
>> .
>>
