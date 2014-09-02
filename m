From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 02 Sep 2014 22:34:47 +0200
Subject: [PATCH v2 0/4] ARM: rockchip: add dma support
In-Reply-To: <3132019.Q6dzkQ3ylK@diego>
References: <3132019.Q6dzkQ3ylK@diego>
Message-ID: <7967994.e4G7JcVEG0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 14. August 2014, 22:59:48 schrieb Heiko St?bner:
> All Rockchip SoCs currently supported use pl330 dma controllers.
> The first patch introduces the concept of critical clocks, stolen from
> sunxi, as some core clocks shouldn't be disabled under normal circumstances.
> The patch is necessary, as the amba bus uses strict clock gating, which
> without this patch results in the core aclk getting disabled halting the
> system, before other components are able to probe and maybe claim their
> clocks.
> 
> As the patches have no compile-time dependency on each other, the patchset
> could be split with the first patch going through the clock tree and the
> other three going through arm-soc.

I've add the patches 2-4 to a v3.18-next/dma branch.


> 
> changes since v1:
> - address comment Sergei Shtylyov and rename nodes to dma-controller
> - address comments from Doug Anderson:
>   - order by address
>   - rename the controller phandles to reflect the naming in the TRMs
>     On the rk3066/rk3188 there is one diversion in this regard.
>     The clocks really use indices 1 and 2 while the controllers references
>     use 0 and 1 (dmac0 and dmac1), so to prevent to much confusion I used
>     the clock indices for the handles instead of having dmac0 use ACLK_DMAC1
> etc.
> - address comment from Andreas F?rber adding suffixes of "_s" for the
>   secure and "_ns" for the non-secure variants of the first controller
>   As (nearly) all boards seem to use the secure controller, this becomes
>   the default
> 
> Heiko Stuebner (4):
>   clk: rockchip: protect critical clocks from getting disabled
>   ARM: rockchip: enable the AMBA bus
>   ARM: dts: rockchip: add rk3288 dma controllers
>   ARM: dts: rockchip: add rk3188 dma controllers
> 
>  arch/arm/boot/dts/rk3288.dtsi     | 38
> ++++++++++++++++++++++++++++++++++++++ arch/arm/boot/dts/rk3xxx.dtsi     |
> 38 ++++++++++++++++++++++++++++++++++++++ arch/arm/mach-rockchip/Kconfig   
> |  1 +
>  drivers/clk/rockchip/clk-rk3188.c |  7 +++++++
>  drivers/clk/rockchip/clk-rk3288.c |  7 +++++++
>  drivers/clk/rockchip/clk.c        | 13 +++++++++++++
>  drivers/clk/rockchip/clk.h        |  1 +
>  7 files changed, 105 insertions(+)
