From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 14 Jan 2017 12:19:45 +0100
Subject: [PATCH] clk: rockchip: rk3288: make aclk_vio1_niu a critical clock
In-Reply-To: <1484097992-9118-1-git-send-email-jacob-chen@iotwrt.com>
References: <1484097992-9118-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <2173949.kdqYFWM6te@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

Am Mittwoch, 11. Januar 2017, 09:26:32 CET schrieb Jacob Chen:
> According to the pd blocks, VIO1_NIU is required by RGA,ISP and VOP1.
> Then at least one VIO_NIU should be turned on to supply eDP, HDMI, MIPI.
> 
> If eDP,HDMI,MIPI is inited early than VOP or RGA is inited early than VOP1,
> system will hang.
> 
> So make aclk_vio1_niu a critical clock and turn it on at all times.

NIU clocks are part of the interconnect, which we do not model at all yet,
so I guess all of those should never be turned off (until an interconnect 
driver handles them).

Could you just make all of them critical in one go please, so that we don't 
have to each clock on its own once things break?


Thanks
Heiko

> 
> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c
> b/drivers/clk/rockchip/clk-rk3288.c index f071c24..59ee244 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -815,6 +815,7 @@ static struct rockchip_clk_branch rk3288_clk_branches[]
> __initdata = { static const char *const rk3288_critical_clocks[]
> __initconst = { "aclk_cpu",
>  	"aclk_peri",
> +	"aclk_vio1_niu",
>  	"hclk_peri",
>  	"pclk_pd_pmu",
>  };
