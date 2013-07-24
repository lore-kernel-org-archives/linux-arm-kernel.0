From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 23 Jul 2013 18:06:05 -0700
Subject: updates for be8 patch series
In-Reply-To: <51EECBBD.20000@codethink.co.uk>
References: <CAA3XUr3h5C0oJVrN5iXsM=NFkLMz_Tssp28CysZfwMNS5KvO-Q@mail.gmail.com>
 <51EEC002.9070808@codethink.co.uk>
 <CAA3XUr2oDEDD6LFjnZ_N0JGTFUMDZG6O9b3JoeJ8AELrK2KDiw@mail.gmail.com>
 <CAA3XUr1BJD-ypfJiEsp079qHDERjGp-xFxc_ke_Ep9z3N=UPaA@mail.gmail.com>
 <51EECBBD.20000@codethink.co.uk>
Message-ID: <CAA3XUr31LAJ3+iWq5gXb+JZO-1G96waOFy-RBVZQEW-djj3dYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Let me split off atomic64 from other issues, so we have focused topic here.

Please see atomic64 issue test case below. Please try it in your setup. I've
run on Pandaboard ES with my set of patches, but I believe it should be the
same in your case.

<snip>

>> Index: linux-linaro-tracking/arch/arm/include/asm/atomic.h
>> ===================================================================
>> --- linux-linaro-tracking.orig/arch/arm/include/asm/atomic.h
>> +++ linux-linaro-tracking/arch/arm/include/asm/atomic.h
>> @@ -301,8 +301,13 @@ static inline void atomic64_add(u64 i, a
>>
>>       __asm__ __volatile__("@ atomic64_add\n"
>>   "1:    ldrexd    %0, %H0, [%3]\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    adds    %0, %0, %4\n"
>>   "    adc    %H0, %H0, %H4\n"
>> +#else
>> +"    adds    %H0, %H0, %H4\n"
>> +"    adc    %0, %0, %4\n"
>> +#endif
>>   "    strexd    %1, %0, %H0, [%3]\n"
>>   "    teq    %1, #0\n"
>>   "    bne    1b"
>> @@ -320,8 +325,13 @@ static inline u64 atomic64_add_return(u6
>>
>>       __asm__ __volatile__("@ atomic64_add_return\n"
>>   "1:    ldrexd    %0, %H0, [%3]\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    adds    %0, %0, %4\n"
>>   "    adc    %H0, %H0, %H4\n"
>> +#else
>> +"    adds    %H0, %H0, %H4\n"
>> +"    adc    %0, %0, %4\n"
>> +#endif
>>   "    strexd    %1, %0, %H0, [%3]\n"
>>   "    teq    %1, #0\n"
>>   "    bne    1b"
>> @@ -341,8 +351,13 @@ static inline void atomic64_sub(u64 i, a
>>
>>       __asm__ __volatile__("@ atomic64_sub\n"
>>   "1:    ldrexd    %0, %H0, [%3]\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    subs    %0, %0, %4\n"
>>   "    sbc    %H0, %H0, %H4\n"
>> +#else
>> +"    subs    %H0, %H0, %H4\n"
>> +"    sbc    %0, %0, %4\n"
>> +#endif
>>   "    strexd    %1, %0, %H0, [%3]\n"
>>   "    teq    %1, #0\n"
>>   "    bne    1b"
>> @@ -360,8 +375,13 @@ static inline u64 atomic64_sub_return(u6
>>
>>       __asm__ __volatile__("@ atomic64_sub_return\n"
>>   "1:    ldrexd    %0, %H0, [%3]\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    subs    %0, %0, %4\n"
>>   "    sbc    %H0, %H0, %H4\n"
>> +#else
>> +"    subs    %H0, %H0, %H4\n"
>> +"    sbc    %0, %0, %4\n"
>> +#endif
>>   "    strexd    %1, %0, %H0, [%3]\n"
>>   "    teq    %1, #0\n"
>>   "    bne    1b"
>> @@ -428,9 +448,15 @@ static inline u64 atomic64_dec_if_positi
>>
>>       __asm__ __volatile__("@ atomic64_dec_if_positive\n"
>>   "1:    ldrexd    %0, %H0, [%3]\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    subs    %0, %0, #1\n"
>>   "    sbc    %H0, %H0, #0\n"
>>   "    teq    %H0, #0\n"
>> +#else
>> +"    subs    %H0, %H0, #1\n"
>> +"    sbc    %0, %0, #0\n"
>> +"    teq    %0, #0\n"
>> +#endif
>>   "    bmi    2f\n"
>>   "    strexd    %1, %0, %H0, [%3]\n"
>>   "    teq    %1, #0\n"
>> @@ -459,8 +485,13 @@ static inline int atomic64_add_unless(at
>>   "    teqeq    %H0, %H5\n"
>>   "    moveq    %1, #0\n"
>>   "    beq    2f\n"
>> +#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
>>   "    adds    %0, %0, %6\n"
>>   "    adc    %H0, %H0, %H6\n"
>> +#else
>> +"    adds    %H0, %H0, %H6\n"
>> +"    adc    %0, %0, %6\n"
>> +#endif
>>   "    strexd    %2, %0, %H0, [%4]\n"
>>   "    teq    %2, #0\n"
>>   "    bne    1b\n"
>
>
> I still believe that you're doing the wrong thing here
> and that these can be left well enough alone. Please give
> a concrete piece of code that can show they're actually
> doing the wrong thing.

Disable CONFIG_GENERIC_ATOMIC64
-------------------------------

Make sure that CONFIG_GENERIC_ATOMIC64 is not set. Otherwise atomic64_add from
lib/atomic64.c will be used and that one works correctly but this case does
not use atomic64_XXX inline functions from arch/arm/include/asm/atomic.h

Personally with my current kernel close to 3.10 I failed to do that and manage
to get live kernel, so to illustrate the issue I will use my own copy of
inline atomic64_add function. But effectively it will show the same problem
that I tried to report.

Compiler used
-------------

gcc-linaro-arm-linux-gnueabihf-4.7-2013.01-20130125_linux

Test module source
------------------

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/atomic.h>

static inline void my_atomic64_add_original(u64 i, atomic64_t *v)
{
    u64 result;
    unsigned long tmp;

    __asm__ __volatile__("@ atomic64_add\n"
"1:    ldrexd    %0, %H0, [%3]\n"
"    adds    %0, %0, %4\n"
"    adc    %H0, %H0, %H4\n"
"    strexd    %1, %0, %H0, [%3]\n"
"    teq    %1, #0\n"
"    bne    1b"
    : "=&r" (result), "=&r" (tmp), "+Qo" (v->counter)
    : "r" (&v->counter), "r" (i)
    : "cc");
}

static inline void my_atomic64_add_fixed(u64 i, atomic64_t *v)
{
    u64 result;
    unsigned long tmp;

    __asm__ __volatile__("@ atomic64_add\n"
"1:    ldrexd    %0, %H0, [%3]\n"
#ifndef CONFIG_CPU_BIG_ENDIAN /* little endian */
"    adds    %0, %0, %4\n"
"    adc    %H0, %H0, %H4\n"
#else
"    adds    %H0, %H0, %H4\n"
"    adc    %0, %0, %4\n"
#endif
"    strexd    %1, %0, %H0, [%3]\n"
"    teq    %1, #0\n"
"    bne    1b"
    : "=&r" (result), "=&r" (tmp), "+Qo" (v->counter)
    : "r" (&v->counter), "r" (i)
    : "cc");
}


atomic64_t a = {0};

#define INCREMENT 0x40000000

void atomic_update_original (void)
{
    my_atomic64_add_original(INCREMENT, &a);
}

void atomic_update_fixed (void)
{
    my_atomic64_add_fixed(INCREMENT, &a);
}

void test_atomic64_original(void)
{
    int i;

    printk("original atomic64_add\n");

    atomic64_set(&a, 0);

    printk("a = %llx\n", a.counter);

    for (i = 0; i < 10; i++) {
        atomic_update_original();
        printk("i = %2d: a =  %llx\n", i, a.counter);
    }
}

void test_atomic64_fixed(void)
{
    int i;

    printk("fixed atomic64_add\n");

    atomic64_set(&a, 0);

    printk("a = %llx\n", a.counter);

    for (i = 0; i < 10; i++) {
        atomic_update_fixed();
        printk("i = %2d: a =  %llx\n", i, a.counter);
    }
}

int
init_module (void)
{
    test_atomic64_original();
    test_atomic64_fixed();
    return 0;
}

void
cleanup_module(void)
{
}

MODULE_LICENSE("GPL");


Test run
--------

Compile and run module, observe in original code counter is not incremented
correctly.

root@genericarmv7ab:~# insmod atomic64.ko
[   73.041107] original atomic64_add
[   73.044647] a = 0
[   73.046691] i =  0: a =  40000000
[   73.050659] i =  1: a =  80000000
[   73.054199] i =  2: a =  c0000000
[   73.057983] i =  3: a =  0
[   73.060852] i =  4: a =  40000000
[   73.064361] i =  5: a =  80000000
[   73.067932] i =  6: a =  c0000000
[   73.071441] i =  7: a =  0
[   73.074310] i =  8: a =  40000000
[   73.077850] i =  9: a =  80000000
[   73.081390] fixed atomic64_add
[   73.084625] a = 0
[   73.086669] i =  0: a =  40000000
[   73.090209] i =  1: a =  80000000
[   73.093749] i =  2: a =  c0000000
[   73.097290] i =  3: a =  100000000
[   73.100891] i =  4: a =  140000000
[   73.104522] i =  5: a =  180000000
[   73.108154] i =  6: a =  1c0000000
[   73.111755] i =  7: a =  200000000
[   73.115386] i =  8: a =  240000000
[   73.119018] i =  9: a =  280000000


Disassemble of original code
----------------------------

(gdb) disassemble atomic_update_original
Dump of assembler code for function atomic_update_original:
   0x00000000 <+0>:    push    {r4}        ; (str r4, [sp, #-4]!)
   0x00000004 <+4>:    mov    r3, #1073741824    ; 0x40000000
   0x00000008 <+8>:    ldr    r12, [pc, #32]    ; 0x30
<atomic_update_original+48>
   0x0000000c <+12>:    mov    r2, #0
   0x00000010 <+16>:    ldrexd    r0, [r12]
   0x00000014 <+20>:    adds    r0, r0, r2
   0x00000018 <+24>:    adc    r1, r1, r3
   0x0000001c <+28>:    strexd    r4, r0, [r12]
   0x00000020 <+32>:    teq    r4, #0
   0x00000024 <+36>:    bne    0x10 <atomic_update_original+16>
   0x00000028 <+40>:    ldmfd    sp!, {r4}
   0x0000002c <+44>:    bx    lr
   0x00000030 <+48>:    andeq    r0, r0, r0
End of assembler dump.

Disassemble of fixed code
-------------------------

(gdb) disassemble atomic_update_fixed
Dump of assembler code for function atomic_update_fixed:
   0x00000034 <+0>:    push    {r4}        ; (str r4, [sp, #-4]!)
   0x00000038 <+4>:    mov    r3, #1073741824    ; 0x40000000
   0x0000003c <+8>:    ldr    r12, [pc, #32]    ; 0x64 <atomic_update_fixed+48>
   0x00000040 <+12>:    mov    r2, #0
   0x00000044 <+16>:    ldrexd    r0, [r12]
   0x00000048 <+20>:    adds    r1, r1, r3
   0x0000004c <+24>:    adc    r0, r0, r2
   0x00000050 <+28>:    strexd    r4, r0, [r12]
   0x00000054 <+32>:    teq    r4, #0
   0x00000058 <+36>:    bne    0x44 <atomic_update_fixed+16>
   0x0000005c <+40>:    ldmfd    sp!, {r4}
   0x00000060 <+44>:    bx    lr
   0x00000064 <+48>:    andeq    r0, r0, r0
End of assembler dump.

Fixed code explanation
----------------------

- $r2 has 4 most significant bytes of increement (0)
- $r3 has 4 least significant bytes of increement (0x40000000)

- Load from address at $r12 'long long' into r0 and r1
  $r0 will get 4 most significant bytes (i.e 4 bytes at $r12)
  $r1 will get 4 least significan bytes (i.e 4 bytes at $r12+4)
  loads are big endian, so $r0 and $r0 will be read with proper be swap

   0x00000044 <+16>:    ldrexd    r0, [r12]

- add $r3 to $r1 store result into $r1, carry flag could be set
- adding 4 least sginificant bytes of 'long long'

   0x00000048 <+20>:    adds    r1, r1, r3

- adding with carry most siginificant parts of increment and counter

   0x0000004c <+24>:    adc    r0, r0, r2

- Store result back
  $r0 will to $r12 address
  $r1 will to $r12+4 address

   0x00000050 <+28>:    strexd    r4, r0, [r12]

Ldrd/strd
---------

Issue boils down to the fact that ldrexd/ldrd and strexd/strd instrucitons
in big endian mode will do byteswap only within 4 bytes boundary, but it will
not swap registers numbers itself. I.e ldrexd rN, <addr> puts swapped 4 bytes
at <addr> address into rN, and it puts swapped 4 bytes at <addr+4> into rN+1

Compiler?
---------

One may thing whether we have compiler bug here. And after all, what is the
meaning of %0 vs %H0? I asked my local gcc expert for the help. Here what
I got. Please look at

https://github.com/mirrors/gcc/blob/master/gcc/config/arm/arm.c

and search for >'Q', 'R' and 'H'<

according to this page '%HN' is always reg+1 operand regardless whether it is
big endian system or not. It is opposite to 'Q'.

Better fix
----------

In fact now I believe correct fix should use 'Q' for least siginificant 4
bytes, 'R' for most siginificant 4 bytes and 'H' is used in load/store
instructions.

It should look something like this:

static inline void my_atomic64_add_fixed1(u64 i, atomic64_t *v)
{
    u64 result;
    unsigned long tmp;

    __asm__ __volatile__("@ atomic64_add\n"
"1:    ldrexd    %0, %H0, [%3]\n"
"    adds    %Q0, %Q0, %Q4\n"
"    adc    %R0, %R0, %R4\n"
"    strexd    %1, %0, %H0, [%3]\n"
"    teq    %1, #0\n"
"    bne    1b"
    : "=&r" (result), "=&r" (tmp), "+Qo" (v->counter)
    : "r" (&v->counter), "r" (i)
    : "cc");
}

It is better that my original fix because it does not have conditional
compilation. I've tested it in the module, it works on both LE and BE kernel
variants.

Thanks,
Victor
