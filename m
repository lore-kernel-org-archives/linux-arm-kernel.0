From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Jan 2017 10:57:33 +0100
Subject: [PATCH 04/11] clk: sunxi-ng: Support separately grouped PLL lock
 status register
In-Reply-To: <20170124023230.3990-5-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
 <20170124023230.3990-5-wens@csie.org>
Message-ID: <20170126095733.azlzxmz63vxajlen@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 24, 2017 at 10:32:23AM +0800, Chen-Yu Tsai wrote:
> On the Allwinner A80 SoC, the PLL lock status indicators are grouped
> together in a separate register, as opposed to being scattered in each
> PLL's configuration register.
> 
> Add a flag to support this.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi-ng/ccu_common.c | 8 ++++++--
>  drivers/clk/sunxi-ng/ccu_common.h | 2 ++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
> index 51d4bac97ab3..3fd0c3331aff 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.c
> +++ b/drivers/clk/sunxi-ng/ccu_common.c
> @@ -25,13 +25,17 @@ static DEFINE_SPINLOCK(ccu_lock);
>  
>  void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock)
>  {
> +	void __iomem *addr;
>  	u32 reg;
>  
>  	if (!lock)
>  		return;
>  
> -	WARN_ON(readl_relaxed_poll_timeout(common->base + common->reg, reg,
> -					   reg & lock, 100, 70000));
> +	addr = common->base + common->reg;
> +	if (common->features & CCU_FEATURE_LOCK_REG)
> +		addr = common->base + common->lock_reg;

I'd rather have an else here (but it's really just a nitpick).

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170126/155f0328/attachment.sig>
