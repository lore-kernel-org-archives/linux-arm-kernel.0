From: rmallon@gmail.com (Ryan Mallon)
Date: Thu, 15 Mar 2012 11:13:46 +1100
Subject: [PATCH v4 09/10] pwm: Add PXA support
In-Reply-To: <1331740593-10807-10-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-10-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F61343A.80103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/12 02:56, Thierry Reding wrote:

> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Changes in v3:
>   - update PWM ops for changes in patch 2

Couple of quick notes, mostly for future work.

> +	/* NOTE: the clock to PWM has to be enabled first
> +	 * before writing to the registers
> +	 */
> +	clk_enable(pc->clk);


Should be fixed to also call clk_prepare (and clk_unprepare after
clk_disable). Could be done in a follow up patch.

> +	__raw_writel(prescale, pc->mmio_base + offset + PWMCR);
> +	__raw_writel(dc, pc->mmio_base + offset + PWMDCR);
> +	__raw_writel(pv, pc->mmio_base + offset + PWMPCR);


Should we fix this driver to use readl/writel instead of the __raw
variants? The memory is properly ioremaped, and to my understanding the
__raw memory accessors should be avoided outside of core code. This
could be done in a follow up patch if you want to keep this patch as
mostly just a move of the code.

~Ryan
