From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 12:18:13 +0000
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <3242371.eHgoTRi3y3@vostro.rjw.lan>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <20140103031055.GB28751@kroah.com>
 <20140103110030.GH7383@n2100.arm.linux.org.uk>
 <3242371.eHgoTRi3y3@vostro.rjw.lan>
Message-ID: <20140103121812.GJ7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 12:58:16PM +0100, Rafael J. Wysocki wrote:
> On Friday, January 03, 2014 11:00:30 AM Russell King - ARM Linux wrote:
> > On Thu, Jan 02, 2014 at 07:10:55PM -0800, Greg Kroah-Hartman wrote:
> > > On Thu, Jan 02, 2014 at 09:27:58PM +0000, Russell King wrote:
> > > > Subsystems such as ALSA, DRM and others require a single card-level
> > > > device structure to represent a subsystem.  However, firmware tends to
> > > > describe the individual devices and the connections between them.
> > > > 
> > > > Therefore, we need a way to gather up the individual component devices
> > > > together, and indicate when we have all the component devices.
> > > > 
> > > > We do this in DT by providing a "superdevice" node which specifies
> > > > the components, eg:
> > > > 
> > > > 	imx-drm {
> > > > 		compatible = "fsl,drm";
> > > > 		crtcs = <&ipu1>;
> > > > 		connectors = <&hdmi>;
> > > > 	};
> > > > 
> > > > The superdevice is declared into the component support, along with the
> > > > subcomponents.  The superdevice receives callbacks to locate the
> > > > subcomponents, and identify when all components are present.  At this
> > > > point, we bind the superdevice, which causes the appropriate subsystem
> > > > to be initialised in the conventional way.
> > > > 
> > > > When any of the components or superdevice are removed from the system,
> > > > we unbind the superdevice, thereby taking the subsystem down.
> > > 
> > > This sounds a lot like the "containers" code that Rafael just submitted
> > > and I acked for 3.14.  Look at the lkml post:
> > > 	Subject: [PATCH 2/2] ACPI / hotplug / driver core: Handle containers in a special way
> > > 	Message-ID: <1991202.gilW172FBV@vostro.rjw.lan>
> > > 
> > > And see if that could possibly be used instead?
> > 
> > That's really disappointing bcause I've put a hell of a lot of work into
> > this over the last few months, and if that's true it's all just been a
> > total waste of my time.  Okay, lesson learned - don't spend any time
> > trying to fix other people's problems after discussing them at
> > kernel-summit.
> 
> Well, I didn't know that you were doing this work and my patch is to address
> a specific problem that people are seeing in testing.  Also, the generic
> containers part in it is very simple and it might be possible to integrate it
> with your code, this way or another.  In fact, the only only thing I need from
> containers at the moment is the online/offline functionality.

We had a session at kernel summit chaired by David Airlie to discuss
various issues associated with DRM which included the problems of
componentised devices registering into card-based subsystems.  There
were quite a number of attendees to that session.

It is in that session that I said I would work on this, specifically
with the aim of getting imx-drm out of drivers/staging.

> > In any case, the above message ID doesn't give me access to this containers
> > code to look at to even evaluate whether it can be used for this - it just
> > gives two patches for ACPI specific patches but not the core stuff.
> > 
> > http://www.spinics.net/lists/linux-acpi/msg48101.html
> > http://www.spinics.net/lists/linux-acpi/msg48102.html
> > 
> > Please provide a better reference to the code you're referring to.
> 
> You can use the linux-next branch of the linux-pm.git tree at the moment or I
> can set up a separate branch for that if that helps.  The two patches above
> depend on some earlier material I've gueued up for 3.14, but it's mostly
> ACPI hotplug code.

I'm not sure what I'm looking for.  I've tried looking at the results of
searching your linux-next branch for "container" but I don't see
anything implementing similar functionality to the patch I've sent.

https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next&qt=grep&q=container

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
