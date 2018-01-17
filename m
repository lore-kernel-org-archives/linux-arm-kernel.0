From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Jan 2018 11:13:20 +0000
Subject: [PATCH v2] arm64: kpti: Fix the interaction between ASID
 switching and software PAN
In-Reply-To: <CAKv+Gu8WD5nENKxJckgzu38rddsunjQY5-26X1wn82+xjXtTKg@mail.gmail.com>
References: <20180115175804.2508-1-catalin.marinas@arm.com>
 <5A5DEC02.7040908@arm.com>
 <CAKv+Gu9VsUTzTFPqS2rDz3sfT_eWmPBM1AAx03xsgYRgcJm6fQ@mail.gmail.com>
 <20180116173545.htflczc7msiqt2bf@armageddon.cambridge.arm.com>
 <CAKv+Gu8WD5nENKxJckgzu38rddsunjQY5-26X1wn82+xjXtTKg@mail.gmail.com>
Message-ID: <20180117111320.73ehp3tlqlmvgnbi@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 16, 2018 at 08:55:52PM +0000, Ard Biesheuvel wrote:
> On 16 January 2018 at 17:35, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Tue, Jan 16, 2018 at 04:23:58PM +0000, Ard Biesheuvel wrote:
> >> On 16 January 2018 at 12:11, James Morse <james.morse@arm.com> wrote:
> >> > On 15/01/18 17:58, Catalin Marinas wrote:
> >> >> With ARM64_SW_TTBR0_PAN enabled, the exception entry code checks the
> >> >> active ASID to decide whether user access was enabled (non-zero ASID)
> >> >> when the exception was taken. On return from exception, if user access
> >> >> was previously disabled, it re-instates TTBR0_EL1 from the per-thread
> >> >> saved value (updated in switch_mm() or efi_set_pgd()).
> >> >>
> >> >> Commit 7655abb95386 ("arm64: mm: Move ASID from TTBR0 to TTBR1") makes a
> >> >> TTBR0_EL1 + ASID switching non-atomic. Subsequently, commit 27a921e75711
> >> >> ("arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN") changes the
> >> >> __uaccess_ttbr0_disable() function and asm macro to first write the
> >> >> reserved TTBR0_EL1 followed by the ASID=0 update in TTBR1_EL1. If an
> >> >> exception occurs between these two, the exception return code will
> >> >> re-instate a valid TTBR0_EL1. Similar scenario can happen in
> >> >> cpu_switch_mm() between setting the reserved TTBR0_EL1 and the ASID
> >> >> update in cpu_do_switch_mm().
> >> >>
> >> >> This patch reverts the entry.S check for ASID == 0 to TTBR0_EL1 and
> >> >> disables the interrupts around the TTBR0_EL1 and ASID switching code in
> >> >> __uaccess_ttbr0_disable(). It also ensures that, when returning from the
> >> >> EFI runtime services, efi_set_pgd() doesn't leave a non-zero ASID in
> >> >> TTBR1_EL1 by using uaccess_ttbr0_{enable,disable}.
> >> >>
> >> >> The accesses to current_thread_info()->ttbr0 are updated to use
> >> >> READ_ONCE/WRITE_ONCE.
> >> >>
> >> >> As a safety measure, __uaccess_ttbr0_enable() always masks out any
> >> >> existing non-zero ASID TTBR1_EL1 before writing in the new ASID.
> >> >>
> >> >> Fixes: 27a921e75711 ("arm64: mm: Fix and re-enable ARM64_SW_TTBR0_PAN")
> >> >> Acked-by: Will Deacon <will.deacon@arm.com>
> >> >> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> >> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> >> Reviewed-by: James Morse <james.morse@arm.com>
> >> >> Cc: James Morse <james.morse@arm.com>
> >> >> Co-developed-by: Marc Zyngier <marc.zyngier@arm.com>
> >> >> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> >> >> ---
> >> >>
> >> >> Changes since v1 (no functional change):
> >> >>
> >> >> - Modified efi_set_pgd() to pair uaccess_ttbr0_disable/enable
> >> >> - Accesses to current_thread_info()->ttbr0 are passed through READ/WRITE_ONCE
> >> >>
> >> >> I dropped James' tested-by, just in case I messed something up.
> >> >
> >> > Tested as before:
> >> > Tested-by: James Morse <james.morse@arm.com>
> >>
> >> Works for me as well (Gnome Shell desktop + Chromium browser)
> >>
> >> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > Great. Thanks both for re-testing. I'll push the patch out to
> > for-next/core.
> 
> Unfortunately, I just got another
> 
> make: ../sysdeps/nptl/fork.c:156: __libc_fork: Assertion
> `THREAD_GETMEM (self, tid) != ppid' failed.
> 
> while compiling a kernel, which is the exact same symptom I had before.

It doesn't look good. Would you be able to try this with EFI run-time
services disabled? Just to take one path out of the suspects list.

Thanks.

-- 
Catalin
