From: michael@smart-africa.com (Michael van der Westhuizen)
Date: Thu, 28 May 2015 13:32:10 +0200
Subject: [PATCH] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
In-Reply-To: <20150528101641.GA3657@e103592.cambridge.arm.com>
References: <1432805760-4590-1-git-send-email-michael@smart-africa.com>
 <20150528101641.GA3657@e103592.cambridge.arm.com>
Message-ID: <5D4F3868-BF10-47D9-94C1-A8EDE97621AE@smart-africa.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 28 May 2015, at 12:16 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> 
> On Thu, May 28, 2015 at 11:36:00AM +0200, Michael van der Westhuizen wrote:
>> Fixes the TCM initialisation code to handle TCM banks that are
>> present but inaccessible due to TrustZone configuration.  This is
>> the default case when enabling the non-secure world.  It may also
>> be the case that that the user decided to use TCM for TrustZone.
>> 
>> This change has exposed a bug in handling of TCM where no TCM bank
>> was usable (the 0 size TCM case).  This change addresses the
>> resulting hang.
> 
> The TCM registers in CP15 are not part of the architecture -- behaviour
> is IMP DEF in v7.

My reading of DDI0406C_C is that the register is defined (CP15, c0, c0, 2), but the format is either v6 format or implementation defined.

The manual explicitly states that in v7 the register must be implemented and that when v7 format is used that the meaning of bits 28:0 is implementation defined (this is all in B4.1.132).

The ARM goes on to state that when no TCMs are implemented the TCMTR register must be implemented in ARMv6 format, indicating no TCM banks (i.e. all defined bits must be 0).

So, since this code assumes v6 format should I just add a check that bits 31:29 or 0b000?  If I do this, then my reading is that this will continue to work reliably in the face of v7 implementations that use v7 (implementation defined) format.

Michael

> 
> This is a problem for multiplatform kernels in particular.  In a v6/v7
> multiplatform kernel with a TCM-enabled platform built in, it is
> unsafe to probe for TCM by accessing these registers if we are running
> on v7.  No Undef exception is guaranteed -- anything might happen.
> 
> We could add a DT binding for TCM, but it should only describe whether
> the CP15 TCM registers are accessible (node present in DT) or not (node
> present, but disabled).
> 
> For backwards compatiblity with old DTs we could maybe fall back to
> unconditional probing for single-platform kernels only, when no tcm
> node is present in the DT.
> 
> Cheers
> ---Dave
> 
> [...]
> 
