From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 19 Jun 2018 17:29:12 +0200
Subject: [PATCH] clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL
In-Reply-To: <1528892771.2292.2.camel@baylibre.com>
References: <1528892421-12180-1-git-send-email-narmstrong@baylibre.com>
 <1528892771.2292.2.camel@baylibre.com>
Message-ID: <1529422152.28510.24.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-06-13 at 14:26 +0200, Jerome Brunet wrote:
> On Wed, 2018-06-13 at 14:20 +0200, Neil Armstrong wrote:
> > On Amlogic Meson GXBB & GXL platforms, the SCPI Cortex-M4 Co-Processor
> > seems to be dependent on the FCLK_DIV2 to be operationnal.
> > 
> > The issue occured since v4.17-rc1 by freezing the kernel boot when
> > the 'schedutil' cpufreq governor was selected as default :
> > 
> >    [   12.071837] scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
> >    domain-0 init dvfs: 4
> >    [   12.087757] hctosys: unable to open rtc device (rtc0)
> >    [   12.087907] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> >    [   12.102241] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> > 
> > But when disabling the MMC driver, the boot finished but cpufreq failed to
> > change the CPU frequency :
> > 
> >    [   12.153045] cpufreq: __target_index: Failed to change cpu frequency: -5
> > 
> > A bisect between v4.16 and v4.16-rc1 gave the 05f814402d61 commit to be
> > the first bad commit.
> > This commit added support for the missing clock gates before the fixed PLL
> > fixed dividers (FCLK_DIVx) and the clock framework basically disabled
> > all the unused fixed dividers, thus disabled a critical clock path for
> > the SCPI Co-Processor.
> > 
> > This patch simply sets the FCLK_DIV2 gate as critical to ensure
> > nobody can disable it.
> > 
> > Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> Good catch !
> We'll probably have to check the axg family as well

SCPI is not enabled on AXG at this time. We'll deal with it when the time comes.

patch applied.
Thx
