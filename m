From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 30 Jul 2014 10:44:43 +0200
Subject: [Patch V2 2/2] i2c: mv64xxx: Remove internal compatible string
 from Documentation
In-Reply-To: <5514427.elClhaDPhf@wuerfel>
References: <1406395238-29758-1-git-send-email-andrew@lunn.ch>
 <20140728132251.GN23220@titan.lakedaemon.net>
 <20140728132716.GC2891@lunn.ch> <5514427.elClhaDPhf@wuerfel>
Message-ID: <20140730084443.GU3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Sorry for jumping into the discussion like this, but we start having
pretty much the same issues on the Allwinner stuff.

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
> 
> I agree it's sad to lose the knowledge about the revision, but we
> already have that as we now accept the generic string even on the
> a0 machines other than ax3.

What's the advantage on pushing the soc-detection to the drivers
themselves?

I'd really liked the idea that mvebu implements following this patch,
with the soc detection and DT fixup being done in the machine, because
it seems like it has a major benefit of centralizing every thing in a
single place.

That way it's much easier to have a status of what's supported and
what's not, that you wouldn't have if every driver was supposed to
handled that itself.

Plus, you seemed to be interested in having the quirks disabled, which
wouldn't be (easily) doable if we move individual quirks to the
drivers.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/34ed86bf/attachment.sig>
