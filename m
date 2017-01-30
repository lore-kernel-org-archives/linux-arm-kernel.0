From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 30 Jan 2017 15:09:55 -0500
Subject: [PATCH v3 06/24] drm/rockchip: dw-mipi-dsi: avoid out-of-bounds
 read on tx_buf
In-Reply-To: <20170130181636.1bc81e86.john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-7-john@metanate.com>
 <20170130180146.GG20076@art_vandelay>
 <20170130181636.1bc81e86.john@metanate.com>
Message-ID: <20170130200955.GL20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 06:16:36PM +0000, John Keeping wrote:
> On Mon, 30 Jan 2017 13:01:46 -0500, Sean Paul wrote:
> 
> > On Sun, Jan 29, 2017 at 01:24:26PM +0000, John Keeping wrote:
> > > As a side-effect of this, encode the endianness explicitly rather than
> > > casting a u16.
> > > 
> > > Signed-off-by: John Keeping <john@metanate.com>
> > > Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> > > ---
> > > v3:
> > > - Add Chris' Reviewed-by
> > > Unchanged in v2
> > > 
> > >  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > > index 4be1ff3a42bb..2e6ad4591ebf 100644
> > > --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > > @@ -572,8 +572,13 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
> > >  static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
> > >  				       const struct mipi_dsi_msg *msg)
> > >  {
> > > -	const u16 *tx_buf = msg->tx_buf;
> > > -	u32 val = GEN_HDATA(*tx_buf) | GEN_HTYPE(msg->type);
> > > +	const u8 *tx_buf = msg->tx_buf;
> > > +	u32 val = GEN_HTYPE(msg->type);
> > > +
> > > +	if (msg->tx_len > 0)
> > > +		val |= GEN_HDATA(tx_buf[0]);
> > > +	if (msg->tx_len > 1)
> > > +		val |= GEN_HDATA(tx_buf[1] << 8);  
> > 
> > You should probably update the mask inside GEN_HDATA to mask off 8 bits instead of
> > 16.
> 
> Won't that mask off the data written by "tx_buf[1] << 8"?

I would move the shift outside the mask, ie:

val |= GEN_HDATA(tx_buf[1]) << 8;

Sean

> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
