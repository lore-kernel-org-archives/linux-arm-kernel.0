From: xuejiancheng@huawei.com (xuejiancheng)
Date: Mon, 7 Dec 2015 14:58:14 +0800
Subject: [PATCH v2 3/9] ARM: hisi: enable Hi3519 soc
In-Reply-To: <43938749.Z0h4RNddN6@wuerfel>
References: <1449110565-23590-1-git-send-email-xuejiancheng@huawei.com>
 <8647404.sBOFNLAMdU@wuerfel> <5661119E.9060309@huawei.com>
 <43938749.Z0h4RNddN6@wuerfel>
Message-ID: <56652E06.10309@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 2015/12/5 5:54, Arnd Bergmann wrote:
> On Friday 04 December 2015 12:07:58 xuejiancheng wrote:
>> On 2015/12/3 17:40, Arnd Bergmann wrote:
>>> On Thursday 03 December 2015 10:42:45 Jiancheng Xue wrote:
>>>> --- a/arch/arm/mach-hisi/Kconfig
>>>> +++ b/arch/arm/mach-hisi/Kconfig
>>>> @@ -12,6 +12,14 @@ if ARCH_HISI
>>>>  
>>>>  menu "Hisilicon platform type"
>>>>  
>>>> +config ARCH_HI3519
>>>> +       bool "Hisilicon Hi3519 Soc" if ARCH_MULTI_V7
>>>> +       select HAVE_ARM_ARCH_TIMER
>>>> +       select ARCH_HAS_RESET_CONTROLLER
>>>> +
>>>> +       help
>>>> +         Support for Hisilicon Hi3519 Soc
>>>> +
>>>>  config ARCH_HI3xxx
>>>>         bool "Hisilicon Hi36xx family" if ARCH_MULTI_V7
>>>>         select CACHE_L2X0
>>>
>>> Do those need to be separate? I would just extend the Hi36xx
>>> to cover all Hi3xxx, if nothing in the platform code really
>>> depends on this.
>>
>> For HI3519, there is really no special platform code. But HI35xx and HI36xx soc families
>> belong to different product lines in hisilicon. HI35xx family also composes of various
>> architectures socs(single core, smp and big-little). So I think it may be clear to have
>> separate arch definitions.
>>
>> Could you give me more suggestions about this?  Thank you!
> 
> For the most part, you already need to enable the device drivers for the
> specific components on each chip, and the per-soc top-level options here
> don't actually control the compilation of any particular code.
> 
> This is slightly different for some of the older platforms that for historic
> reasons need fine-grained options. You could probably just make the device
> drivers depend on "ARCH_HISI || COMPILE_TEST" in general, but some level
> of classification is ok, in particular when the chips are not related at all.
> 
> In this case, my impression is that while HI3519 and HI36xx are made
> by different business units, there is still a noticeable amount of shared
> IP in them (e.g. the "sysctrl" node that seems to be shared with some of
> the other chips as well), so grouping them together should make sense.

HI35xx and HI36xx are designed totally independently, including IP selection.
The relation between HI35xx and HI36xx is just like the one between HI36xx
and HIP0x. In another word, HI35xx and HI36xx are not related except they all
belong to hisilicon. So I don't think it's proper to group them together.

Is it OK if I drop ARCH_HI3519 and use ARCH_HISI directly?

> 
> 	Arnd
> 
> .
> 
