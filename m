From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 11 Mar 2015 16:00:54 +0100
Subject: [PATCH 4/5] arm64/efi: ensure that Image does not cross a 512 MB
 boundary
In-Reply-To: <20150311115028.GD4114@leverpostej>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425380630-3684-5-git-send-email-ard.biesheuvel@linaro.org>
 <20150311115028.GD4114@leverpostej>
Message-ID: <CAKv+Gu_byjCSTHbpg7foeu_74-yjOt_URZpcuxWaxrM+=0ww3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2015 at 12:50, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Ard,
>
> On Tue, Mar 03, 2015 at 11:03:49AM +0000, Ard Biesheuvel wrote:
>> Update the Image placement logic used by the stub to make absolutely
>> sure that Image is placed in such a way that the early init code will
>
> Minor grammatical nits:
>
> s/that Image/that the Image/
>
> s/in such a way that/such that/
>
>> always be able to map it. This means the entire static memory footprint
>> of Image should be inside the same naturally aligned 512 MB region.
>
> s/Image/the Image/
>

ok

>>
>> First of all, the preferred offset of dram_base + TEXT_OFFSET is only
>> suitable if it doesn't result in the Image crossing a 512 MB
>> alignment boundary, which could be the case if dram_base itself
>> is close to the end of a naturally aligned 512 MB region.
>>
>> Also, when moving the kernel Image, we need to verify that the new
>> destination region does not cross a 512 MB alignment boundary either.
>> If that is the case, we retry the allocation with the alignment
>> chosen such that the resulting region will always be suitable.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/efi-stub.c | 38 ++++++++++++++++++++++++++++++++------
>>  1 file changed, 32 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
>> index f5374065ad53..5f8175979be8 100644
>> --- a/arch/arm64/kernel/efi-stub.c
>> +++ b/arch/arm64/kernel/efi-stub.c
>> @@ -22,14 +22,40 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table,
>>                                       efi_loaded_image_t *image)
>>  {
>>       efi_status_t status;
>> -     unsigned long kernel_size, kernel_memsize = 0;
>> +     unsigned long kernel_size, kernel_memsize;
>> +     unsigned long preferred_offset;
>>
>> -     /* Relocate the image, if required. */
>>       kernel_size = _edata - _text;
>> -     if (*image_addr != (dram_base + TEXT_OFFSET)) {
>> -             kernel_memsize = kernel_size + (_end - _edata);
>> -             status = efi_low_alloc(sys_table, kernel_memsize + TEXT_OFFSET,
>> -                                    SZ_2M, reserve_addr);
>> +     kernel_memsize = kernel_size + (_end - _edata);
>> +
>> +     /*
>> +      * The kernel Image should be located as close as possible to the base
>> +      * of system RAM, but must not cross a 512 MB alignment boundary.
>
> It might be better to say "but its static memory footprint must not
> cross a 512MB boundary" or something to that effect, to avoid any
> ambiguity regarding the Image binary vs the runtime memory footprint
> thereof.
>

ok

>> +      */
>> +     preferred_offset = dram_base + TEXT_OFFSET;
>> +     if ((preferred_offset & (SZ_512M - 1)) + kernel_memsize > SZ_512M)
>> +             preferred_offset = round_up(dram_base, SZ_512M) + TEXT_OFFSET;
>> +
>> +     if (*image_addr != preferred_offset) {
>> +             unsigned long alloc_size = kernel_memsize + TEXT_OFFSET;
>
> This could be const.
>

yep

>> +             unsigned long alloc_align = SZ_2M;
>> +
>> +again:
>> +             status = efi_low_alloc(sys_table, alloc_size, alloc_align,
>> +                                    reserve_addr);
>> +
>> +             /*
>> +              * Check whether the new allocation crosses a 512 MB alignment
>> +              * boundary. If so, retry with the alignment set to a power of
>> +              * two upper bound of the allocation size. That is guaranteed
>> +              * to produce a suitable allocation, but may waste more memory.
>> +              */
>> +             if (status == EFI_SUCCESS &&
>> +                 ((*reserve_addr & (SZ_512M - 1)) + alloc_size) > SZ_512M) {
>> +                     efi_free(sys_table, alloc_size, *reserve_addr);
>> +                     alloc_align = roundup_pow_of_two(alloc_size);
>> +                     goto again;
>> +             }
>
> If you move this check after the status != EFI_SUCCESS check below then
> you don't need to check status == EFI_SUCCESS, which would make the
> condition a little more legible.
>

Actually, I was going to drop the goto and put another invocation of
efi_low_alloc() inside the if {} block, that makes it a lot clearer
imo


> Other than those comments this looks sane to me.
>

Thanks
