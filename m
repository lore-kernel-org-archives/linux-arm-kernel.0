From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 31 Jul 2017 13:13:34 +0800
Subject: [PATCH 0/4] clk: sunxi-ng: Fix issues with fractional mode
In-Reply-To: <20170730164150.26302-1-jernej.skrabec@siol.net>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65pH-Me6JjMYzp41NwS478azMTLBPrkJwZcho9Ay2JX1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

On Mon, Jul 31, 2017 at 12:41 AM, Jernej Skrabec
<jernej.skrabec@siol.net> wrote:
> During development of H3 HDMI driver, I found some issues with
> setting video clock rate. It turned out that clock driver decided
> to use fractional mode and selected right frequency, but it didn't
> enable it. Additionally, fractional helpers don't wait on lock.

What kind of resolution were you testing to actually hit this?

AFAIK the fractional mode is either 297 or 270 MHz. Even Full HD
1080p60 dot clocks aren't that high. And the clk drivers should
try to request a matching parent clk rate. So the PLL wouldn't
go that high. Are you testing 4k @ 30fps?

As it stands, I don't think any of the existing display support
can go that high, so I think we're safe as far as old kernels
go, i.e. we don't need to Cc stable for these.

Regards
ChenYu

> Patch 1 adds a call to N-M clock driver which enables fractional mode.
> It also clears M factor before that as required by most SoCs.
>
> Patch 2 adds a call to N clock driver which enables fractional mode.
>
> Patch 3 makes fractional helpers less chatty.
>
> Patch 4 adds a wait for lock to fractional helpers.
>
> Jernej Skrabec (4):
>   clk: sunxi-ng: Fix fractional mode for N-M clocks
>   clk: sunxi-ng: multiplier: Fix fractional mode
>   clk: sunxi-ng: Make fractional helper less chatty
>   clk: sunxi-ng: Wait for lock when using fractional mode
>
>  drivers/clk/sunxi-ng/ccu_frac.c | 14 ++++++++------
>  drivers/clk/sunxi-ng/ccu_frac.h |  2 +-
>  drivers/clk/sunxi-ng/ccu_mult.c | 10 +++++++---
>  drivers/clk/sunxi-ng/ccu_nm.c   | 19 ++++++++++++++++---
>  4 files changed, 32 insertions(+), 13 deletions(-)
>
> --
> 2.13.3
>
