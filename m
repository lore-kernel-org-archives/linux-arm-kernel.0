From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 04 Apr 2013 17:33:51 -0600
Subject: [PATCH V2] clk: tegra: defer application of init table
In-Reply-To: <1365111340-2143-1-git-send-email-swarren@wwwdotorg.org>
References: <1365111340-2143-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <515E0DDF.6050008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 03:35 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Tegra clock driver is initialized during the ARM machine descriptor's
> .init_irq() hook. It can't be initialized earlier, since dynamic memory
> usage is required. It can't be initialized later, since the .init_timer()
> hook needs the clocks initialized. However, at this time, udelay()
> doesn't work.
> 
> The Tegra clock initialization table may enable some PLLs. Enabling a PLL
> may require usage of udelay(). Hence, this can't happen right when the
> clock driver is initialized.
> 
> To solve this, separate the clock driver initialization from the clock
> table processing, so they can execute at separate times.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Mike, the Tegra114 CCF V9 series assume this is applied first. Hence, I'm
> looking for an ack on this too. Thanks!

I've applied this to Tegra's for-3.10/clk branch, since Mike already
acked the Tegra114 CCF V9, which requires this patch, and embodies use
of it anyway.
