From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Fri, 9 Mar 2018 09:54:48 +0100
Subject: [PATCH v3 2/2] ARM: ftrace: Add MODULE_PLTS support
In-Reply-To: <CAKv+Gu87oP4Bxn_XkQkc2zf8GXLhoRkWBkUr5N0KMdyMfq1GMg@mail.gmail.com>
References: <20180309084151.2379-1-alexander.sverdlin@nokia.com>
 <20180309084151.2379-3-alexander.sverdlin@nokia.com>
 <CAKv+Gu87oP4Bxn_XkQkc2zf8GXLhoRkWBkUr5N0KMdyMfq1GMg@mail.gmail.com>
Message-ID: <93864477-75bb-3f73-1d06-03d128b04f94@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ard!

On 09/03/18 09:50, Ard Biesheuvel wrote:
>> +static u32 fixed_plts[] = {
>> +       FTRACE_ADDR,
>> +       MCOUNT_ADDR,
>> +#ifdef CONFIG_OLD_MCOUNT
>> +       (unsigned long)ftrace_caller_old,
>> +       (unsigned long)mcount,
>> +#endif
>> +};
>> +
> Do we need this stuff in the PLT loader if ftrace is disabled?

You are right, it probably would not even build w/o FTRACE.
I'll fix it, thanks for looking into this!

>>  static bool in_init(const struct module *mod, unsigned long loc)
>>  {
>>         return loc - (u32)mod->init_layout.base < mod->init_layout.size;
>> @@ -31,26 +41,43 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>>  {
>>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>>                                                           &mod->arch.init;
>> +       int idx;
>> +       struct plt_entries *plt;
>> +
>> +       /* Pre-allocate entries in the first plt */
>> +       if (!pltsec->plt_count) {
>> +               plt = (struct plt_entries *)pltsec->plt->sh_addr;
>> +               for (idx = 0; idx < ARRAY_SIZE(plt->ldr); ++idx)
>> +                       plt->ldr[idx] = PLT_ENT_LDR;
>> +               memcpy(plt->lit, fixed_plts, sizeof(fixed_plts));
>> +               pltsec->plt_count = ARRAY_SIZE(fixed_plts);
>> +               /*
>> +                * cache the address,
>> +                * ELF header is available only during module load
>> +                */
>> +               pltsec->plt_ent = plt;
>> +       }
>> +       plt = pltsec->plt_ent;
>>
>> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
>> -       int idx = 0;
>> +       idx = ARRAY_SIZE(fixed_plts);
>> +       while (idx)
>> +               if (plt->lit[--idx] == val)
>> +                       return (u32)&plt->ldr[idx];
>>
> Same here.

-- 
Best regards,
Alexander Sverdlin.
