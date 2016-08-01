From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Aug 2016 11:39:36 -0500
Subject: [PATCH v2 4/5] mmc: sunxi: sun4i / sun5i do not have sample clocks
In-Reply-To: <1469888748-26085-5-git-send-email-hdegoede@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
 <1469888748-26085-5-git-send-email-hdegoede@redhat.com>
Message-ID: <20160801163936.GA26855@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2016 at 04:25:47PM +0200, Hans de Goede wrote:
> It turns out that sun4i (A10) and sun5i (A13 & co) do not have sample
> clocks, so add a new sun7i-a20-mmc compatible and do not try to use
> sample clocks on sun4i / sun5i.
> 
> Since sun4i / sun5i do not have sample clocks, they cannot (reliably) do
> DDR rates, so only set MMC_CAP_1_8V_DDR when we do have sample clks.
> 
> Note this patch leaves the clk_prepare_enable() / clk_disable_unprepare()
> calls to the sample clks as-is, without adding checks for them being
> NULL. All the clk_foo calls accept a NULL clk and will return success when
> called with a NULL clk.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Add a new sun7i-a20-compatible for SoCs with sample clks, rather then
>  making them optional
> ---
>  .../devicetree/bindings/mmc/sunxi-mmc.txt          |  6 +++-

I find the subject a bit strange as it should describe the change, not 
the problem. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mmc/host/sunxi-mmc.c                       | 35 +++++++++++++++-------
>  2 files changed, 29 insertions(+), 12 deletions(-)
