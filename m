From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Fri, 15 Nov 2013 11:24:17 -0800
Subject: [PATCH v2] ARM: signal: fix armv7-m build issue in
 sigreturn_codes.S
In-Reply-To: <20131115190330.GD4028@e103592.cambridge.arm.com>
References: <1384325867-5140-1-git-send-email-victor.kamensky@linaro.org>
 <20131115190330.GD4028@e103592.cambridge.arm.com>
Message-ID: <CAA3XUr0D=6Vo--HojBSw_R9ROWH6LqXs3SUSkyu0DszNr-Ev5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Thank you for looking into this.

On 15 November 2013 11:03, Dave Martin <Dave.Martin@arm.com> wrote:
> On Tue, Nov 12, 2013 at 10:57:46PM -0800, Victor Kamensky wrote:
>> Hi,
>>
>> Here is version 2 of fix to armv7-m build failure in sigreturn_codes.S.
>> It is based on Dave's suggestion on [1]. Basically it set
>> arch to arm4t explicitly if CONFIG_CPU_THUMBONLY is set.
>> That enables both arm and thumb opcodes and code merged with
>> the rest of image.
>>
>> Version 1 [2] used conditional compilation.
>>
>> Fix was tested
>>    linux-next with efm32_defconfig build (along with few other fixes)
>>    rmk-next BE/LE arndale build/boot and LTP rt_sigaction0? tests run
>>
>> Dave, I've added your name with Suggested-by tag, please
>> let me know if it is not OK with you, I'll remove it then.
>>
>> Uwe, is it possible for you to test that this fix runs on
>> efm32? Sorry, for multiple requests.
>>
>> To address concern about fragility of proposed solution
>> I looked binutils bfd/elf32-arm.c
>>
>>   https://sourceware.org/git/?p=binutils.git;a=blob;f=bfd/elf32-arm.c;h=5af1643bf506870e741ee4da7bd645083619e16d;hb=HEAD
>>
>> Attributes merge deals with couple things:
>>
>> Tag_CPU_arch: tag_cpu_arch_combine function deals with it
>> and from its tables it seems that v4t is compatible with
>> any latter version and resulting value will come from
>> latter version. I.e v4t and v7 (v7m) would merge fine.
>>
>> Tag_CPU_arch_profile: since in case of '.arch armv4t'
>> profile attribute is not generated it is merged fine
>> with any other profile. Unlike in case of
>> '.arch armv7a' and '.arch armv7m' profile values would
>> be 'Application' and 'Microcontroller' and those
>> conflict.
>>
>> Above logic seems to be universal, so other linkers
>> may follow it too. So it seems it is good to use
>> '.arch armv4t' with armv7m code.
>
> [Apologies if you already saw a reply to this.  I was writing one
> previously, but I think I never finished it.  Anyway, here it is...]
>
> After thinking about this, I'm not sure that this logic is really sound.
>
> By allowing v7M objects to be linked together with ARM objects, ld
> creates objects with nonsensical attributes:
>
> File Attributes
>   Tag_CPU_name: "7-M"
>   Tag_CPU_arch: v7
>   Tag_CPU_arch_profile: Microcontroller
>   Tag_ARM_ISA_use: Yes
>   Tag_THUMB_ISA_use: Thumb-2
>
> i.e., a object cannot really be compatible with the microcontroller
> profile and also contain ARM instructions.  v7-M is absolutely not a
> superset of v4T.
>
>
> So, I think we are getting lucky here, and there's no real reason why
> a different linker (or future versions of GNU ld) should allow this.
>
> The alternative is to use #ifdefs, and replace the ARM instructions and
> associates directives with suitable .space directives or nops in the ARM
> case.
>
> This brings us back closer to your original suggestion, I guess.

I am OK with this. What are the next steps then?

Should we continue review of [1]? If you could take a look at would
be great. Or should I resubmit the same patches as V3?
[1] was already tested on armv7m by Uwe.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/210393.html

Thanks,
Victor

>
> Cheers
> ---Dave
