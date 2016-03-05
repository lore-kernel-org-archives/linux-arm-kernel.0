From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Mar 2016 12:39:42 +0000
Subject: [PATCH 1/2] drm/rockchip: dw_hdmi: Call drm_encoder_cleanup() in
 error path
In-Reply-To: <20160305121005.GA11966@serenity.lan>
References: <1457133723-24869-1-git-send-email-dianders@chromium.org>
 <20160305121005.GA11966@serenity.lan>
Message-ID: <20160305123942.GE19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 05, 2016 at 12:11:16PM +0000, John Keeping wrote:
> On Fri, Mar 04, 2016 at 03:22:01PM -0800, Douglas Anderson wrote:
> > The drm_encoder_cleanup() was missing both from the error path of
> > dw_hdmi_rockchip_bind().  This caused a crash when slub_debug was
> > enabled and we ended up deferring probe of HDMI at boot.
> > 
> > This call isn't needed from unbind() because if dw_hdmi_bind() returns
> > no error then it takes over the job of freeing the encoder (in
> > dw_hdmi_unbind).
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> 
> Does dw_hdmi-imx need a similar change?  I wonder if it would be cleaner
> to push this into dw_hdmi_bind() if it affects all of the platforms..

I don't think moving it there would make sense - keep the initialisation
and cleanup together in the same file so that it's contained together.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
