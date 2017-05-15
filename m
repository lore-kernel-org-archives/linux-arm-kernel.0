From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 15 May 2017 17:56:19 +0200
Subject: [PATCH v2 2/2] clk: meson: gxbb: remove the "cpu_clk" from the
 GXBB and GXL driver
In-Reply-To: <20170504181920.21880-3-martin.blumenstingl@googlemail.com>
References: <20170401125519.7339-1-martin.blumenstingl@googlemail.com>
 <20170504181920.21880-1-martin.blumenstingl@googlemail.com>
 <20170504181920.21880-3-martin.blumenstingl@googlemail.com>
Message-ID: <1494863779.13948.2.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-05-04 at 20:19 +0200, Martin Blumenstingl wrote:
> It seems that the "cpu_clk" was carried over from the meson8b clock
> controller driver. On Meson GX (GXBB/GXL/GXM) the registers which are
> used by the cpu_clk have a different purpose (in other words: they don't
> control the CPU clock anymore). HHI_SYS_CPU_CLK_CNTL1 bits 31:24 are
> reserved according to the public S905 datasheet, while bit 23 is the
> "A53_trace_clk_DIS" gate (which according to the datasheet should only
> be used in case a silicon bug is discovered) and bits 22:20 are a
> divider (A53_trace_clk). The meson clk-cpu code however expects that
> bits 28:20 are reserved for a divider (according to the public S805
> datasheet this "SCALE_DIV: This value represents an N+1 divider of the
> input clock.").
> 
> The CPU clock on Meson GX SoCs is provided by the SCPI DVFS clock
> driver instead. Two examples from a Meson GXL S905X SoC:
> - vcpu (SCPI DVFS clock 0) rate: 1000000000 / cpu_clk rate: 708000000
> - vcpu (SCPI DVFS clock 0) rate: 1512000000 / cpu_clk rate: 708000000
> 
> Unfortunately the CLKID_CPUCLK was already exported (but is currently
> not used) to DT. Due to the removal of this clock definition there is
> now a hole in the clk_hw_onecell_data (which is not a problem because
> this case is already handled in gxbb_clkc_probe).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied, Thanks
Jerome
