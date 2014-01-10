From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Jan 2014 14:54:44 +0000
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <20140103031055.GB28751@kroah.com>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <20140103031055.GB28751@kroah.com>
Message-ID: <20140110145444.GE15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 07:10:55PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Jan 02, 2014 at 09:27:58PM +0000, Russell King wrote:
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
> > 	imx-drm {
> > 		compatible = "fsl,drm";
> > 		crtcs = <&ipu1>;
> > 		connectors = <&hdmi>;
> > 	};
> > 
> > The superdevice is declared into the component support, along with the
> > subcomponents.  The superdevice receives callbacks to locate the
> > subcomponents, and identify when all components are present.  At this
> > point, we bind the superdevice, which causes the appropriate subsystem
> > to be initialised in the conventional way.
> > 
> > When any of the components or superdevice are removed from the system,
> > we unbind the superdevice, thereby taking the subsystem down.
> 
> This sounds a lot like the "containers" code that Rafael just submitted
> and I acked for 3.14.  Look at the lkml post:
> 	Subject: [PATCH 2/2] ACPI / hotplug / driver core: Handle containers in a special way
> 	Message-ID: <1991202.gilW172FBV@vostro.rjw.lan>
> 
> And see if that could possibly be used instead?

Greg,

Not sure if you saw the outcome to your comment above.  My conclusion
was:

"Yes, I'm coming to that conclusion as well.  It looks like your "containers"
aren't about collecting up several individual component devices into one
super-device and probing the appropriate subsystem when all components are
known.

"Confused why Greg is pointing me at your patches."

Does this mean you're happy with the patch?

Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
