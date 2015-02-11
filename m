From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 11 Feb 2015 14:00:48 +0100
Subject: [PATCH RFC v8 11/21] Documentation: dt-bindings: Add bindings
 for Synopsys DW MIPI DSI DRM bridge driver
In-Reply-To: <20150211072128.GA13301@victor>
References: <1420014219-915-1-git-send-email-Ying.Liu@freescale.com>
 <1420014219-915-12-git-send-email-Ying.Liu@freescale.com>
 <1423131004.3207.27.camel@pengutronix.de> <20150206081318.GA15088@victor>
 <20150211072128.GA13301@victor>
Message-ID: <1423659648.4680.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liu,

Am Mittwoch, den 11.02.2015, 15:21 +0800 schrieb Liu Ying:
[...]
> Our internal MIPI DSI SoC owner gave me some feedbacks on the clock sources.
> According to him, the Synopsys DesignWare MIPI DSI host controller needs four
> clock sources from an application platform - pclk, refclk, cfg_clk and dpipclk.
> These clocks are mentioned in the "DesignWare Cores MIPI DSI Host Controller
> Databook, 1.01a1.30a.pdf" documentation.
> 
> Quote some words from the documentation:
> pclk    - APB clock signal.
> refclk  - D-PHY reference clock used for Master-side serial clock generation in
>           clock multiplying unit(PLL).
> cfg_clk - D-PHY Configuration clock used for the initialization of the PHY. It
>           is also used for exiting ULPS state.
> dpipclk - Input Pixel clock signal.
> 
> The below table reflects how does i.MX6Q/DL provide the pclk, refclk and cfg_clk
> for the DesignWare MIPI DSI host controller, according to the SoC owner.
>  ----------------------------------------------------------------------------
> | Synopsys      |                     i.MX6Q/DL MIPI DSI                     |
> | DesignWare    |------------------------------------------------------------|
> | documentation |    clock   |     clock root     |       CCM_CCGR bits      |
> |---------------|------------|--------------------|--------------------------|
> |     pclk      |   ips_clk  |    ipg_clk_root    | mipi_core_cfg_clk_enable |
> |---------------|------------|--------------------|--------------------------|
> |    refclk     | pll_refclk | video_27m_clk_root | mipi_core_cfg_clk_enable |
> |---------------|------------|--------------------|--------------------------|
> |    cfg_clk    |   cfg_clk  | video_27m_clk_root | mipi_core_cfg_clk_enable |
>  ----------------------------------------------------------------------------
> 
> I think we should add a new clock "IMX6QDL_CLK_MIPI_IPG" as a shared clock gate
> clock.

That would be necessary if the pclk clock rate mattered or would be set
anywhere.

> And, the clock-names property should exactly contain "pclk", "refclk"
> and "cfg_clk", right?

My personal preference would be to drop the superfluous "clk" prefix if
the resulting clock name is still clearly relatable to the official
name. Existing clock naming for the pclk is a bit mixed -
The "snps,dw-apb-timer" binding uses "pclk", which seems to be quite
common in other places, too. The "snps,dw-apb-uart" bindings use
"apb_pclk". "snps,dw-hdmi-tx" uses "iahb" and "isfr" without the clk
suffix.
How about "pclk", "ref" and "cfg"?

regards
Philipp
