From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 4 May 2018 15:40:33 +0200
Subject: [PATCH v2 09/10] ARM: dts: sun7i-a20: Add Video Engine and
 reserved memory nodes
In-Reply-To: <fc064c3f1534a6082dc2b4e18454e054b53e5aee.camel@bootlin.com>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154536.17846-5-paul.kocialkowski@bootlin.com>
 <20180420073908.nkcbsdxibnzkqski@flea>
 <82057e2f734137a3902d9313c228b01ceb345ee7.camel@bootlin.com>
 <20180504084008.h6p4brari3xrbv6l@flea>
 <e8cd340605ab4db8ebf2888a4fce645e8bc481d0.camel@bootlin.com>
 <20180504091555.idgtzey53lozj2uh@flea>
 <fc064c3f1534a6082dc2b4e18454e054b53e5aee.camel@bootlin.com>
Message-ID: <20180504134033.wngpe5scyisreonn@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 02:04:38PM +0200, Paul Kocialkowski wrote:
> On Fri, 2018-05-04 at 11:15 +0200, Maxime Ripard wrote:
> > On Fri, May 04, 2018 at 10:47:44AM +0200, Paul Kocialkowski wrote:
> > > > > > > +			reg = <0x01c0e000 0x1000>;
> > > > > > > +			memory-region = <&ve_memory>;
> > > > > > 
> > > > > > Since you made the CMA region the default one, you don't need
> > > > > > to
> > > > > > tie
> > > > > > it to that device in particular (and you can drop it being
> > > > > > mandatory
> > > > > > from your binding as well).
> > > > > 
> > > > > What if another driver (or the system) claims memory from that
> > > > > zone
> > > > > and
> > > > > that the reserved memory ends up not being available for the VPU
> > > > > anymore?
> > > > > 
> > > > > Acccording to the reserved-memory documentation, the reusable
> > > > > property
> > > > > (that we need for dmabuf) puts a limitation that the device
> > > > > driver
> > > > > owning the region must be able to reclaim it back.
> > > > > 
> > > > > How does that work out if the CMA region is not tied to a driver
> > > > > in
> > > > > particular?
> > > > 
> > > > I'm not sure to get what you're saying. You have the property
> > > > linux,cma-default in your reserved region, so the behaviour you
> > > > described is what you explicitly asked for.
> > > 
> > > My point is that I don't see how the driver can claim back (part of)
> > > the
> > > reserved area if the area is not explicitly attached to it.
> > > 
> > > Or is that mechanism made in a way that all drivers wishing to use
> > > the
> > > reserved memory area can claim it back from the system, but there is
> > > no
> > > priority (other than first-come first-served) for which drivers
> > > claims
> > > it back in case two want to use the same reserved region (in a
> > > scenario
> > > where there isn't enough memory to allow both drivers)?
> > 
> > This is indeed what happens. Reusable is to let the system use the
> > reserved memory for things like caches that can easily be dropped when
> > a driver wants to use the memory in that reserved area. Once that
> > memory has been allocated, there's no claiming back, unless that
> > memory segment was freed of course.
> 
> Thanks for the clarification. So in our case, perhaps the best fit would
> be to make that area the default CMA pool so that we can be ensured that
> the whole 96 MiB is available for the VPU and that no other consumer of
> CMA will use it?

The best fit for what use case ? We already discussed this, and I
don't see any point in having two separate CMA regions. If you have a
reasonably sized region that will accomodate for both the VPU and
display engine, why would we want to split them?

Or did you have any experience of running out of buffers?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/d2d87aa3/attachment.sig>
