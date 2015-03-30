From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Mar 2015 13:25:12 +0100
Subject: [PATCH 0/3] Improve dw-hdmi CTS/N setting
In-Reply-To: <1427708597.3739.4.camel@pengutronix.de>
References: <20150327111320.GA4019@n2100.arm.linux.org.uk>
 <1427708597.3739.4.camel@pengutronix.de>
Message-ID: <20150330122512.GH24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 11:43:17AM +0200, Philipp Zabel wrote:
> Hi Russell,
> 
> Am Freitag, den 27.03.2015, 11:13 +0000 schrieb Russell King - ARM
> Linux:
> > All,
> > 
> > This is a mini-series to try and move audio support for the Designware
> > HDMI bridge along.
> >
> > There are two known versions of the Designware HDMI audio:
> > 
> > - The Rockchip version, which is based upon feeding the HDMI block I2S
> >   stream(s), which doesn't have any on-board DMA support.
> > - The Freescale version, which only has AHB DMA support.
> > 
> > There are two drivers around at present, one which I've had which is
> > ALSA based due to its simplicity for the Freescale version of the IP,
> > and one which is ASoC based from Yakir Yang for the Rockchip version.
> > 
> > There is some commonality between the two drivers - for example, the
> > setup of the CTS/N values is very similar, although not identical.
> > 
> > I have been reviewing (when time permits) the patches from Yakir Yang,
> > and making recommendations to try and extract the common parts of the
> > driver.  This is the patch set I came up with (mentioned in
> > 20150202130920.GC8656 at n2100.arm.linux.org.uk).
> > 
> > Yakir merged some of my ideas into his patch set - for example, Yakir
> > Yang's "drm: bridge/dw_hdmi: combine hdmi_set_clock_regenerator_n() and
> > hdmi_regenerate_cts()" is very close to the version which I came up
> > with.
> > 
> > Yakir Yang didn't include the mutex patch, which I've included here -
> > it really is necessary because we have potentially two different
> > threads which can change the CTS/N values - a change of the video mode
> > vs a change in the audio driver.
> > 
> > The last patch is adjusting the CTS/N setting order - I have only gone
> > as far as what we know works for iMX6, and this is also identical to
> > Yakir Yang's patch.
> > 
> > The identical nature is hardly surprising; my patches were derived from
> > a previous set of his patches (which I acknowledge in the commit messages)
> > and I detailed in the above message what I wanted to see.
> > 
> > What I would like to see is that - as we are effectively in agreement
> > over two of these patches - we get these patches merged rather than
> > having to repeatedly see them.  If there's any objection, please let me
> > know, otherwise I'll collect acks and send them to David.
> 
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Also,
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> (with your dw-hdmi-audio patches on i.MX6)

Thanks.

I'd really like an Acked-by from Andy Yan on these patches so that we
can be sure we have agreement that these should be merged.

Over the last few days, I've separated out some more patches from the
audio work, and also cleaned up dw_hdmi a little more:

drm: bridge/dw_hdmi: clean up hdmi_set_clk_regenerator()
 drivers/gpu/drm/bridge/dw_hdmi.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

drm: bridge/dw_hdmi: introduce interface to setting sample rate
 drivers/gpu/drm/bridge/dw_hdmi.c | 10 ++++++++++
 include/drm/bridge/dw_hdmi.h     |  5 +++++
 2 files changed, 15 insertions(+)

drm: bridge/dw_hdmi: introduce interfaces to enable and disable audio
 drivers/gpu/drm/bridge/dw_hdmi.c | 34 +++++++++++++++++++++++++++++++++-
 include/drm/bridge/dw_hdmi.h     |  2 ++
 2 files changed, 35 insertions(+), 1 deletion(-)

drm: bridge/dw_hdmi: use drm_hdmi_avi_infoframe_from_display_mode()
 drivers/gpu/drm/bridge/dw_hdmi.c | 126 +++++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 59 deletions(-)

drm: bridge/dw_hdmi: simplify hdmi_config_AVI() a little
 drivers/gpu/drm/bridge/dw_hdmi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

drm: bridge/dw_hdmi: remove mhsyncpolarity/mvsyncpolarity/minterlaced
 drivers/gpu/drm/bridge/dw_hdmi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

drm/edid: add function to help find SADs
 include/drm/drm_edid.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

The 3rd is part of the fix for one of the iMX6 bugs - it doesn't do
anything other than manipulate the programmed N value right now.  What
we don't know is whether Rockchip's implementation suffers from the
same problem.  I suspect it doesn't, as the problematical FIFO probably
isn't present.

It's a bit of a shame that switching to using the new
drm_hdmi_avi_infoframe_from_display_mode() helper has increased the
code size - that's mainly down to the differently formatted infoframe
data (annoyingly, the dw_hdmi's registers have the bits in different
positions to the HDMI packets.)  On the plus side, we get proper
signalling of the aspect ratio data from the DRM mode structure.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
