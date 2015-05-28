From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Thu, 28 May 2015 15:37:16 +0200
Subject: [PATCH] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
In-Reply-To: <20150528133219.GD3657@e103592.cambridge.arm.com>
References: <1432805760-4590-1-git-send-email-michael@smart-africa.com>
 <20150528101641.GA3657@e103592.cambridge.arm.com>
 <5D4F3868-BF10-47D9-94C1-A8EDE97621AE@smart-africa.com>
 <20150528133219.GD3657@e103592.cambridge.arm.com>
Message-ID: <869737C3-AF28-465D-B21A-6BFC0B71562E@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 28 May 2015, at 3:32 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> 
> On Thu, May 28, 2015 at 01:32:10PM +0200, Michael van der Westhuizen wrote:
>> 
>>> On 28 May 2015, at 12:16 PM, Dave Martin <Dave.Martin@arm.com> wrote:
>>> 
>>> On Thu, May 28, 2015 at 11:36:00AM +0200, Michael van der Westhuizen wrote:
>>>> Fixes the TCM initialisation code to handle TCM banks that are
>>>> present but inaccessible due to TrustZone configuration.  This is
>>>> the default case when enabling the non-secure world.  It may also
>>>> be the case that that the user decided to use TCM for TrustZone.
>>>> 
>>>> This change has exposed a bug in handling of TCM where no TCM bank
>>>> was usable (the 0 size TCM case).  This change addresses the
>>>> resulting hang.
>>> 
>>> The TCM registers in CP15 are not part of the architecture -- behaviour
>>> is IMP DEF in v7.
>> 
>> My reading of DDI0406C_C is that the register is defined (CP15, c0,
>> c0, 2), but the format is either v6 format or implementation defined.
>> 
>> The manual explicitly states that in v7 the register must be
>> implemented and that when v7 format is used that the meaning of bits
>> 28:0 is implementation defined (this is all in B4.1.132).
>> 
>> The ARM goes on to state that when no TCMs are implemented the TCMTR
>> register must be implemented in ARMv6 format, indicating no TCM banks
>> (i.e. all defined bits must be 0).
>> 
>> So, since this code assumes v6 format should I just add a check that
>> bits 31:29 or 0b000?  If I do this, then my reading is that this will
>> continue to work reliably in the face of v7 implementations that use
>> v7 (implementation defined) format.
> 
> You're right, that looks sound.

I?ll resend with this check added.

> 
> Providing that TCMTR is read first and reports v6 format, then access
> to the region registers will either succeed safely, or Undef (when
> disallowed by the Secure World).
> 
> TCMTR itself is guaranteed to be readable even in the ARMv6 base
> architecture.
> 
> ARMv8 gives mixed messages on this point[1], but it appears[2] that
> the intention is for the above check to continue to work.
> 
> [1] DDI0487A.e, G6.2.126 (TCMTR, TCM Type Register)
> [2] DDI0487A.e, G3.5 (System register support for IMPLEMENTATION DEFINED
> memory features)
> 
> 
> It would be good to see testing of this in a multiplatform kernel,
> assuming you haven't tried it already.

I?m afraid that I only have one (V6K) board to test against.

Michael

> 
> [...]
> 
> Cheers
> ---Dave
> 
