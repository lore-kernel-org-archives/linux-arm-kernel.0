From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 9 Feb 2017 11:53:43 -0800
Subject: [PATCH 1/2] ARM: add ARM_SINGLE_ARMV7 as config option
In-Reply-To: <SG2PR06MB1165828CEDD6C06F6D1CBBF98A450@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170209033044.19513-1-chris.brandt@renesas.com>
 <20170209033044.19513-2-chris.brandt@renesas.com>
 <519f1f67-5cfc-db78-c2b7-6bb74b78f3c8@gmail.com>
 <SG2PR06MB1165828CEDD6C06F6D1CBBF98A450@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <5d90aff5-63b7-83a8-7529-2ac61ef82021@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2017 07:50 PM, Chris Brandt wrote:
> Hello Florian,
> 
> On Wednesday, February 08, 2017, Florian Fainelli wrote:
>> On 02/08/2017 07:30 PM, Chris Brandt wrote:
>>> Creates a new ARM_SINGLE_ARMV7 option as an alternative
>> ARCH_MULTIPLATFORM.
>>>
>>> ARM_SINGLE_ARMV7 is very similar to ARCH_MULTIPLATFORM, except the
>>> options from ARCH_MULTI_V6_V7 were copied directly into the new
>> ARM_SINGLE_ARMV7.
>>>
>>> Additionally, everywhere ARCH_MULTIPLATFORM existed in build scripts,
>>> ARM_SINGLE_ARMV7 was added along side it in order to produce similar
>>> results.
>>
>> Could we try to be a little smarter than this and if ARCH_MULTIPLATFORM is
>> selected but only one platform beneath is we automatically select
>> ARM_SINGLE_ARMV7 (this may require Kconfig hackery)?
> 
> Months ago I spent hours on trying to get the current kbuild system to do
> that and nothing I came up with would work. It's simply not designed that
> way.
> 
> I think the closest I might have come was to purposely break the build
> if more then 1 was select, but that still didn't stop you from making
> the selection.
> 
> If someone smarter than me has a way to do (not just an idea...I received
> lots of ideas but none of them worked), I'd be happy to hear it.

I am definitively not a Kbuild expert, but it would almost necessarily
require introduce some kind of new type in the Kconfig/Kbuild syntax
that does something like that:

- have a way to count the number of symbols that are selected and do a
"if ARCH_MULTI_V6_V7" (or an arbitrary expression) this most likely
should exist internally within Kconfig

- introduce a new type of Kconfig type which is a "count", and gets
assigned this value that we just counted, something that could look like
this:

count ARCH_MULTI_V6_V7_COUNT
	tracks ARCH_MULTI_V6_V7

All other typical Kconfig syntax thould then still apply and we could be
doing something like:

depends on ARCH_MULTI_V6_V7_COUNT=1 etc..

So yeah, I am no better than whoever gave you indications better ;)

> 
> 
> 
>> I see value in what you are doing, but I don't think pulling the platforms
>> out of the menu like what you do in the subsequent patch is looking nice
>> as an user/configurator.
> 
> What I was trying to do (and what was already removed from Kconfigs) was
> to avoid having a duplicate set of configs for each SOC: one for single and
> one for multi.
> 
> 
> #I'm trying to get away from manually hacking these Kconfig files every time
> a new kernel is released.

Sure, that makes complete sense to me. FWIW, there is one particular
case that I am interested that you solved which is allowing
DEBUG_UNCOMPRESS to be set in our downstream kernel because we typically
only enable BRCMSTB and nothing else.
-- 
Florian
