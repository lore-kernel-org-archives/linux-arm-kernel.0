From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Tue, 13 Mar 2018 18:13:25 +0100
Subject: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
In-Reply-To: <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com>
 <20180313135314.18780-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
Message-ID: <5d3ae760-45bd-3588-500f-1b352e1722de@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ard,

On 13/03/18 17:12, Ard Biesheuvel wrote:
>>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>  {
>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>                                                           &mod->arch.init;
>> +       struct plt_entries *plt;
>> +       int idx;
>>
>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
                                                           ^^^^^^^^^^^ (*)

>> -       int idx = 0;
>> +       /* cache the address, ELF header is available only during module load */
>> +       if (!pltsec->plt_ent)
>> +               pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
>> +       plt = pltsec->plt_ent;
>> +
> Where is plt_ent ever used?

Above is exactly the place it's used.
I need to cache it because after the module load is finished the ELF header is freed,
pltsec->plt pointer (*) is not valid any more.
With the above modification it's possible to call the function during the whole life
time of the module.

>> +       if (!pltsec->plt_count)
>> +               prealloc_fixed(pltsec, plt);

I'll prepare v5 based on your other comments.

-- 
Best regards,
Alexander Sverdlin.
