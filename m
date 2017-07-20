From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 20 Jul 2017 14:07:46 +0200
Subject: [PATCH] powerpc/asm/cacheflush: Cleanup cacheflush function params
In-Reply-To: <87mv7zgwpl.fsf@concordia.ellerman.id.au>
References: <20170720062850.2195-1-matthew.brown.dev@gmail.com>
 <87mv7zgwpl.fsf@concordia.ellerman.id.au>
Message-ID: <CAMuHMdXU-R8kBs_xp7XDK0pnC5fakpghchuEPD8jtEcHLmgyHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 1:43 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Matt Brown <matthew.brown.dev@gmail.com> writes:
>> The cacheflush prototypes currently use start and stop values and each
>> call requires typecasting the address to an unsigned long.
>> This patch changes the cacheflush prototypes to follow the x86 style of
>> using a base and size values, with base being a void pointer.
>>
>> All callers of the cacheflush functions, including drivers, have been
>> modified to conform to the new prototypes.
>>
>> The 64 bit cacheflush functions which were implemented in assembly code
>> (flush_dcache_range, flush_inval_dcache_range) have been translated into
>> C for readability and coherence.

>> --- a/arch/powerpc/include/asm/cacheflush.h
>> +++ b/arch/powerpc/include/asm/cacheflush.h
>> @@ -51,13 +51,13 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
>>   * Write any modified data cache blocks out to memory and invalidate them.
>>   * Does not invalidate the corresponding instruction cache blocks.
>>   */
>> -static inline void flush_dcache_range(unsigned long start, unsigned long stop)
>> +static inline void flush_dcache_range(void *start, unsigned long size)
>>  {
>> -     void *addr = (void *)(start & ~(L1_CACHE_BYTES - 1));
>> -     unsigned long size = stop - (unsigned long)addr + (L1_CACHE_BYTES - 1);
>> +     void *addr = (void *)((u32)start & ~(L1_CACHE_BYTES - 1));
>
> unsigned long would be nicer than u32.

Indeed. That would make this work on ppc64, too.
After which ppc64 has an identical copy (u64 = unsigned long on ppc64) below?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
