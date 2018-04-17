From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 17 Apr 2018 13:52:43 +0200
Subject: [linux-sunxi] Re: [PATCH 3/5] net: stmmac: dwmac-sun8i: Allow
 getting syscon regmap from device
In-Reply-To: <CAGb2v65VLYc1X2bN5v0_1xokZCEkKFYNLzecnE3WeP8goc2KmQ@mail.gmail.com>
References: <20180411141641.14675-1-icenowy@aosc.io>
 <20180411141641.14675-4-icenowy@aosc.io>
 <20180412145628.iaaeue2imiijwx5d@flea>
 <A027702A-F3F7-4896-B2B8-E024DA521661@aosc.io>
 <CAGb2v66Qi2D1qgF3-iVJFAiznMUzzen0nHM5vsPe7Cyi6QTYpw@mail.gmail.com>
 <20180416143130.tls6xtcq3hsv7u7f@flea>
 <CAGb2v65VLYc1X2bN5v0_1xokZCEkKFYNLzecnE3WeP8goc2KmQ@mail.gmail.com>
Message-ID: <20180417115243.x42s7ygdpdbhtys2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 10:51:55PM +0800, Chen-Yu Tsai wrote:
> On Mon, Apr 16, 2018 at 10:31 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Thu, Apr 12, 2018 at 11:23:30PM +0800, Chen-Yu Tsai wrote:
> >> On Thu, Apr 12, 2018 at 11:11 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> >> > ? 2018?4?12? GMT+08:00 ??10:56:28, Maxime Ripard <maxime.ripard@bootlin.com> ??:
> >> >>On Wed, Apr 11, 2018 at 10:16:39PM +0800, Icenowy Zheng wrote:
> >> >>> From: Chen-Yu Tsai <wens@csie.org>
> >> >>>
> >> >>> On the Allwinner R40 SoC, the "GMAC clock" register is in the CCU
> >> >>> address space; on the A64 SoC this register is in the SRAM controller
> >> >>> address space, and with a different offset.
> >> >>>
> >> >>> To access the register from another device and hide the internal
> >> >>> difference between the device, let it register a regmap named
> >> >>> "emac-clock". We can then get the device from the phandle, and
> >> >>> retrieve the regmap with dev_get_regmap(); in this situation the
> >> >>> regmap_field will be set up to access the only register in the
> >> >>regmap.
> >> >>>
> >> >>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> >>> [Icenowy: change to use regmaps with single register, change commit
> >> >>>  message]
> >> >>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> >>> ---
> >> >>>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 48
> >> >>++++++++++++++++++++++-
> >> >>>  1 file changed, 46 insertions(+), 2 deletions(-)
> >> >>>
> >> >>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >> >>b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >> >>> index 1037f6c78bca..b61210c0d415 100644
> >> >>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >> >>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> >> >>> @@ -85,6 +85,13 @@ const struct reg_field old_syscon_reg_field = {
> >> >>>      .msb = 31,
> >> >>>  };
> >> >>>
> >> >>> +/* Specially exported regmap which contains only EMAC register */
> >> >>> +const struct reg_field single_reg_field = {
> >> >>> +    .reg = 0,
> >> >>> +    .lsb = 0,
> >> >>> +    .msb = 31,
> >> >>> +};
> >> >>> +
> >> >>
> >> >>I'm not sure this would be wise. If we ever need some other register
> >> >>exported through the regmap, will have to change all the calling sites
> >> >>everywhere in the kernel, which will be a pain and will break
> >> >>bisectability.
> >> >
> >> > In this situation the register can be exported as another
> >> >  regmap. Currently the code will access a regmap with name
> >> > "emac-clock" for this register.
> >> >
> >> >>
> >> >>Chen-Yu's (or was it yours?) initial solution with a custom writeable
> >> >>hook only allowing a single register seemed like a better one.
> >> >
> >> > But I remember you mentioned that you want it to hide the
> >> > difference inside the device.
> >>
> >> The idea is that a device can export multiple regmaps. This one,
> >> the one named "gmac" (in my soon to come v2) or "emac-clock" here,
> >> is but one of many possible regmaps, and it only exports the register
> >> needed by the GMAC/EMAC.
> >
> > I'm not sure this would be wise either. There's a single register map,
> > and as far as I know we don't have a binding to express this in the
> > DT. This means that the customer and provider would have to use the
> > same name, but without anything actually enforcing it aside from
> > "someone in the community knows it".
> >
> > This is not a really good design, and I was actually preferring your
> > first option. We shouldn't rely on any undocumented rule. This will be
> > easy to break and hard to maintain.
> 
> So, one regmap per device covering the whole register range, and the
> consumer knows which register to poke by looking at its own compatible.
> 
> That sound right?

Yep. And ideally, sending a single serie for both the A64 and the R40
cases, in order to provide the big picture.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180417/74e65df6/attachment.sig>
