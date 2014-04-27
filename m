From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Apr 2014 14:32:37 +0100
Subject: [RFC PATCH 0/8] component helper improvements
In-Reply-To: <CAKMK7uFE7NVTS8dgb7kmXtAcz2Q59WhxrZJWcktG98UegFW1zA@mail.gmail.com>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
 <CAKMK7uFE7NVTS8dgb7kmXtAcz2Q59WhxrZJWcktG98UegFW1zA@mail.gmail.com>
Message-ID: <20140427133237.GD26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 02:51:30PM +0200, Daniel Vetter wrote:
> On Sun, Apr 27, 2014 at 1:00 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > A while back, Laurent raised some comments about the component helper,
> > which this patch set starts to address.
> >
> > The first point it addresses is the repeated parsing inefficiency when
> > deferred probing occurs.  When DT is used, the structure of the
> > component helper today means that masters end up parsing the device
> > tree for each attempt to re-bind the driver.
> >
> > We remove this inefficiency by creating an array of matching data and
> > functions, which the component helper can use internally to match up
> > components to their master.
> >
> > The second point was the inefficiency of destroying the list of
> > components each time we saw a failure.  We did this to ensure that
> > we kept things correctly ordered: component bind order matters.
> > As we have an array instead, the array is already ordered, so we
> > use this array to store the component pointers instead of a list,
> > and remember which are duplicates (and thus should be avoided.)
> > Avoiding the right duplicates matters as we walk the array in the
> > opposite direction at tear down.
> >
> > I would like to see patches 1-5 scheduled for the next merge window,
> > with 6-8 for the following window - this gives us grace of one kernel
> > cycle to ensure that any new component helper users are properly
> > converted.
> 
> Afaict the actual patches haven't made it to dri-devel, only to
> linux-arm-kernel. Are they stuck somewhere?

The patches themselves end up being Cc'd depending on their content and
the contents of the MAINTAINERS file, unless I specifically tell my
scripts that the patches are to be sent to/cc people - generally I do
that for the primary recipients of the series.

That means only the patch(es) which touch DRM stuff were copied to
dri-devel, in this case, that being the MSM one.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
