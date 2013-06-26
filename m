From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 26 Jun 2013 12:55:33 +0200
Subject: [PATCH v2 3/5] ARM: add support for kernel mode NEON
In-Reply-To: <1372191891-24574-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1372191891-24574-1-git-send-email-ard.biesheuvel@linaro.org>
 <1372191891-24574-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAKv+Gu_NZNAcW13CBP=QJQ8KXD6H9zx_T6ZQPsWuagRm3n6Okg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replying to self:

On 25 June 2013 22:24, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> +void kernel_neon_end(void)
> +{
> +       /* Disable the NEON/VFP unit. */
> +       fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
> +       barrier();
> +       dec_preempt_count();
> +}
> +EXPORT_SYMBOL(kernel_neon_end);

Meh. This is not going to please the RT crowd, as preempt_schedule()
will not be called on PREEMPT builds in this case.

Propose to replace it with

    preempt_enable();
#ifndef CONFIG_PREEMPT_COUNT
    /* in this case, the preempt_enable() right above is just a barrier() */
    dec_preempt_count();
#endif

(and the converse in kernel_neon_begin())

In that case, preempt_disable will either be just a barrier(), or it
will re-enable preemption, and potentially reschedule if the preempt
count has dropped to zero.

-- 
Ard.


> +
> +#endif /* CONFIG_KERNEL_MODE_NEON */
> +
>  /*
>   * VFP support code initialisation.
>   */
> --
> 1.8.1.2
>
