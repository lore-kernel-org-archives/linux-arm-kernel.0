From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 6 Mar 2018 16:56:46 +0000
Subject: [PATCH] KVM: arm: reserve bit in KVM_REG_ARM encoding for
 secure/nonsecure
In-Reply-To: <4dbad5e5-8e62-4729-16f3-59ce1cfdd550@arm.com>
References: <20180306162646.7646-1-peter.maydell@linaro.org>
 <4dbad5e5-8e62-4729-16f3-59ce1cfdd550@arm.com>
Message-ID: <CAFEAcA9KYxtUzH+DtUR-zVXeFYeVA1orh-Y7+FkufxNZ6o8ivw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2018 at 16:43, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 06/03/18 16:26, Peter Maydell wrote:
>> +/* For KVM currently all guest registers are nonsecure, but we reserve a bit
>> + * in the encoding to distinguish secure from nonsecure for banked registers.
>> + */
>
> Nit:
>
> /*
>  * This is the canonical comment style.
>  */
>
> It might be worth pointing out in the comment that this only applies to
> AArch32 system registers that are banked by security.

Sure. How about

/*
 * For KVM currently all guest registers are nonsecure, but we reserve a bit
 * in the encoding to distinguish secure from nonsecure for AArch32 system
 * registers that are banked by security. This is 1 for the secure banked
 * register, and 0 for the nonsecure banked register or if the register is
 * not banked by security.
 */

?

>> +#define KVM_REG_ARM_SECURE_MASK      0x0000000010000000
>> +#define KVM_REG_ARM_SECURE_SHIFT     28
>>
>>  #define ARM_CP15_REG_SHIFT_MASK(x,n) \
>>       (((x) << KVM_REG_ARM_ ## n ## _SHIFT) & KVM_REG_ARM_ ## n ## _MASK)
>>
>
> Don't you also need to define it on the arm64 side?

I don't think so, because AArch64 registers aren't security banked
(except for some GICv3 ones, which aren't set via GET/SET_ONE_REG.)
Or is there a case I'm missing?

thanks
-- PMM
