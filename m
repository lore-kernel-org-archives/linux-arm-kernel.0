From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 4 Aug 2017 22:16:56 +0800
Subject: [linux-sunxi] [PATCH 10/13] [NOT FOR REVIEW NOW] clk: sunxi: Add
 CLK_SET_RATE_PARENT flag for H3 HDMI clock
In-Reply-To: <18315912.JHEzglLTUl@jernej-laptop>
References: <20170801131304.7741-1-icenowy@aosc.io>
 <13060066.Dl610HiJ2r@jernej-laptop>
 <CAGb2v64hQGwZtcRMhkSejKFozZu7rbL+47NbOuYrc7pKoOYLkw@mail.gmail.com>
 <18315912.JHEzglLTUl@jernej-laptop>
Message-ID: <CAGb2v67B_8kHBtnLd_1vB-pHR7bV6p2M3H8iZ7njeSztE0pMVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 4, 2017 at 9:49 PM, Jernej ?krabec <jernej.skrabec@siol.net> wrote:
> Hi Chen-Yu,
>
> Dne petek, 04. avgust 2017 ob 11:27:33 CEST je Chen-Yu Tsai napisal(a):
>> On Fri, Aug 4, 2017 at 4:59 PM, Jernej ?krabec <jernej.skrabec@siol.net>
> wrote:
>> > Hi Chen-Yu,
>> >
>> > Dne petek, 04. avgust 2017 ob 06:29:50 CEST je Chen-Yu Tsai napisal(a):
>> >> On Fri, Aug 4, 2017 at 12:16 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> >> > ? 2017?8?4? GMT+08:00 ??12:15:27, Chen-Yu Tsai <wens@csie.org> ??:
>> >> >>Hi,
>> >> >>
>> >> >>On Tue, Aug 1, 2017 at 9:13 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> >> >>> From: Jernej Skrabec <jernej.skrabec@siol.net>
>> >> >>>
>> >> >>> When setting the HDMI clock of H3, the PLL_VIDEO clock needs to be
>> >> >>
>> >> >>set.
>> >> >>
>> >> >>> Add CLK_SET_RATE_PARENT flag for H3 HDMI clock.
>> >> >>>
>> >> >>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> >> >>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> >> >>> ---
>> >> >>>
>> >> >>>  drivers/clk/sunxi-ng/ccu-sun8i-h3.c | 2 +-
>> >> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >>>
>> >> >>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> >> >>
>> >> >>b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> >> >>
>> >> >>> index b1127e8629d9..2ebb3d865b01 100644
>> >> >>> --- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> >> >>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
>> >> >>> @@ -474,7 +474,7 @@ static SUNXI_CCU_GATE(avs_clk,
>> >> >>
>> >> >>"avs",          "osc24M",
>> >> >>
>> >> >>>  static const char * const hdmi_parents[] = { "pll-video" };
>> >> >>>  static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
>> >> >>>
>> >> >>> -                                0x150, 0, 4, 24, 2, BIT(31), 0);
>> >> >>> +                                0x150, 0, 4, 24, 2, BIT(31),
>> >> >>
>> >> >>CLK_SET_RATE_PARENT);
>> >> >>
>> >> >>Line is longer than 80 characters.
>> >> >>
>> >> >>This looks independent enough so I've merged this for 4.14 with the
>> >> >>offending line wrapped and the following tag added:
>> >> >>
>> >> >>Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")
>> >> >>
>> >> > Please don't merge this now until Jernej send it.
>> >>
>> >> (Dropped Rob, devicetree and dri mailing lists)
>> >>
>> >> Hi Jernej,
>> >>
>> >> Is it OK if we take this patch for the next release? Or rather,
>> >> if there anything blocking this patch?
>> >
>> > I just made last check now and this patch is indeed OK. Before merging,
>> > please read explanation below.
>>
>> Ack.
>>
>> > Background:
>> > According to H3 datasheet and BSP driver, HDMI clock has M factor
>> > (divider) to correctly set pixel clock to desired value. However, Jens
>> > Kuske discovered that this factor doesn't play any role whatsoever and
>> > instead, division factor set in PHY registers is the important one. I
>> > confirmed that on BSP kernel by tying M factor to 0. Both, HDMI video and
>> > audio, still worked correctly.
>> Great. Sounds like what we have on A31 and earlier SoCs.
>>
>> > So that flag is necessary to set pll-video to pixel clock * div factor. I
>> > can also change HDMI clock type to SUNXI_CCU_GATE (without M factor) and
>> > document discrepancy with datasheet in ccu-sun8i-h3.c. Alternatively to
>> > this patch, just in case, to be on the safe side, I can add pll-video
>> > clock phandle to the dt node. However, as far as I know, that might
>> > prevent selecting another parent on SoCs where HDMI clock has multiple
>> > parents.
>>
>> It could be that the HDMI clock only drives the DW-HDMI sampler and other
>> internal logic, while the PHY takes the PLL input directly for the TMDS
>> clock? I'm not sure how you could verify this though. Maybe increase M
>> to the maximum, and see if there is any tearing or other artifacts?
>> Ideally we could just ask Allwinner...
>
> I just made quick test with maximum divider and everything seems to be ok.
> Unfortunately, I don't have time to do extensive test.
>
> I will forward the question to Tl Lim and let's see if he can get the answer,
> since the situation for A64 is completely the same.

That would be much appreciated.

>>
>> You should change it to SUNXI_CCU_MUX_WITH_GATE if you want to change it.
>> If there are mux bits, even if there's only one valid setting, you should
>> still have the mux, so the kernel can actually correct any invalid settings
>> that may be incorrectly programmed into the hardware by the bootloader or
>> user. This would be a separate patch.
>
> I will leave it as it is for now. Will you still merge the patch?

I'll drop it for now. Although we have this how A10s and A31, the hardware
is not wired to actually use, as I mentioned above. We can do something
about it once we have a better understanding of the hardware.

Thanks for all the explanation and testing.

Regards
ChenYu
