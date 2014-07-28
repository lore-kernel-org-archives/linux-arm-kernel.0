From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 28 Jul 2014 16:12:17 +0200
Subject: [Patch V2 2/2] i2c: mv64xxx: Remove internal compatible string
 from Documentation
In-Reply-To: <5514427.elClhaDPhf@wuerfel>
References: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
 <20140728132251.GN23220@titan.lakedaemon.net>
 <20140728132716.GC2891@lunn.ch> <5514427.elClhaDPhf@wuerfel>
Message-ID: <20140728141217.GE2891@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 03:51:27PM +0200, Arnd Bergmann wrote:
> On Monday 28 July 2014 15:27:16 Andrew Lunn wrote:
> > > > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> > > > index 5c30026921ae..6eb6f6e40ba1 100644
> > > > --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> > > > +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> > > > @@ -9,11 +9,6 @@ Required properties :
> > > >                       - "allwinner,sun6i-a31-i2c"
> > > >                       - "marvell,mv64xxx-i2c"
> > > >                       - "marvell,mv78230-i2c"
> > > > -                     - "marvell,mv78230-a0-i2c"
> > > > -                       * Note: Only use "marvell,mv78230-a0-i2c" for a
> > > > -                         very rare, initial version of the SoC which
> > > > -                         had broken offload support.  Linux
> > > > -                         auto-detects this and sets it appropriately.
> > > 
> > > I think we're losing knowledge here.  *We* know that attempting to
> > > enable transaction offload on A0 SoCs is bad news.  Other OS's would now
> > > need to dig through the Linux kernel code for clues as to what's
> > > happening.
> > > 
> > > Perhaps we should retain the info in the form of a note at the bottom of
> > > this file?
> > 
> > Hi Jason
> > 
> > I did wounder about this a bit. I've not looked, but now that XP
> > datasheets are public, i assume there is an errata for this, so it at
> > least should be documented by Marvell. But anybody looking in
> > /proc/device-tree on an A0 is going to see this undocumented string
> > which might raise questions.
> > 
> > So i'm happy to document it at the end of the binding.
> > 
> > Arnd, what do you say?
> 
> The final consequence of the API change would be to no longer
> change the compatible string in the fixup, but instead to call an
> API from the driver to find out the SoC revision when it encounters
> an mv78230-i2c.
> 
> I remember this being discussed when the quirk was initially added,
> but it seemed cleaner to handle this in the platform code at the time
> when it was just for one particular board. Now that it's basically
> an accepted feature of the i2c device that you have to know the
> SoC version, that should probably become a proper API.
> 
> Also, we now have drivers/soc/ and can move the soc-id code there
> with a publically documented API.

Getting the SoC ID and revision seems like something that should be
generic. Would it be better to make this part of drivers/base/soc.c?
mvebu already does a soc_device_register() with the relevant
information.

Add a call something like:

/*
 * Return the soc device attributes for a given soc_dev. If soc_dev is NULL,
 * the first device on the soc bus is returned.
 */
struct soc_device_attribute *soc_attribute_get(struct soc_device * soc_dev);

       Andrew
