From: xobs@kosagi.com (Sean Cross)
Date: Mon, 25 Jan 2016 16:33:00 +0800
Subject: [PATCH v3 0/3] i.MX6 LDB mux/divider glitch workaround
In-Reply-To: <1453461088-31549-1-git-send-email-p.zabel@pengutronix.de>
References: <1453461088-31549-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <56A5DDBC.3010101@kosagi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/2016 19:11, Philipp Zabel wrote:
> Hi,
>
> The previous version was broken for i.MX6S/DL since
> disable_anatop_clocks() would try to check the parent of clk_periph_pre,
> but it was called before clk_periph_pre was registered.
> disable_anatop_clocks() then went on and failed to not disable the
> memory clock.
>
> So it appears there is a yet unreleased ERR009219, which I have not yet
> seen, that supposedly describes the LDB mux glitch issue, and a draft
> engineering bulletin EB821 that describes the clock switching procedure.
> Shawn, do you have access to these documents?
>
> Especially the comment explaining init_ldb_clks() should be double checked
> against the erratum once available, as that contains my interpretation of
> the original patch comment.
Hi Philipp,

I have applied this series on Novena, and it results in a mostly
nonfunctional display.

We use dual-lane LVDS via an LVDS-to-eDP bridge.  Since we support HDMI
as well, and HDMI monitors are much pickier about timing than raw
panels, we clock the LDB off of PLL3 with the following entry in our
device tree:

&clks {
        assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
                          <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
        assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
                                 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
};

With the patch applied, the screen looks very wrong.  The clock is
unstable, and the picture bounces around.  It is somewhat related to CPU
load.

Curiously, this is visually similar to (but not exactly the same as) the
effect we spoke of on IRC, except the result with this patch has more
banding and sparkling, and is slightly less stable.  I can very easily
reproduce the problem by writing first 0x000, then 0x660 to physical
address 0x2600000.


Sean
