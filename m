From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 31 Jul 2018 16:19:32 +0200
Subject: [PATCH] mmc: sunxi: Use new timing mode for A64 eMMC controller
In-Reply-To: <CAGb2v67XaWoBGX2Tn_J8LfBJiJja0yfRbM+QyHPLnXvQtBuGGw@mail.gmail.com>
References: <20180712030225.15681-1-wens@csie.org>
 <20180712071959.fi4rhgwv2iuoelbl@flea>
 <CAGb2v65rE2nQbyeiSPAyTzw-n-EQsUwQABx3nrvXTu4JogFPBQ@mail.gmail.com>
 <20180717151558.wn7v33whtljqt53w@flea>
 <CAGb2v64NRVaWpbDqiX0JX7_6uvypUpNEecPUj-sSjaK5X-hdQA@mail.gmail.com>
 <20180718152203.svrt6wmr2vwh4rb5@flea>
 <CAGb2v67XaWoBGX2Tn_J8LfBJiJja0yfRbM+QyHPLnXvQtBuGGw@mail.gmail.com>
Message-ID: <20180731141932.5fgaybgkshhk2rww@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 05:27:43PM +0800, Chen-Yu Tsai wrote:
> On Wed, Jul 18, 2018 at 11:22 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Tue, Jul 17, 2018 at 11:43:03PM +0800, Chen-Yu Tsai wrote:
> >> On Tue, Jul 17, 2018 at 11:15 PM, Maxime Ripard
> >> <maxime.ripard@bootlin.com> wrote:
> >> > On Thu, Jul 12, 2018 at 06:17:23PM +0800, Chen-Yu Tsai wrote:
> >> >> On Thu, Jul 12, 2018 at 3:19 PM, Maxime Ripard
> >> >> <maxime.ripard@bootlin.com> wrote:
> >> >> > Hi,
> >> >> >
> >> >> > On Thu, Jul 12, 2018 at 11:02:25AM +0800, Chen-Yu Tsai wrote:
> >> >> >> The eMMC controller is also a new timing mode controller, but it doesn't
> >> >> >> have the timing mode switch. It does however have signal delay and
> >> >> >> calibration controls, typical of Allwinner MMC controllers that support
> >> >> >> the new timing mode.
> >> >> >>
> >> >> >> Enable the new timing mode setting for the A64 eMMC controller. This
> >> >> >> also enables MMC HS-DDR modes, which gives higher throughput for eMMC
> >> >> >> chips that support it, and can deliver such throughput.
> >> >> >>
> >> >> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> >> >
> >> >> > That doesn't look right. The datasheet explicitly mentions that this
> >> >> > bit doesn't apply to the eMMC controller, and the BSP is doing the same:
> >> >> > https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-1.c
> >> >> >
> >> >> > vs
> >> >> > https://github.com/longsleep/linux-pine64/blob/lichee-dev-v3.10.65/drivers/mmc/host/sunxi-mmc-sun50iw1p1-2.c
> >> >>
> >> >> You mean the bit in SDXC_REG_SD_NTSR? Yes I know that doesn't exist
> >> >> for the eMMC controller. I mentioned this in the commit message. It
> >> >> doesn't exist, and writes to it become a no-op.
> >> >>
> >> >> Would a comment, or comments, help with making this clear?
> >> >
> >> > Ah right. Maybe we should move the calibration under can_calibrate
> >> > though, or create another boolean for this?
> >> >
> >> > Putting it under has_new_timings while the SoC doesn't use it looks
> >> > very confusing.
> >>
> >> IIRC we don't support calibration anyway. This boolean simply signals
> >> the usage of the new timing mode, whether by choice, or because it is
> >> the only mode the controller supports.
> >
> > This is not the semantic I had in mind when I introduced it. The
> > original intent was to set the new timing bit all the time for
> > SoCs. If we want to change that semantic, then we also need to make
> > sure what this bit means is documented properly.
> 
> In the driver:
> 
>     /* hardware only supports new timing mode */
>     bool needs_new_timings;
> 
>     /* hardware can switch between old and new timing modes */
>     bool has_timings_switch;
> 
> So if the A64 / H6 eMMC controller only supports / is stuck with the new
> timing mode, that surely fits the description of the first one, right?

I guess so, yes

> As for setting the new timing bit all the time, yes it is set, but it's
> a no-op. Would a comment clarifying this at the point the hardware bit
> is set suffice?

Yep. Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180731/67794c1d/attachment.sig>
