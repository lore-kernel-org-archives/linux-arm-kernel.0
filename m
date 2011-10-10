From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 10 Oct 2011 14:42:08 -0600 (MDT)
Subject: [PATCHv9 03/18] TEMP: OMAP3xxx: hwmod data: add PRM hwmod
In-Reply-To: <4E934D79.4080000@ti.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
	<1316781986-30642-4-git-send-email-t-kristo@ti.com>
	<alpine.DEB.2.00.1110101320180.5205@utopia.booyaka.com>
	<4E934D79.4080000@ti.com>
Message-ID: <alpine.DEB.2.00.1110101416530.5205@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t

On Mon, 10 Oct 2011, Cousson, Benoit wrote:

> On 10/10/2011 9:24 PM, Paul Walmsley wrote:
> > On Fri, 23 Sep 2011, Tero Kristo wrote:
> > 
> > > This patch is temporary until Paul can provide a final version.
> > > 
> > > Signed-off-by: Tero Kristo<t-kristo@ti.com>
> > 
> > Here's an updated version of this one.  The one change is that the hwmod's
> > name is now "prm3xxx" to reflect that the register layout of this IP block
> > is quite different from its OMAP2 predecessors and OMAP4 successors.
> > This should avoid some of the special-purpose driver probing code.
> 
> This is not really aligned with the naming convention we've been using so far.
> In both cases, the hwmod should just be named "prm". If a version information
> is needed, then it should be added in the revision class field.
> 
> It will make the device creation even simpler and not dependent of the SoC
> version.

The problem in this case is that we should be using a completely different 
device driver for the PRM that's in the OMAP3 chips, from the driver used 
for OMAP2 or OMAP4 PRM blocks, due to the completely different register 
layout.  As far as I know, we haven't yet used the hwmod IP version to 
probe a different device driver when the version number changes.  There's 
no support for that in the current Linux platform* code, so we'd need 
special-purpose code for that.

In an ideal world, we'd have an omap_bus, etc., which would include an 
additional interface version number as part of its driver matching 
criteria.  Device drivers would then specify which interface version 
numbers they supported.  The device data would specify that interface 
version number should be matched.

But as it is right now in the current platform_device/platform_driver 
based system, we have only the name to match.  We could implement 
something where we concatenate the existing IP version number onto the 
hwmod name, and modify the device drivers to use that name.  But that 
seems like a lot of potential churn in light of a future DT and/or 
omap_bus migration.

So I'm proposing to use the IP version number field that's in the hwmod 
data to indicate evolutionary revisions of an IP block -- rather than 
revolutionary revisions that would require a new driver.  Then, since we 
use the hwmod name for driver matching, we'd use a different name for 
radically different IPs.

If it's the "3xxx" that you're objecting to in the name, we could call it 
"prm2" or "prmxyz" - the '3xxx' just seemed like the most logical 
approach.  The name of the hwmod class in the patch is still "prm", of 
course. 

Thoughts?

...

N.B., it's true that by waiting, this problem will presumably go away, 
with DT, in which the driver matching data would go into the 
"compatible" string in the DT.

But I guess it would be good to figure out a clean approach in the 
meantime.


- Paul
