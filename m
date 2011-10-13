From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 13 Oct 2011 10:38:50 -0600 (MDT)
Subject: [PATCHv9 03/18] TEMP: OMAP3xxx: hwmod data: add PRM hwmod
In-Reply-To: <4E954CDA.10107@ti.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
	<1316781986-30642-4-git-send-email-t-kristo@ti.com>
	<alpine.DEB.2.00.1110101320180.5205@utopia.booyaka.com>
	<4E934D79.4080000@ti.com>
	<alpine.DEB.2.00.1110101416530.5205@utopia.booyaka.com>
	<4E936F0E.9050203@ti.com>
	<alpine.DEB.2.00.1110101725140.5205@utopia.booyaka.com>
	<4E954CDA.10107@ti.com>
Message-ID: <alpine.DEB.2.00.1110131033410.24155@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Oct 2011, Cousson, Benoit wrote:

> On 10/11/2011 1:26 AM, Paul Walmsley wrote:
> > On Tue, 11 Oct 2011, Cousson, Benoit wrote:
> > 
> > > In fact the device name does not have to match the hwmod name. So we 
> > > can just create an "omap2_prm" omap_device for OMAP2, "omap3_prm" 
> > > omap_device for OMAP3... That will allow the relevant PRM driver to 
> > > be bound to the proper device.
> > 
> > Incidentally, given that we would be using the hwmod name and the version
> > number to determine the appropriate omap_device name, what IP version
> > numbers should we assign to these PRM IP blocks for different SoCs?
> 
> It can just be 1, 2 and 3... The idea is just to differentiate the IP for each
> OMAP.

So those are basically arbitrary?  Something is not clear here.

In the current hwmod design, IP blocks with different interfaces were 
intended to be uniquely identified by the hwmod name alone.  That is why 
omap_hwmod_lookup() only takes a 'name' parameter.

If I understand what you want to do, you wish to change this to uniquely 
identify them by a (name, interface version number) tuple.

I don't have a problem with this in theory, but it implies some changes to 
the existing model.  Specifically:

- we'll need to add an interface version number to the struct omap_hwmod

- we'll need to modify omap_hwmod_lookup() to take an interface version 
number

- the "ti,hwmod" DT binding that you proposed earlier will need to include 
an interface version number


- Paul
