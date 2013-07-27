From: david@gibson.dropbear.id.au (David Gibson)
Date: Sun, 28 Jul 2013 01:28:46 +1000
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130726131423.GL24642@n2100.arm.linux.org.uk>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726080115.GA5436@netboy>
 <1374831744.2923.42.camel@shinybook.infradead.org>
 <20130726130927.GC4219@netboy>
 <20130726131423.GL24642@n2100.arm.linux.org.uk>
Message-ID: <20130727152845.GB29970@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 02:14:23PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 26, 2013 at 03:09:29PM +0200, Richard Cochran wrote:
> > On Fri, Jul 26, 2013 at 10:42:24AM +0100, David Woodhouse wrote:
> > > On Fri, 2013-07-26 at 10:01 +0200, Richard Cochran wrote:
> > > > On Thu, Jul 25, 2013 at 03:37:53PM -0600, Jason Gunthorpe wrote:
> > > > > 
> > > > > We use DT has a kernel configuration input. Our environment is
> > > > > designed to guarantee 100% that the kernel and DT match exactly. DT
> > > > > very deliberately isn't an ABI boundary in our systems.
> > > > 
> > > > Think about what you just said.
> > > > 
> > > > The DT describes the *hardware* not the kernel. Why should you ever
> > > > need to update your DT at all?
> > > 
> > > Well, the nodes which describe hardware devices, according to the
> > > bindings which form an ABI contract between DT and drivers, should not
> > > normally change. Although they *can* change, if for example you change
> > > the MAC address and that's stored there. Or you change the PHY you want
> > > it to use. Or something like that. The *ABI* doesn't change, but the
> > > data you express *using* that ABI can change. That's kind of the point.
> > 
> > Unless I totally misunderstood, the thread is talking about letting
> > established bindings change with each new kernel version.  I am
> > opposed to that.
> > 
> > Of course, a user may want to change the values of his MAC addresses,
> > if he needs to. But he should never have to change *how* he specifies
> > those addresses.
> > 
> > So, as long as everyone can agree to the principle that a working DT
> > should remain working after a kernel upgrade, then I'll shut up. In
> > actual fact, this is not the case today, nor was it ever so in the
> > past, AFAICT, but it never hurts to set goals.
> 
> We agree.
> 
> That's precisely why I'm saying that once a binding appears in a -final
> released kernel, it is _stable_ by that very fact.  If there were any
> doubts about it, it should never have been accepted into the kernel tree
> in the first place.
> 
> It's no different from how we treat syscalls.  Once we accept a syscall
> and it's published in a -final kernel, it can't then be altered - it can
> be supplemented by a new syscall with a different interface, but the old
> one remains and keeps its semantics for a great many years.
> 
> There's no reason for DT to be any different in this regard.

I agree, and the fact that we have a bunch of bad bindings in the wild
is a mess which is difficult but necessary to clean up.

Something that helps, is that just as it's possible to support old,
badly-thought out syscalls with a compat shim over newer
implementations, we can in many cases localize handling of bad device
tree bindings to early boot code, so that old bad ideas don't have to
infect every part of every driver.

It would probably be a good idea to implement a DT quirks mechanism,
to be run immediately after unflattening.  That way a driver can just
register a fixup function to patch the DT up to a newer standard,
instead of scattering if (old-style-representation) throughout the
code.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130728/54e30f87/attachment.sig>
