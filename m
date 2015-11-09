From: dianders@chromium.org (Doug Anderson)
Date: Sun, 8 Nov 2015 20:39:54 -0800
Subject: [RESEND PATCH 0/1] Fix the "hard LOCKUP" when running a heavy
 loading
In-Reply-To: <20151106121741.GH6087@arm.com>
References: <1446538209-13490-1-git-send-email-wxt@rock-chips.com>
 <20151103113030.GB14159@arm.com>
 <CAD=FV=XYBeKSo7NeTt3P0nSPA_A3yQ0qHDwxsJSzsTgA5VPkoA@mail.gmail.com>
 <20151106121741.GH6087@arm.com>
Message-ID: <CAD=FV=XFmgBoxm6oOgwu6HDajFBjsmF=1Sem_0UPN51zNO64fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Fri, Nov 6, 2015 at 4:17 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Nov 03, 2015 at 11:00:20AM -0800, Doug Anderson wrote:
>> Hi,
>
> Hey Doug,
>
>> When CPUs are hard locked up, they are often found at:
>>
>> <c0117c8c> v7_coherent_kern_range+0x58/0x74
>>   or
>> <c0118278> v7wbi_flush_user_tlb_range+0x30/0x38
>>
>> That made me think that an errata might be the root cause of our hard
>> lockups, since ARM errata often trigger in cache/tlb functions.  I
>> think Caesar dug up this old errata fix in response to my suggestion.
>
> I still don't see how 818325 is related, since there aren't any conditional
> stores in the sequences below.
>
>> If you know of any ARM errata that might trigger hard lockups like
>> this, I'd certainly be all ears.  It's also possible that we've got
>> something running at too low of a voltage or we've got clock dividers
>> or cache timings programmed incorrectly somewhere.  To give a more
>> full disassembly of one of the crashes:
>>
>>   <4>[ 1623.480846] SMP: failed to stop secondary CPUs
>>   <3>[ 1623.480862] CPU1 PC: <c01827e8> __unqueue_futex+0x68/0x88
>>   <3>[ 1623.480879] CPU2 PC: <c0117c8c> v7_coherent_kern_range+0x58/0x74
>>   <3>[ 1623.480895] CPU3 PC: <c0118268> v7wbi_flush_user_tlb_range+0x20/0x38
>>
>> ---
>
> Do you have any register values for these CPUs?

No, unfortunately not.  The only reason I have the PCs is because we
have code to sample CPU_DBGPCSR at hard lockup time (actually any
panic time).  There's no equivalent for other registers.  The code
does try to sample a number of times, so the fact that we only have
one PC value for each of the other CPUs implies that they are either
totally stuck or running in a very tight loop (from experimentation,
if you are running in a tight loop of just a few instructions the
CPU_DBGPCSR for a CPU may or may not update).

If you're curious, you can see rockchip_panic_notify() in
<https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/arch/arm/mach-rockchip/rockchip.c>.
It's basically some code that's been ported forward from code in an
old Android tree and it's not beautiful, but it's better than nothing.
The code only runs if the panic notifier failed to stop the other CPUs
in a normal way.

Technically (I think) I saw something in the CPU debug registers that
would actually allow me to force another CPU to stop.  That might let
me gain control over it and inspect the other registers.  Doing that
is probably beyond what I have time for right now, though.


>> c01827dc:       e2841010        add     r1, r4, #16
>> c01827e0:       e2445004        sub     r5, r4, #4
>> c01827e4:       eb068d33        bl      c0325cb8 <plist_del> (File
>> Offset: 0x235cb8)
>> => c01827e8:    f595f000        pldw    [r5]
>> c01827ec:       e1953f9f        ldrex   r3, [r5]
>> c01827f0:       e2433001        sub     r3, r3, #1
>> c01827f4:       e1852f93        strex   r2, r3, [r5]
>> c01827f8:       e3320000        teq     r2, #0
>> c01827fc:       1afffffa        bne     c01827ec
>> <__unqueue_futex+0x6c> (File Offset: 0x927ec)
>> c0182800:       e89da830        ldm     sp, {r4, r5, fp, sp, pc}
>
> For example, the futex address in r5 ...
>
>> c0117c80:       e08cc002        add     ip, ip, r2
>> c0117c84:       e15c0001        cmp     ip, r1
>> c0117c88:       3afffffb        bcc     c0117c7c
>> <v7_coherent_kern_range+0x48> (File Offset: 0x27c7c)
>> => c0117c8c:    e3a00000        mov     r0, #0
>> c0117c90:       ee070fd1        mcr     15, 0, r0, cr7, cr1, {6}
>> c0117c94:       f57ff04a        dsb     ishst
>> c0117c98:       f57ff06f        isb     sy
>> c0117c9c:       e1a0f00e        mov     pc, lr
>
> ... the address in r0 for the cache maintenance ...
>
>> c0118260:       e1830600        orr     r0, r3, r0, lsl #12
>> c0118264:       e1a01601        lsl     r1, r1, #12
>> => c0118268:    ee080f33        mcr     15, 0, r0, cr8, cr3, {1}
>> c011826c:       e2800a01        add     r0, r0, #4096   ; 0x1000
>> c0118270:       e1500001        cmp     r0, r1
>> c0118274:       3afffffb        bcc     c0118268
>> <v7wbi_flush_user_tlb_range+0x20> (File Offset: 0x28268)
>> c0118278:       f57ff04b        dsb     ish
>> c011827c:       e1a0f00e        mov     pc, lr
>
> ... and the address in r0 for the TLBI.
>
> Are the cores executing instructions at this point, or by "hard LOCKUP"
> do you mean that they're deadlocked in hardware?

If they are executing, they aren't executing much.  That means it's
likely they're deadlocked in hardware.

-Doug
