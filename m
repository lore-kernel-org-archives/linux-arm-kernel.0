From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jan 2014 16:32:50 +0000
Subject: imx-drm: screen flickering
In-Reply-To: <201401291553.15040.marex@denx.de>
References: <CAH9NwWe673znThNPWRvOCyAU2o7M-oouHD7+1tyRcmWTeJ8YFw@mail.gmail.com>
 <20140129111557.GI16215@pengutronix.de> <201401291553.15040.marex@denx.de>
Message-ID: <20140129163250.GU15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 03:53:14PM +0100, Marek Vasut wrote:
> Isn't it the clock polarity being inverted thing again [1]?
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-
> December/215536.html
> 
> The easiest way to check this would be to try sig_cfg.clk_pol = 0
> or = 1 and see if it changes anything.

It seems that the pixel clock polarity on iMX hardware is something of
a mess.  Some hardware blocks require one polarity, others require a
different polarity.

I think what would make sense is if the various output connectors/
encoders (in other words, imx-hdmi, imx-ldb, etc supplied their
properties concerning the clock polarity to the IPU layer.

We already have something like this in place already: we have the encoder
prepare functions calling into the ipuv3-crtc layer (via imx-drm-core) to
set the interface format, vsync/hsync pins, and clock flags - all of which
get used in the CRTC's mode_set method.  Adding the clock polarity into
that path doesn't sound too difficult.

The only issue is that there's a lack of conflict management here - but
that's not a new problem with this approach - it exists with the existing
data.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
