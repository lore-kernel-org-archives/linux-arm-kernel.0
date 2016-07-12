From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Jul 2016 14:00:56 -0300
Subject: [PATCH v5 3/3] clk: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1468235521-3163-3-git-send-email-p.zabel@pengutronix.de>
References: <1468235521-3163-1-git-send-email-p.zabel@pengutronix.de>
 <1468235521-3163-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5AwUXOY5sE6=B60A68h7FNFNkkvsNBvBMVS5dDQSc+J4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Mon, Jul 11, 2016 at 8:12 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk
> tree, the glitchy parent mux of ldb_di[x]_clk can cause a glitch to
> enter the ldb_di_ipu_div divider. If the divider gets locked up, no
> ldb_di[x]_clk is generated, and the LVDS display will hang when the
> ipu_di_clk is sourced from ldb_di_clk.
>
> To fix the problem, both the new and current parent of the ldb_di_clk
> should be disabled before the switch. This patch ensures that correct
> steps are followed when ldb_di_clk parent is switched in the beginning
> of boot. The glitchy muxes are then registered as read-only. The clock
> parent can be selected using the assigned-clocks and
> assigned-clock-parents properties of the ccm device tree node:
>
>         &clks {
>                 assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
>                                   <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
>                 assigned-clock-parents = <&clks IMX6QDL_CLK_MMDC_CH1_AXI>,
>                                          <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>;
>         };
>
> The issue is explained in detail in EB821 ("LDB Clock Switch Procedure &
> i.MX6 Asynchronous Clock Switching Guidelines") [1].
>
> [1] http://www.nxp.com/files/32bit/doc/eng_bulletin/EB821.pdf
>
> Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

On a previous version of the patch you reported issues on Novena:
http://www.spinics.net/lists/arm-kernel/msg476324.html

Does v5 work fine on your board?

Christian,

I remember you had an automated way of testing this LDB glitch
problem. Would it be possible to run v5 through your test setup?

Thanks,

Fabio Estevam
