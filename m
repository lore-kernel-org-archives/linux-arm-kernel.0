From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 25 Jul 2013 10:29:13 +0200
Subject: [PATCH v1 05/14] clk: msm: Add support for phase locked loops
 (PLLs)
In-Reply-To: <1374713022-6049-6-git-send-email-sboyd@codeaurora.org>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
 <1374713022-6049-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <6003715.TMZ71jDUbL@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wednesday 24 of July 2013 17:43:33 Stephen Boyd wrote:
> Add support for MSM's PLLs (phase locked loops). This is
> sufficient enough to be able to determine the rate the PLL is
> running at. We can add rate setting support later when it's
> needed.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/clock/msm.txt |  40 ++++
>  drivers/clk/Kconfig                             |   2 +
>  drivers/clk/Makefile                            |   1 +
>  drivers/clk/msm/Kconfig                         |   4 +
>  drivers/clk/msm/Makefile                        |   3 +
>  drivers/clk/msm/clk-pll.c                       | 233
> ++++++++++++++++++++++++ drivers/clk/msm/clk-pll.h                     
>  |  43 +++++
>  7 files changed, 326 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/msm.txt
>  create mode 100644 drivers/clk/msm/Kconfig
>  create mode 100644 drivers/clk/msm/Makefile
>  create mode 100644 drivers/clk/msm/clk-pll.c
>  create mode 100644 drivers/clk/msm/clk-pll.h
[snip]
> diff --git a/drivers/clk/msm/clk-pll.h b/drivers/clk/msm/clk-pll.h
> new file mode 100644
> index 0000000..4e63a5e
> --- /dev/null
> +++ b/drivers/clk/msm/clk-pll.h
> @@ -0,0 +1,43 @@
> +/*
> + * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms. + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __MSM_CLK_PLL_H__
> +#define __MSM_CLK_PLL_H__
> +
> +struct device;
> +struct clk;
> +struct clk_init_data;
> +
> +struct pll_desc {
> +	void __iomem *base;
> +	u16 l_reg;
> +	u16 m_reg;
> +	u16 n_reg;
> +	u16 config_reg;
> +	u16 mode_reg;
> +	u16 status_reg;
> +	u8 status_bit;
> +};
> +
> +struct pll_vote_desc {
> +	void __iomem *base;
> +	u16 vote_reg;
> +	u8 vote_bit;
> +};
> +
> +extern struct clk *pll_clk_register(struct device *dev, struct pll_desc
> *desc, +		struct clk_init_data *init);
> +extern struct clk *pll_vote_clk_register(struct device *dev,
> +		struct pll_vote_desc *desc, struct clk_init_data *init);

I don't think such generic name is good here. What about prefixing them 
with msm_ or qcom_ string?

Best regards,
Tomasz
