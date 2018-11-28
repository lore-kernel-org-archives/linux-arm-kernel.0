From: bhe@redhat.com (Baoquan He)
Date: Wed, 28 Nov 2018 09:39:49 +0800
Subject: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
In-Reply-To: <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic>
 <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
 <20181127232916.GG1824@MiWiFi-R3L-srv>
 <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
Message-ID: <20181128013949.GH1824@MiWiFi-R3L-srv>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/18 at 04:39pm, Kees Cook wrote:
> >> >> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> >> >> index 4c8acdfdc5a7..6161d77c5bfb 100644
> >> >> --- a/arch/x86/kernel/machine_kexec_64.c
> >> >> +++ b/arch/x86/kernel/machine_kexec_64.c
> >> >> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
> >> >>       VMCOREINFO_SYMBOL(init_top_pgt);
> >> >>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
> >> >>                       pgtable_l5_enabled());
> >> >> +#ifdef CONFIG_RANDOMIZE_BASE
> 
> Okay, gotcha. In that case, shouldn't this be CONFIG_RANDOMIZE_MEMORY?

Currently, Kirill added level5 support to x86_64, and kernel with level5
enabled can be boot switched into level4 or level5 with kernel option
"no5lvl". So page_offset_base will be changed accordingly. You can see
code pasted at bottom, DYNAMIC_MEMORY_LAYOUT is added for this change,
not only KASLR, but 5LEVEL.

If only put it inside ifdef CONFIG_RANDOMIZE_MEMORY, change between l4
and l5 will force us to decide page_offset again if
CONFIG_RANDOMIZE_MEMORY or CONFIG_RANDOMIZE_BASE is not set. Besides, 
below commit change the starting address of the direct mapping again, if
only judge CONFIG_RANDOMIZE_MEMORY, in case KASLR is disabled, code in
userspace may need many if-else checking as below. So if we pass, better
pass it for all.

get_page_offset()
{
	if(get_page_offset_from_vmcoreinfo()) {
		xxx //in KASLR case
		return;
	} else if (check_5level_paging()) {
		if (version < 4.21) {
			page_offset = 0xff10000000000000;
		} else //version > = 4.21
		{
			page_offset = 0xff11000000000000;
		}
		
	} else { //4level
		if (version < 2.6.27) {
			page_offset = 0xffff810000000000;
		} else if (version < 4.21) {
			page_offset = 0xffff880000000000;
		} else //version > = 4.21
		{
			page_offset = 0xffff888000000000,;
		}
	}
}

Sign, seeing above code, I still think that deducing it from
kcore/vmcore elf header is better. Can't we be better to ourselves?

commit d52888aa2753e3063a9d3a0c9f72f94aa9809c15
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Fri Oct 26 15:28:54 2018 +0300

    x86/mm: Move LDT remap out of KASLR region on 5-level paging

[bhe@ linux]$ git describe --contains d52888aa2753e3063a9d3a0c9f72f94aa9809c15
v4.20-rc2~5^2~4


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;                                                                           
EXPORT_SYMBOL(page_offset_base);
unsigned long vmalloc_base __ro_after_init = __VMALLOC_BASE_L4;
EXPORT_SYMBOL(vmalloc_base);
unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
EXPORT_SYMBOL(vmemmap_base);
#endif


config DYNAMIC_MEMORY_LAYOUT                                                                                                                      
        bool
        ---help---
          This option makes base addresses of vmalloc and vmemmap as well as
          __PAGE_OFFSET movable during boot.

config RANDOMIZE_MEMORY
        bool "Randomize the kernel memory sections"
        depends on X86_64
        depends on RANDOMIZE_BASE
        select DYNAMIC_MEMORY_LAYOUT
        default RANDOMIZE_BASE

config X86_5LEVEL
        bool "Enable 5-level page tables support"
        select DYNAMIC_MEMORY_LAYOUT
        select SPARSEMEM_VMEMMAP
        depends on X86_64
