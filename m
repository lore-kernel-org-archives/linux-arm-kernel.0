From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jan 2014 21:27:33 +0000
Subject: [PATCH RFC 30/46] imx-drm: remove separate imx-fbdev
In-Reply-To: <20140107064949.GC12346@S2101-09.ap.freescale.net>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoR-0007FW-4q@rmk-PC.arm.linux.org.uk>
 <20140107064949.GC12346@S2101-09.ap.freescale.net>
Message-ID: <20140108212733.GR27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 02:49:50PM +0800, Shawn Guo wrote:
> On Thu, Jan 02, 2014 at 09:28:19PM +0000, Russell King wrote:
> > @@ -449,6 +458,24 @@ static int imx_drm_driver_load(struct drm_device *drm, unsigned long flags)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * All components are now initialised, so setup the fb helper.
> > +	 * The fb helper takes copies of key hardware information, so the
> > +	 * crtcs/connectors/encoders must not change after this point.
> > +	 */
> > +#if IS_ENABLED(CONFIG_DRM_IMX_FB_HELPER)
> > +	if (legacyfb_depth != 16 && legacyfb_depth != 32) {
> > +		dev_warn(drm->dev, "Invalid legacyfb_depth.  Defaulting to 16bpp\n");
> > +		legacyfb_depth = 16;
> > +	}
> > +	imxdrm->fbhelper = drm_fbdev_cma_init(drm, legacyfb_depth,
> > +				drm->mode_config.num_crtc, 4);
> 
> s/4/MAX_CRTC
> 
> imx-drm-core.c has the macro.

Possible, but when moving code from one location to another it's best
to move it with minimal changes.  Even so, I've now changed this.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
