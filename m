From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 07 Jul 2015 12:37:40 +0200
Subject: [PATCH v4 0/3] clk: Add regmap support for clk mulitplexer
In-Reply-To: <1434464615-9080-1-git-send-email-matthias.bgg@gmail.com>
References: <1434464615-9080-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <4747793.LCMeNNmSbd@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 16, 2015 04:23:32 PM Matthias Brugger wrote:
> This patch set adds regmap support for the simple clock multiplexer,
> the divider clock and the clock gate.
> Regmap use, apart from a pointer to the regmap struct, needs an
> offset value to know where in the regmap it has to read/write.
> We add both fields to the corresponding structs.
> 
> The driver will distinguish between a clock which is based on regmap or not
> through a flag specified in the clock hardware struct.
> The approach does not break the existing clock framework API but adds
> new functions for registering regmap clocks. Unregistering the clocks is
> independent of the use of regmap or not, so that no new functions were
> implemented.
> 
> As an example user of the regmap clock multiplexer, it was implemented on
> the mt8135. When accepted it will also be applied to the other Mediatek
> SoCs. Other possible user are Qualcomm SoCs which up to now implement their
> own regmap based clock multiplexer.
> 
> This patch set is based on linux next.
> To get the mt8135 eval board up and running, we need to enable the clock
> support [1] and use the two clocks for the uart port [2].
> 
> Any comments welcome.
> 
> [1] https://patchwork.kernel.org/patch/6261141/
> [2] https://patchwork.kernel.org/patch/6261151/
> 

Hi Mike, hi Stephen,

Any comments on this patch set?

Regrads,
Matthias

> Changes for v4:
> - fix style issues
> - use __clk_get_flags
> - delete #ifdef CONFIG_REGMAP
> 
> Changes for v3:
> - rebase against linux-next
> - provide regmap access to all three clock types in a unified way
> 
> Changes for v2:
> - use regmap_update_bits instead of read-write
> - fix flag check
> - add union in struct clk_mux
> - fix typo in commit message
> 
> ---
> 
> Matthias Brugger (3):
>   clk: Add regmap support
>   clk: mediatek: Add support for clk-mux using regmap
>   clk: mediatek: Use regmap clk-mux for mt8135
> 
>  drivers/clk/Makefile              |  1 +
>  drivers/clk/clk-divider.c         | 68 ++++++++++++++++++++++------
>  drivers/clk/clk-gate.c            | 57 +++++++++++++++++++-----
>  drivers/clk/clk-io.c              | 48 ++++++++++++++++++++
>  drivers/clk/clk-io.h              | 22 +++++++++
>  drivers/clk/clk-mux.c             | 94
> ++++++++++++++++++++++++++++++++------- drivers/clk/mediatek/clk-mt8135.c |
> 21 +++------
>  drivers/clk/mediatek/clk-mtk.c    | 37 +++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h    | 26 +++++++++++
>  include/linux/clk-provider.h      | 54 ++++++++++++++++++++--
>  10 files changed, 370 insertions(+), 58 deletions(-)
>  create mode 100644 drivers/clk/clk-io.c
>  create mode 100644 drivers/clk/clk-io.h
