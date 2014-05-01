From: gnurou@gmail.com (Alexandre Courbot)
Date: Thu, 1 May 2014 16:22:22 +0900
Subject: [PATCH] ARM: trusted_foundations: only set setup_max_cpus if SMP
 set
In-Reply-To: <1398592890-31301-1-git-send-email-acourbot@nvidia.com>
References: <20140427093250.GA26756@n2100.arm.linux.org.uk>
 <1398592890-31301-1-git-send-email-acourbot@nvidia.com>
Message-ID: <CAAVeFuKbhMSDz3QQAJaNsxOyk_EfAaGq-_m-rsc8RmdnYLXeew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 7:01 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> The setup_max_cpu variable is only defined if CONFIG_SMP is set. Add
> a preprocessor condition to avoid the following compilation error if
> CONFIG_SMP is not set:
>
>     arch/arm/include/asm/trusted_foundations.h: In function 'register_trusted_foundations':
>     arch/arm/include/asm/trusted_foundations.h:57:2: error: 'setup_max_cpus' undeclared (first use in this function)
>
> Reported-by: Russell King <rmk@arm.linux.org.uk>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Hi Russell,
>
> This should take care of the trusted foundations issue. Thanks for reporting this.

Russell,

Do you mind taking this into your tree? Or do you prefer if the Tegra
folks do it?

>
>  arch/arm/include/asm/trusted_foundations.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
> index b5f7705..624e1d4 100644
> --- a/arch/arm/include/asm/trusted_foundations.h
> +++ b/arch/arm/include/asm/trusted_foundations.h
> @@ -54,7 +54,9 @@ static inline void register_trusted_foundations(
>          */
>         pr_err("No support for Trusted Foundations, continuing in degraded mode.\n");
>         pr_err("Secondary processors as well as CPU PM will be disabled.\n");
> +#if IS_ENABLED(CONFIG_SMP)
>         setup_max_cpus = 0;
> +#endif
>         cpu_idle_poll_ctrl(true);
>  }
>
> --
> 1.9.2
>
