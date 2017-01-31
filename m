From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 31 Jan 2017 09:47:05 -0500
Subject: [PATCH v3 24/24] drm/rockchip: dw-mipi-dsi: support read commands
In-Reply-To: <20170131124147.170d8588.john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-25-john@metanate.com>
 <20170130152611.GA20076@art_vandelay>
 <20170130181427.1940024f.john@metanate.com>
 <20170130201609.GM20076@art_vandelay>
 <20170131124147.170d8588.john@metanate.com>
Message-ID: <20170131144705.GW20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 12:41:47PM +0000, John Keeping wrote:
> On Mon, 30 Jan 2017 15:16:09 -0500, Sean Paul wrote:
> 
> > On Mon, Jan 30, 2017 at 06:14:27PM +0000, John Keeping wrote:
> > > On Mon, 30 Jan 2017 10:26:11 -0500, Sean Paul wrote:
> > >   
> > > > On Sun, Jan 29, 2017 at 01:24:44PM +0000, John Keeping wrote:  
> > > > > I haven't found any method for getting the length of a response, so this
> > > > > just uses the requested rx_len
> > > > > 
> > > > > Signed-off-by: John Keeping <john@metanate.com>
> > > > > ---
> > > > > v3:
> > > > > - Fix checkpatch warnings
> > > > > Unchanged in v2
> > > > > 
> > > > >  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 56 ++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 56 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > > > > index cf3ca6b0cbdb..cc58ada75425 100644
> > > > > --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > > > > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> > > > > @@ -678,6 +678,56 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
> > > > >  	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, hdr_val);
> > > > >  }
> > > > >  
> > > > > +static int dw_mipi_dsi_dcs_read(struct dw_mipi_dsi *dsi,
> > > > > +				const struct mipi_dsi_msg *msg)
> > > > > +{
> > > > > +	const u8 *tx_buf = msg->tx_buf;
> > > > > +	u8 *rx_buf = msg->rx_buf;
> > > > > +	size_t i;
> > > > > +	int ret, val;
> > > > > +
> > > > > +	dsi_write(dsi, DSI_PCKHDL_CFG, EN_CRC_RX | EN_ECC_RX | EN_BTA);
> > > > > +	dsi_write(dsi, DSI_GEN_HDR,
> > > > > +		  GEN_HDATA(tx_buf[0]) | GEN_HTYPE(msg->type));
> > > > > +
> > > > > +	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
> > > > > +				 val, !(val & GEN_RD_CMD_BUSY), 1000,
> > > > > +				 CMD_PKT_STATUS_TIMEOUT_US);
> > > > > +	if (ret < 0) {
> > > > > +		dev_err(dsi->dev, "failed to read command response\n");
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	for (i = 0; i < msg->rx_len;) {
> > > > > +		u32 pld = dsi_read(dsi, DSI_GEN_PLD_DATA);
> > > > > +
> > > > > +		while (i < msg->rx_len) {
> > > > > +			rx_buf[i] = pld & 0xff;
> > > > > +			pld >>= 8;
> > > > > +			i++;
> > > > > +		}
> > > > > +	}    
> > > > 
> > > > AFAICT, the outer for loop just initializes i and ensures msg->rx_len is
> > > > non-zero? 
> > > > 
> > > > I think the following would be easier to read (and safe against the case where
> > > > msg->rx_len > sizeof(pld) (even though this shouldn't happen according to DCS
> > > > spec)).
> > > > 
> > > > if (msg->rx_len > 0) {
> > > >         u32 pld = dsi_read(dsi, DSI_GEN_PLD_DATA);
> > > >         memcpy(rx_buf, &pld, MIN(msg->rx_len, sizeof(pld));
> > > > }  
> > > 
> > > I think the intent was to handle rx_len > 4, but the patch is obvously
> > > completely broken regarding that.  As far as I can tell, rx_len is
> > > limited by the maximum return packet size which can be any value up to
> > > the maximum size of a long packet, so we may need to read from the FIFO
> > > multiple times.
> > > 
> > > The loop should be something like this:
> > > 
> > > 	for (i = 0; i < msg->rx_len;) {
> > > 		u32 pld = dsi_read(dsi, DSI_GEN_PLD_DATA);
> > > 		int j;
> > > 
> > > 		for (j = 0; j < 4 && i < msg->rx_len; i++, j++) {
> > > 			rx_buf[i] = pld & 0xff;
> > > 			pld >>= 8;
> > > 		}
> > > 	}  
> > 
> > Short packets should never exceed 32 bits, so I don't think you need to add the
> > nested loop.
> 
> The read response is not restricted to a short packet.  I have a panel
> that documents a read request that returns up to 64KiB, admittedly with
> a continuation command and the panels I have seem to only be programmed
> to return 5 bytes of meaningful data, but they do return all of those
> bytes in a single read response.

Ah, apologies for the misunderstanding. In that case, I think you can get away
with replacing the inner loop in your snippet with a memcpy and call it a day.

Sean

> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
