From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 16 Jan 2014 15:29:24 +0800
Subject: [PATCH V6 1/3] ARM: imx: add suspend in ocram support for i.mx6q
In-Reply-To: <1389840105-17625-1-git-send-email-b20788@freescale.com>
References: <1389840105-17625-1-git-send-email-b20788@freescale.com>
Message-ID: <20140116072922.GB4049@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 10:41:43AM +0800, Anson Huang wrote:
> +/*
> + * ==================== low level suspend ====================
> + *
> + * Better to follow below rules to use ARM registers:
> + * r0: pm_info structure address;
> + * r1 ~ r5: for saving pm_info members;

The register r5 is free to use now.

> + * r6 ~ r10: free registers;
> + * r11: io base address.
> + *
> + * suspend ocram space layout:
> + * ======================== high address ======================
> + *                              .
> + *                              .
> + *                              .
> + *                              ^
> + *                              ^
> + *                              ^
> + *                      imx6_suspend code
> + *              PM_INFO structure(imx6_cpu_pm_info)
> + * ======================== low address =======================
> + */

<snip>

> +	/*
> +	 * now delay for a short while (3usec)
> +	 * ARM is at 1GHz at this point
> +	 * so a short loop should be enough.
> +	 * this delay is required to ensure that
> +	 * the RBC counter can start counting in
> +	 * case an interrupt is already pending
> +	 * or in case an interrupt arrives just
> +	 * as ARM is about to assert DSM_request.
> +	 */
> +	ldr     r6, =2000
> +rbc_loop:
> +	sub     r6, r6, #0x1
> +	cmp     r6, #0x0

Use 'subs' instead to save the 'cmp'.

Shawn

> +	bne     rbc_loop
