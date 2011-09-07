From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 7 Sep 2011 09:13:38 -0700
Subject: [RFC PATCH 2/3] ARM: iwmmxt: Port problematic iwmmxt support code
	to v7/Thumb-2
In-Reply-To: <1315411158-17479-3-git-send-email-dave.martin@linaro.org>
References: <1315411158-17479-1-git-send-email-dave.martin@linaro.org>
	<1315411158-17479-3-git-send-email-dave.martin@linaro.org>
Message-ID: <CAMPhdO927WucyKRjbj69ahD7xmu-7L-Vt1AkGe1yZsmXv4YS8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2011 at 8:59 AM, Dave Martin <dave.martin@linaro.org> wrote:
> The iwmmxt code contains some code to implement a pseudo-ISB, but
> this is not buildable for Thumb-2.
>
> This patch replaces the pseudo-ISB with a real one for Thumb-2
> kernels.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> ?arch/arm/kernel/iwmmxt.S | ? ?9 +++++++++
> ?1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
> index a087838..bee8a74 100644
> --- a/arch/arm/kernel/iwmmxt.S
> +++ b/arch/arm/kernel/iwmmxt.S
> @@ -319,8 +319,17 @@ ENTRY(iwmmxt_task_switch)
> ? ? ? ?PJ4(eor r1, r1, #0xf)
> ? ? ? ?PJ4(mcr p15, 0, r1, c1, c0, 2)
>
> +/*
> + * When enough people have binutils which support -march=...+iwmmxt, this
> + * should change to #if __LINUX_ARM_ARCH__ < 7.
> + */
> +#ifndef CONFIG_THUMB2_KERNEL
> ? ? ? ?mrc ? ? p15, 0, r1, c2, c0, 0
> ? ? ? ?sub ? ? pc, lr, r1, lsr #32 ? ? ? ? ? ? @ cpwait and return
> +#else
> + ? ? ? isb ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ ISB needed instead on ARMv7
> + ? ? ? mov ? ? pc, lr
> +#endif

Or maybe using ARM() and THUMB() will be a better fit here?
