From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 25 Jun 2018 12:52:44 +0200
Subject: [PATCH v8 3/6] module: use relative references for __ksymtab
 entries
In-Reply-To: <CAB0TPYHrx=tcOmzT2_4QpDG-reSJVX3BYEZcH0-X1m30WEADNw@mail.gmail.com>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <20180311123815.17916-4-ard.biesheuvel@linaro.org>
 <CAB0TPYGd1jQzgc2q+fJZif4LVQTPnOrD4b6w0YSAzgAB0oL86g@mail.gmail.com>
 <CAKv+Gu-M4vJfppfQ8PYv3hFR6a1FuOAEKpvyisYSZBe-ubMvHQ@mail.gmail.com>
 <CAB0TPYHrx=tcOmzT2_4QpDG-reSJVX3BYEZcH0-X1m30WEADNw@mail.gmail.com>
Message-ID: <CAKv+Gu-vmYxsEh-yRJqntWKqSimkCKzFYEqHhSoQLnbp=HuSaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 June 2018 at 12:15, Martijn Coenen <maco@android.com> wrote:
> On Mon, Jun 25, 2018 at 11:14 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> Because struct kernel_symbol is only 8 bytes in size after this
>> change, and aligning a 8 byte quantity to 16 bytes wastes 8 bytes.
>
> I get that, but then that means the 16-byte alignment wasn't actually
> necessary in the first place.
>

Not really, I suppose, although it is not unusual to align large
arrays to the entry size if it is a power of 2, so they don't span
cachelines.

>> The x86 ABI may require it, but we don't actually adhere to it in the
>> kernel. Also, these structures never occur on the stack anyway.
>
> Ok, makes sense.
>
> Thanks,
> Martijn
>
>>
>>
>>>> -#include <asm-generic/export.h>
>>>> diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
>>>> index 719db1968d81..97ce606459ae 100644
>>>> --- a/include/asm-generic/export.h
>>>> +++ b/include/asm-generic/export.h
>>>> @@ -5,12 +5,10 @@
>>>>  #define KSYM_FUNC(x) x
>>>>  #endif
>>>>  #ifdef CONFIG_64BIT
>>>> -#define __put .quad
>>>>  #ifndef KSYM_ALIGN
>>>>  #define KSYM_ALIGN 8
>>>>  #endif
>>>>  #else
>>>> -#define __put .long
>>>>  #ifndef KSYM_ALIGN
>>>>  #define KSYM_ALIGN 4
>>>>  #endif
>>>> @@ -25,6 +23,16 @@
>>>>  #define KSYM(name) name
>>>>  #endif
>>>>
>>>> +.macro __put, val, name
>>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>>> +       .long   \val - ., \name - .
>>>> +#elif defined(CONFIG_64BIT)
>>>> +       .quad   \val, \name
>>>> +#else
>>>> +       .long   \val, \name
>>>> +#endif
>>>> +.endm
>>>> +
>>>>  /*
>>>>   * note on .section use: @progbits vs %progbits nastiness doesn't matter,
>>>>   * since we immediately emit into those sections anyway.
>>>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>>>> index ab4711c63601..0a9328ea9dbd 100644
>>>> --- a/include/linux/compiler.h
>>>> +++ b/include/linux/compiler.h
>>>> @@ -280,6 +280,25 @@ unsigned long read_word_at_a_time(const void *addr)
>>>>
>>>>  #endif /* __KERNEL__ */
>>>>
>>>> +/*
>>>> + * Force the compiler to emit 'sym' as a symbol, so that we can reference
>>>> + * it from inline assembler. Necessary in case 'sym' could be inlined
>>>> + * otherwise, or eliminated entirely due to lack of references that are
>>>> + * visible to the compiler.
>>>> + */
>>>> +#define __ADDRESSABLE(sym) \
>>>> +       static void * const __attribute__((section(".discard"), used))  \
>>>> +               __PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
>>>> +
>>>> +/**
>>>> + * offset_to_ptr - convert a relative memory offset to an absolute pointer
>>>> + * @off:       the address of the 32-bit offset value
>>>> + */
>>>> +static inline void *offset_to_ptr(const int *off)
>>>> +{
>>>> +       return (void *)((unsigned long)off + *off);
>>>> +}
>>>> +
>>>>  #endif /* __ASSEMBLY__ */
>>>>
>>>>  #ifndef __optimize
>>>> diff --git a/include/linux/export.h b/include/linux/export.h
>>>> index 25005b55b079..04c78e6bfec9 100644
>>>> --- a/include/linux/export.h
>>>> +++ b/include/linux/export.h
>>>> @@ -24,12 +24,6 @@
>>>>  #define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
>>>>
>>>>  #ifndef __ASSEMBLY__
>>>> -struct kernel_symbol
>>>> -{
>>>> -       unsigned long value;
>>>> -       const char *name;
>>>> -};
>>>> -
>>>>  #ifdef MODULE
>>>>  extern struct module __this_module;
>>>>  #define THIS_MODULE (&__this_module)
>>>> @@ -60,17 +54,47 @@ extern struct module __this_module;
>>>>  #define __CRC_SYMBOL(sym, sec)
>>>>  #endif
>>>>
>>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>>> +#include <linux/compiler.h>
>>>> +/*
>>>> + * Emit the ksymtab entry as a pair of relative references: this reduces
>>>> + * the size by half on 64-bit architectures, and eliminates the need for
>>>> + * absolute relocations that require runtime processing on relocatable
>>>> + * kernels.
>>>> + */
>>>> +#define __KSYMTAB_ENTRY(sym, sec)                                      \
>>>> +       __ADDRESSABLE(sym)                                              \
>>>> +       asm("   .section \"___ksymtab" sec "+" #sym "\", \"a\"  \n"     \
>>>> +           "   .balign 8                                       \n"     \
>>>> +           VMLINUX_SYMBOL_STR(__ksymtab_##sym) ":              \n"     \
>>>> +           "   .long " VMLINUX_SYMBOL_STR(sym) "- .            \n"     \
>>>> +           "   .long " VMLINUX_SYMBOL_STR(__kstrtab_##sym) "- .\n"     \
>>>> +           "   .previous                                       \n")
>>>> +
>>>> +struct kernel_symbol {
>>>> +       int value_offset;
>>>> +       int name_offset;
>>>> +};
>>>> +#else
>>>> +#define __KSYMTAB_ENTRY(sym, sec)                                      \
>>>> +       static const struct kernel_symbol __ksymtab_##sym               \
>>>> +       __attribute__((section("___ksymtab" sec "+" #sym), used))       \
>>>> +       = { (unsigned long)&sym, __kstrtab_##sym }
>>>> +
>>>> +struct kernel_symbol {
>>>> +       unsigned long value;
>>>> +       const char *name;
>>>> +};
>>>> +#endif
>>>> +
>>>>  /* For every exported symbol, place a struct in the __ksymtab section */
>>>>  #define ___EXPORT_SYMBOL(sym, sec)                                     \
>>>>         extern typeof(sym) sym;                                         \
>>>>         __CRC_SYMBOL(sym, sec)                                          \
>>>>         static const char __kstrtab_##sym[]                             \
>>>> -       __attribute__((section("__ksymtab_strings"), aligned(1)))       \
>>>> +       __attribute__((section("__ksymtab_strings"), used, aligned(1))) \
>>>>         = VMLINUX_SYMBOL_STR(sym);                                      \
>>>> -       static const struct kernel_symbol __ksymtab_##sym               \
>>>> -       __used                                                          \
>>>> -       __attribute__((section("___ksymtab" sec "+" #sym), used))       \
>>>> -       = { (unsigned long)&sym, __kstrtab_##sym }
>>>> +       __KSYMTAB_ENTRY(sym, sec)
>>>>
>>>>  #if defined(__DISABLE_EXPORTS)
>>>>
>>>> diff --git a/kernel/module.c b/kernel/module.c
>>>> index ad2d420024f6..b4782cfbb79b 100644
>>>> --- a/kernel/module.c
>>>> +++ b/kernel/module.c
>>>> @@ -549,12 +549,30 @@ static bool check_symbol(const struct symsearch *syms,
>>>>         return true;
>>>>  }
>>>>
>>>> +static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
>>>> +{
>>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>>> +       return (unsigned long)offset_to_ptr(&sym->value_offset);
>>>> +#else
>>>> +       return sym->value;
>>>> +#endif
>>>> +}
>>>> +
>>>> +static const char *kernel_symbol_name(const struct kernel_symbol *sym)
>>>> +{
>>>> +#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
>>>> +       return offset_to_ptr(&sym->name_offset);
>>>> +#else
>>>> +       return sym->name;
>>>> +#endif
>>>> +}
>>>> +
>>>>  static int cmp_name(const void *va, const void *vb)
>>>>  {
>>>>         const char *a;
>>>>         const struct kernel_symbol *b;
>>>>         a = va; b = vb;
>>>> -       return strcmp(a, b->name);
>>>> +       return strcmp(a, kernel_symbol_name(b));
>>>>  }
>>>>
>>>>  static bool find_symbol_in_section(const struct symsearch *syms,
>>>> @@ -2198,7 +2216,7 @@ void *__symbol_get(const char *symbol)
>>>>                 sym = NULL;
>>>>         preempt_enable();
>>>>
>>>> -       return sym ? (void *)sym->value : NULL;
>>>> +       return sym ? (void *)kernel_symbol_value(sym) : NULL;
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(__symbol_get);
>>>>
>>>> @@ -2228,10 +2246,12 @@ static int verify_export_symbols(struct module *mod)
>>>>
>>>>         for (i = 0; i < ARRAY_SIZE(arr); i++) {
>>>>                 for (s = arr[i].sym; s < arr[i].sym + arr[i].num; s++) {
>>>> -                       if (find_symbol(s->name, &owner, NULL, true, false)) {
>>>> +                       if (find_symbol(kernel_symbol_name(s), &owner, NULL,
>>>> +                                       true, false)) {
>>>>                                 pr_err("%s: exports duplicate symbol %s"
>>>>                                        " (owned by %s)\n",
>>>> -                                      mod->name, s->name, module_name(owner));
>>>> +                                      mod->name, kernel_symbol_name(s),
>>>> +                                      module_name(owner));
>>>>                                 return -ENOEXEC;
>>>>                         }
>>>>                 }
>>>> @@ -2280,7 +2300,7 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
>>>>                         ksym = resolve_symbol_wait(mod, info, name);
>>>>                         /* Ok if resolved.  */
>>>>                         if (ksym && !IS_ERR(ksym)) {
>>>> -                               sym[i].st_value = ksym->value;
>>>> +                               sym[i].st_value = kernel_symbol_value(ksym);
>>>>                                 break;
>>>>                         }
>>>>
>>>> @@ -2540,7 +2560,7 @@ static int is_exported(const char *name, unsigned long value,
>>>>                 ks = lookup_symbol(name, __start___ksymtab, __stop___ksymtab);
>>>>         else
>>>>                 ks = lookup_symbol(name, mod->syms, mod->syms + mod->num_syms);
>>>> -       return ks != NULL && ks->value == value;
>>>> +       return ks != NULL && kernel_symbol_value(ks) == value;
>>>>  }
>>>>
>>>>  /* As per nm */
>>>> --
>>>> 2.15.1
>>>>
