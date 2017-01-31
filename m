From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 31 Jan 2017 09:53:13 -0500
Subject: [PATCH v3 10/24] drm/rockchip: dw-mipi-dsi: don't assume buffer
 is aligned
In-Reply-To: <20170131115618.633398fc.john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-11-john@metanate.com>
 <20170130200811.GK20076@art_vandelay>
 <20170131115618.633398fc.john@metanate.com>
Message-ID: <20170131145313.GY20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 11:56:18AM +0000, John Keeping wrote:
> On Mon, 30 Jan 2017 15:08:11 -0500, Sean Paul wrote:
> 
> > On Sun, Jan 29, 2017 at 01:24:30PM +0000, John Keeping wrote:
> > > By dereferencing the MIPI command buffer as a u32* we rely on it being
> > > correctly aligned on ARM, but this may not be the case.  Copy it into a
> > > stack variable that will be correctly aligned.
> > > 
> > > Signed-off-by: John Keeping <john@metanate.com>
> > > Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> > > ---
> > > v3:
> > > - Add Chris' Reviewed-by
> > > Unchanged in v2
> > > 
> > >  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > > index 03fc096fe1bd..ddbc037e7ced 100644
> > > --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > > @@ -607,10 +607,10 @@ static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
> > >  static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
> > >  				      const struct mipi_dsi_msg *msg)
> > >  {
> > > -	const u32 *tx_buf = msg->tx_buf;
> > > -	int len = msg->tx_len, pld_data_bytes = sizeof(*tx_buf), ret;
> > > +	const u8 *tx_buf = msg->tx_buf;
> > > +	int len = msg->tx_len, pld_data_bytes = sizeof(u32), ret;
> > >  	u32 hdr_val = GEN_HDATA(msg->tx_len) | GEN_HTYPE(msg->type);
> > > -	u32 remainder = 0;
> > > +	u32 remainder;
> > >  	u32 val;
> > >  
> > >  	if (msg->tx_len < 3) {
> > > @@ -621,12 +621,14 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
> > >  
> > >  	while (DIV_ROUND_UP(len, pld_data_bytes)) {
> > >  		if (len < pld_data_bytes) {
> > > +			remainder = 0;
> > >  			memcpy(&remainder, tx_buf, len);
> > >  			dsi_write(dsi, DSI_GEN_PLD_DATA, remainder);
> > >  			len = 0;
> > >  		} else {
> > > -			dsi_write(dsi, DSI_GEN_PLD_DATA, *tx_buf);
> > > -			tx_buf++;
> > > +			memcpy(&remainder, tx_buf, pld_data_bytes);
> > > +			dsi_write(dsi, DSI_GEN_PLD_DATA, remainder);
> > > +			tx_buf += pld_data_bytes;
> > >  			len -= pld_data_bytes;
> > >  		}  
> > 
> > 
> > You can clean this up further by removing a couple of the locals, the
> > conditional and the division:
> > 
> > while(len < msg->tx_len) {
> >         size_t to_write = MIN(msg->tx_len - len, sizeof(remainder));
> > 
> >         memcpy(&remainder, msg->tx_buf + len, to_write);
> >         dsi_write(dsi, DSI_GEN_PLD_DATA, remainder);
> >         len += to_write;
> > 
> >         ...
> > }
> 
> That's a nice simplification, but it's more than I was trying to do with
> this patch.  I can add a cleanup patch on top to simplify the function,
> but I don't have that much time to spend on this at the moment and I'd
> rather not block this fix because the original code structure could be
> improved.

Ok. I'm inclined to argue that writing your response probably took more time
than the copy/paste to fix it, but *shrug*.

Sean

> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
