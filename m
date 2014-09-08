From: charlebm@gmail.com (Mark Charlebois)
Date: Mon, 8 Sep 2014 11:35:47 -0700
Subject: [PATCH] arm64: LLVMLinux: Fix inline arm64 assembly for use with
 clang
In-Reply-To: <20140908105307.GF26030@arm.com>
References: <1409959460-15989-1-git-send-email-behanw@converseincode.com>
 <20140908105307.GF26030@arm.com>
Message-ID: <CAFzeTN2Q-RkOeDx4jG5jiEtiN7i+gkfmyvBC1b3B1wpDPUDdxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I compile

int main()
{
        u64 foo, tmp;

        // This works for both clang and gcc
        asm volatile(
        "       mrs     %0, mair_el1\n"
        "       bfi     %0, %1, %2, #8\n"
        "       msr     mair_el1, %0\n"
        "       isb\n"
        : "=&r" (tmp)
        : "r" (foo), "i" (MT_NORMAL * 8));
}

with clang I get:

00000000004004f0 <main>:
  4004f0: d538a208 mrs x8, mair_el1
  4004f4: b3601d08 bfi x8, x8, #32, #8
  4004f8: d518a208 msr mair_el1, x8
  4004fc: d5033fdf isb
  400500: 2a1f03e0 mov w0, wzr
  400504: d65f03c0 ret

When I compile it with GCC I get:

0000000000400510 <main>:
  400510: d10043ff sub sp, sp, #0x10
  400514: f94003e1 ldr x1, [sp]
  400518: d538a200 mrs x0, mair_el1
  40051c: b3601c20 bfi x0, x1, #32, #8
  400520: d518a200 msr mair_el1, x0
  400524: d5033fdf isb
  400528: f90007e0 str x0, [sp,#8]
  40052c: 910043ff add sp, sp, #0x10
  400530: d65f03c0 ret

When I compile

int main()
{
        u64 foo, tmp;

       // This fails for clang but not gcc
        asm volatile(
        "       mrs     %0, mair_el1\n"
        "       bfi     %0, %1, #%2, #8\n"
        "       msr     mair_el1, %0\n"
        "       isb\n"
        : "=&r" (tmp)
        : "r" (foo), "i" (MT_NORMAL * 8));
}

Clang fails and GCC generates:

00000000004004f0 <main>:
  4004f0: d538a208 mrs x8, mair_el1
  4004f4: b3601d08 bfi x8, x8, #32, #8
  4004f8: d518a208 msr mair_el1, x8
  4004fc: d5033fdf isb
  400500: 2a1f03e0 mov w0, wzr
  400504: d65f03c0 ret

On Mon, Sep 8, 2014 at 3:53 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Sep 06, 2014 at 12:24:20AM +0100, behanw at converseincode.com wrote:
>> From: Mark Charlebois <charlebm@gmail.com>
>>
>> Fix variable types for 64-bit inline assembly.
>>
>> This patch now works with both gcc and clang.
>
> Really? This looks like something the clang needs to do better on, as I
> really don't see people adding these casts to future code. They're ugly and
> redundant (or GCC).
>
> This hunk:
>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index c555672..6894ef3 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -94,7 +94,7 @@ static int __init early_cachepolicy(char *p)
>>        */
>>       asm volatile(
>>       "       mrs     %0, mair_el1\n"
>> -     "       bfi     %0, %1, #%2, #8\n"
>> +     "       bfi     %0, %1, %2, #8\n"
>>       "       msr     mair_el1, %0\n"
>>       "       isb\n"
>>       : "=&r" (tmp)
>
> also looks fishy. Does gas accept that without the '#' prefix?
>
> Will
