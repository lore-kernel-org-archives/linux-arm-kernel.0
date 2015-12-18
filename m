From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 18 Dec 2015 11:29:18 +0000
Subject: [PATCH 2/2] irqchip/gic: Identify and report any reserved SGI IDs
In-Reply-To: <20151218073956.0622f8bf@why.wild-wind.fr.eu.org>
References: <1450285686-844-1-git-send-email-daniel.thompson@linaro.org>
 <1450285686-844-3-git-send-email-daniel.thompson@linaro.org>
 <5671A39D.9000500@arm.com> <20151217192610.GA16577@wychelm.lan>
 <20151218073956.0622f8bf@why.wild-wind.fr.eu.org>
Message-ID: <5673EE0E.6090500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/15 07:39, Marc Zyngier wrote:
>>> On 16/12/15 17:08, Daniel Thompson wrote:
>>>> It is possible for the secure world to reserve certain SGI IDs for itself.
>>>> Currently we have limited visibility of which IDs are safe to use for IPIs.
>>>>
>>>> Modify the GIC initialization code to actively search for reserved SGI IDs
>>>> and report if any are found. Warn even more loudly if the reserved SGIs
>>>> overlap with the normal IPI range.
>>>>
>>>> When run on an Inforce IFC6410 (Snapdragon 600) this code produces the
>>>> following messages:
>>>> ~~~ cut here ~~~
>>>> CPU0: Detected reserved SGI IDs: 14-15
>>>> CPU1: Detected reserved SGI IDs: 15
>>>> CPU2: Detected reserved SGI IDs: 15
>>>> CPU3: Detected reserved SGI IDs: 15
>>>> ~~~ cut here ~~~
>>>>
>>>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
...

>>> Another thing to consider is that these locations are only defined on
>>> GICv2 and not GICv1, so this patch is likely to cause trouble on older HW.
>>
>> As presented the code relies on the RAZ/WI property of reserved
>> registers to avoid issues on GICv1; it does not report anything if there
>> appear to be know working SGIs on the assumption we are actually running
>> on a GICv1.
>>
>> You'd prefer an explicit version check?
>
> I'd rather be cautious and check for the architecture version,
> specially if you settle for the byte access mentioned above (a GICv1
> may not support byte access and explode unexpectedly). ICPIDR2.ArchRev
> should be the right thing to check.

Will do.


>>>> +
>>>> +			/* record original value */
>>>> +			pending = readl_relaxed(set_reg);
>>>> +
>>>> +			/* clear, test, set, and test again */
>>>> +			writel_relaxed(mask, clear_reg);
>>>> +			after_clear = readl_relaxed(set_reg);
>>>> +			writel_relaxed(mask, set_reg);
>>>> +			after_set = readl_relaxed(set_reg);
>>>
>>> It should be enough to write to the SET register, and read back, as the
>>> bit is RAZ/WI when the interrupt is Group-0.
>>
>> Good point. Will simplify.
>
> I'd also suggest moving the whole thing to a separate function that'd
> get called from gic_cpu_init().

Will do.

I think I will also upgrade the pr_crit() to a WARN_ON() and hard code 
the check to 8 rather than NR_IPI.

Currently NR_IPI is small on arm64 so it would be good for us to shout 
loudly about latent firmware/secure-zone misconfiguration.


Daniel.
