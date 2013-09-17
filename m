From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Sep 2013 14:04:06 -0600
Subject: [PATCH] ARM: tegra: split tegra_pmc_init() in two
In-Reply-To: <1377034065-26373-1-git-send-email-swarren@wwwdotorg.org>
References: <1377034065-26373-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5238B5B6.9040405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 03:27 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra's board file currently initializes clocks much earlier than those
> for most other ARM SoCs. The reason is:
> 
> * The PMC HW block is involved in the path of some interrupts (i.e. it
> inverts, or not, the IRQ input pin dedicated to the PMIC).
> 
> * So, that part of the PMC must be initialized early so that the IRQ
> polarity is correct.
> 
> * The PMC initialization is currently monolithic, and the PMC has some
> clock inputs, so the init routine ends up calling of_clk_get_by_name(),
> and hence clocks must be set up early too.
> 
> In order to defer clock initialization to the more typical location,
> split out the portions of tegra_pmc_init() that are truly IRQ-related
> into a separate tegra_pmc_init_irq(), which can be called from the
> machine descriptor's .init_irq() function, and defer the rest until
> the machine descriptor's .init_machine() function. This allows the
> clock initiliazation to happen from the machine descriptor's
> .init_time() function, as is typical.

I have applied this to Tegra's for-3.13/deps-for-clk-init-hook branch.

Sebastian, I'll send out a pull request to you containing this patch for
inclusion in your time hook series shortly.
