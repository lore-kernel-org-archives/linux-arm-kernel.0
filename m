From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Oct 2013 12:05:57 +0100
Subject: [PATCH 3/5] ARM: ux500: fix clock for GPIO blocks 6 and 7
In-Reply-To: <1382087112-31665-1-git-send-email-linus.walleij@linaro.org>
References: <1382087112-31665-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131018110557.GW19112@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Linus Walleij wrote:

> The clock assignment in the device tree for GPIO blocks 6
> and 7 was incorrect, indicating this was managed by bit 1 on
> PRCC 2 while it was in fact bit 11 on PRCC 2.

Nice catch.

It's also wrong in the driver:

        clk = clk_reg_prcc_pclk("p2_pclk10", "per2clk", clkrst2_base,
                                BIT(10), 0);
        clk_register_clkdev(clk, "hsit_hclk", "ste_hsi.0");
        PRCC_PCLK_STORE(clk, 2, 10);
 
        clk = clk_reg_prcc_pclk("p2_pclk11", "per2clk", clkrst2_base,
                                BIT(11), 0);
        clk_register_clkdev(clk, NULL, "gpio.6");
        clk_register_clkdev(clk, NULL, "gpio.7");
        clk_register_clkdev(clk, NULL, "gpioblock1");
        PRCC_PCLK_STORE(clk, 2, 1);
 
        clk = clk_reg_prcc_pclk("p2_pclk12", "per2clk", clkrst2_base,
                                BIT(12), 0);
        PRCC_PCLK_STORE(clk, 2, 12);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
