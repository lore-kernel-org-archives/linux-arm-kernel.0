From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 11 Apr 2012 16:54:42 -0600 (MDT)
Subject: [PATCH 11/12] arm: omap3: am35x: Add do_wfi routine for EMIF4
 submodules
In-Reply-To: <1334171147-7517-12-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-12-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1204111653110.29473@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


One other minor thing I just noticed...

On Wed, 11 Apr 2012, Mark A. Greer wrote:

> +ENTRY(omap3_emif4_do_wfi)
> +	/* Put EMIF in self-refresh */
> +	ldr     r4, pwr_mgmt_ctrl
> +	ldr     r5, [r4]
> +	orr     r5, r5, #0x200
> +	str     r5, [r4]
> +
> +	dsb
> +	dmb
> +
> +	wfi
> +
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +	nop
> +
> +	/* Take EMIF out of self-refresh */
> +	ldr     r4, pwr_mgmt_ctrl
> +	ldr     r5, [r4]

Looks like the above two instructions might not be needed -- they should 
be preserved across the WFI ?

> +	bic     r5, r5, #0x200
> +	str     r5, [r4]
> +
> +	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
> +
> +pwr_mgmt_ctrl:
> +	.word   PWR_MGMT_CTRL_V
> +ENDPROC(omap3_emif4_do_wfi)
> +ENTRY(omap3_emif4_do_wfi_sz)
> +	.word	. - omap3_emif4_do_wfi
> +


- Paul
