From: keescook@chromium.org (Kees Cook)
Date: Tue, 27 Nov 2018 14:16:25 -0800
Subject: [PATCH v2] x86_64,
 vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
In-Reply-To: <20181121113944.GD27797@zn.tnic>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
Message-ID: <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 3:39 AM, Borislav Petkov <bp@alien8.de> wrote:
> + Kees.
>
> On Fri, Nov 16, 2018 at 03:17:49AM +0530, Bhupesh Sharma wrote:
>> x86_64 kernel uses 'page_offset_base' variable to point to the
>> start of direct mapping of all physical memory. This variable
>> is also updated for KASLR boot cases, so this can be exported
>> via vmcoreinfo as a standard ABI between kernel and user-space,
>> to allow user-space utilities to use the same for calculating
>> the start of direct mapping of all physical memory.

Why is KERNELOFFSET= not sufficient?

See commit b6085a865762 ("x86, kaslr: export offset in VMCOREINFO ELF notes")

+       vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
+                             (unsigned long)&_text - __START_KERNEL);

-Kees

>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 4c8acdfdc5a7..6161d77c5bfb 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
>>       VMCOREINFO_SYMBOL(init_top_pgt);
>>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>>                       pgtable_l5_enabled());
>> +#ifdef CONFIG_RANDOMIZE_BASE
>> +     VMCOREINFO_NUMBER(page_offset_base);
>> +#endif
>>
>>  #ifdef CONFIG_NUMA
>>       VMCOREINFO_SYMBOL(node_data);

-- 
Kees Cook
