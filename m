From: james.morse@arm.com (James Morse)
Date: Mon, 05 Sep 2016 14:03:42 +0100
Subject: [PATCH] arm64: mm: phys_mem_access_prot() reports non-kernel
 memory as device memory
In-Reply-To: <20160905103526.GD2649@arm.com>
References: <1473064984-9494-1-git-send-email-james.morse@arm.com>
 <20160905103526.GD2649@arm.com>
Message-ID: <57CD6D2E.70208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

(CC: Ard and Mark, get_maintainer.pl didn't apply common sense for me...)

On 05/09/16 11:35, Will Deacon wrote:
> On Mon, Sep 05, 2016 at 09:43:03AM +0100, James Morse wrote:
>> Running 'acpidump' on an arm64 system causes the program to SIGSEGV, and
>> yield the following trace:
>> [   71.623572] acpidump[2159]: unhandled alignment fault (11) at 0xffff8a4a909c, esr 0x92000021
>> [   71.632030] pgd = ffff8003ecf7d000
>> [   71.635420] [ffff8a4a909c] *pgd=00000083ec370003, *pud=00000083e7225003, *pmd=00000083ec3f1003, *pte=01600083ff1c3fc3
>> [   71.646042]
>> [   71.647524] CPU: 0 PID: 2159 Comm: acpidump Tainted: G        W I     4.8.0-rc4 #5081
>> [   71.655352] Hardware name: AMD Overdrive/Supercharger/Default string, BIOS ROD1002C 04/08/2016
>> [   71.663957] task: ffff8003eac41900 task.stack: ffff8003e7210000
>> [   71.669871] PC is at 0xffff8a3c77d4
>> [   71.673353] LR is at 0x404934
>> [   71.676314] pc : [<0000ffff8a3c77d4>] lr : [<0000000000404934>] pstate: 00000000
>> [   71.683702] sp : 0000ffffd0e39af0
>>
>> Acpidump digs through /sys/ to find the physical address of the ACPI tables,
>> then reads them from /dev/mem. The code that provides /dev/mem uses
>> phys_mem_access_prot() to determine the protection type it should use.
>>
>> Arm64's phys_mem_access_prot() reports any memory region that isn't part
>> of the linear map as device memory. This breaks Acpidump as the acpi tables
>> are neither device memory nor part of the linear map.
>>
>> Change this check to use memblock_is_memory() instead. On an EFI system
>> any region the efi memory map described as any of WB/WC/WT appears in
>> memblock.memory. On a non-EFI system, setup_machine_fdt() will cause
>> memory nodes in the DT to be added to memblock.memory.
>>
>> /dev/mem is the only user of phys_mem_access_prot()

>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 4989948d1feb..96a2f327fd2c 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -63,7 +63,7 @@ static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>>  			      unsigned long size, pgprot_t vma_prot)
>>  {
>> -	if (!pfn_valid(pfn))
>> +	if (!memblock_is_memory(pfn << PAGE_SHIFT))

> Hmm, this looks pretty weird to me. pfn_valid currently calls
> memblock_is_map_memory, so now we have this slightly paradoxical situation
> of having some memory marked NOMAP but wanting to map it to userspace.

Yup, crazy as it looks, that is what is happening.


> So our abstractions don't seem to align with reality. Why are the ACPI
> tables getting marked as NOMAP to being with?

EFI adds any region we can map as normal memory to memblock.memory, it also adds
anything it considers reserved to the memblock.nomap, e.g. the ACPI tables. This
causes these regions be left out of the linear map.
(I don't know why exactly, but assume its so that the attributes and permissions
can be tweaked easily)

Nomap here means 'not in the linear map'. When we call phys_mem_access_prot(),
or acpi_os_ioremap() we are accessing these pages and want to know the
attributes to map with. For phys_mem_access_prot() 'not in the linear map' means
'device memory', which causes acpidump to crash as it makes unaligned accesses.
(We had similar problems with acpica in the kernel and acpi_os_ioremap(), which
[0] fixes).


Thanks,

James

[0] https://www.spinics.net/lists/arm-kernel/msg525369.html
