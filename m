From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2011 19:39:30 +0000
Subject: [PATCH V3 2/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <20111108190200.GC24399@legolas.emea.dhcp.ti.com>
References: <cover.1320753142.git.n.voss@weinmann.de>
 <7bdd6b456b0e055441cb25634c8cb6d483718f6c.1320753142.git.n.voss@weinmann.de>
 <20111108144115.GH20728@legolas.emea.dhcp.ti.com>
 <4EB9477E.8070002@atmel.com>
 <20111108152343.GJ20728@legolas.emea.dhcp.ti.com>
 <20111108182955.GH12913@n2100.arm.linux.org.uk>
 <20111108184447.GB24399@legolas.emea.dhcp.ti.com>
 <20111108185525.GI12913@n2100.arm.linux.org.uk>
 <20111108190200.GC24399@legolas.emea.dhcp.ti.com>
Message-ID: <20111108193930.GJ12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 09:02:02PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Nov 08, 2011 at 06:55:25PM +0000, Russell King - ARM Linux wrote:
> > > so ? Instead of saying this to me, you should contact the
> > > authors/maintainers of those drivers and ask them to clean that up.
> > 
> > Oh for god sake, I was just asking you to clarify your statement in
> > light of what is currently being done.
> > 
> > Now, let me set something straight.  I've been saying that machine_is_xxx()
> > should not be used in drivers.  That's a platform thing and platform
> > specifics should not be in drivers - it should be passed in via DT or
> > platform data.  That's enforced by the way DT works (Grant's decision
> > not mine) - with DT you don't have any kind of testable machine ID for
> > machine_is_xxx() to use.
> > 
> > I've never said that cpu_is_xxx() should not - that's something *other*
> > people are saying (and quite rightly so) because if we're going to start
> > sharing drivers between different SoCs (or even architectures - eg, PXA
> > IP appearing on x86) then it doesn't make sense for the type of SoC to
> > be tested.  It makes more sense for the revision of the IP implementation
> > to be checked IFF such information is available.  If not, some other way
> > of controlling the 'features' needs to be sought.
> > 
> > As far as the use of asm/*.h includes, I've NEVER made any statement
> > about the use of those in drivers.  In fact, I don't see any reason to
> > avoid them _provided_ they're standard cross-arch includes.
> > 
> > As for mach/*.h includes, I don't think that I've made any statement
> > about those either, but at this point - given that we're working towards
> > a single zImage on ARM - it is _sensible_ to avoid such includes in
> > drivers.
> > 
> > So, I think your reaction to my statement is way off mark, and you're
> > attributing statements (that it seems you personally don't agree with)
> > to me.
> 
> If I did, then it's really my fault. But I _do_ remember you complaining
> about uses of <asm/gpio.h> instead of <linux/gpio.h>, for example.

Yes, I do complain about those with _good_ reason:
1. it's a strict checkpatch thing.
2. it's a correctness thing which matters as linux/gpio.h is the top-level
   include for gpio stuff, and at some point may have stuff pulled up
   from asm/gpio.h into it (or new stuff added to it.)

Same reasoning for linux/io.h - things get moved out of asm/io.h into
linux/io.h.  One such example is check_signature() which used to be
declared at the asm/io.h level but is now at the linux/io.h level.

And the overriding reason: if I can get them fixed _now_ they won't have
to be fixed in some massive patch in the future when we've got a few
thousand of them to deal with and tonnes of breakage because something
cross-arch changed there.

That point has been *well* proven by my recent clean ups to the mach/gpio.h
includes - which necessitated changing tonnes of mach/gpio.h includes
across the kernel tree.  Had people paid more attention to getting these
includes right, that cleanup would have been much easier.

But, that's something very different from your statement in your previous
message about my alleged stance on *all* asm/*.h includes in drivers,
which is FALSE.

> Now, all the other topics I agree and, in fact, have been pushing for
> that as I can. Specially with regards to IP cores being shared among
> several architectures (see drivers/usb/dwc3 where I have a core driver
> shared between ARM and PCI/x86).

Good, so you've just taken back most of what you said in your previous
message.
