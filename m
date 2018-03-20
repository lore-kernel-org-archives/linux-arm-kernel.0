From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Tue, 20 Mar 2018 13:28:45 +0100
Subject: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
In-Reply-To: <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
 <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com>
 <CAKv+Gu-Z58VseyCQBe_3KqgKn4s9dNBxR8wGyZ7JFrLB=EX8jw@mail.gmail.com>
 <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com>
Message-ID: <bc085586-457e-5c0c-181c-0c908ba17c9a@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ard,

On 13/03/18 18:32, Alexander Sverdlin wrote:
>>>>>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>>>>  {
>>>>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>>>>                                                           &mod->arch.init;
>>>>> +       struct plt_entries *plt;
>>>>> +       int idx;
>>>>>
>>>>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
>>>                                                            ^^^^^^^^^^^ (*)
>>>
>>>>> -       int idx = 0;
>>>>> +       /* cache the address, ELF header is available only during module load */
>>>>> +       if (!pltsec->plt_ent)
>>>>> +               pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
>>>>> +       plt = pltsec->plt_ent;
>>>>> +
>>>> Where is plt_ent ever used?
>>> Above is exactly the place it's used.
>>> I need to cache it because after the module load is finished the ELF header is freed,
>>> pltsec->plt pointer (*) is not valid any more.
>>> With the above modification it's possible to call the function during the whole life
>>> time of the module.
>>>
>> Right, ok. That's a problem.
>>
>> This means that you are relying on get_module_plt() being called at
>> least once at module load time, which is not guaranteed.
> This is indeed guaranteed. For FTRACE use case. If it's being called from FTRACE in
> run time, this would mean there were long calls in this module section, which in
> turn means, get_module_plt() was called at least once for this module and this
> section.
> 
> This doesn't hold in general, though.
> 
> In any case, if you insist, I can try to rework the whole stuff implementing module_finalize().

now when I have a new implementation via module_finalize(), I must admit it's not possible to
do it sanely this way.

module_finalize() can only add entries at the end of PLT, which means, they will be different
from the entries module loader/relocator has created before, which means, FTRACE will not
be able to replace these entries with NOPs.
As I don't want to do O(N) search on every dynamic ftrace operation, seems this is not an
option.
Either v4 has to be accepted, or I cannot propose a solution for upstream FTRACE+MODULES_PLT
combination.

-- 
Best regards,
Alexander Sverdlin.
