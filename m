From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Nov 2015 10:28:00 +0800
Subject: [PATCH] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <1446651896-22902-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1445964626-6484-2-git-send-email-jenskuske@gmail.com>
 <1446651896-22902-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v651vNyUqE_LXYnuYNhN0siywtg7Pt1TDQZUMxwZ3psmJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 4, 2015 at 11:44 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Remove the fixed dividers from the PLL6 driver to be able to have a
> reusable driver that can be used across several SoCs that share the same
> controller, but don't have the same set of dividers for this clock, and to
> also be reused multiple times in the same SoC, since we're droping the
> clock name.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Hi Jens,
>
> Here is an alternative (untested) patch to deal with the PLL6 issue you're
> experiencing with the H3.
>
> It doesn't rely on parsing clock-output-names that turns out to be pretty
> fragile.

A quick look through. I've no problems with changing the design, but I'd
like to keep the original names, i.e. pll6x2 for the clock module bits,
and pll6 for the fixed divider. It better matches the user manual.

>From the PLL6 register description:
In the Clock Control Module, PLL(2X) output = PLL * 2= 24 MHz * N * K.

And all places that use the "normal" output say PLL_PERIPH (that is PLL6),
while MBUS on A23/A33 use the 2X output, and say PLL_PERIPH(2X).

On the side, do we want to get rid of all the divs clocks?

Regards
ChenYu
