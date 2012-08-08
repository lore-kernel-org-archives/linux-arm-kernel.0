From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 8 Aug 2012 13:56:33 +0300
Subject: [PATCH v2] Revert "ARM: OMAP3: PM: call pre/post transition per
 powerdomain"
In-Reply-To: <1344379659-26152-1-git-send-email-khilman@ti.com>
References: <1344379659-26152-1-git-send-email-khilman@ti.com>
Message-ID: <CANOLnONQhqYcqW8ZAfn+5ceZQ_h2W_yKZVZrnrP5cUJDooTrQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 1:47 AM, Kevin Hilman <khilman@ti.com> wrote:
> This reverts commit 58f0829b7186150318c79515f0e0850c5e7a9c89.
>
> Converstion to per-pwrdm per/post transition calls was a bit
> premature.  Only tracking MPU, PER & CORE in the idle path means we
> lose the accounting for all the other powerdomains which may also
> transition in idle.  On OMAP3, due to autodeps, several powerdomains
> transition along with MPU (e.g. DSS, USBHOST), and the accounting for
> these was lost with this patch.  Since the accounting includes the
> context loss counters, drivers for devices in those power domains
> would never notice context lost, so would likely hang after any
> off-mode transitions.

That's a shame, pwrdm_pre_transition/pwrdm_post_transition are the
main contributors to idle latency and cause large performance loss on
small and frequent loads, like short DMAs. Could we perhaps only do it
when PM_DEBUG is on or when off transitions happen instead?

> This patch should be revisited when the upcoming clkdm/pwrmdm/voltdm
> use-counting seires is merged since then we can properly do accounting
> without relying on a call in the idle path.

So all hope of getting rid of those pre/post transition calls goes here then?
Small typo with 'seires'..

> In addition, the original patch had another bug because the PER
> powerdomain accounting was not updated until after the GPIO resume
> hook is called.  Since gpio_resume_after_idle() checks the context
> loss count (which is not yet updated) it would not properly restore
> context, leaving the GPIO banks in an undefined state.
>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index e4fc88c..05bd8f0 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -272,21 +272,16 @@ void omap_sram_idle(void)
>         per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
>         core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>
> -       if (mpu_next_state < PWRDM_POWER_ON) {
> -               pwrdm_pre_transition(mpu_pwrdm);
> -               pwrdm_pre_transition(neon_pwrdm);
> -       }
> +       pwrdm_pre_transition(NULL);
>
>         /* PER */
>         if (per_next_state < PWRDM_POWER_ON) {
> -               pwrdm_pre_transition(per_pwrdm);
>                 per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
>                 omap2_gpio_prepare_for_idle(per_going_off);
>         }
>
>         /* CORE */
>         if (core_next_state < PWRDM_POWER_ON) {
> -               pwrdm_pre_transition(core_pwrdm);
>                 if (core_next_state == PWRDM_POWER_OFF) {
>                         omap3_core_save_context();
>                         omap3_cm_save_context();
> @@ -339,20 +334,14 @@ void omap_sram_idle(void)
>                         omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
>                                                OMAP3430_GR_MOD,
>                                                OMAP3_PRM_VOLTCTRL_OFFSET);
> -               pwrdm_post_transition(core_pwrdm);
>         }
>         omap3_intc_resume_idle();
>
> +       pwrdm_post_transition(NULL);
> +
>         /* PER */
> -       if (per_next_state < PWRDM_POWER_ON) {
> +       if (per_next_state < PWRDM_POWER_ON)
>                 omap2_gpio_resume_after_idle();
> -               pwrdm_post_transition(per_pwrdm);
> -       }
> -
> -       if (mpu_next_state < PWRDM_POWER_ON) {
> -               pwrdm_post_transition(mpu_pwrdm);
> -               pwrdm_post_transition(neon_pwrdm);
> -       }
>  }
>
>  static void omap3_pm_idle(void)
> --
> 1.7.9.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Gra?vydas
