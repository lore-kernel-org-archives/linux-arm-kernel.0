From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 11 Jun 2012 18:28:04 +0200
Subject: [PATCHv2 11/12] ARM: OMAP4: clock data: add clockdomains for
 clocks used as main clocks
In-Reply-To: <20120611004623.20034.52760.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
 <20120611004623.20034.52760.stgit@dusk>
Message-ID: <4FD61C94.4030004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 6/11/2012 2:46 AM, Paul Walmsley wrote:
> Until the OMAP4 code is converted to disable the use of the clock
> framework-based clockdomain enable/disable sequence, any clock used as
> a hwmod main_clk must have a clockdomain associated with it.

But why? The clock domain information is already present in every hwmod 
nodes for OMAP4.

> This
> patch populates some clock structure clockdomain names to resolve the
> following warnings during kernel init:
>
> omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
> omap_hwmod: trace_clk_div_ck: missing clockdomain for trace_clk_div_ck.
> omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
> omap_hwmod: ddrphy_ck: missing clockdomain for ddrphy_ck.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 2172f66..e2b701e 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -84,6 +84,7 @@ static struct clk slimbus_clk = {
>
>   static struct clk sys_32k_ck = {
>   	.name		= "sys_32k_ck",
> +	.clkdm_name	= "prm_clkdm",

In fact, neither prm_clkdm not cm_clkdm are valid clock domain on OMAP4 :-(.

I've just realized that you introduced that for 3.5, but this is wrong. 
We should not start adding some fake clock domains just because the fmwk 
is not smart enough to allow a NULL clock domain.

The clkdomain should be optional, at least for clock nodes.
There is no need to enforce the presence of the clock domain in the 
structure. We should remove the warning and test the clkdm attribute 
before de-referencing it inside the clock core code.

This is the only proper fix for that issue for my point of view.

In a period of data size reduction, adding some fake information does 
not seems to be the right approach.
Don't you think so?

Regards,
Benoit


PS: I think we should revert 6ba5a69ee92c29c2ffc814dad6ac61c4cd49090c 
(ARM: OMAP2+: clockdomains: make {prm,cm}_clkdm common) and fix the 
OMAP4 hwmod data.
