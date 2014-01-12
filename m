From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jan 2014 13:38:50 +0000
Subject: [PATCH v2 20/28] drm/i2c: tda998x: move the TBG_CNTRL_0
 register setting
In-Reply-To: <20140112142000.1f3e5ab5@armhf>
References: <20140109120607.6a33bee5@armhf>
 <20140111183648.GH15937@n2100.arm.linux.org.uk>
 <20140112132321.757f3fa7@armhf>
 <20140112123159.GS15937@n2100.arm.linux.org.uk>
 <20140112142000.1f3e5ab5@armhf>
Message-ID: <20140112133849.GT15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 02:20:00PM +0100, Jean-Francois Moine wrote:
> On Sun, 12 Jan 2014 12:31:59 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > > So, in my patch 9, I was writing the REG_TBG_CNTRL_1 after writing
> > > REG_TBG_CNTRL_0, and you refused it. Here, I write REG_TBG_CNTRL_0
> > > after the write of REG_TBG_CNTRL_1 in the HDMI sequence, and you still
> > > don't agree.
> > > 
> > > What is the right way?  
> > 
> > No, both NAKS are for the exact same issue.
> > 
> > Patch 9 inserted the write to REG_TBG_CNTRL_1 after REG_TBG_CNTRL_0.
> > Then in this patch you move REG_TBG_CNTRL_0 after all writes.
> > 
> > Had you appropriately placed the write to REG_TBG_CNTRL_1 in patch 9
> > in the first place, _this_ patch (patch 20) would not be required to
> > then move REG_TBG_CNTRL_0 after it.  So, fixing patch 9 removes the
> > need for patch 20.
> 
> Fixing the patch 9 gives:
> 
> 	/*
> 	 * Always generate sync polarity relative to input sync and
> 	 * revert input stage toggled sync at output stage
> 	 */
> 	reg = TBG_CNTRL_1_DWIN_DIS | TBG_CNTRL_1_TGL_EN;
> 	if (adj_mode->flags & DRM_MODE_FLAG_NHSYNC)
> 		reg |= TBG_CNTRL_1_H_TGL;
> 	if (adj_mode->flags & DRM_MODE_FLAG_NVSYNC)
> 		reg |= TBG_CNTRL_1_V_TGL;
> 	reg_write(priv, REG_TBG_CNTRL_1, reg);
> 
> 	/* must be last register set: */
> 	reg_clear(priv, REG_TBG_CNTRL_0, TBG_CNTRL_0_SYNC_ONCE);
> 
> 	/* Only setup the info frames if the sink is HDMI */
> 	if (priv->is_hdmi_sink) {
> 		/* We need to turn HDMI HDCP stuff on to get audio through */
> 		reg &= ~TBG_CNTRL_1_DWIN_DIS;
> 		reg_write(priv, REG_TBG_CNTRL_1, reg);
> 		reg_write(priv, REG_ENC_CNTRL, ENC_CNTRL_CTL_CODE(1));
> 		reg_set(priv, REG_TX33, TX33_HDMI);
> 
> 		tda998x_write_avi(priv, adj_mode);
> 
> 		if (priv->params.audio_cfg)
> 			tda998x_configure_audio(priv, adj_mode, &priv->params);
> 	}
> 
> and REG_TBG_CNTRL_1 is set in the HDMI branch (with REG_ENC_CNTRL and
> REG_TX33).
> 
> Is this OK?

I would find that acceptable to ack it as a replacement patch 9, thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
