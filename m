From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 11 Mar 2014 14:34:38 +0100
Subject: [PATCH v5 00/11] imx-drm dt bindings
In-Reply-To: <20140311132727.GB26502@S2101-09.ap.freescale.net>
References: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
 <20140311034607.GA26502@S2101-09.ap.freescale.net>
 <1394538128.3772.15.camel@paszta.hi.pengutronix.de>
 <20140311132727.GB26502@S2101-09.ap.freescale.net>
Message-ID: <1394544878.4339.7.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 11.03.2014, 21:27 +0800 schrieb Shawn Guo:
> On Tue, Mar 11, 2014 at 12:42:08PM +0100, Philipp Zabel wrote:
> > Hi Shawn,
> > 
> > Am Dienstag, den 11.03.2014, 11:46 +0800 schrieb Shawn Guo:
> > > On Wed, Mar 05, 2014 at 10:20:51AM +0100, Philipp Zabel wrote:
> > > > Hi,
> > > > 
> > > > this latest version of the imx-drm DT binding patches applies
> > > > on top of staging-next and also depends on the OF graph binding
> > > > patchset that moves the v4l2_of helpers to drivers/of.
> > > > Currently, the two patchsets are also available at:
> > > >     git://git.pengutronix.de/git/pza/linux.git topic/of-graph
> > > >     git://git.pengutronix.de/git/pza/linux.git topic/imx-drm-dt
> > > 
> > > Hi Philipp,
> > > 
> > > I just came across a couple problems when testing the series on
> > > my imx6dl-sabresd board in dual display case - HDMI + LVDS.  I tested it
> > > using Russell's branch below, which I believe has all the pieces put
> > > together.
> > > 
> > >   git://ftp.arm.linux.org.uk/~rmk/linux-arm.git imx-drm-staging
> > > 
> > > - When I enable HDMI and LVDS support in both kernel build and device
> > >   tree, HDMI seems working fine but LVDS color is corrupted quite badly.
> > > 
> > > - When I enable HDMI and LVDS support in kernel build but only LVDS in
> > >   device tree (keep HDMI disabled in device tree by not changing
> > >   'status' of HDMI node to 'okay'), LVDS does not even work.  In this
> > >   case, it seems that the binding of display-subsystem does not succeed.
> > 
> > Can you check if you get the bound messages from
> > drivers/base/component.c:
> > 
> > imx-drm display-subsystem.11: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
> > imx-drm display-subsystem.11: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
> > imx-drm display-subsystem.11: bound ldb.10 (ops imx_ldb_ops)
> > 
> > I have tried this branch with a Phytec phyFLEX i.MX6S on PBAB01
> > baseboard with EDT 800x480 LVDS panel, and it seems to work.
> > The check in drivers/staging/imx-drm/imx-drm-core.c:675 should make sure
> > that unavailable (status="disabled") devices are just skipped.
> 
> Sorry, Philipp.  The setup in my report is incorrect.  The correct setup
> to see this issue consists of:
> 
> 1) build a kernel without HDMI support, i.e. !CONFIG_DRM_IMX_HDMI
> 
> 2) enable HDMI device in DT, i.e. adding the lines below in board dts.
> 
> 	&hdmi {
> 	       status = "okay";
> 	};
> 
> Sorry for the confusion.
> 
This isn't a supported use-case, the componentized device stuff is there
exactly to ensure that the DRM device is only brought up after all
active components have an driver attached to them.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
