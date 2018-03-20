From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 20 Mar 2018 15:15:02 +0800
Subject: [PATCH net-next 02/12] clk: sunxi-ng: r40: export a regmap to
 access the GMAC register
In-Reply-To: <20180318213129.ucwslzvwq6khxrcd@flea>
References: <20180317092857.4396-1-wens@csie.org>
 <20180317092857.4396-3-wens@csie.org>
 <20180318213129.ucwslzvwq6khxrcd@flea>
Message-ID: <CAGb2v67Fp20wkmqWyRowpAmm4EDwENnKFG+mccqWaPa5Jj4zBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 5:31 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Sat, Mar 17, 2018 at 05:28:47PM +0800, Chen-Yu Tsai wrote:
>> From: Icenowy Zheng <icenowy@aosc.io>
>>
>> There's a GMAC configuration register, which exists on A64/A83T/H3/H5 in
>> the syscon part, in the CCU of R40 SoC.
>>
>> Export a regmap of the CCU.
>>
>> Read access is not restricted to all registers, but only the GMAC
>> register is allowed to be written.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Gah, this is crazy. I'm really starting to regret letting that syscon
> in in the first place...

IMHO syscon is really a better fit. It's part of the glue layer and
most other dwmac user platforms treat it as such and use a syscon.
Plus the controls encompass delays (phase), inverters (polarity),
and even signal routing. It's not really just a group of clock controls,
like what we poorly modeled for A20/A31. I think that was really a
mistake.

As I mentioned in the cover letter, a slightly saner approach would
be to let drivers add custom syscon entries, which would then require
less custom plumbing.

> And I'm not really looking forward the time where SCPI et al. will be
> mature and we'll have the clock controller completely outside of our
> control.

I don't think it's going to happen for any of the older SoCs. The R40
only stands out because the GMAC controls are in the clock controller
address space, presumably to be like the A20.


ChenYu
