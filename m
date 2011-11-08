From: balbi@ti.com (Felipe Balbi)
Date: Tue, 8 Nov 2011 20:44:48 +0200
Subject: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <20111108182955.GH12913@n2100.arm.linux.org.uk>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
 <4EB9477E.8070002@atmel.com>
 <20111108152343.GJ20728@legolas.emea.dhcp.ti.com>
 <20111108182955.GH12913@n2100.arm.linux.org.uk>
Message-ID: <20111108184447.GB24399@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Tue, Nov 08, 2011 at 06:29:55PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 08, 2011 at 05:23:46PM +0200, Felipe Balbi wrote:
> > On Tue, Nov 08, 2011 at 04:15:10PM +0100, Nicolas Ferre wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > On 11/08/2011 03:41 PM, Felipe Balbi :
> > > 
> > > >> +	if (cpu_is_at91rm9200()) {			/* AT91RM9200 Errata #22 */
> > > > 
> > > > I don't think you should be using cpu_is_* on drivers.
> > > 
> > > It is a common pattern in at91 drivers and has worked for ages.
> > > Do you think it is related to the need to be able to compile the
> > > driver for any SoC in the case of multi-SoC zImage support?
> > 
> > we have drivers compiling on multiple OMAP versions without those hacks.
> > Generally, we check the IP revision for that. Don't you have a Revision
> > register of some sort ?
> 
> I'm not sure what your objection is - this is no different from what
> happens with OMAP when detecting OMAP1,2,3,4 etc.  E.g.:

so ? Instead of saying this to me, you should contact the
authors/maintainers of those drivers and ask them to clean that up.

Moreover, just because there are a bunch of drivers with such silly
mistakes, is it really enough argument to perpetuate the problem ?

You were (actually still is) one of the biggest source of complaints for
drivers using <mach/*> and <asm/*> includes and now you're changing your
mind ?

Also, instead of taking bad examples take the ones which are activelly
improving with regards to those details. I have been fighting against
those on the USB drivers, at least. And, except for
drivers/usb/musb/davinci.c you won't find those on MUSB driver or its
glue layers. Similarly, I have been asking all USB Peripheral Controller
drivers to make their driver buildable on all arches, which will get rid
of bad usage of <mach/*> and <asm/*> headers while also allowing for a
better coverage of compile tests on linux-next.

Now, if you really think those aren't problematic, refrain from
complaining next time someone adds a machine_is_* or cpu_is_* check on a
driver.

> drivers/mfd/twl-core.c:     if (cpu_is_omap2430())
> drivers/media/video/omap3isp/isp.c: if (cpu_is_omap3630())
> drivers/media/video/omap/omap_vout.c:               if (cpu_is_omap24xx() || cpu_is_omap34xx())
> drivers/media/video/omap/omap_voutlib.c:    if (cpu_is_omap24xx()) {
> drivers/media/video/omap/omap_voutlib.c:    } else if (cpu_is_omap34xx()) {
> drivers/media/video/omap/omap_voutlib.c:    if (cpu_is_omap24xx()) {

at least vout and voutlib haven't been touched since january.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111108/9676d69d/attachment.sig>
