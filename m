From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Feb 2016 17:35:35 +0000
Subject: [PATCH] arm64: mark kernel text segment as MEMBLOCK_NOMAP
In-Reply-To: <CAKv+Gu8XJ4br8U0x2=AzzDUxo3he2gK6MtBkMKEsZ=Juds3_=A@mail.gmail.com>
References: <1455528512-32491-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160215114505.GE13683@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-Y-k_LAbFZJjiPuHq6ssaFCb3WMG_fVGx3ODrvb+hEUQ@mail.gmail.com>
 <20160215120809.GF13683@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8XJ4br8U0x2=AzzDUxo3he2gK6MtBkMKEsZ=Juds3_=A@mail.gmail.com>
Message-ID: <20160215173534.GA19413@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 06:17:46PM +0100, Ard Biesheuvel wrote:
> On 15 February 2016 at 13:08, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Feb 15, 2016 at 12:53:59PM +0100, Ard Biesheuvel wrote:
> >> On 15 February 2016 at 12:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> > Ard, I'm about to drop the kernel memory map patches from -next. There
> >> > are several issues like KASAN (which may as well be a KASAN bug but I
> >> > haven't got to the bottom of it yet), initrd (you have patches but
> >> > require additional acks).
> >> >
> >> > I'll keep your stuff on the for-next/kernmap branch and do further
> >> > debugging. If it stabilises in the next 1-2 weeks, I'll merge it into
> >> > for-next/core for 4.6, otherwise, it will have to wait. I would really
> >> > like these patches merged but it looks like they need wider testing.
> > [...]
> >> If you are going to drop it for now anyway, I can do a v6sub1 with
> >> this issue and the initrd issue addressed, but also an issue with the
> >> KVM ksym ref patch with GCC 4.8. Since these issues affect
> >> bisectability, I'd prefer to rebase entirely, and fold all the fixes
> >> rather than apply them on top.
> >
> > That's fine. I'll push one more patch to the for-next/pgtable branch,
> > converting __set_fixmap_offset() back to a macro as it broke other
> > architectures. Otherwise it is not rebased and I'll merge it into
> > for-next core.
> 
> I have identified (and fixed) a Kasan issue in my patches: instead of
> leaving a hole for the 64 MB module window in the Kasan shadow region,
> I populated it with zero mappings, which caused many strange errors,
> and since the vmap() routines don't expect block mappings (which are
> created for the kernel image shadow by vmemmap_populate()),

This would probably fix the vmalloc warning caused from kasan when
loading modules.

> I guess false positive kasan warnings (like the ones you were seeing)
> are also a possible symptom of this issue.

I now get kasan warnings even on vanilla 4.5-rc1 (though not on 4.4).
I'm trying to figure out whether they are genuine or just false
positives:

BUG: KASAN: stack-out-of-bounds in clockevents_program_event+0x2c8/0x310 at addr ffffffc0016ffc08
Read of size 8 by task swapper/0/0
page:ffffffbdc205bfc0 count:1 mapcount:0 mapping:          (null) index:0x0
flags: 0x400(reserved)
page dumped because: kasan: bad access detected
CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B           4.5.0-rc1+ #158
Hardware name: Juno (DT)
Call trace:
[<ffffffc00008f130>] dump_backtrace+0x0/0x358
[<ffffffc00008f49c>] show_stack+0x14/0x20
[<ffffffc000785d40>] dump_stack+0xf8/0x188
[<ffffffc000343bb4>] kasan_report_error+0x524/0x550
[<ffffffc000343cf8>] __asan_report_load8_noabort+0x40/0x48
[<ffffffc0001f2b38>] clockevents_program_event+0x2c8/0x310
[<ffffffc0001f737c>] tick_program_event+0xac/0x108
[<ffffffc0001d85c8>] hrtimer_start_range_ns+0x8a0/0xb20
[<ffffffc0001f8b50>] __tick_nohz_idle_enter+0x970/0xca8
[<ffffffc0001f9310>] tick_nohz_idle_enter+0x60/0x98
[<ffffffc0001933ec>] cpu_startup_entry+0x14c/0x448
[<ffffffc00119104c>] rest_init+0xc4/0xd0
[<ffffffc00161beec>] start_kernel+0x54c/0x578
[<ffffffc0000811e0>] 0xffffffc0000811e0
Memory state around the buggy address:
 ffffffc0016ffb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc0016ffb80: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00
>ffffffc0016ffc00: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
                      ^
 ffffffc0016ffc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc0016ffd00: 00 00 00 00 00 00 f1 f1 f1 f1 00 f4 f4 f4 f3 f3

-- 
Catalin
