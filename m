From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 15 Nov 2017 10:35:38 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C0063545@dggemm510-mbs.china.huawei.com>
 (liuwenliang@huawei.com's message of "Wed, 15 Nov 2017 10:20:02
 +0000")
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
 <227e2c6e-f479-849d-8942-1d5ff4ccd440@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063172@dggemm510-mbs.china.huawei.com>
 <8e959f69-a578-793b-6c32-18b5b0cd08c2@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063545@dggemm510-mbs.china.huawei.com>
Message-ID: <87a7znsubp.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15 2017 at 10:20:02 am GMT, "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com> wrote:
> On 09/11/17 18:11, Marc Zyngier [mailto:marc.zyngier at arm.com] wrote:
>>On 09/11/17 07:46, Liuwenliang (Abbott Liu) wrote:
>>> diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
>>> index 049ee0a..359a782 100644
>>> --- a/arch/arm/mm/kasan_init.c
>>> +++ b/arch/arm/mm/kasan_init.c
>>> @@ -15,6 +15,7 @@
>>>  #include <asm/proc-fns.h>
>>>  #include <asm/tlbflush.h>
>>>  #include <asm/cp15.h>
>>> +#include <asm/kvm_hyp.h>
>>
>>No, please don't do that. You shouldn't have to include KVM stuff in
>>unrelated code. Instead of adding stuff to kvm_hyp.h, move all the
>>__ACCESS_CP15* to cp15.h, and it will be obvious to everyone that this
>>is where new definition should be added.
>
> Thanks for your review.  You are right. It is better to move
> __ACCESS_CP15* to cp15.h than to include kvm_hyp.h. But I don't think
> it is a good idea to move registers definition which is used in
> virtualization to cp15.h, Because there is no virtualization stuff in
> cp15.h.

It is not about virtualization at all.

It is about what is a CP15 register and what is not. This file is called
"cp15.h", not "cp15-except-virtualization-and-maybe-some-others.h". But
at the end of the day, that's for Russell to decide.

>
> Here is the code which I tested on vexpress_a15 and vexpress_a9:
> diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
> index dbdbce1..6db1f51 100644
> --- a/arch/arm/include/asm/cp15.h
> +++ b/arch/arm/include/asm/cp15.h
> @@ -64,6 +64,43 @@
>  #define __write_sysreg(v, r, w, c, t)  asm volatile(w " " c : : "r" ((t)(v)))
>  #define write_sysreg(v, ...)           __write_sysreg(v, __VA_ARGS__)
>
> +#ifdef CONFIG_ARM_LPAE
> +#define TTBR0           __ACCESS_CP15_64(0, c2)
> +#define TTBR1           __ACCESS_CP15_64(1, c2)
> +#define PAR             __ACCESS_CP15_64(0, c7)
> +#else
> +#define TTBR0           __ACCESS_CP15(c2, 0, c0, 0)
> +#define TTBR1           __ACCESS_CP15(c2, 0, c0, 1)
> +#define PAR             __ACCESS_CP15(c7, 0, c4, 0)
> +#endif

Again: there is no point in not having these register encodings
cohabiting. They are both perfectly defined in the architecture. Just
suffix one (or even both) with their respective size, making it obvious
which one you're talking about.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
