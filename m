From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 4 Aug 2014 12:38:54 +0200
Subject: [PATCH 2/3] arm64: add helper functions to read I-cache attributes
In-Reply-To: <20140804095814.GA3197@leverpostej>
References: <1407140216-22747-1-git-send-email-ard.biesheuvel@linaro.org>
 <1407140216-22747-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140804095814.GA3197@leverpostej>
Message-ID: <CAKv+Gu-so+hGMtMZvPLcarBLVqkpZ9p3hyX4aSwJ9Tr3RFopgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 August 2014 11:58, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Aug 04, 2014 at 09:16:55AM +0100, Ard Biesheuvel wrote:
>> This adds helper functions and #defines to <asm/cachetype.h> to read the
>> line size and the number of sets from the level 1 instruction cache.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/include/asm/cachetype.h | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
>> index 7a2e0762cb40..c0bf1fc3d6a0 100644
>> --- a/arch/arm64/include/asm/cachetype.h
>> +++ b/arch/arm64/include/asm/cachetype.h
>> @@ -39,6 +39,34 @@
>>
>>  extern unsigned long __icache_flags;
>>
>> +#define CCSIDR_EL1_LINESIZE_MASK     0x7
>> +#define CCSIDR_EL1_LINESIZE(x)               (x & CCSIDR_EL1_LINESIZE_MASK)
>
> It's probably worth bracketing x in case these get used elsewhere.
>

OK

>> +#define CCSIDR_EL1_NUMSETS_SHIFT     13
>> +#define CCSIDR_EL1_NUMSETS_MASK              (0x7fff << CCSIDR_EL1_NUMSETS_SHIFT)
>> +#define CCSIDR_EL1_NUMSETS(x) \
>> +     ((x & CCSIDR_EL1_NUMSETS_MASK) >> CCSIDR_EL1_NUMSETS_SHIFT)
>> +
>> +static inline __attribute_const__ u32 icache_get_ccsidr(void)
>> +{
>> +     u32 ccsidr;
>> +
>> +     /* Select L1 I-cache and read its size ID register */
>> +     asm("msr csselr_el1, %x1; isb; mrs %x0, ccsidr_el1"
>> +         : "=r"(ccsidr) : "r"(0x1));
>
> Does GCC provide any guarantee about the upper bits in this case?
>
> Can we not make both values u64 rather than forcing the use of x
> registers within the asm template?
>

Well, this appears to work fine, but making it explicit u64 seems like
the safest option in any case so I am happy to change that.

-- 
Ard.

>> +     return ccsidr;
>> +}
>> +
>> +static inline int icache_get_linesize(void)
>> +{
>> +     return 16 << CCSIDR_EL1_LINESIZE(icache_get_ccsidr());
>> +}
>> +
>> +static inline int icache_get_numsets(void)
>> +{
>> +     return 1 + CCSIDR_EL1_NUMSETS(icache_get_ccsidr());
>> +}
>> +
>>  /*
>>   * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
>>   * permitted in the I-cache.
>> --
>> 1.8.3.2
>>
>>
