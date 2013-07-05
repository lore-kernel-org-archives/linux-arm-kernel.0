From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 6 Jul 2013 00:23:42 +0200
Subject: MTD EEPROM support and driver integration
In-Reply-To: <201307052302.40588.arnd@arndb.de>
References: <20130705201118.GM2959@lukather> <201307052302.40588.arnd@arndb.de>
Message-ID: <20130705222342.GP2959@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Jul 05, 2013 at 11:02:40PM +0200, Arnd Bergmann wrote:
> On Friday 05 July 2013, Maxime Ripard wrote:
> > Hi everyone,
> > 
> > In the last weeks, we've drivers coming up both about mostly some very
> > simple drivers that expose to the userspace a few bytes of memory-mapped
> > IO. Both will probably live under drivers/misc/eeprom, where there's
> > support already for other kind of what could be assimilated as eeproms
> > (AT24, AT25, etc.).
> > 
> > Now, besides the code duplication every driver has to make to register
> > the sysfs attributes, it wouldn't cause much of a problem.
> > 
> > Except that these EEPROMs could store values useful for other drivers in
> > Linux. For example:
> >   - imx28 OCOTP (the latest of the two EEPROM drivers recently submitted)
> >     use it most of the time to store its MAC addresses
> >   - Allwinner SoCs SID (the other latest driver submitted) use it
> >     sometime to store a MAC address, and also the SoC ID, which could be
> >     useful to implement a SoC bus driver.
> >   - Some Allwinner boards (and presumably others) use an AT24 to store
> >     the MAC address in it.
> > 
> > For now, everyone comes up with a different solution:
> >   - imx28 has a hook in mach-mxs to patch the device tree at runtime and
> >     add the values retrieved from the OCOTP to it.
> >   - AT24 seem to have some function exported (at24_macc_(read|write)) so
> >     that other part of the kernel can use them to retrieve values from
> >     such an EEPROM.
> >   - Allwinner SoCs have, well, basically nothing for now, which is why I
> >     send this email.
> > 
> > The current way of working has several flaws imho:
> >   - The code is heavily duplicated: the sysfs registering is common to
> >     every driver, and at the end of the day, every driver should only
> >     give a read/write callback, and that's it.
> >   - The "consumer" drivers should not have to worry at all about the
> >     EEPROM type it should retrieve the needed value from, let alone
> >     dealing with the number of instances of such an EEPROM.
> > 
> > To solve this issues, I think I have some solution. Would merging this
> > drivers into MTD make some sense? It seems like there is already some
> > EEPROM drivers into drivers/mtd (such as an AT25 one, which also have a
> > drivers under drivers/misc/eeprom), so I guess it does, but I'd like to
> > have your opinion on this.
> 
> I always felt that we should eventually move the eeprom drivers out of
> drivers/misc into their own subsystem. Moving them under drivers/mtd
> also seems reasonable.
> 
> Having a common API sounds like a good idea, and we should probably
> spend some time comparing the options.

Great :)

> > If so, would some kind of MTD in-kernel API to retrieve values from MTD
> > devices would be acceptable to you? I mostly have DT in mind, so I'm
> > thinking of having DT bindings to that API such as
> > 
> >   mac-storage = <&phandle 0xoffset 0xsize>
> > 
> > to describe which device to get a value from, and where in that device.
> > 
> > That would allow consumer drivers to only have to call a function like
> > of_mtd_get_value and let the MTD subsystem do the hard work.
> > 
> > What's your feeling on this?
> 
> My first thought is that it should be more generic than that and not
> have the mac address hardcoded as the purpose. We could possibly use
> regmap as the in-kernel interface, and come up with a more generic
> way of referring to registers in another device node.

Hmm, I maybe wasn't as clear as I wanted. Here mac-storage was just an
example. It should indeed be completely generic, and a device could have
several "storage source" defined, each driver knowing what property it
would need, pretty much like what's done currently for the regulators
for example.

We will have such a use case anyway for the Allwinner stuff, since the
fuses can be used for several thing, including storing the SoC ID,
serial numbers, and so on.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130706/1ba30a45/attachment.sig>
