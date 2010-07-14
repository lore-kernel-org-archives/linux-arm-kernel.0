From: eric.miao@canonical.com (Eric Miao)
Date: Wed, 14 Jul 2010 12:32:09 +0800
Subject: [PATCH 08/13] [ARM] Make VMALLOC_END into a global variable if
	not defined
In-Reply-To: <AANLkTilKNo-1EcjwP11SiSj_guOfgmUr3sP9tJwD9iEG@mail.gmail.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
	<1279035208-7249-9-git-send-email-eric.miao@canonical.com>
	<AANLkTin_6kl-VkN1h6PGHXPHOBir9dKsNUeHpiF30nBt@mail.gmail.com>
	<AANLkTik8M5RN-hK8P--rJZ-aPcVzIwSs2xVy4QZUz5M0@mail.gmail.com>
	<AANLkTilKNo-1EcjwP11SiSj_guOfgmUr3sP9tJwD9iEG@mail.gmail.com>
Message-ID: <AANLkTik1l6agzMxl5KAJhMYA7SkCIPFvwPtiTz3jQG3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 12:24 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> On Wed, Jul 14, 2010 at 1:11 PM, Eric Miao <eric.miao@canonical.com> wrote:
>> On Wed, Jul 14, 2010 at 10:57 AM, Kyungmin Park <kmpark@infradead.org> wrote:
>>> Good idea!
>>> Each board can use each own vmalloc_end. no need to bound chip global
>>> vmalloc_end.
>>>
>>> On Wed, Jul 14, 2010 at 12:33 AM, Eric Miao <eric.miao@canonical.com> wrote:
>>>> Signed-off-by: Eric Miao <eric.miao@canonical.com>
>>>> ---
>>>> ?arch/arm/include/asm/mach/arch.h | ? ?1 +
>>>> ?arch/arm/include/asm/pgtable.h ? | ? ?5 +++++
>>>> ?arch/arm/kernel/setup.c ? ? ? ? ?| ? ?6 ++++++
>>>> ?3 files changed, 12 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
>>>> index 52bea4c..2191d40 100644
>>>> --- a/arch/arm/include/asm/mach/arch.h
>>>> +++ b/arch/arm/include/asm/mach/arch.h
>>>> @@ -27,6 +27,7 @@ struct machine_class {
>>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? * page tabe entry ? ? ?*/
>>>> ? ? ? ?const char ? ? ? ? ? ? ?*name; ? ? ? ? ?/* machine class name ? */
>>>> ? ? ? ?unsigned long ? ? ? ? ? boot_params; ? ?/* tagged list ? ? ? ? ?*/
>>>> + ? ? ? unsigned long ? ? ? ? ? vmalloc_end; ? ?/* VMALLOC_END ? ? ? ? ?*/
>>>>
>>>> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*map_io)(void);/* IO mapping function */
>>>> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*init_irq)(void);
>>>> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
>>>> index ab68cf1..478249a 100644
>>>> --- a/arch/arm/include/asm/pgtable.h
>>>> +++ b/arch/arm/include/asm/pgtable.h
>>>> @@ -40,6 +40,11 @@
>>>> ?#define VMALLOC_START ? ? ? ? ?(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
>>>> ?#endif
>>>>
>>>> +#ifndef VMALLOC_END
>>>> +extern unsigned long vmalloc_end;
>>>> +#define VMALLOC_END (vmalloc_end)
>>>> +#endif
>>>> +
>>>> ?/*
>>>> ?* Hardware-wise, we have a two level page table structure, where the first
>>>> ?* level has 4096 entries, and the second level has 256 entries. ?Each entry
>>>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>>>> index 295de99..672a8ec 100644
>>>> --- a/arch/arm/kernel/setup.c
>>>> +++ b/arch/arm/kernel/setup.c
>>>> @@ -95,6 +95,9 @@ EXPORT_SYMBOL(isa_dma_threshold);
>>>> ?unsigned long max_dma_address = 0xffffffffUL;
>>>> ?EXPORT_SYMBOL(max_dma_address);
>>>>
>>>> +unsigned long vmalloc_end = 0xffffffffUL;
>>>> +EXPORT_SYMBOL(vmalloc_end);
>>>
>>> At current code, 0xfe800000UL is the largest number. If we set end
>>> vmalloc_end to 0xffffffffUL and use it. maybe system can't boot.
>>> arch/arm/mach-loki/include/mach/vmalloc.h:#define VMALLOC_END ? 0xfe800000UL
>>>
>>
>> So the platform has to setup vmalloc correct :-)
>>
>>>> +
>>>> ?#ifdef MULTI_CPU
>>>> ?struct processor processor;
>>>> ?#endif
>>>> @@ -684,6 +687,9 @@ void __init setup_arch(char **cmdline_p)
>>>> ? ? ? ?class = mdesc->class;
>>>> ? ? ? ?machine_name = mdesc->name;
>>>>
>>>> + ? ? ? if (class)
>>>> + ? ? ? ? ? ? ? vmalloc_end = class->vmalloc_end;
>>>
>>> Don't check 'if (class->vmalloc_end)'?
>>>
>>
>> Better to check that, but not sure if that's necessary. I'd expect
>> every machine_class to get this correct, instead of leaving it
>> uninitialized (i.e. == 0).
>>
> Then this patch is intermediate patch and VMALLOC_END will be removed finally?
> At first I understand there's global VMALLOC_END on each chip and each
> board can override it.
>

Yes. Currently, each sub-arch defines their own VMALLOC_END in
arch/arm/mach-*/include/mach/vmalloc.h. To move all to use a variable
version of VMALLOC_END would be tedious work and also requires
every sub-arch to have their own 'struct machine_class' ready. So the
idea here is for each sub-arch to:

1) have their 'struct machine_class' ready
2) encode the correct VMALLOC_END value into that
3) remove the definition from vmalloc.h
4) and the variable version will be used

Each sub-arch can do this without affecting others.
