From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Wed, 8 Apr 2015 11:37:04 +0530
Subject: [PATCH v5 3/6] arm64: Kprobes with single stepping support
In-Reply-To: <1424214701-4899-4-git-send-email-dave.long@linaro.org>
References: <1424214701-4899-1-git-send-email-dave.long@linaro.org>
 <1424214701-4899-4-git-send-email-dave.long@linaro.org>
Message-ID: <CAHM4w1=84w40VCKyEtGfqYEziZaqgRWG6O7TGn+w1CeQuPyVPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Wed, Feb 18, 2015 at 4:41 AM, David Long <dave.long@linaro.org> wrote:
>
> From: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
>
> Add support for basic kernel probes(kprobes) and jump probes
> (jprobes) for ARM64.
>

[...]

>
> +#ifdef CONFIG_KPROBES
> +static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)
> +{
> +       int ret = 0;
> +
> +       /* kprobe_running() needs smp_processor_id() */
> +       if (!user_mode(regs)) {
> +               preempt_disable();
> +               if (kprobe_running() && kprobe_fault_handler(regs, esr))
> +                       ret = 1;
> +               preempt_enable();
> +       }
> +
> +       return ret;
> +}
> +#else
> +static inline int notify_page_fault(struct pt_regs *regs)

Please fix this definition in next revision, other wise there would be
a build error
if CONFIG_KPROBES is not defined.


should be:

+static inline int notify_page_fault(struct pt_regs *regs, unsigned int esr)


~Pratyush
