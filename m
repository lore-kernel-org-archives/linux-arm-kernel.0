From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Oct 2014 18:17:04 +0100
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20141001124852.GB21733@ulmo>
References: <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
 <20141001081443.GC18463@ulmo> <20141001122008.GW4273@sirena.org.uk>
 <20141001124852.GB21733@ulmo>
Message-ID: <20141001171704.GG4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 02:48:53PM +0200, Thierry Reding wrote:
> On Wed, Oct 01, 2014 at 01:20:08PM +0100, Mark Brown wrote:

> > I think you're setting constraints on the implementation you want to see
> > which make it unworkable but I don't think those constraints are needed.
> > You're starting from the position that the DT needs to be updated without
> > the bootloader

> No, what I'm saying is that what the simplefb driver expects and what
> the bootloader sets up may diverge as resource drivers are added to the
> kernel. The DT /could/ be updated without the bootloader. You may only
> be able to replace the DTB but not the bootloader on a given platform.

Sure, but doing that and also having the bootloader write part of the DT
from scratch with no cooperation from the rest of the DT doesn't seem
like the way to robustness.

> >                and that the DT must not contain any hint of simplefb as
> > shipped separately.

> Well, I don't think it should because it describes the same resources
> that the device tree node for the real device already describes. But
> perhaps this is one of the cases where duplication isn't all that bad?

If we were worried about this wecould also do it by referring to
those nodes and saying "get all the resources these things need" rather
than duplicating the references (this might make it easier to work out
when the system is ready to hand off to the real drivers).

> >                     That's never going to work well as far as I can see
> > but doesn't seem like an ABI stability issue, or at least not a
> > reasonable one.

> It would work well under the assumption that the kernel wouldn't be
> touching any of the resources that simplefb depends on. If that's not a
> reasonable assumption then I think we can't make simplefb work the way
> it's currently written.

I can't see how that's reasonable unless the kernel has some way of
figuring out what it shouldn't be touching.

> > Either the bootloader needs to be updated along with the DT

> I thought we had decided that this was one of the big no-nos. But
> perhaps I'm misremembering.

It makes things more fragile so it's not desirable, no.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141001/f3dc3840/attachment.sig>
