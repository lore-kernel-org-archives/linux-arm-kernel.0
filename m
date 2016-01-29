From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 29 Jan 2016 10:36:03 +0100
Subject: [PATCH 1/3] arm64: efistub: drop __init annotation from
 handle_kernel_image()
In-Reply-To: <20160128225809.GF2571@codeblueprint.co.uk>
References: <1453979254-25374-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453979254-25374-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160128225809.GF2571@codeblueprint.co.uk>
Message-ID: <CAKv+Gu9sE4oJrFmSK8sEjTrU8A7k53Hj1S1pTyCqyA5Gsba2Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 January 2016 at 23:58, Matt Fleming <matt@codeblueprint.co.uk> wrote:
> On Thu, 28 Jan, at 12:07:32PM, Ard Biesheuvel wrote:
>> After moving arm64-stub.c to libstub/, all of its sections are emitted
>> as .init.xxx sections automatically, and the __init annotation of
>> handle_kernel_image() causes it to end up in .init.init.text, which is
>> not recognized as an __init section by the linker scripts. So drop the
>> annotation.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  drivers/firmware/efi/libstub/arm64-stub.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
>> index 78dfbd34b6bf..9e0342745e4f 100644
>> --- a/drivers/firmware/efi/libstub/arm64-stub.c
>> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
>> @@ -13,13 +13,13 @@
>>  #include <asm/efi.h>
>>  #include <asm/sections.h>
>>
>> -efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
>> -                                     unsigned long *image_addr,
>> -                                     unsigned long *image_size,
>> -                                     unsigned long *reserve_addr,
>> -                                     unsigned long *reserve_size,
>> -                                     unsigned long dram_base,
>> -                                     efi_loaded_image_t *image)
>> +efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
>> +                              unsigned long *image_addr,
>> +                              unsigned long *image_size,
>> +                              unsigned long *reserve_addr,
>> +                              unsigned long *reserve_size,
>> +                              unsigned long dram_base,
>> +                              efi_loaded_image_t *image)
>>  {
>>       efi_status_t status;
>>       unsigned long kernel_size, kernel_memsize = 0;
>> --
>> 2.5.0
>>
>
> Would it make more sense to #undef __init in one of the arm64 efistub
> header files? I'm thinking of the case where some poor unsuspecting
> developer writes a new function and marks it as __init, and we miss it
> during review.
>

Yes, I can add it to efistub.h, and make sure it gets included in all the files

Should we #undef it and #define it to a string that is easily grep'ed
for, so it is easy to find the explanatory comment that goes along
with it?
E.g.,

#define __init __init_not_supported_in_efi_stub

> At least if we do the #undef we can document why __init makes no sense
> in the EFI stub, and at the same time automatically fix things up.
>
> An alternative would be to write some Kbuild magic that complains if
> it sees __init, but that seems like more work than is reasonable.
