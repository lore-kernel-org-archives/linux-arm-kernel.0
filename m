From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Thu, 12 Feb 2015 14:17:41 -0800
Subject: [PATCHv1] rtc: bcm-iproc: Add support for Broadcom iproc rtc
In-Reply-To: <1603624.EMYvBCWhuM@wuerfel>
References: <1418757750-3628-1-git-send-email-arun.ramamurthy@broadcom.com>
 <549095CA.7090505@broadcom.com> <5490A9FC.6030305@broadcom.com>
 <1603624.EMYvBCWhuM@wuerfel>
Message-ID: <54DD2685.6020207@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

My apologies for the late reply, I was moved to other work items. I 
wanted to get more clarification on the syscon issue so that I can 
submit the next patch set. If I understand correctly, you would like
me to move the CRMU logic to a new driver under mfd/ and use the syscon
api calls in my rtc driver? Thanks

Arun

On 14-12-17 06:31 AM, Arnd Bergmann wrote:
> On Tuesday 16 December 2014 13:54:04 Arun Ramamurthy wrote:
>> On 14-12-16 12:27 PM, Ray Jui wrote:
>>> On 12/16/2014 12:19 PM, Arnd Bergmann wrote:
>>>>
>>>> It sounds like CRMU is some other unit aside from the RTC. Could this
>>>> be something like a generic system controller? I think it should
>>>> either have its own driver or use the syscon logic if that is what
>>>> this is.
>>>>
>>> Giving that CRMU has scattered, miscellaneous control logic for multiple
>>> different peripherals, it probably makes more sense to use the syscon
>>> logic here.
>>>
>> Arnd, thanks for the feedback. If I was to write a separate driver for
>> the CRMU, I would have to export certain functions and create an api
>> that only this RTC driver would use. I am not sure that is efficient or
>> required. What is your opinion?
>> Would it be better if I use the syson api in my current driver and move
>> the CRMU registers to separate syscon device tree entry?
>>
>
> This is something that's normally up to the platform maintainers, depending
> on what works best for a given SoC. If you have a control block that
> wants to export the same high-level API for multiple drivers, that's
> fine, but if literally every register does something different, a syscon
> driver works best.
>
> It's also possible that some of the functions of the CRMU already have
> abstractions, like system-reset, device-reset, regulator or clock support.
> In that case, you can still use syscon but have the more other drivers
> use that for accessing the registers.
>
> 	Arnd
>
