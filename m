From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Nov 2017 09:46:08 +0000
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[PATCH_01/11]_Initialize_the_mapp?=
 =?UTF-8?Q?ing_of_KASan_shadow_memory?=
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C0068F12@dggemm510-mbx.china.huawei.com>
References: <8e959f69-a578-793b-6c32-18b5b0cd08c2@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063545@dggemm510-mbs.china.huawei.com>
 <87a7znsubp.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063587@dggemm510-mbs.china.huawei.com>
 <bbf43f92-3d0c-940d-b66b-68f92eb9b282@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C00635F3@dggemm510-mbs.china.huawei.com>
 <87po8ir1kg.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C006371B@dggemm510-mbs.china.huawei.com>
 <87375eqobb.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063816@dggemm510-mbs.china.huawei.com>
 <20171117073556.GB28855@cbox>
 <B8AC3E80E903784988AB3003E3E97330C00638D4@dggemm510-mbs.china.huawei.com>
 <20171118134841.3f6c9183@why.wild-wind.fr.eu.org>
 <B8AC3E80E903784988AB3003E3E97330C0068F12@dggemm510-mbx.china.huawei.com>
Message-ID: <3e7590d7-dca2-335a-581c-94da0caa9475@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/17 07:59, Liuwenliang (Abbott Liu) wrote:
> On Nov 17, 2017  21:49  Marc Zyngier [mailto:marc.zyngier at arm.com]  wrote:
>> On Sat, 18 Nov 2017 10:40:08 +0000
>> "Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com> wrote:
> 
>>> On Nov 17, 2017  15:36 Christoffer Dall [mailto:cdall at linaro.org]  wrote:
>>>> If your processor does support LPAE (like a Cortex-A15 for example),
>>>> then you have both the 32-bit accessors (MRC and MCR) and the 64-bit
>>>> accessors (MRRC, MCRR), and using the 32-bit accessor will simply access
>>>> the lower 32-bits of the 64-bit register.
>>>>
>>>> Hope this helps,
>>>> -Christoffer
>>>
>>> If you know the higher 32-bits of the 64-bits cp15's register is not useful for your system,
>>> then you can use the 32-bit accessor to get or set the 64-bit cp15's register.
>>> But if the higher 32-bits of the 64-bits cp15's register is useful for your system,
>>> then you can't use the 32-bit accessor to get or set the 64-bit cp15's register.
>>>
>>> TTBR0/TTBR1/PAR's higher 32-bits is useful for CPU supporting LPAE.
>>> The following description which comes from ARM(r) Architecture Reference
>>> Manual ARMv7-A and ARMv7-R edition tell us the reason:
>>>
>>> 64-bit TTBR0 and TTBR1 format:
>>> ...
>>> BADDR, bits[39:x] :
>>> Translation table base address, bits[39:x]. Defining the translation table base address width on
>>> page B4-1698 describes how x is defined.
>>> The value of x determines the required alignment of the translation table, which must be aligned to
>>> 2x bytes.
>>>
>>> Abbott Liu: Because BADDR on CPU supporting LPAE may be bigger than max value of 32-bit, so bits[39:32] may
>>> be valid value which is useful for the system.
>>>
>>> 64-bit PAR format
>>> ...
>>> PA[39:12]
>>> Physical Address. The physical address corresponding to the supplied virtual address. This field
>>> returns address bits[39:12].
>>>
>>> Abbott Liu: Because Physical Address on CPU supporting LPAE may be bigger than max value of 32-bit,
>>> so bits[39:32] may be valid value which is useful for the system.
>>>
>>> Conclusion: Don't use 32-bit accessor to get or set TTBR0/TTBR1/PAR on CPU supporting LPAE,
>>> if you do that, your system may run error.
> 
>> That's not really true. You can run an non-LPAE kernel that uses the
>> 32bit accessors an a Cortex-A15 that supports LPAE. You're just limited
>> to 4GB of physical space. And you're pretty much guaranteed to have
>> some memory below 4GB (one way or another), or you'd have a slight
>> problem setting up your page tables.
> 
>>       M.
>> --
>> Without deviation from the norm, progress is not possible.
> 

> Thanks for your review.
> Please don't ask people to limit to 4GB of physical space on CPU
> supporting LPAE, please don't ask people to guaranteed to have some
> memory below 4GB on CPU supporting LPAE.

Please tell me how you enable LPAE if you don't. I've truly curious.
Because otherwise, you should really take a step back and seriously
reconsider what you're writing. Hint: where do you think the page tables
required to enable LPAE will be? How do you even *boot*?

> Why people select CPU supporting LPAE(just like cortex A15)? 
> Because some of people think 4GB physical space is not enough for their 
> system, maybe they want to use 8GB/16GB DDR space.
> Then you tell them that they must guaranteed to have some memory below 4GB,
> just only because you think the code as follow:
> +#define TTBR0           __ACCESS_CP15(c2, 0, c0, 0)
> +#define TTBR1           __ACCESS_CP15(c2, 0, c0, 1)
> +#define PAR             __ACCESS_CP15(c7, 0, c4, 0)
> 
> is better than the code like this:
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
> 
> 
> So,I think the following code: 
> +#ifdef CONFIG_ARM_LPAE
> +#define TTBR0           __ACCESS_CP15_64(0, c2)
> +#define TTBR1           __ACCESS_CP15_64(1, c2)
> +#define PAR             __ACCESS_CP15_64(0, c7)
> +#else
> +#define TTBR0           __ACCESS_CP15(c2, 0, c0, 0)
> +#define TTBR1           __ACCESS_CP15(c2, 0, c0, 1)
> +#define PAR             __ACCESS_CP15(c7, 0, c4, 0)
> +#endif
> 
> is better because it's not necessary to ask people to guaranteed to
> have some memory below 4GB on CPU supporting LPAE. 

NAK.

> If we want to ask people to guaranteed to have some memory below 4GB 
> on CPU supporting LPAE, there need to modify some other code.
> I think it makes the simple problem more complex to modify some other code for this.

At this stage, you've proven that you don't understand the problem at hand.

	M.
-- 
Jazz is not dead. It just smells funny...
