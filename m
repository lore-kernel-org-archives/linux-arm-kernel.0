From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Nov 2016 15:19:58 +0000
Subject: [PATCH v2 2/3] efi/libstub: add random.c to ARM build
In-Reply-To: <2189664.D28O3TYR8x@wuerfel>
References: <1476962486-18368-1-git-send-email-ard.biesheuvel@linaro.org>
 <1476962486-18368-3-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_=et=2zHBTYOr9thz2kS0cXHHYg96oWGRdD3D10fqXtw@mail.gmail.com>
 <2189664.D28O3TYR8x@wuerfel>
Message-ID: <CAKv+Gu-=sdp6Mz75NpeAxmBnnHVtgT3waDTm7R=MdmKyqMr94g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2016 at 15:11, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, November 2, 2016 9:37:13 AM CET Ard Biesheuvel wrote:
>> @@ -98,7 +100,7 @@
>>                 efi_memory_desc_t *md = (void *)memory_map + map_offset;
>>                 unsigned long slots;
>>
>> -               slots = get_entry_num_slots(md, size, align);
>> +               slots = get_entry_num_slots(md, size, ilog2(align));
>>                 MD_NUM_SLOTS(md) = slots;
>>                 total_slots += slots;
>>         }
>> """
>>
>> This is because ARM does not have a division routine in the
>> decompressor, and the fact that the division by 'align' should always
>> involve a power of 2 is not visible to the compiler.
>>
>> If nobody objects, I will fold this in when applying
>>
>>
>
> I'm getting a link error here when building with -Os:
>
> drivers/firmware/efi/libstub/random.stub.o: In function `efi_random_alloc':
> random.c:(.text.efi_random_alloc+0x264): undefined reference to `__aeabi_llsr'
>
> If I compile this with -O2, the ilog2 gets inlined and everything
> works.
>

This is caused by the fact that 'start' and 'end are u64 rather than
unsigned long, and the stub does not have the u64 logical shift right
routines.
But interestingly, it does cover another issue with this code, i.e.,
that you cannot do allocations over 4 GB in the ARM stub, even on LPAE
capable hardware.

I will send out a patch to fix this.

Thanks,
Ard.
