From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 May 2010 20:19:04 +0100
Subject: [PATCH 1/5] i.MX27: add suspend to RAM support
In-Reply-To: <1274440363-435-1-git-send-email-eric@eukrea.com>
References: <1274440363-435-1-git-send-email-eric@eukrea.com>
Message-ID: <20100521191904.GD11042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 01:12:39PM +0200, Eric B?nard wrote:
> +#include <linux/kernel.h>
> +#include <linux/suspend.h>
> +#include <asm/io.h>

linux/io.h

> +#include <mach/system.h>
> +#include <mach/mx27.h>
> +
> +static int mx27_suspend_enter(suspend_state_t state)
> +{
> +	u32 cscr;
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		/* Clear MPEN and SPEN to disable MPLL/SPLL */
> +		cscr = __raw_readl(MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
> +		cscr &= 0xFFFFFFFC;
> +		__raw_writel(cscr, MX27_IO_ADDRESS(MX27_CCM_BASE_ADDR));
> +		/* Executes WFI */
> +		arch_idle();
> +		break;
> +
> +	default:
> +		return -1;

-Exxx ?
