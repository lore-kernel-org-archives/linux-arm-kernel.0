From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 2 Oct 2014 10:27:58 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20141001171704.GG4273@sirena.org.uk>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
 <20141001081443.GC18463@ulmo> <20141001122008.GW4273@sirena.org.uk>
 <20141001124852.GB21733@ulmo> <20141001171704.GG4273@sirena.org.uk>
Message-ID: <20141002082757.GB30167@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 06:17:04PM +0100, Mark Brown wrote:
> On Wed, Oct 01, 2014 at 02:48:53PM +0200, Thierry Reding wrote:
> > On Wed, Oct 01, 2014 at 01:20:08PM +0100, Mark Brown wrote:
[...]
> > >                and that the DT must not contain any hint of simplefb as
> > > shipped separately.
> 
> > Well, I don't think it should because it describes the same resources
> > that the device tree node for the real device already describes. But
> > perhaps this is one of the cases where duplication isn't all that bad?
> 
> If we were worried about this wecould also do it by referring to
> those nodes and saying "get all the resources these things need" rather
> than duplicating the references (this might make it easier to work out
> when the system is ready to hand off to the real drivers).

That's problematic to some degree because not all resource types may
have a binding that allows them to be automatically probed, so it could
be difficult to implement "get all the resources this thing needs". But
perhaps we can come up with good enough heuristics to make that work
reliably.

One downside of that is that there may be a lot of components involved
in getting display to work and not all resources may be needed to keep
the current state running, so we may be claiming too many. But given
that we'd eventually release all of them anyway this shouldn't be too
much of an issue.

> > >                     That's never going to work well as far as I can see
> > > but doesn't seem like an ABI stability issue, or at least not a
> > > reasonable one.
> 
> > It would work well under the assumption that the kernel wouldn't be
> > touching any of the resources that simplefb depends on. If that's not a
> > reasonable assumption then I think we can't make simplefb work the way
> > it's currently written.
> 
> I can't see how that's reasonable unless the kernel has some way of
> figuring out what it shouldn't be touching.

Agreed. It's become clear in this discussion that we can't do this in
the way x86 and other more firmware-oriented architectures do it. They
get away with it because they in fact hide all of this in the firmware
or don't provide a way to control the resources in such a fine-grained
manner to begin with.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141002/24e38157/attachment.sig>
