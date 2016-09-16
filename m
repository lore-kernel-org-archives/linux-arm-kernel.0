From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 Sep 2016 16:18:16 -0700
Subject: [PATCH] clk: zx: fix pointer case warnings
In-Reply-To: <20160915154618.3007024-1-arnd@arndb.de>
References: <20160915154618.3007024-1-arnd@arndb.de>
Message-ID: <20160916231816.GZ7243@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15, Arnd Bergmann wrote:
> The zx296718 clock driver has a creative way of assigning the register
> values for each clock, by initializing an __iomem pointer to an
> offset and then later adding the base (from ioremap) on top
> with a cast to u64. This fail on all 32-bit architectures during
> compile testing:
> 
> drivers/clk/zte/clk-zx296718.c: In function 'top_clocks_init':
> drivers/clk/zte/clk-zx296718.c:554:35: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>    zx296718_pll_clk[i].reg_base += (u64)reg_base;
> drivers/clk/zte/clk-zx296718.c:579:29: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> drivers/clk/zte/clk-zx296718.c:592:31: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
> 
> It would be nice to avoid all the casts, but I decided to simply
> shut up the warnings by changing the type from u64 to uintptr_t,
> which does the right thing in practice.

Thanks. I usually push people to have descriptor structures that
they use to create these things at runtime but that isn't working
out so great all the time and we don't really have a precedent
for one way or the other. This will work for now.

Applied to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
