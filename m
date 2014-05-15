From: elder@linaro.org (Alex Elder)
Date: Thu, 15 May 2014 13:17:00 -0500
Subject: [PATCH v3 RESEND 2/5] ARM: add SMP support for Broadcom mobile
 SoCs
In-Reply-To: <CAGVrzca20+3kmJjyGv8Pr-qNNV4n0hhADL6GWvcYVDUL4q28Hg@mail.gmail.com>
References: <1400176691-26058-1-git-send-email-elder@linaro.org>
 <1400176691-26058-3-git-send-email-elder@linaro.org>
 <CAGVrzca20+3kmJjyGv8Pr-qNNV4n0hhADL6GWvcYVDUL4q28Hg@mail.gmail.com>
Message-ID: <5375049C.40104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2014 01:03 PM, Florian Fainelli wrote:
> Hi Alex,
> 
> 2014-05-15 10:58 GMT-07:00 Alex Elder <elder@linaro.org>:
>> This patch adds SMP support for BCM281XX and BCM21664 family SoCs.
>>
>> This feature is controlled with a distinct config option such that a
>> SMP-enabled multi-v7 binary can be configured to run these SoCs in
>> uniprocessor mode.  Since this SMP functionality is used for
>> multiple Broadcom mobile chip families the config option is called
>> ARCH_BCM_MOBILE_SMP (for lack of a better name).
>>
>> On SoCs of this type, the secondary core is not held in reset on
>> power-on.  Instead it loops in a ROM-based holding pen.  To release
>> it, one must write into a special register a jump address whose
>> low-order bits have been replaced with a secondary core's id, then
>> trigger an event with SEV.  On receipt of an event, the ROM code
>> will examine the register's contents, and if the low-order bits
>> match its cpu id, it will clear them and write the value back to the
>> register just prior to jumping to the address specified.
>>
>> The location of the special register is defined in the device tree
>> using a "secondary-boot-reg" property in a node whose "enable-method"
>> matches.
>>
>> Derived from code originally provided by Ray Jui <rjui@broadcom.com>
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>  arch/arm/mach-bcm/Kconfig   |  18 +++-
>>  arch/arm/mach-bcm/Makefile  |   3 +
>>  arch/arm/mach-bcm/platsmp.c | 201 ++++++++++++++++++++++++++++++++++++++++++++
> 
> Could we make that name a little bit more specific to the mobile SoCs?

Sure.  I thought about that but naming stuff here has been a sort
of ongoing struggle...  "Kona" made some sense, in some cases,
but it's not perfect.  Simlar with "mobile."

I'll propose "kona_smp.c".  OK with you?  Unless I get a better
suggestion I'll plan to go with that next time around.

Thanks.

					-Alex

> There are other BCM SoCs either currently supported in this directory
> (BCM5310X), or making their way to be supported (brcmstb, bcm63xx),
> and those share nothing with the Mobile SoC SMP code.
> 
> Maybe we should create another level directory within mach-bcm...
> 
