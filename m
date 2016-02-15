From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Feb 2016 18:59:57 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <56C1E072.2090909@virtuozzo.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
 <20160212145844.GI31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-x6QPorWsPDP8bqAkmbasqzhqmP39HS=qprfGB4r8JLw@mail.gmail.com>
 <20160212151006.GJ31665@e104818-lin.cambridge.arm.com>
 <CAKv+Gu84mVP=YjbLhWoGj9AEUD8m8+Lq8kTCniCHwxJwMWaZtA@mail.gmail.com>
 <20160212152641.GK31665@e104818-lin.cambridge.arm.com>
 <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
Message-ID: <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 05:28:02PM +0300, Andrey Ryabinin wrote:
> On 02/12/2016 07:06 PM, Catalin Marinas wrote:
> > So far, we have:
> > 
> > KASAN+for-next/kernmap goes wrong
> > KASAN+UBSAN goes wrong
> > 
> > Enabled individually, KASAN, UBSAN and for-next/kernmap seem fine. I may
> > have to trim for-next/core down until we figure out where the problem
> > is.
> > 
> > BUG: KASAN: stack-out-of-bounds in find_busiest_group+0x164/0x16a0 at addr ffffffc93665bc8c
> 
> Can it be related to TLB conflicts, which supposed to be fixed in
> "arm64: kasan: avoid TLB conflicts" patch from "arm64: mm: rework page
> table creation" series ?

I can very easily reproduce this with a vanilla 4.5-rc1 series by
enabling inline instrumentation (maybe Mark's theory is true w.r.t.
image size).

Some information, maybe you can shed some light on this. It seems to
happen only for secondary CPUs on the swapper stack (I think allocated
via fork_idle()). The code generated looks sane to me, so KASAN should
not complain but maybe there is some uninitialised shadow, hence the
error.

The report:

-------------->8---------------
BUG: KASAN: stack-out-of-bounds in clockevents_program_event+0x354/0x368 at addr ffffffc93651bca8
Read of size 8 by task swapper/1/0
page:ffffffbde6d946c0 count:0 mapcount:0 mapping:          (null) index:0x0
flags: 0x4000000000000000()
page dumped because: kasan: bad access detected
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G    B           4.5.0-rc1+ #163
Hardware name: Juno (DT)
Call trace:
[<ffffffc00008f130>] dump_backtrace+0x0/0x358
[<ffffffc00008f49c>] show_stack+0x14/0x20
[<ffffffc000785dc0>] dump_stack+0xf8/0x188
[<ffffffc000343c0c>] kasan_report_error+0x524/0x550
[<ffffffc000343d50>] __asan_report_load8_noabort+0x40/0x48
[<ffffffc0001f2bc4>] clockevents_program_event+0x354/0x368
[<ffffffc0001f73d4>] tick_program_event+0xac/0x108
[<ffffffc0001d85c8>] hrtimer_start_range_ns+0x8a0/0xb20
[<ffffffc0001f8ba8>] __tick_nohz_idle_enter+0x970/0xca8
[<ffffffc0001f9368>] tick_nohz_idle_enter+0x60/0x98
[<ffffffc0001933ec>] cpu_startup_entry+0x14c/0x448
[<ffffffc000098654>] secondary_start_kernel+0x264/0x2e0
[<0000000080082ecc>] 0x80082ecc
Memory state around the buggy address:
 ffffffc93651bb80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc93651bc00: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
>ffffffc93651bc80: 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00
                                  ^
 ffffffc93651bd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc93651bd80: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f4
-------------->8---------------

I put some printks in clockevents_program_event() and the SP is
0xffffffc93651bc70, so it matches the above.

Disassembling the code:

-------------->8---------------
ffffffc0001f2870 <clockevents_program_event>:
ffffffc0001f2870:       a9bc7bfd        stp     x29, x30, [sp,#-64]!
ffffffc0001f2874:       d2dff204        mov     x4, #0xff9000000000             // #280993940373504
ffffffc0001f2878:       910003fd        mov     x29, sp
ffffffc0001f287c:       910103a3        add     x3, x29, #0x40
ffffffc0001f2880:       f2fbffe4        movk    x4, #0xdfff, lsl #48
ffffffc0001f2884:       a90153f3        stp     x19, x20, [sp,#16]
ffffffc0001f2888:       a9025bf5        stp     x21, x22, [sp,#32]
ffffffc0001f288c:       f81f8c61        str     x1, [x3,#-8]!
ffffffc0001f2890:       aa0003f3        mov     x19, x0
ffffffc0001f2894:       53001c55        uxtb    w21, w2
ffffffc0001f2898:       d343fc60        lsr     x0, x3, #3
ffffffc0001f289c:       38e46800        ldrsb   w0, [x0,x4]
ffffffc0001f28a0:       350018e0        cbnz    w0, ffffffc0001f2bbc <clockevents_program_event+0x34c>

[...]

ffffffc0001f2bbc:       aa0303e0        mov     x0, x3
ffffffc0001f2bc0:       94054454        bl      ffffffc000343d10 <__asan_report_load8_noabort>
-------------->8---------------

To me, line ffffffc0001f288c looks like a normal store to a stack
variable and the stack boundaries look fine. The ffffffc0001f289c line
checks shadow and reads non-zero, hence the report. But I don't get
what's wrong with this function, other than corrupt KASAN shadow.

-- 
Catalin
