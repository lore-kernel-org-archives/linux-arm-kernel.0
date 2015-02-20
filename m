From: peter@hurleysoftware.com (Peter Hurley)
Date: Fri, 20 Feb 2015 11:34:35 -0500
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <9EDB5290-5C9F-42C1-826A-B38CC8C01F9B@konsulko.com>
References: <1424271576-1952-3-git-send-email-pantelis.antoniou@konsulko.com>
 <20150218154106.GC29429@leverpostej>
 <FE61DD1C-51DA-4869-8A62-C019C3D70577@konsulko.com>
 <20150218173115.GG29429@leverpostej>
 <76BD1B22-BAED-4205-9B34-186907CE0217@konsulko.com>
 <54E613E7.2020405@gmail.com>
 <670D0881-DBF0-45E8-A502-A6DB2B77A750@konsulko.com>
 <54E61DD2.3060002@gmail.com>
 <53F2F94C-0C43-4A54-B8CD-EEC454A0AC19@konsulko.com>
 <54E742F2.80506@hurleysoftware.com>
 <20150220143533.GA29908@odux.rfo.atmel.com> <54E74BF6.208@hurleysoftware.com>
 <F2A28070-4A8D-4869-8E2A-6AA744EECCCE@konsulko.com>
 <54E751BF.3000604@hurleysoftware.com>
 <9EDB5290-5C9F-42C1-826A-B38CC8C01F9B@konsulko.com>
Message-ID: <54E7621B.6040100@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20/2015 10:38 AM, Pantelis Antoniou wrote:
> Hi Peter,
> 
>> On Feb 20, 2015, at 17:24 , Peter Hurley <peter@hurleysoftware.com> wrote:
>>
>> On 02/20/2015 10:02 AM, Pantelis Antoniou wrote:
>>> Hi Peter,
>>>
>>>> On Feb 20, 2015, at 17:00 , Peter Hurley <peter@hurleysoftware.com> wrote:
>>>>
>>>> On 02/20/2015 09:35 AM, Ludovic Desroches wrote:

[...]

>>>>> As you said, we can imagine many reasons to have a failure during the
>>>>> production, having several DTB files will increase the risk.
>>>>
>>>> It's interesting that you don't see the added complexity of open-coding
>>>> the i2c driver or mixing DTS fragments for different designs as increased risk
>>>> (for us all).
>>>>
>>>>
>>>
>>> You don?t have to use it.
>>
>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>> index 5d27dfd..02129e7 100644
>>> --- a/arch/arm/mach-omap2/Makefile
>>> +++ b/arch/arm/mach-omap2/Makefile
>>> @@ -259,6 +259,11 @@ obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
>>>
>>> obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
>>>
>>> +# DT quirks
>>> +ifneq ($(CONFIG_OF_DYNAMIC),)
>>> +obj-$(CONFIG_SOC_AM33XX)		+= am33xx-dt-quirks.o
>>> +endif
>>
>> Won't this automatically be included on my Black that supports DT overlays?
>>
> 
> Yes it will. It is a grand total of 498 lines of code, and the total size of
> the code segment is about 2.2K.
> 
> You do realize that you?re probably booting a multi-platform kernel on the 
> black right? Including things for all 2xxx/3xxx and 44xx platforms?
> For instance:
> 
>> ~/ti/kernels/linux-github.git $ wc -l arch/arm/mach-omap2/*44xx*.c
>>    443 arch/arm/mach-omap2/clockdomains44xx_data.c
>>    526 arch/arm/mach-omap2/cminst44xx.c
>>    251 arch/arm/mach-omap2/cpuidle44xx.c
>>    250 arch/arm/mach-omap2/dpll44xx.c
>>   4864 arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>    295 arch/arm/mach-omap2/pm44xx.c
>>    358 arch/arm/mach-omap2/powerdomains44xx_data.c
>>     62 arch/arm/mach-omap2/prcm_mpu44xx.c
>>    770 arch/arm/mach-omap2/prm44xx.c
>>    210 arch/arm/mach-omap2/prminst44xx.c
>>    117 arch/arm/mach-omap2/vc44xx_data.c
>>    130 arch/arm/mach-omap2/voltagedomains44xx_data.c
>>    104 arch/arm/mach-omap2/vp44xx_data.c
>>   8380 total
> 
> I bet those things are far larger than 2.2K. And I also bet that in the
> tradeoff analysis that the board maintainer did things came down to 
> increasing complexity so that he can consolidate the kernels for all the
> other platforms he has to support besides the black.

Not that it really matters, but I'm not using any of that.


>>> Some people really do though. As for increased risk
>>> I expect to see arguments instead of a statement.
>>
>> No one is wasting your time with random arguments. Please keep your tone civil.
>>
> 
> A statement like 'increasing risk for all of us' is very open ended. What is
> the risk? How much of it exists?

My point was simply that this trades reduced complexity in one area
with increased complexity in another area.

For you, that trade-off is worth it, but for others, not so much.

FWIW, I agree that some mechanism is required to support the other
use cases. I just don't think ease of manufacturing, when the
submit configuration is the BeagleBone, is where I would hang my hat.


> If I offended you I?m really sorry though, I meant no such thing.

In re-reading it, I realize I shouldn't have taken offense. Thanks anyway
for the apology.

Regards,
Peter Hurley
