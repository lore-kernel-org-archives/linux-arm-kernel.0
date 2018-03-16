From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 16 Mar 2018 06:30:13 +0000
Subject: [PATCH v5 2/4] clk: imx: add new gate/gate2 wrapper funtion
In-Reply-To: <1520846957-22348-2-git-send-email-ping.bai@nxp.com>
References: <1520846957-22348-1-git-send-email-ping.bai@nxp.com>
 <1520846957-22348-2-git-send-email-ping.bai@nxp.com>
Message-ID: <AM3PR04MB3065CB215B6264649D64C9B80D70@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jacky Bai
> Sent: Monday, March 12, 2018 5:29 PM
> To: sboyd at kernel.org; robh+dt at kernel.org; shawnguo at kernel.org;
> kernel at pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; linux-clk at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> A.s. Dong <aisheng.dong@nxp.com>; jacky.baip at gmail.com
> Subject: [PATCH v5 2/4] clk: imx: add new gate/gate2 wrapper funtion
> 
> Add new gate/gate2 wrapper function to register clocks with optional flags.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

AFAIK Stephen requested to switch to clk_hw based APIs when reviewing my
mx7ulp clk driver. We may need some comments from Stephen here.

Hi Stefen,

Do you have any comments about this?

Regards
Dong Aisheng

> ---
>  change from v3->v4:
>  - no
>  change from v4->5:
>  - optimize commit subject
> ---
>  drivers/clk/imx/clk.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> d69c4bb..8076ec0 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -123,6 +123,13 @@ static inline struct clk *imx_clk_gate(const char
> *name, const char *parent,
>  			shift, 0, &imx_ccm_lock);
>  }
> 
> +static inline struct clk *imx_clk_gate_flags(const char *name, const char
> *parent,
> +		void __iomem *reg, u8 shift, unsigned long flags) {
> +	return clk_register_gate(NULL, name, parent, flags |
> CLK_SET_RATE_PARENT, reg,
> +			shift, 0, &imx_ccm_lock);
> +}
> +
>  static inline struct clk *imx_clk_gate_dis(const char *name, const char
> *parent,
>  		void __iomem *reg, u8 shift)
>  {
> @@ -137,6 +144,13 @@ static inline struct clk *imx_clk_gate2(const char
> *name, const char *parent,
>  			shift, 0x3, 0, &imx_ccm_lock, NULL);  }
> 
> +static inline struct clk *imx_clk_gate2_flags(const char *name, const char
> *parent,
> +		void __iomem *reg, u8 shift, unsigned long flags) {
> +	return clk_register_gate2(NULL, name, parent, flags |
> CLK_SET_RATE_PARENT, reg,
> +			shift, 0x3, 0, &imx_ccm_lock, NULL); }
> +
>  static inline struct clk *imx_clk_gate2_shared(const char *name,
>  		const char *parent, void __iomem *reg, u8 shift,
>  		unsigned int *share_count)
> --
> 1.9.1
