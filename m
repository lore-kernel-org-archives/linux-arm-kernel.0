From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 21 May 2017 22:55:20 +0200
Subject: may_use_simd on aarch64, chacha20
In-Reply-To: <CAHmME9qH=Wu-=9YUmxi7NPrczHu1UrB7phG0y68ipB+ProQ2TA@mail.gmail.com>
References: <CAHmME9qH=Wu-=9YUmxi7NPrczHu1UrB7phG0y68ipB+ProQ2TA@mail.gmail.com>
Message-ID: <4150EFDC-CD3A-4C5C-9EF7-689F63C142C2@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Dave)

> On 21 May 2017, at 19:02, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> 
> Hi folks,
> 
> I noticed that the ARM implementation [1] of chacha20 makes a check to
> may_use_simd(), but the ARM64 implementation [2] does not. Question 1:
> is this a bug, in which case I'll submit a patch shortly, or is this
> intentional? In case of the latter, could somebody explain the
> reasoning?

This is intentional. arm64 supports kernel mode NEON in any context, whereas ARM only supports it in process context. This is due to the way lazy FP restore is implemented on ARM. However, we are about to
change this on arm64 to only allow non-nested kernel mode NEON, similar to x86. This is necessary to support SVE.

> On a similar note, the only ARM64 glue code that uses
> may_use_simd() is sha256; everything else does not. Shall I submit a
> substantial patch series to fix this up everywhere?
> 

Currently, may_use_simd() is only used as a hint on arm64 whether it makes sense to offload crypto to process context. In the sha256
code, whose arm64 neon implementation is only marginally faster than scalar on some micro-architectures, it is used to prefer the scalar code in interrupt context, because the NEON code preserves/restores the NEON state of the interrupted context eagerly, which is costly.

> Secondly, I noticed that may_use_simd() is essentially aliased to
> !in_interrupt(), since it uses the asm-generic variety. Question 2:
> Isn't this overkill? Couldn't we make an arm/arm64 variant of this
> that only checks in_irq()?
> 

No. ARM does not support kernel mode NEON in softirq
context, and arm64 will soon have its own override that only allows non-nested use in softirq context.

> Lastly, APIs like pcrypts and padata execute with bottom halves
> disabled, even though their actual execution environment is process
> context, via a workqueue. Thus, here, in_interrupt() will always be
> true, even though this is likely a place where we want to use simd.
> Question 3: is there something better that could be done?

I guess we should switch to in_serving_softirq() instead.

Thanks,
Ard.
