From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 May 2016 10:16:59 +0100
Subject: [PATCH 13/20] drm/bridge: Add RGB to VGA bridge support
In-Reply-To: <20160526085330.GM9232@lukather>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-14-git-send-email-maxime.ripard@free-electrons.com>
 <1773896.kpi58ilqqm@avalon> <20160526085330.GM9232@lukather>
Message-ID: <20160526091659.GG19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 10:53:30AM +0200, Maxime Ripard wrote:
> Hi Laurent,
> 
> On Mon, May 16, 2016 at 04:24:15PM +0300, Laurent Pinchart wrote:
> > Hi Maxime,
> > 
> > Thank you for the patch.
> > 
> > On Monday 16 May 2016 14:47:13 Maxime Ripard wrote:
> > > +fallback:
> > > +	/*
> > > +	 * In case we cannot retrieve the EDIDs (broken or missing i2c
> > > +	 * bus), fallback on the XGA standards
> > > +	 */
> > > +	ret = drm_add_modes_noedid(connector, 1920, 1200);
> > 
> > The DRM core adds modes up to 1024x768 in 
> > drm_helper_probe_single_connector_modes(). I wonder if it really makes sense 
> > to override that in drivers, compared to increasing the maximum resolution in 
> > the core. What we can reasonable expect from a VGA monitor doesn't really 
> > depend on which display engine it is connected to.
> 
> Actually, I would expect it to come from the connectors. Nowadays, the
> core add modes that might not even be relevant at all for a given
> connector. Take TV as an example, there's not a single TV output that
> can reach 1024x768, but actually rely on very different resolutions.

There is the requirement to support 640x480 almost universally.

> > Would it make sense to add an optional GPIO-based connection detection to this 
> > driver ?
> 
> I asked for it in our prototypes, and apparently, doing VGA cable
> detection is really non-trivial, so I don't really expect it to be
> found in a lot of designs.

... and prone to problems.  Intel designs try to measure the termination
resistance to detect whether something is connected (they pulse the RGB
signals and measure the current.)  This mostly works fine, except if you
have some KVM boxes which can make this very unreliable.

I ended up replacing the bipolar transistors switching the RGB signals
in my KVM switch with FETs because of this problem.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
