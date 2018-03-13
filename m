From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Mar 2018 17:18:44 +0000
Subject: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
In-Reply-To: <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
 <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com>
Message-ID: <CAKv+Gu-Z58VseyCQBe_3KqgKn4s9dNBxR8wGyZ7JFrLB=EX8jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2018 at 17:13, Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:
> Hello Ard,
>
> On 13/03/18 17:12, Ard Biesheuvel wrote:
>>>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>>  {
>>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>>                                                           &mod->arch.init;
>>> +       struct plt_entries *plt;
>>> +       int idx;
>>>
>>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
>                                                            ^^^^^^^^^^^ (*)
>
>>> -       int idx = 0;
>>> +       /* cache the address, ELF header is available only during module load */
>>> +       if (!pltsec->plt_ent)
>>> +               pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
>>> +       plt = pltsec->plt_ent;
>>> +
>> Where is plt_ent ever used?
>
> Above is exactly the place it's used.
> I need to cache it because after the module load is finished the ELF header is freed,
> pltsec->plt pointer (*) is not valid any more.
> With the above modification it's possible to call the function during the whole life
> time of the module.
>

Right, ok. That's a problem.

This means that you are relying on get_module_plt() being called at
least once at module load time, which is not guaranteed.

Instead, you should set this member (and perhaps the entire prealloc
routine) in a module_finalize() implementation.

>>> +       if (!pltsec->plt_count)
>>> +               prealloc_fixed(pltsec, plt);
>
> I'll prepare v5 based on your other comments.
>
> --
> Best regards,
> Alexander Sverdlin.
