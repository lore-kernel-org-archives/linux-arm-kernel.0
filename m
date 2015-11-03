From: dianders@chromium.org (Doug Anderson)
Date: Tue, 3 Nov 2015 11:00:20 -0800
Subject: [RESEND PATCH 0/1] Fix the "hard LOCKUP" when running a heavy
 loading
In-Reply-To: <20151103113030.GB14159@arm.com>
References: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
 <20151103113030.GB14159@arm.com>
Message-ID: <CAD=FV=XYBeKSo7NeTt3P0nSPA_A3yQ0qHDwxsJSzsTgA5VPkoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 3, 2015 at 3:30 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Nov 03, 2015 at 04:10:08PM +0800, Caesar Wang wrote:
>> As the following log:
>> where we experience a CPU hard lockup. The assembly code (disassembled by gdb)
>>
>> 0xc06c6e90 <__tcp_select_window+148>:        beq     0xc06c6eb0<__tcp_select_window+180>
>> 0xc06c6e94 <__tcp_select_window+152>:        mov     r2, #1008; 0x3f0
>> 0xc06c6e98 <__tcp_select_window+156>:        ldr     r5, [r0,#1004] ; 0x3ec
>> 0xc06c6e9c <__tcp_select_window+160>:        ldrh    r2, [r0,r2]
>> ....
>>
>> 0xc06c6ee0 <__tcp_select_window+228>:        addne   r0, r0, #1
>> 0xc06c6ee4 <__tcp_select_window+232>:        lslne   r0, r0, r2
>> 0xc06c6ee8 <__tcp_select_window+236>:        ldmne   sp, {r4, r5,r11, sp,pc}
>>
>> Could either the ?strhi?/?strlo? pair, or the lslne/ldmne pair, be
>> tripping over errata 818325, or a similar errata?
>
> No. One of the conditions for #818325 is:
>
>   The second instruction is an UNPREDICTABLE STR or STM (maximum two2
>   registers in the list) with write-back and the write-back register is
>   in the list of stored registers.
>
> I don't see either of those in your code snippet above, but then I don't
> see your strhi/strlo either. What's going on?

It looks like Caesar is proposing that this errata is the root cause
for some hard lockups we're seeing on rk3288 Chromebooks.  I agree
with folks here that say this isn't terribly likely, but I always like
to be proven wrong.  ;)

We've got code that samples / prints CPU_DBGPCSR at the time of a hard
lockup.  That register isn't 100% accurate about where a CPU is, but
it's better than nothing (technically there may be ways to actually
use the DBG registers to stop the remote CPU and maybe give more info,
but I digress).

When CPUs are hard locked up, they are often found at:

<c0117c8c> v7_coherent_kern_range+0x58/0x74
  or
<c0118278> v7wbi_flush_user_tlb_range+0x30/0x38

That made me think that an errata might be the root cause of our hard
lockups, since ARM errata often trigger in cache/tlb functions.  I
think Caesar dug up this old errata fix in response to my suggestion.

If you know of any ARM errata that might trigger hard lockups like
this, I'd certainly be all ears.  It's also possible that we've got
something running at too low of a voltage or we've got clock dividers
or cache timings programmed incorrectly somewhere.  To give a more
full disassembly of one of the crashes:

  <4>[ 1623.480846] SMP: failed to stop secondary CPUs
  <3>[ 1623.480862] CPU1 PC: <c01827e8> __unqueue_futex+0x68/0x88
  <3>[ 1623.480879] CPU2 PC: <c0117c8c> v7_coherent_kern_range+0x58/0x74
  <3>[ 1623.480895] CPU3 PC: <c0118268> v7wbi_flush_user_tlb_range+0x20/0x38

---

c01827dc:       e2841010        add     r1, r4, #16
c01827e0:       e2445004        sub     r5, r4, #4
c01827e4:       eb068d33        bl      c0325cb8 <plist_del> (File
Offset: 0x235cb8)
=> c01827e8:    f595f000        pldw    [r5]
c01827ec:       e1953f9f        ldrex   r3, [r5]
c01827f0:       e2433001        sub     r3, r3, #1
c01827f4:       e1852f93        strex   r2, r3, [r5]
c01827f8:       e3320000        teq     r2, #0
c01827fc:       1afffffa        bne     c01827ec
<__unqueue_futex+0x6c> (File Offset: 0x927ec)
c0182800:       e89da830        ldm     sp, {r4, r5, fp, sp, pc}

---

c0117c80:       e08cc002        add     ip, ip, r2
c0117c84:       e15c0001        cmp     ip, r1
c0117c88:       3afffffb        bcc     c0117c7c
<v7_coherent_kern_range+0x48> (File Offset: 0x27c7c)
=> c0117c8c:    e3a00000        mov     r0, #0
c0117c90:       ee070fd1        mcr     15, 0, r0, cr7, cr1, {6}
c0117c94:       f57ff04a        dsb     ishst
c0117c98:       f57ff06f        isb     sy
c0117c9c:       e1a0f00e        mov     pc, lr

---

c0118260:       e1830600        orr     r0, r3, r0, lsl #12
c0118264:       e1a01601        lsl     r1, r1, #12
=> c0118268:    ee080f33        mcr     15, 0, r0, cr8, cr3, {1}
c011826c:       e2800a01        add     r0, r0, #4096   ; 0x1000
c0118270:       e1500001        cmp     r0, r1
c0118274:       3afffffb        bcc     c0118268
<v7wbi_flush_user_tlb_range+0x20> (File Offset: 0x28268)
c0118278:       f57ff04b        dsb     ish
c011827c:       e1a0f00e        mov     pc, lr
