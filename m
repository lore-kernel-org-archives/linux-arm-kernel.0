From: ddaney@caviumnetworks.com (David Daney)
Date: Mon, 29 Feb 2016 14:56:55 -0800
Subject: [PATCH v12 3/5] dt, numa: Add NUMA dt binding implementation.
In-Reply-To: <20160229194522.GH31343@rric.localdomain>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-4-git-send-email-ddaney.cavm@gmail.com>
 <20160229172956.GF31343@rric.localdomain>
 <56D48A5C.6040709@caviumnetworks.com>
 <20160229194522.GH31343@rric.localdomain>
Message-ID: <56D4CCB7.2020505@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2016 11:45 AM, Robert Richter wrote:
> On 29.02.16 10:13:48, David Daney wrote:
>> On 02/29/2016 09:29 AM, Robert Richter wrote:
>>> On 22.02.16 17:58:21, David Daney wrote:
>>>> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>>>
>>>> ADD device tree node parsing for NUMA topology using device
>>>> "numa-node-id" property distance-map.
>>>>
>>>> Reviewed-by: Robert Richter <rrichter@cavium.com>
>>>> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>>> Signed-off-by: David Daney <david.daney@cavium.com>
>>>> ---
>>>>   drivers/of/Kconfig   |   3 +
>>>>   drivers/of/Makefile  |   1 +
>>>>   drivers/of/of_numa.c | 211 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   include/linux/of.h   |   9 +++
>>>>   4 files changed, 224 insertions(+)
>>>>   create mode 100644 drivers/of/of_numa.c
>>>>
>>>> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
>>>> index e2a4841..b3bec3a 100644
>>>> --- a/drivers/of/Kconfig
>>>> +++ b/drivers/of/Kconfig
>>>> @@ -112,4 +112,7 @@ config OF_OVERLAY
>>>>   	  While this option is selected automatically when needed, you can
>>>>   	  enable it manually to improve device tree unit test coverage.
>>>>
>>>> +config OF_NUMA
>>>
>>> In arch/arm64/Kconfig you now need to:
>>>
>>> 	select OF_NUMA if NUMA && OF
>>>
>>> This should depend here on OF and NUMA and enabled in that case. Why
>>> moving that to arch code?
>>
>> The dependency on of_numa.o is in the architecture specific code, so that is
>> where the Kconfig select should be too.
>
> If you grep for select in Kconfig files you will see that dependency
> checkers in the form of select ... if ... are very rare.

You are right...

$ find . -name Kconfig | xargs grep -e 'select.*if' | wc -l
1513
$ find . -name Kconfig | xargs grep -e 'select' | wc -l
14179

The 'if' variety is encountered in fewer than 11% of the cases.

That said, I am not sure if this type of statistic should be used to 
evaluate code "goodness".

[...]
>
> But to avoid arch configs in generic Kconfigs, define HAVE_OF_NUMA,
> add it as dependency to OF_NUMA and select it in arch/arm64/Kconfig.
> OF_NUMA is then enabled with defbool y if all requirements are met.
>

Really, what we want is NEEDS_OF_NUMA.  That is exactly what "select 
OF_NUMA" means.

There is no need to build a Rube Goldberg device out of these Kconfig 
things.  The "select OF_NUMA if NUMA && OF" is concise, allowed by the 
Kconfig system and exactly expresses when the file should be compiled.

Unless there are other objections, I am going to use the the Kconfig 
changes in the v12 form.

David.
