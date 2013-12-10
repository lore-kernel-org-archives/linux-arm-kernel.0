From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 10 Dec 2013 12:38:31 +0000
Subject: [Linaro-acpi] [PATCH v3 2/5] ACPI: bus master reload not
 supported in reduced HW mode
In-Reply-To: <1386192127-28564-3-git-send-email-al.stone@linaro.org>
References: <1386192127-28564-1-git-send-email-al.stone@linaro.org> <
 1386192127-28564-3-git-send-email-al.stone@linaro.org>
Message-ID: <20131210123831.AEFACC40A27@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  4 Dec 2013 14:22:04 -0700, al.stone at linaro.org wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Remove the saving and restoring of bus master reload registers in
> suspend/resume when in reduced HW mode; according to the spec, no
> such registers should exist
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/processor_idle.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 597cdab..8b48c08 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -202,7 +202,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
>  
>  #endif
>  
> -#ifdef CONFIG_PM_SLEEP
> +#if (IS_ENABLED(CONFIG_PM_SLEEP) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE))
>  static u32 saved_bm_rld;
>  
>  static int acpi_processor_suspend(void)
> @@ -236,7 +236,10 @@ void acpi_processor_syscore_exit(void)
>  {
>  	unregister_syscore_ops(&acpi_processor_syscore_ops);
>  }
> -#endif /* CONFIG_PM_SLEEP */
> +#else
> +void acpi_processor_syscore_init(void) { return; }
> +void acpi_processor_syscore_exit(void) { return; }
> +#endif

Ditto comment on this patch. This breaks normal ACPI on x86 if hardware
reduced is enabled. That is bad form. It is fine to compile it out if
normal ACPI is explicitly /disabled/, but it must be possible for normal
and hardware reduced to co-exist.

g.
