From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Tue, 13 Mar 2018 19:28:15 +0100
Subject: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
In-Reply-To: <CAKv+Gu9G9UNf_jif4ySw9iM9mYW_LNzKXyVv7mEAQP_Laaq3UA@mail.gmail.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
 <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com>
 <CAKv+Gu-Z58VseyCQBe_3KqgKn4s9dNBxR8wGyZ7JFrLB=EX8jw@mail.gmail.com>
 <60156300-b74a-628c-d296-7fb71a0eeb4f@nokia.com>
 <CAKv+Gu9G9UNf_jif4ySw9iM9mYW_LNzKXyVv7mEAQP_Laaq3UA@mail.gmail.com>
Message-ID: <ead0216b-d270-dc1f-162e-872ec956c729@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 13/03/18 18:39, Ard Biesheuvel wrote:
>>>>>>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>>>>>  {
>>>>>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>>>>>                                                           &mod->arch.init;
>>>>>> +       struct plt_entries *plt;
>>>>>> +       int idx;
>>>>>>
>>>>>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
>>>>                                                            ^^^^^^^^^^^ (*)
>>>>
>>>>>> -       int idx = 0;
>>>>>> +       /* cache the address, ELF header is available only during module load */
>>>>>> +       if (!pltsec->plt_ent)
>>>>>> +               pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
>>>>>> +       plt = pltsec->plt_ent;
>>>>>> +
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
(*)

>>>>> Where is plt_ent ever used?
>>>> Above is exactly the place it's used.
>>>> I need to cache it because after the module load is finished the ELF header is freed,
>>>> pltsec->plt pointer (*) is not valid any more.
>>>> With the above modification it's possible to call the function during the whole life
>>>> time of the module.
>>>>
>>> Right, ok. That's a problem.
>>>
>>> This means that you are relying on get_module_plt() being called at
>>> least once at module load time, which is not guaranteed.
>> This is indeed guaranteed. For FTRACE use case. If it's being called from FTRACE in
>> run time, this would mean there were long calls in this module section, which in
>> turn means, get_module_plt() was called at least once for this module and this
>> section.
>>
>> This doesn't hold in general, though.
>>
>> In any case, if you insist, I can try to rework the whole stuff implementing module_finalize().
>>
> I think it would be much better to use the module_finalize() hook for
> this, given that it is only called once already, and all the data you
> need is still available.

No problem, but some kind of (*) block would still be required, because
get_module_plt() has to work after module_finalize() as well as *before* it.
So before module_finalize() we would have to dereference pltsec->plt->sh_addr conditionally.
 
> Note that ARM already has such a function, so you'll need to add a
> call there, i.e.,
> 
> if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS))
>     module_plt_alloc_fixed();
> 
> or something like that. The CONFIG_FTRACE dependency can be kept local
> to module-plts.c
> 

-- 
Best regards,
Alexander Sverdlin.
