From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 17 Jun 2016 16:49:34 +0100
Subject: [PATCH] arm64: Kconfig: select PM for ARCH_VEXPRESS
In-Reply-To: <5285733.mW80cUVgAV@wuerfel>
References: <1466090128-24425-1-git-send-email-sudeep.holla@arm.com>
 <3892833.90HLNUPjM3@wuerfel> <57641056.2000708@arm.com>
 <5285733.mW80cUVgAV@wuerfel>
Message-ID: <57641C0E.2010700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/06/16 16:07, Arnd Bergmann wrote:
> On Friday, June 17, 2016 3:59:34 PM CEST Sudeep Holla wrote:

[...]

>> To be more precise genpd/runtime code return same error -ENODEV when
>> PM_GENERIC_DOMAINS=n and if the no power domain is found with
>> PM_GENERIC_DOMAINS=y . The AMBA bus code just checks for -EPROBE_DEFER
>> to stop adding devices, while proceeds to access the device otherwise.
>>
>> However on Juno, the coresight needs to powered up before accessing it.
>> Well all is fine if you specify power domains in DT and have
>> PM_GENERIC_DOMAINS=y. However if PM_GENERIC_DOMAINS=n the AMBA ignores
>> the error(-ENODEV) from runtime PM and access the device resulting in
>> boot hang when adding amba devices.
>>
>> I thought we need is to have code to check for power domains in DT for
>> the device even when PM_GENERIC_DOMAINS=n and return an error that can
>> be used to skip registering the device and clearly identifies with other
>> allowed errors. It may need a bit of surgery and closer look IMO. But
>> when asked for opinion, I was suggested to do this. I admit that I
>> didn't propose my thoughts then :)
>
> Ok, so we also need PM_GENERIC_DOMAINS, not just PM, right?
>
Yes, but latter won't select former. Generally I have seen domain
controller code selecting PM_GENERIC_DOMAINS if PM=y

> It also sounds like there is no easy way to just turn on the clocks
> in the amba bus handler when PM_GENERIC_DOMAINS is turned off, other
> than reimplementing PM_GENERIC_DOMAINS?
>

Turn on power domain, not just clocks(just to be precise), yes. It needs
some thoughts as there are some assumptions on which existing platform
work. Adding the support to handle the scenario I mentioned earlier is
not trivial. Also the driver to handle the device may not be compiled in
when PM_GENERIC_DOMAINS=n or when PM=n. So I was thinking of not
accessing the device and hence skip adding it.

> I'm just guessing here, I haven't looked into the code in enough
> depth.
>

Ok, but that's correct.

-- 
Regards,
Sudeep
