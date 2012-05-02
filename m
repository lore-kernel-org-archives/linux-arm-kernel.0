From: rob.lee@linaro.org (Rob Lee)
Date: Tue, 1 May 2012 21:16:48 -0500
Subject: [PATCH 01/17] ARM: provide a late_initcall hook for platform
 initialization
In-Reply-To: <1335454725-13089-2-git-send-email-shawn.guo@linaro.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAMXH7KEzQUpFFVrdyVsUaBZdNCTuotrTWhYABxQYBcaFRE8yqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 10:38 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> This allows platforms to set up things that need to be done at
> late_initcall time.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> ?arch/arm/include/asm/mach/arch.h | ? ?1 +
> ?arch/arm/kernel/setup.c ? ? ? ? ?| ? ?8 ++++++++
> ?2 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
> index d7692ca..0b1c94b 100644
> --- a/arch/arm/include/asm/mach/arch.h
> +++ b/arch/arm/include/asm/mach/arch.h
> @@ -43,6 +43,7 @@ struct machine_desc {
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*init_irq)(void);
> ? ? ? ?struct sys_timer ? ? ? ?*timer; ? ? ? ? /* system tick timer ? ?*/
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*init_machine)(void);
> + ? ? ? void ? ? ? ? ? ? ? ? ? ?(*init_late)(void);
> ?#ifdef CONFIG_MULTI_IRQ_HANDLER
> ? ? ? ?void ? ? ? ? ? ? ? ? ? ?(*handle_irq)(struct pt_regs *);
> ?#endif
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index ebfac78..549f036 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -800,6 +800,14 @@ static int __init customize_machine(void)
> ?}
> ?arch_initcall(customize_machine);
>
> +static int __init init_machine_late(void)
> +{
> + ? ? ? if (machine_desc->init_late)
> + ? ? ? ? ? ? ? machine_desc->init_late();
> + ? ? ? return 0;
> +}
> +late_initcall(init_machine_late);
> +
> ?#ifdef CONFIG_KEXEC
> ?static inline unsigned long long get_total_mem(void)
> ?{
> --
> 1.7.5.4
>

Tested-by: Robert Lee <rob.lee@linaro.org>
