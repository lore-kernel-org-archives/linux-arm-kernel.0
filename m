From: bhe@redhat.com (Baoquan He)
Date: Wed, 28 Nov 2018 07:29:16 +0800
Subject: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
In-Reply-To: <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
 <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
Message-ID: <20181127232916.GG1824@MiWiFi-R3L-srv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/18 at 02:16pm, Kees Cook wrote:
> Why is KERNELOFFSET= not sufficient?
> 
> See commit b6085a865762 ("x86, kaslr: export offset in VMCOREINFO ELF notes")
> 
> +       vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
> +                             (unsigned long)&_text - __START_KERNEL);

KERNELOFFSET is virtual address delta after kernel text KASLR, namely
the offset from the original default kernel text virtual address,
0xffffffff88000000.

While after memory region KASLR in kernel_randomize_memory(), the
starting address of the direct mapping of physical memory, PAGE_OFFSET,
is changed too. We need get it to analyze memory in makedumpfile/crash.
Currently we deduce it from elf program segment of kcore:
Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
......

  LOAD           0x00000a62c0004000 0xffff8a62c0001000 0x0000000000001000
                 0x000000000009c000 0x000000000009c000  RWE    1000

page_offset = 0xffff8a62c0001000 - 0x0000000000001000;
Since we put the direct mapping segments at the bottom part of kcore, we
can always get page_offset right.

Thanks
Baoquan

> 
> -Kees
> 
> >> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> >> index 4c8acdfdc5a7..6161d77c5bfb 100644
> >> --- a/arch/x86/kernel/machine_kexec_64.c
> >> +++ b/arch/x86/kernel/machine_kexec_64.c
> >> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> >>       VMCOREINFO_SYMBOL(init_top_pgt);
> >>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> >>                       pgtable_l5_enabled());
> >> +#ifdef CONFIG_RANDOMIZE_BASE
> >> +     VMCOREINFO_NUMBER(page_offset_base);
> >> +#endif
> >>
> >>  #ifdef CONFIG_NUMA
> >>       VMCOREINFO_SYMBOL(node_data);
> 
> -- 
> Kees Cook
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
