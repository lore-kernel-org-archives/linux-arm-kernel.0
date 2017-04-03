From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Apr 2017 15:32:47 +0200
Subject: Prototype of find_first_zero_bit in bitops.h
In-Reply-To: <41797b5e-1eac-badf-9f44-08eb7adbba65@free.fr>
References: <87371ad9-012b-358d-f186-f8caa79feb0f@free.fr>
 <41797b5e-1eac-badf-9f44-08eb7adbba65@free.fr>
Message-ID: <CAK8P3a3q3RLEyT+vDGjXMqhSj9_JYiDaj28vgT=w13-84TPpHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 3, 2017 at 2:37 PM, Mason <slash.tmp@free.fr> wrote:
> On 29/03/2017 13:54, Mason wrote:>>
>> --- a/arch/arm/include/asm/bitops.h
>> +++ b/arch/arm/include/asm/bitops.h
>> @@ -159,8 +159,8 @@ static inline void ____atomic_change_bit(unsigned int bit, volatile unsigned lon
>>  /*
>>   * Little endian assembly bitops.  nr = 0 -> byte 0 bit 0.
>>   */
>> -extern int _find_first_zero_bit_le(const void * p, unsigned size);
>> -extern int _find_next_zero_bit_le(const void * p, int size, int offset);
>> +extern int _find_first_zero_bit_le(const unsigned long *p, unsigned size);
>> +extern int _find_next_zero_bit_le(const unsigned long *p, int size, int offset);
>>  extern int _find_first_bit_le(const unsigned long *p, unsigned size);
>>  extern int _find_next_bit_le(const unsigned long *p, int size, int offset);
>>
>
> On IRC, Arnd wrote:
>> make find_first_zero_bit() an inline function taking a unsigned long pointer
>> instead of a macro, but leave find_first_zero_bit_le taking a void pointer
>
>
> Can someone point out why the current code handles finding "zero"
> (unset) bits differently than finding "one" (set) bits?
>
> _find_first_bit_le() requires a const unsigned long *p argument.
> _find_first_zero_bit_le() only requires a const void *p argument.

find_first_bit_le appears to be unused, and is only defined on ARM.

> FWIW, using v4.9 with the proposed patch applied, I ran
> make allyesconfig
> make -j24 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage
>
> I did not see a single warning during compilation, although the build
> fails at link-time with:
>
>   LD      vmlinux.o
>   MODPOST vmlinux.o
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
> drivers/built-in.o: In function `alpine_msix_middle_domain_alloc':
> zynq-fpga.c:(.text+0xb8): relocation truncated to fit: R_ARM_CALL against symbol `_raw_spin_lock' defined in .spinlock.text section in kernel/built-in.o
> zynq-fpga.c:(.text+0xf0): relocation truncated to fit: R_ARM_CALL against symbol `_raw_spin_unlock' defined in .spinlock.text section in kernel/built-in.o
...
>
> Which I don't think is related to the bitops prototypes.

It's a known problem. I have an experimental patch that turns on
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION and
CONFIG_THIN_ARCHIVES, which fixes this, but needs to be
refreshed.

Just use 'allmodconfig' for build testing instead of 'allyesconfig'.

       Arnd
