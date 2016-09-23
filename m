From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 23 Sep 2016 19:12:15 -0300
Subject: [PATCH 3/3] clk: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1474036587-13819-3-git-send-email-fabio.estevam@nxp.com>
References: <1474036587-13819-1-git-send-email-fabio.estevam@nxp.com>
 <1474036587-13819-3-git-send-email-fabio.estevam@nxp.com>
Message-ID: <CAOMZO5D7=A=ms_iq1D+Fgg4wKpRx-aScm5V=avxRPu62rFymzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Sep 16, 2016 at 11:36 AM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
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
> Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Reviewed-by: Akshay Bhat <akshay.bhat@timesys.com>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> Tested-by: Charles Kang <Charles.Kang@advantech.com.tw>
> Acked-by: Shawn Guo <shawnguo@kernel.org>

Do you think this one could be applied to clk-next? It fixes an
important LVDS bug.

Thanks
