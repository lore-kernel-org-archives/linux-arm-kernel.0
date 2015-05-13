From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 May 2015 16:58:18 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.2
In-Reply-To: <3302855.7BhJdLtyJZ@wuerfel>
References: <20150511193527.GA29690@lukather> <2423239.y1LCAVXsLT@wuerfel>
 <20150513115455.GZ10961@lukather> <3302855.7BhJdLtyJZ@wuerfel>
Message-ID: <20150513145818.GB4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 03:03:04PM +0200, Arnd Bergmann wrote:
> On Wednesday 13 May 2015 13:54:55 Maxime Ripard wrote:
> > On Wed, May 13, 2015 at 12:30:39PM +0200, Arnd Bergmann wrote:
> > > > > Sorry I hadn't looked at the new driver before, but I did now and need a little
> > > > > clarification. It seems to me that the device should be compatible with the
> > > > > generic DT binding we have in Documentation/devicetree/bindings/misc/sram.txt,
> > > > > and use more generic code. At least I can't see much in here that is really sunxi
> > > > > specific.
> > > > >
> > > > > Were you not aware of that generic binding, or did you have a good reason
> > > > > not to use it?
> > > > 
> > > > I asked myself the same question, and I don't really think that this
> > > > would be wise, since that in order to be accessible by the CPU it has
> > > > to be mapped to it through this driver.
> > > > 
> > > > I felt like this alone justify a new compatible, even though we might
> > > > end up using the same driver.
> > > 
> > > Have you discussed this with Heiko?
> > 
> > No, I didn't.
> > 
> > We don't need to use his driver, there was no point about discussing
> > with him about anything.
> 
> The point is that you add a new binding for an SRAM. We already have
> a binding for that, so you should try to make your device fit in with
> the existing design.

Again, we have a binding for, according to the documentation, "Generic
on-chip SRAM. Simple IO memory regions to be managed by the genalloc
API." whatever the genalloc API means from a DT point of view.

These SRAM are in no way generic. They are not always IO mapped, and
are not to be managed by the genalloc API.

I'm not sure how that qualifies.

Plus, if we ever need to use genalloc, nothing actually prevents us
from using that binding, both are not incompatible.

> > > but I now think I was misreading it, and the problem is different:
> > > Rather than having separate devices for parts of the SRAM, you
> > > are actually missing a node for the SRAM physical window. I think
> > > the individual SRAM pieces should be nodes below one that describes
> > > all of the SRAM, as we do in 
> > > Documentation/devicetree/bindings/misc/sram.txt
> > 
> > These are physically separate SRAM, used for different purposes, by
> > different devices.
> > 
> > Since when in the DT different instances of the same IP should be
> > represented in a single node?
> > 
> > And again, this patch is really not about "Simple IO memory regions to
> > be managed by the genalloc API". We have no use for these SRAMs, and
> > just want them to be mapped to the device, so the CPU won't even have
> > access to them for most of them.
> 
> I believe that is the case for a lot of the other SRAMs as well,
> and that is why I think we need Heiko to review your binding and
> say if it makes sense separately from the generic driver, or if
> we should extend the existing binding.
> 
> We can still have separate drivers if necessary, but I really don't
> want to see multiple incompatible ways of describing something this
> fundamental in DT.

And this is not incompatible. We can very well add sub-regions later
on if needed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/f883b2ab/attachment.sig>
