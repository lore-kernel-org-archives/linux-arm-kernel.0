From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Mar 2015 11:54:30 +0100
Subject: [PATCH 2/5] arm64: use fixmap region for permanent FDT mapping
In-Reply-To: <20150311104342.GB4114@leverpostej>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425380630-3684-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150311104342.GB4114@leverpostej>
Message-ID: <CAKv+Gu-=azueQfe29qhCGCe5f4dL9srOSdiAooUpsZHAgAWz0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2015 at 11:43, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> The below is modulo Rob's comments regarding fdt_to_phys and the
> associated memory reservation. I'm not too worried where those live.
>
> On Tue, Mar 03, 2015 at 11:03:47AM +0000, Ard Biesheuvel wrote:
>> Currently, the FDT blob needs to be in the same naturally aligned
>> 512 MB region as the kernel, so that it can be mapped into the
>> kernel virtual memory space very early on using a minimal set of
>> statically allocated translation tables.
>>
>> Now that we have early fixmap support, we can relax this restriction,
>> by moving the permanent FDT mapping to the fixmap region instead.
>> This way, the FDT blob may be anywhere in memory.
>>
>> This also moves the vetting of the FDT to setup.c, since the early
>> init code in head.S does not handle mapping of the FDT anymore.
>
> Nit: s/anymore/any more/
>
>> At the same time, fix up some comments in head.S that have gone stale.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  Documentation/arm64/booting.txt |  7 ++---
>>  arch/arm64/include/asm/fixmap.h |  9 ++++++
>>  arch/arm64/kernel/Makefile      |  1 +
>>  arch/arm64/kernel/head.S        | 38 +------------------------
>>  arch/arm64/kernel/setup.c       | 62 +++++++++++++++++++++++++++++++++++++----
>>  5 files changed, 70 insertions(+), 47 deletions(-)
>>
>> diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
>> index f3c05b5f9f08..bdc35fc97ac8 100644
>> --- a/Documentation/arm64/booting.txt
>> +++ b/Documentation/arm64/booting.txt
>> @@ -45,10 +45,9 @@ sees fit.)
>>
>>  Requirement: MANDATORY
>>
>> -The device tree blob (dtb) must be placed on an 8-byte boundary within
>> -the first 512 megabytes from the start of the kernel image and must not
>> -cross a 2-megabyte boundary. This is to allow the kernel to map the
>> -blob using a single section mapping in the initial page tables.
>> +The device tree blob (dtb) must be placed on an 8-byte boundary and must
>> +not cross a 2-megabyte boundary. This is to allow the kernel to map the
>> +blob using a single section mapping in the fixmap region.
>
> As we do elsewhere in booting.txt I'd prefer that we kept a note
> regarding the restriction expected by older kernels, so bootloader/VM
> authors can do the right thing for those on a best-effort basis.
>

OK

>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -45,6 +45,7 @@
>>  #include <linux/of_platform.h>
>>  #include <linux/efi.h>
>>  #include <linux/personality.h>
>> +#include <linux/libfdt.h>
>
> I was going to say it would be nice to keep these ordered, but I see
> from the rest of the includes that's a foregone hope. Never mind :(
>
> [...]
>
>> +static unsigned long const dt_virt_base = __fix_to_virt(FIX_FDT);
>
> I'd prefer "static const unsigned long".
>
> [...]
>
>>  static void __init setup_machine_fdt(phys_addr_t dt_phys)
>>  {
>> -     if (!dt_phys || !early_init_dt_scan(phys_to_virt(dt_phys))) {
>> +     void *dt_virt = NULL;
>> +
>> +     if (dt_phys && (dt_phys & 7) == 0)
>> +             dt_virt = fixmap_remap_fdt(dt_phys);
>> +
>
> It might be worth checking that dt_phys is sufficiently far from the end
> of a 2MB boundary that we can read the totalsize field below. Trivially
> that means 8 bytes below, the header is 40 bytes, and any real DTB will
> be larger than that.
>

Y i kind of cheated by putting the alignment check first: this means
the first 8 bytes will always be readable


> It's a shame the arley DTB verification functions don't take a limit
> parameter or we could prevent them from making potentially bad accesses.
>
>> +     /*
>> +      * Before passing the dt_virt pointer to early_init_dt_scan(), we have
>> +      * to ensure that the FDT size as reported in the FDT itself does not
>> +      * exceed the 2 MB window we just mapped for it.
>> +      */
>> +     if (!dt_virt ||
>> +         fdt_check_header(dt_virt) != 0 ||
>> +         (dt_phys & (SZ_2M - 1)) + fdt_totalsize(dt_virt) > SZ_2M ||
>> +         !early_init_dt_scan(dt_virt)) {
>>               early_print("\n"
>>                       "Error: invalid device tree blob at physical address 0x%p (virtual address 0x%p)\n"
>> -                     "The dtb must be 8-byte aligned and passed in the first 512MB of memory\n"
>> +                     "The dtb must be 8-byte aligned and must not cross a 2 MB alignment boundary\n"
>>                       "\nPlease check your bootloader.\n",
>> -                     dt_phys, phys_to_virt(dt_phys));
>> +                     dt_phys, dt_virt);
>
> I'm surprised the toolchain doesn't scream about dt_phys being a
> phys_addr_t rather than a pointer here, given that's alway been wrong. I
> guess the early_print wrapper managed to hide that from us -- can we
> nuke that and use pr_crit here?
>

Sure, why not. Nobody is going to be able to read it anyway, I
suppose, unless you are dumping __log_buf from gdb

> With that we'd need to use %pa for the phys_addr_t, passing &dt_phys
> rather than dt_phys.
>
> Other than those points, this looks good to me.
>

Thanks
