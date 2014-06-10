From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 10 Jun 2014 14:49:18 +0200
Subject: [PATCH] ARM: exynos: move sysram info to exynos.c
In-Reply-To: <1401770866-1975-1-git-send-email-olof@lixom.net>
References: <1401770866-1975-1-git-send-email-olof@lixom.net>
Message-ID: <5396FECE.7010405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 03.06.2014 06:47, Olof Johansson wrote:
> This solves a problem with building with CONFIG_SMP=n due to missing
> sysram_base_addr (or sysram_ns_base_addr) variables.
> 
> The new setup method is more awkward than I'd like for it to be, but
> it can't be done in init_early() since ioremap is not yet available,
> but it needs to happen before SMP.
> 
> Reported-by: Russell King <linux@arm.linux.org.uk>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> I'm not entirely happy with the solution here, especially the dual
> call path. The platsmp.c->exynos.c call isn't ideal either but I'm less
> worried about that. Seemed overkill to create a new c file just for this.
> 
> I've tested to make sure this still works on arndale, and the build
> errors as reported by Russell are definitely gone.

In general, I'm okay with this patch, so if nobody is willing to find a
better way feel free to add my Reviewed-by.

> 
> Better ideas welcome.
> 

Probably the best idea would be to find a way to always call
exynos_sysram_init() after DT unflattening and before SMP
initialization. Some platforms (e.g. tegra) abuse .init_irq callback for
this, e.g.:

mach-tegra/tegra.c:
	static void __init tegra_dt_init_irq(void)
	{
		tegra_pmc_init_irq();
		tegra_init_irq();
		irqchip_init();
		tegra_legacy_irq_syscore_init();
	}

We could do the same on Exynos if this is considered better.

Best regards,
Tomasz
