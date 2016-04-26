From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 26 Apr 2016 12:02:26 +0100
Subject: [PATCH v2] drivers: firmware: psci: unify enable-method binding
 on ARM {64,32}-bit systems
In-Reply-To: <31757054.8aSO57qemx@wuerfel>
References: <1461338282-19509-1-git-send-email-sudeep.holla@arm.com>
 <571F4632.6090003@arm.com> <31757054.8aSO57qemx@wuerfel>
Message-ID: <571F4AC2.5040502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/04/16 11:49, Arnd Bergmann wrote:
> On Tuesday 26 April 2016 11:42:58 Sudeep Holla wrote:
>> On 22/04/16 16:18, Sudeep Holla wrote:
>>> Currently ARM CPUs DT bindings allows different enable-method value for
>>> PSCI based systems. On ARM 64-bit this property is required and must be
>>> "psci" while on ARM 32-bit systems this property is optional and must
>>> be "arm,psci" if present.
>>>
>>> However, "arm,psci" has always been the compatible string for the PSCI
>>> node, and was never intended to be the enable-method. So this is a bug
>>> in the binding and not a deliberate attempt at specifying 32-bit
>>> differently.
>>>
>>> This is problematic if 32-bit OS is run on 64-bit system which has
>>> "psci" as enable-method rather than the expected "arm,psci".
>>>
>>> So let's unify the value into "psci" and remove support for "arm,psci"
>>> before it finds any users.
>>>
>>> Reported-by: Soby Mathew <Soby.Mathew@arm.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>    Documentation/devicetree/bindings/arm/cpus.txt | 1 -
>>>    drivers/firmware/psci.c                        | 2 +-
>>>    2 files changed, 1 insertion(+), 2 deletions(-)
>>>
>>> v2->v1:
>>>        - Added Mark and Lorenzo's ACKs
>>>        - Updated commit message to specify that it also conflicts with
>>>          PSCI compatible(from Mark's reply on the thread)
>>>
>>> Hi ARM-SoC guys,
>>>
>>> Can you please pick up this single fix for PSCI binding/driver for v4.6 ?
>>>
>>
>> Gentle ping to include this in next round of arm-soc fixes. It would be
>> good to get this fixed before v4.6 as we don't want to have user of the
>> binding which we want to remove in the release.
>>
>
> Applied to the fixes branch. I have to admit that I don't understand
> how the compatible string is really used here, so I have to trust that
> this cannot break any existing machine.
>

No it's not compatible string, it's the enable-method string value. So
far, I don't see any DT in the mainline using "arm,psci" as enable
method. It is indeed the compatible value for PSCI v0.1. Also, the
kernel didn't honor it even if it was present earlier until

Commit 8b6f2499ac45 ("ARM: 8511/1: ARM64: kernel: PSCI: move PSCI idle 
management code to drivers/firmware")

which was introduced in v4.6 and obeyed ARM32 DT bindings but Soby
reported issue when using 64-bit machine to run 32-bit kernel. So it was
good catch at right time. Hence we need to unify the binding though it
was never added intentionally and I assume it a mistake(git blame showed
it was not even reviewed). Luckily it was not used until v4.6, so we are
safe.

-- 
Regards,
Sudeep
