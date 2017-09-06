From: brendanhiggins@google.com (Brendan Higgins)
Date: Tue, 5 Sep 2017 17:42:46 -0700
Subject: [PATCH v2 1/3] arm: npcm: add basic support for Nuvoton BMCs
In-Reply-To: <8fd55a57-946d-f53f-e10b-c73d1f70d1dc@gmail.com>
References: <20170831225400.19756-1-brendanhiggins@google.com>
 <20170831225400.19756-2-brendanhiggins@google.com>
 <8fd55a57-946d-f53f-e10b-c73d1f70d1dc@gmail.com>
Message-ID: <CAFd5g45W0jBFe-Uhjv07fxsaxtAbHmxkJU=RQu+qWT=Ohf8s+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the exception of one comment, which I have responded to
below, I have addressed your comments in my new version of
this patch: https://patchwork.kernel.org/patch/9914153/

On Mon, Sep 4, 2017 at 7:47 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
...
>> +
>> +ENTRY(v7_invalidate_l1_npcmX50)
>> +     mov     r0, #0
>> +     mcr     p15, 0, r0, c7, c5, 0 /* invalidate I cache */
>> +     mcr     p15, 2, r0, c0, c0, 0
>> +     mrc     p15, 1, r0, c0, c0, 0
>> +
>> +     ldr     r1, =0x7fff
>> +     and     r2, r1, r0, lsr #13
>> +
>> +     ldr     r1, =0x3ff
>> +
>> +     and     r3, r1, r0, lsr #3 /* NumWays - 1 */
>> +     add     r2, r2, #1         /* NumSets */
>> +
>> +     and     r0, r0, #0x7
>> +     add     r0, r0, #4 /* SetShift */
>> +
>> +     clz     r1, r3     /* WayShift */
>> +     add     r4, r3, #1 /* NumWays */
>> +1:   sub     r2, r2, #1 /* NumSets-- */
>> +     mov     r3, r4     /* Temp = NumWays */
>> +2:   subs    r3, r3, #1 /* Temp-- */
>> +     mov     r5, r3, lsl r1
>> +     mov     r6, r2, lsl r0
>> +     /* Reg = (Temp << WayShift) | (NumSets << SetShift) */
>> +     orr     r5, r5, r6
>> +     mcr     p15, 0, r5, c7, c6, 2
>> +     bgt     2b
>> +     cmp     r2, #0
>> +     bgt     1b
>> +     dsb
>> +     isb
>> +     mov     pc, lr
>> +ENDPROC(v7_invalidate_l1_npcmX50)
>
> This looks a lot, if not nearly the same thing as v7_invalidate_l1 which
> is already called by secondary_startup, can you see if you can re-use it
> directly?
>
>> +
>> +/*
>> + * MSM specific entry point for secondary CPUs.  This provides
>> + * a "holding pen" into which all secondary cores are held until we're
>> + * ready for them to initialise.
>> + */
>
> Assuming this was copied from a Qualcomm MSM routine, you may want to
> fix the comment, typo on "initialis.
>
>> +ENTRY(npcm7xx_secondary_startup)
>> +     msr     CPSR_c, #(SVC_MODE)
>
> Is there a BootROM or something that would not make the secondary cores
> start in supervisor mode?

Unfortunately, yes; however, I was able to cut all of the other code out of
npcm7xx_secondary_startup, so now it just puts the core in SVC mode and
relies on secondary_startup to do all of the L1 cache invalidation.

>
>> +
>> +     bl      v7_invalidate_l1_npcmX50
>> +     /* disable vector table remapping */
>> +     mrc     p15, 0,r0, c1, c0, 0
>> +     and     r0, #0xffffdfff
>> +     mcr     p15, 0,r0, c1, c0, 0
>> +
>> +#ifdef CONFIG_CACHE_L2X0
>> +     /* Enable L1 & L2 prefetch + Zero line */
>> +     mrc     p15, 0, r0, c1, c0, 1
>> +     orr     r0, r0, #(7 << 1)
>> +     mcr     p15, 0, r0, c1, c0, 1
>> +#endif /* CONFIG_CACHE_L2X0 */
>> +
>> +     mrc     p15, 0, r0, c0, c0, 5
>> +     and     r0, r0, #15
>> +     adr     r4, 1f
>> +     ldmia   r4, {r5, r6}
>> +     sub     r4, r4, r5
>> +     add     r6, r6, r4
>> +     str r3,[r2]
>> +
>> +pen: ldr     r7, [r6]
>> +     cmp     r7, r0
>> +     bne     pen
>> +
...
