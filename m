From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Aug 2018 19:42:10 -0300
Subject: [RFC] clk: imx6: Mark imx_clk_mux as glitchy by default
In-Reply-To: <e56c6f0acfe7afb885d2cb67e1e069f7edd0d2d7.1534879459.git.leonard.crestez@nxp.com>
References: <e56c6f0acfe7afb885d2cb67e1e069f7edd0d2d7.1534879459.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5Dr9NUXuu+LECp2QHZLRhfbymHK23yCCFW-9jB=VXNn+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leonard,

On Tue, Aug 21, 2018 at 4:34 PM, Leonard Crestez
<leonard.crestez@nxp.com> wrote:

> More concretely on 6qp-sdb blanking the display happens like this:
>  * imx_ldb_encoder_disable switches ipu1_di0_sel to ipu1_di0_pre from ldb_di1_podf
>  * reparenting to ipu1_di0_pre enables it and its parents up to pll5
>  * possibly glitchy muxing
>  * ipu_di_disable disables ipu1_di0 (and parents, up to pll5)

Have you seen such glitch issue in practice with the LDB clocks?

We have already taken care of it in these commits:

commit 5d283b083800867dc329e6433576664bf0fc18d5
Author: Fabio Estevam <fabio.estevam@nxp.com>
Date:   Mon Oct 17 22:29:14 2016 -0200

    clk: imx6: Fix procedure to switch the parent of LDB_DI_CLK

    Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk
    tree, the glitchy parent mux of ldb_di[x]_clk can cause a glitch to
    enter the ldb_di_ipu_div divider. If the divider gets locked up, no
    ldb_di[x]_clk is generated, and the LVDS display will hang when the
    ipu_di_clk is sourced from ldb_di_clk.

    To fix the problem, both the new and current parent of the ldb_di_clk
    should be disabled before the switch. This patch ensures that correct
    steps are followed when ldb_di_clk parent is switched in the beginning
    of boot. The glitchy muxes are then registered as read-only. The clock
    parent can be selected using the assigned-clocks and
    assigned-clock-parents properties of the ccm device tree node:

            &clks {
                    assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
                                      <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
                    assigned-clock-parents = <&clks IMX6QDL_CLK_MMDC_CH1_AXI>,
                                             <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>;
            };

    The issue is explained in detail in EB821 ("LDB Clock Switch Procedure &
    i.MX6 Asynchronous Clock Switching Guidelines") [1].

    [1] http://www.nxp.com/files/32bit/doc/eng_bulletin/EB821.pdf

    Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
    Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    Reviewed-by: Akshay Bhat <akshay.bhat@timesys.com>
    Tested-by Joshua Clayton <stillcompiling@gmail.com>
    Tested-by: Charles Kang <Charles.Kang@advantech.com.tw>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

commit 03d576f202e8cd40d500aa4f7594ad702d861096
Author: Philipp Zabel <p.zabel@pengutronix.de>
Date:   Mon Oct 17 22:29:13 2016 -0200

    clk: imx6: Make the LDB_DI0 and LDB_DI1 clocks read-only

    Due to incorrect placement of the clock gate cell in the ldb_di[x]_clk
    tree, the glitchy parent mux of ldb_di[x]_clk can cause a glitch to
    enter the ldb_di_ipu_div divider. If the divider gets locked up, no
    ldb_di[x]_clk is generated, and the LVDS display will hang when the
    ipu_di_clk is sourced from ldb_di_clk.

    To fix the problem, both the new and current parent of the ldb_di_clk
    should be disabled before the switch. As this can not be guaranteed by
    the clock framework during runtime, make the ldb_di[x]_sel muxes read-only.
    A workaround to set the muxes once during boot could be added to the
    kernel or bootloader.

    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

,but I think we should also take care of the other glitchy muxes as
you propose here.
