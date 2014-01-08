From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Jan 2014 21:36:47 +0000
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <CAOw6vbJNgdWJvb6t7zJ0Gm6gjXuq8Yd=ySgU+zqg-Kb1j1bBvw@mail.gmail.com>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <CAOw6vbJNgdWJvb6t7zJ0Gm6gjXuq8Yd=ySgU+zqg-Kb1j1bBvw@mail.gmail.com>
Message-ID: <20140108213647.GT27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 03:18:21PM -0500, Sean Paul wrote:
> On Thu, Jan 2, 2014 at 4:27 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Subsystems such as ALSA, DRM and others require a single card-level
> > device structure to represent a subsystem.  However, firmware tends to
> > describe the individual devices and the connections between them.
> >
> > Therefore, we need a way to gather up the individual component devices
> > together, and indicate when we have all the component devices.
> >
> > We do this in DT by providing a "superdevice" node which specifies
> > the components, eg:
> >
> >         imx-drm {
> >                 compatible = "fsl,drm";
> >                 crtcs = <&ipu1>;
> >                 connectors = <&hdmi>;
> >         };
> >
> 
> Hi Russell,
> This looks really good. I'd definitely like to use it for the exynos
> drm driver both to bind the various IP blocks together, and also to
> pull in any attached bridges that are specified in the device tree.
> Along those lines, it might be worthwhile to pull some of the master
> bind functionality in your next patch into drm helpers so other
> drivers can use them, and so we have concrete bindings across drm.

Which bits do you think would be useful to move into the core?
imx_drm_add_components() is rather imx-drm specific, especially for
the CRTCs - it carries the knowledge that the OF device to be matched
can be found in the _parent_ device, rather than the device registered
into the component helpers.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
