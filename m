From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 27 Apr 2016 11:55:12 +0100
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <5212316.Wg9FOfdsuU@wuerfel>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <5591261.0X3WRSsdGl@wuerfel> <572081FB.5090303@arm.com>
 <5212316.Wg9FOfdsuU@wuerfel>
Message-ID: <57209A90.5070707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/04/16 10:50, Arnd Bergmann wrote:
> On Wednesday 27 April 2016 10:10:19 Vladimir Murzin wrote:
>>> On the other hand, separating the two has the advantage of keeping it
>>> simple, as we don't have to worry about all the ARMv7-A platforms
>>> and whether we actually want to allow their kernels to be built with
>>> MMU disabled.
>>>
>>
>> Ok, what if we start with your approach explicitly saying which platform
>> wants to be listed when CONFIG_MMU is deselected (I think R-class is the
>> first user here) gradually extending such list with ARMv7-A? There is
>> (little?) chance that at some point we can support kernel which can run
>> on both configurations.
> 
> Do you mean adding a ARM_SINGLE_ARMV7R option, or ARCH_MULTI_V7R?

I'd think that ARCH_MULTI_V7R would make more sense since it is close
rather to the CPU variant than platform, so for the imaginary case where
ARMv7-A platform want to run without MMU can adjust it's dependency to

depends on ARCH_MULTI_V7 || ARCH_MULTI_V7R

where

config ARCH_MULTI_V7
	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
	depends on MMU
...

config ARCH_MULTI_V7R
	bool "MMU-less ARMv7 based platforms (Cortex-R)"
	depends on !MMU
...

It is also should work for purely R-class platform, although I'm not
keen on Kconfig and may be totally wrong here :(

Cheers
Vladimir

> 
> 	Arnd
> 
> 
