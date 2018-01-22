From: clingutla@codeaurora.org (Chandra Sekhar Lingutla)
Date: Mon, 22 Jan 2018 12:23:10 +0530
Subject: [PATCH] arm64: setup: Check for overlapping dtb and Image load
 addresses
In-Reply-To: <CAKv+Gu-2m+kt6vB5FXsHFwT5DjCk7_rcMRBYxaEG2RMFz7vbGg@mail.gmail.com>
References: <20180119065637.12789-1-clingutla@codeaurora.org>
 <CAKv+Gu-2m+kt6vB5FXsHFwT5DjCk7_rcMRBYxaEG2RMFz7vbGg@mail.gmail.com>
Message-ID: <e5fefb53-aa46-c373-ca68-c59a74b1e30f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/19/2018 7:33 PM, Ard Biesheuvel wrote:
> On 19 January 2018 at 06:56, Lingutla Chandrasekhar
> <clingutla@codeaurora.org> wrote:
>> Sometime kernel image and dtb load offsets can overlap due to
>> dynamically increased Image or dtb size if both load addresses
>> are near to each other, which leads to bootup failures.
>>
>> So validate dtb load address and kernel image, if they overlap
>> do not proceed to boot.
>>
>> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
>>
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 30ad2f085d1f..c9dd699f09ab 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -181,11 +181,17 @@ static void __init smp_build_mpidr_hash(void)
>>   static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>   {
>>          void *dt_virt = fixmap_remap_fdt(dt_phys);
>> +       u64 end_phys = __pa_symbol(_end);
>> +       u64 start_phys = __pa_symbol(_text);
>>          const char *name;
>>
>> -       if (!dt_virt || !early_init_dt_scan(dt_virt)) {
>> +       if (!dt_virt || ((dt_phys < start_phys) &&
>> +               ((dt_phys + fdt_totalsize(dt_virt)) > start_phys)) ||
>> +               ((dt_phys > start_phys) && (dt_phys < end_phys)) ||
>> +               !early_init_dt_scan(dt_virt)) {
>>                  pr_crit("\n"
>>                          "Error: invalid device tree blob at physical address %pa (virtual address 0x%p)\n"
>> +                       "The dtb load address should not overlap with kernel image\n"
>>                          "The dtb must be 8-byte aligned and must not exceed 2 MB in size\n"
>>                          "\nPlease check your bootloader.",
>>                          &dt_phys, dt_virt);
> Paradoxically, this pr_crit() will only ever be able to produce
> readable output if early_init_dt_scan() returns success. If not, no
> early DT parsing will have occurred, and we will have no idea where
> the UART is nor whether earlycon was passed via /chosen/bootargs.
>
> That means adding the check before the call to early_init_dt_scan() is
> not very helpful, since the system will just hang with no output.
>
> If you really want to check for overlap, please do it *after* the
> if(), as a separate WARN_ON() that does not force the boot to fail.
> This has a much higher likelihood of anyone ever reading your error
> message, and being able to do something about it.
If overlap happens, we can't predict the behavior,
ex: in our case, image size increased such that dtb load offset falls 
under bss section,
because of that, initial dtb is been zeroed while clearing the bss 
section, which fails
the early_init_dt_scan() and system hangs there.

In this case, If we put check *after* the if(), it would not be useful 
right?
I think, if we have all check together,? based on PC we could find 
possible failures of system hang.
And if early_init_dt_scan() is success, then we would get overlapped 
bytes (new patchset have this) at pr_crit().
> Also, checking for overlap can be done using two comparisons:
>
> end1 > start2 && end2 > start1
sure, will update.
