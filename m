From: ashbertslists@gmail.com (Ashwin Chaugule)
Date: Mon, 18 Jan 2010 13:42:30 -0500
Subject: [RFC 07/18] arm: mm: retry on QSD icache parity errors
In-Reply-To: <1263250057-26692-8-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-8-git-send-email-dwalker@codeaurora.org>
Message-ID: <ad7a95ae1001181042j3ae165dfkb70d43d983b808f9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 5:47 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
> From: Steve Muckle <smuckle@quicinc.com>
>

> +static int
> +do_imprecise_ext(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> +{
> +#ifdef CONFIG_ARCH_MSM_SCORPION
> + ? ? ? unsigned int regval;
> + ? ? ? static unsigned char flush_toggle;
> +
> + ? ? ? asm("mrc p15, 0, %0, c5, c1, 0\n" /* read adfsr for fault status */
> + ? ? ? ? ? : "=r" (regval));
> + ? ? ? if (regval == 0x2) {
> + ? ? ? ? ? ? ? /* Fault was caused by icache parity error. Alternate
> + ? ? ? ? ? ? ? ?* simply retrying the access and flushing the icache. */
> + ? ? ? ? ? ? ? flush_toggle ^= 1;
> + ? ? ? ? ? ? ? if (flush_toggle)
> + ? ? ? ? ? ? ? ? ? ? ? asm("mcr p15, 0, %0, c7, c5, 0\n"
> + ? ? ? ? ? ? ? ? ? ? ? ? ? :
> + ? ? ? ? ? ? ? ? ? ? ? ? ? : "r" (regval)); /* input value is ignored */

Wouldn't you need regval = 0 here, to clear the EFSR ?


> + ? ? ? ? ? ? ? /* Clear fault in EFSR. */
> + ? ? ? ? ? ? ? asm("mcr p15, 7, %0, c15, c0, 1\n"
> + ? ? ? ? ? ? ? ? ? :
> + ? ? ? ? ? ? ? ? ? : "r" (regval));
> + ? ? ? ? ? ? ? /* Clear fault in ADFSR. */
> + ? ? ? ? ? ? ? regval = 0;
> + ? ? ? ? ? ? ? asm("mcr p15, 0, %0, c5, c1, 0\n"
> + ? ? ? ? ? ? ? ? ? :
> + ? ? ? ? ? ? ? ? ? : "r" (regval));
> + ? ? ? ? ? ? ? return 0;
> + ? ? ? }
> +#endif
> +
