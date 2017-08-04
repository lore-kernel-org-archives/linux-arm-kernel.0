From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 4 Aug 2017 17:39:04 +0800
Subject: [linux-sunxi] [PATCH 10/13] [NOT FOR REVIEW NOW] clk: sunxi: Add
 CLK_SET_RATE_PARENT flag for H3 HDMI clock
In-Reply-To: <E50F5E8C-2121-493C-A7B2-D1535E916471@aosc.io>
References: <20170801131304.7741-1-icenowy@aosc.io>
 <55076172-DD11-4AF5-AEAF-A16C757BF5F0@aosc.io>
 <CAGb2v67ihCOmjojidpGfp9WvLiWWbwL+27tm7vOrKX0rRH4O1w@mail.gmail.com>
 <13060066.Dl610HiJ2r@jernej-laptop>
 <E50F5E8C-2121-493C-A7B2-D1535E916471@aosc.io>
Message-ID: <CAGb2v64W-7pyazHhgZEWH-3KwRQOPR79mNJdV6FMSvdZEkbWRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 4, 2017 at 5:03 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> ? 2017?8?4? GMT+08:00 ??4:59:03, "Jernej ?krabec" <jernej.skrabec@siol.net> ??:
>>Hi Chen-Yu,
>>
>>Dne petek, 04. avgust 2017 ob 06:29:50 CEST je Chen-Yu Tsai napisal(a):
>>> On Fri, Aug 4, 2017 at 12:16 PM, Icenowy Zheng <icenowy@aosc.io>
>>wrote:
>>> > ? 2017?8?4? GMT+08:00 ??12:15:27, Chen-Yu Tsai <wens@csie.org> ??:
>>> >>Hi,
>>> >>
>>> >>On Tue, Aug 1, 2017 at 9:13 PM, Icenowy Zheng <icenowy@aosc.io>
>>wrote:
>>> >>> From: Jernej Skrabec <jernej.skrabec@siol.net>
>>> >>>
>>> >>> When setting the HDMI clock of H3, the PLL_VIDEO clock needs to
>>be
>>> >>
>>> >>set.
>>> >>
>>> >>> Add CLK_SET_RATE_PARENT flag for H3 HDMI clock.
>>> >>>
>>> >>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>> >>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> >>> ---
>>> >>>
>>> >>>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
>>> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> >>>
>>> >>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>>> >>
>>> >>b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>>> >>
>>> >>> index b1127e8629d9..2ebb3d865b01 100644
>>> >>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>>> >>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>>> >>> @@ -474,7 +474,7 @@ static SUNXI_CCU_GATE(avs_clk,
>>> >>
>>> >>"avs",          "osc24M",
>>> >>
>>> >>>  static const char * const hdmi_parents[] = { "pll-video" };
>>> >>>  static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
>>> >>>
>>> >>> -                                0x150, 0, 4, 24, 2, BIT(31), 0);
>>> >>> +                                0x150, 0, 4, 24, 2, BIT(31),
>>> >>
>>> >>CLK_SET_RATE_PARENT);
>>> >>
>>> >>Line is longer than 80 characters.
>>> >>
>>> >>This looks independent enough so I've merged this for 4.14 with the
>>> >>offending line wrapped and the following tag added:
>>> >>
>>> >>Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
>>> >>
>>> > Please don't merge this now until Jernej send it.
>>>
>>> (Dropped Rob, devicetree and dri mailing lists)
>>>
>>> Hi Jernej,
>>>
>>> Is it OK if we take this patch for the next release? Or rather,
>>> if there anything blocking this patch?
>>
>>I just made last check now and this patch is indeed OK. Before merging,
>>please
>>read explanation below.
>>
>>Background:
>>According to H3 datasheet and BSP driver, HDMI clock has M factor
>>(divider) to
>>correctly set pixel clock to desired value. However, Jens Kuske
>>discovered
>>that this factor doesn't play any role whatsoever and instead, division
>>factor
>>set in PHY registers is the important one. I confirmed that on BSP
>>kernel by
>>tying M factor to 0. Both, HDMI video and audio, still worked
>>correctly.
>>
>>So that flag is necessary to set pll-video to pixel clock * div factor.
>>I can
>>also change HDMI clock type to SUNXI_CCU_GATE (without M factor) and
>>document
>>discrepancy with datasheet in ccu-sun8i-h3.c. Alternatively to this
>>patch,
>>just in case, to be on the safe side, I can add pll-video clock phandle
>>to the
>>dt node. However, as far as I know, that might prevent selecting
>>another
>>parent on SoCs where HDMI clock has multiple parents.
>
> Unfortunately A64 is this situation -- A64 TCON1/HDMI clocks can
> use pll-video0/1 as parent, but TCON0 can only use pll-video0 or
> pll-mipi (also a downstream clock of pll-video0), and by default
> TCON1/HDMI also uses pll-video0.
>
> Because of this I have never succeeded in multihead (LCD+HDMI)
> on Pinebook.

Multihead support hasn't been tested, despite all the patches I've
done to try and support it. I had to do some more to get HDMI and
LCD working together on the A31. And even then there are still
issues.

The current (as of Maxime's sunxi-drm/for-next branch) issues are

  - Two outputs with incompatible dot clocks will step on each
    other, instead of switching to another PLL. Maxime seems to
    have some patches to prevent this.

  - Engine and TCON pairing in a fully connected display system
    is (still) broken. You will end up tying both TCON with the
    same engine. I have patches to fix this in my a31-hdmi-v2
    branch.

You can work around both issues, the first one by adding
CLK_SET_RATE_NO_REPARENT to the TCON clocks, and forcing the
TCON parents at ccu probe time. The second one can be worked
around by removing the extra unused connections between mixer0
and TCON1, and vice versa.

This should at least allow you to test your hardware.

Regards
ChenYu
