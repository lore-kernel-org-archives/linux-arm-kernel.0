From: tony@atomide.com (Tony Lindgren)
Date: Tue, 24 Apr 2012 09:39:16 -0700
Subject: [PATCH 12/19] ARM: OMAP4: PM: update ROM return address for
 OSWR and OFF
In-Reply-To: <1334914432-26456-13-git-send-email-t-kristo@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-13-git-send-email-t-kristo@ti.com>
Message-ID: <20120424163916.GN3739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [120420 02:39]:
> @@ -384,6 +386,17 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>  	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
>  
>  	if (omap4_mpuss_read_prev_context_state()) {
> +		/*
> +		 * Dummy dispatcher call after OSWR and OFF
> +		 * Restore the right return Kernel address (with MMU on) for
> +		 * subsequent calls to secure ROM. Otherwise the return address
> +		 * will be to a PA return address and the system will hang.
> +		 */
> +		if (omap_type() != OMAP2_DEVICE_TYPE_GP)
> +			omap_secure_dispatcher(OMAP4_PPA_SERVICE_0,
> +					       FLAG_START_CRITICAL,
> +					       0, 0, 0, 0, 0);
> +
>  		restore_ivahd_tesla_regs();
>  		restore_l3instr_regs();

This SoC test here too should be only done once during init.

Tony
