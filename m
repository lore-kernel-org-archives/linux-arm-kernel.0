From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 11:12:33 +0800
Subject: [PATCH v3 2/4] driver: clk: imx: add new gate/gate2 wrapper
 funtion
In-Reply-To: <1517968819-12869-2-git-send-email-ping.bai@nxp.com>
References: <1517968819-12869-1-git-send-email-ping.bai@nxp.com>
 <1517968819-12869-2-git-send-email-ping.bai@nxp.com>
Message-ID: <20180224031232.GW3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Lucas

On Wed, Feb 07, 2018 at 10:00:17AM +0800, Bai Ping wrote:
> Add new gate/gate2 wrapper function to register clocks with optional flags.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  drivers/clk/imx/clk.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index d69c4bb..8076ec0 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -123,6 +123,13 @@ static inline struct clk *imx_clk_gate(const char *name, const char *parent,
>  			shift, 0, &imx_ccm_lock);
>  }
>  
> +static inline struct clk *imx_clk_gate_flags(const char *name, const char *parent,
> +		void __iomem *reg, u8 shift, unsigned long flags)
> +{
> +	return clk_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
> +			shift, 0, &imx_ccm_lock);
> +}
> +
>  static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
>  		void __iomem *reg, u8 shift)
>  {
> @@ -137,6 +144,13 @@ static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
>  			shift, 0x3, 0, &imx_ccm_lock, NULL);
>  }
>  
> +static inline struct clk *imx_clk_gate2_flags(const char *name, const char *parent,
> +		void __iomem *reg, u8 shift, unsigned long flags)
> +{
> +	return clk_register_gate2(NULL, name, parent, flags | CLK_SET_RATE_PARENT, reg,
> +			shift, 0x3, 0, &imx_ccm_lock, NULL);
> +}
> +

Lucas' patch 'clk: imx: add clock driver for i.MX8MQ CCM' [1] adds an
imx_clk_gate2_flags() as well, but with different implementation.  Can
you guys talk to each other to sort it out?

Shawn

[1] https://patchwork.kernel.org/patch/10195759/

>  static inline struct clk *imx_clk_gate2_shared(const char *name,
>  		const char *parent, void __iomem *reg, u8 shift,
>  		unsigned int *share_count)
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
