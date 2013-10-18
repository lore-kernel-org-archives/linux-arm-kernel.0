From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Oct 2013 12:03:14 +0100
Subject: [PATCH 4/5] ARM: ux500: fix I2C4 clock bit
In-Reply-To: <1382087123-31702-1-git-send-email-linus.walleij@linaro.org>
References: <1382087123-31702-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131018110314.GV19112@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Linus Walleij wrote:

> The PCLK for I2C4 is controlled by bit 10 in the PCKEN registers
> while the KCLK is controlled by bit 9 on the KCKEN, it's
> one of these odd assymetric things. Correct the PCLK bit to 10.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/ste-dbx5x0.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> index 5112f4c..b7d1738 100644
> --- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> @@ -694,7 +694,7 @@
>  
>  			clock-frequency = <400000>;
>  
> -			clocks = <&prcc_kclk 1 9>, <&prcc_pclk 1 9>;
> +			clocks = <&prcc_kclk 1 10>, <&prcc_pclk 1 9>;
>  			clock-names = "i2cclk", "apb_pclk";
>  		};
>  

NACK: Bit 10 is MSP1

        clk = clk_reg_prcc_kclk("p1_i2c4_kclk", "i2cclk",
                        clkrst1_base, BIT(9), CLK_SET_RATE_GATE);
        clk_register_clkdev(clk, NULL, "nmk-i2c.4");
        PRCC_KCLK_STORE(clk, 1, 9);
 
        clk = clk_reg_prcc_kclk("p1_msp3_kclk", "msp1clk",
                        clkrst1_base, BIT(10), CLK_SET_RATE_GATE);
        clk_register_clkdev(clk, NULL, "msp3");
        clk_register_clkdev(clk, NULL, "ux500-msp-i2s.3");
        PRCC_KCLK_STORE(clk, 1, 10);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
