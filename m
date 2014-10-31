From: dianders@chromium.org (Doug Anderson)
Date: Fri, 31 Oct 2014 15:59:58 -0700
Subject: [PATCH v3] clk: rockchip: disable unused clocks
In-Reply-To: <1414732244-27126-1-git-send-email-kever.yang@rock-chips.com>
References: <1414732244-27126-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=VAqvmwGNwN6RNTg2rYk1UJ6k-4KKaD7ERJDXmqzCFKNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Thu, Oct 30, 2014 at 10:10 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> The rockchip clock driver use CLK_IGNORE_UNUSED flag to make sure
> all the clocks are available like default power on state.
> We have implement the clock manage in most of rockchip drivers,
> it is time to remove it for power save.
> Instead we add CLK_IGNORE_UNUSED for some clock nodes which should
> be on during boot or no module driver in kernel will initialize it.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
> Changes in v3:
> - get CLK_DIVIDER_READ_ONLY tag back fro armcores
> - add CLK_IGNORE_UNUSED tag for cs_dbg, pclk_dgb_pre and pclk_rkpwm
>
> Changes in v2:
> - get some clock ID back
> - add CLK_IGNORE_UNUSED tag for aclk_strc and aclk_core in clk-rk3188.c
> - add CLK_IGNORE_UNUSED tag for rk3288 dwc2
>
>  drivers/clk/rockchip/clk-rk3188.c |  36 +++++-----
>  drivers/clk/rockchip/clk-rk3288.c | 140 +++++++++++++++++++-------------------
>  drivers/clk/rockchip/clk.c        |   9 ---
>  3 files changed, 88 insertions(+), 97 deletions(-)

I found that I needed this in order to keep graphics from failing:

-       GATE(ACLK_VIO1_NIU, "aclk_vio1_niu", "aclk_vio1", 0,
RK3288_CLKGATE_CON(15), 12, GFLAGS),
+       GATE(ACLK_VIO1_NIU, "aclk_vio1_niu", "aclk_vio1",
CLK_IGNORE_UNUSED, RK3288_CLKGATE_CON(15), 12, GFLAGS),

Off-list Heiko suggested that maybe VIO0_NIU would be similar.

Should maybe add that as IGNORE for now until we have something
claiming that clock?

-Doug
