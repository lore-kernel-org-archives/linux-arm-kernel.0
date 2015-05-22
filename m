From: arnd@linaro.org (Arnd Bergmann)
Date: Fri, 22 May 2015 11:46:56 +0200
Subject: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
In-Reply-To: <CAKv+Gu-bMy29BhQJb=bap_KDWTUTKOW4JVjvFOEtHuubJWhMDQ@mail.gmail.com>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
 <4053482.VK9u0kqo8W@wuerfel>
 <CAKv+Gu-bMy29BhQJb=bap_KDWTUTKOW4JVjvFOEtHuubJWhMDQ@mail.gmail.com>
Message-ID: <2318126.unulghvt2b@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 18:01:27 Ard Biesheuvel wrote:
> 
> You could but I wouldn't recommend it since it may also prevent you
> from being able to set the boot path, but more importantly, reset and
> poweroff may also be available only via UEFI Runtime Services on UEFI
> systems.

Right, makes sense. Another option then could be to disable fpsimd
support with preempt-rt on real systems, and document this as a known
source of latency.

> So could someone comment on whether virt_efi_set_time() is present in
> all the problematic traces? Or was it only chosen because it
> illustrates the underlying problem the best? In the former case, there
> is an hidden bug that I would like to know about: however, if some
> time related facility that is used in a performance (or latency)
> sensitive context ultimately ends up programming the wall clock time
> in the RTC, then I would expect the same issue to occur on non-UEFI
> systems as well.

But without UEFI, updating the RTC would cause much less latency,
because  you don't need to save/restore the fpsimd context, disable
preemption, or call into a potentially unknown external binary
blob, the only latency you'd get there is that of a readl/writel
accessing the RTC register.

> One thing I should point out is that this FP/SIMD save/restore is
> implemented differently depending on whether it is called from process
> context or from hardirq/softirq context. In the former case,
> kernel_neon_begin() preserves the userland FP/SIMD context only once,
> and only restores it right before returning to userland. This way,
> only the first kernel_neon_begin() and the last kernel_neon_end() call
> actually induce this latency, and so the average latency could be
> quite a bit lower than the worst case (although I understand that few
> people may care about the average in an RT context)

Just for my own interest: in what case do we save/restore the fpsimd
state from interrupt context?

	Arnd
