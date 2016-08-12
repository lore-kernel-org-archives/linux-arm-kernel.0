From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 12 Aug 2016 18:30:16 +0200
Subject: [PATCH v3 3/7] clk: rockchip: rk3399: fix incorrect GATE bits for
 {c, g}pll_aclk_perihp_src
In-Reply-To: <1470122401-31934-4-git-send-email-zhengxing@rock-chips.com>
References: <1470122401-31934-1-git-send-email-zhengxing@rock-chips.com>
 <1470122401-31934-4-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1511923.bnfOuYbtIQ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 2. August 2016, 15:19:57 schrieb Xing Zheng:
> Sorry to refer incorrect clock diagram, we double check it that the bits
> configuration of the Xpll_aclk_perihp_src need to be fixed:
> bit 1 - shows aclk_perihp_cpll_src_en
> bit 0 - shows aclk_perihp_gpll_src_en
> 
> Through the testing that plug/unplug the USB ethernet cable on the RK3399
> kevin board.
> 
> 1. the hclk_host0 and hclk_host1 are endpoint clocks:
> cpll --> G5[1] --> aclk_perihp_cpll_src --\              |--> hclk_host0
> 
>                                           | --> ... ---> |
> 
> gpll --> G5[0] --> aclk_perihp_gpll_src --/              |--> hclk_host1
> 
> 2. there is no clock below the cpll_aclk_perihp_src,
>    and the hclk_hostX are below the gpll_aclk_perihp_src:
>     pll_cpll                              1            1   800000000        
>  0 0 cpll                               7           19   800000000         
> 0 0 cpll_aclk_perihp_src            0            0   800000000          0 0
> ...
>     pll_gpll                              1            1   594000000        
>  0 0 gpll                              10           10   594000000         
> 0 0 gpll_aclk_perihp_src            2            2   594000000          0 0
> hclk_perihp               5            5    74250000          0 0
> hclk_host1_arb         2            2    74250000          0 0 hclk_host1  
>           2            2    74250000          0 0 hclk_host0_arb         2 
>           2    74250000          0 0 hclk_host0             2            2 
>   74250000          0 0
> 
> 3. by default, G5[0] and G5[1] are enabled:
> localhost ~ # mem r 0xff760314
> 0x000003e0
> 
> 4. close the G5[1] (aclk_perihp_cpll_src), and plug/unplug USB ethernet
> cable, the DUT still works well:
> localhost ~ # mem w 0xff760314 0xffff03e2
> localhost ~ # mem r 0xff760314
> 0x000003e2
> plug/unplug, the work statue is ok
> 
> 5. close the G5[0] (aclk_perihp_gpll_src), , and plug/unplug USB ethernet
> cable, the DUT will be crashed:
> localhost ~ # mem w 0xff760314 0xffff03e1
> localhost ~ # mem r 0xff760314
> 0x000003e1
> plug/unplug, the DUT is crashed
> 
> Summary:
> bit 1 - shows aclk_perihp_cpll_src_en
> bit 0 - shows aclk_perihp_gpll_src_en
> 
> Fixes: 3bd14ae9da91 ("clk: rockchip: fix incorrect parent for rk3399's
> {c,g}pll_aclk_perihp_src") Signed-off-by: Xing Zheng
> <zhengxing@rock-chips.com>

applied to my clk-fixes branch for 4.8


Thanks
Heiko
