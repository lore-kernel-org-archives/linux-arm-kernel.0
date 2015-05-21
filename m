From: arnd@linaro.org (Arnd Bergmann)
Date: Thu, 21 May 2015 17:35:11 +0200
Subject: [PATCH] arch/arm64 :Cyclic Test fix in ARM64 fpsimd
In-Reply-To: <CAKv+Gu_u+iYL4niHip9nzUd9p7tEt6XEvhZ4fQLJK_gVaw+FSA@mail.gmail.com>
References: <CAPyr0yJSGqvxkUWLtNKe0q5mNanBczAfAVx0tPKuzYeDG+eJ=Q@mail.gmail.com>
 <20150521135007.GC3983@localhost.localdomain>
 <CAKv+Gu_u+iYL4niHip9nzUd9p7tEt6XEvhZ4fQLJK_gVaw+FSA@mail.gmail.com>
Message-ID: <4053482.VK9u0kqo8W@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 17:23:43 Ard Biesheuvel wrote:
> On 21 May 2015 at 15:50, Anders Roxell <anders.roxell@gmail.com> wrote:
> > On 2015-05-01 20:59, Ayyappa Ch wrote:
> >> Floating point operations in arm64 should not disable preempt .
> >> Activating realtime features with below code.
> >
> > I've talked with an engineer who worked on fpsimd and I was told that
> > replacing preempt_disable with migrate_disable would leave fpsimd open
> > to corruption.
> >
> > The kernel won't save the state of the simd registers when it is
> > preempted so if another task runs on the same CPU and also uses simd, it
> > clobbers the registers of the first task, and migrate_disable() does not
> > prevent that.
> >
> > If we want to use SIMD with preemption enabled, we need to update the
> > context switch code to do a full SIMD register state save&restore if
> > necessary. However, this can have a noticeable cost in all task switch
> > latencies.
> >
> 
> I noticed somewhere in this thread that the culprit was ultimately a
> call to virt_efi_set_time(), which is the UEFI Runtime Service that
> programs the RTC. If this is a hot spot, then there is something very
> wrong with the system which is entirely unrelated to preempt_rt.

Ah, that explains a lot!

> But let's assume this is a valid UEFI Runtime Services call: since
> UEFI Runtime Services are allowed to use the FP/SIMD register file, we
> need the kernel_neon_begin()/kernel_neon_end() pair even though it is
> highly unlikely that such a runtime service call would actually need
> to use the NEON or floating point. It is simply imposed by the
> kernel<->firmware ABI. Also, on this particular code path, preemption
> will be disabled regardless, since the UEFI Runtime Services are
> invoked with a UEFI specific TTBR0 mapping, which rules out preemption
> for reasons unrelated to the FP/SIMD register file.

Can we disable support for UEFI runtime services with preempt-rt
kernels? A 'depends on !PREEMPT_RT' would seem sufficient there.

	Arnd
