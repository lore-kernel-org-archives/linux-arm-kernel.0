From: ian.campbell@citrix.com (Ian Campbell)
Date: Tue, 6 Oct 2015 11:17:14 +0100
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <56139428.4050402@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F68BC9.6020509@citrix.com> <55F6A437.3040403@citrix.com>
 <55F6A9DB.8040503@citrix.com> <55F6ADAE.1010609@citrix.com>
 <55F6B8CC.5090406@citrix.com> <55F6C1D2.7010206@citrix.com>
 <55F6D9DC.8060607@citrix.com>
 <alpine.DEB.2.02.1509141542430.2672@kaball.uk.xensource.com>
 <55F6E658.4070908@citrix.com> <1442919576.10338.146.camel@citrix.com>
 <56139428.4050402@citrix.com>
Message-ID: <1444126634.5302.116.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-10-06 at 11:28 +0200, Roger Pau Monn? wrote:
> El 22/09/15 a les 12.59, Ian Campbell ha escrit:
> > On Mon, 2015-09-14 at 17:23 +0200, Roger Pau Monn? wrote:
> > > I'm not saying that we shouldn't take those patches, I'm just saying
> > > that IMHO this is a workaround, and I would like to see a plan and
> > > somebody committed to have it fixed in a proper way, by introducing a
> > > 64KB PV block protocol.
> > 
> > In my view the basic unit of operation for all Xen interfaces (on x86
> > and
> > arm at least[0]) is 4K. The peer at either end of a PV protocol should
> > therefore be entitled to assume that at a minimum the other end
> > supports
> > operation in 4K mode (i.e. 4K is the baseline).
> > 
> > Operations in larger sizes (which would necessarily be multiples of 4K)
> > are
> > then an extension which is subject to a negotiation between the two
> > ends,
> > it doesn't really matter if those larger sizes arise because of the use
> > of
> > superpages or because the guest is internally using some larger basic
> > page
> > size (which ARM calls a "granule", and where 64K comes from here).
> > 
> > I think this line of reasoning applies just as strongly to the
> > hypercall
> > ABI as well BTW, they all use 4K as their basic unit, but might support
> > extensions to operation on multiples of that (negotiated either via a
> > specific error return and fallback or via the use of XENFEAT).
> 
> Yes, I completely agree that the current Xen interface is based on 4KB
> chunks. What I'm trying to say is that the approach taken, which is
> "let's not modify Xen" puts all the burden on the guest and it is going
> to hurt us in the long run.
> 
> Are we expecting all guests that want to use 64KB page to implement all
> the modifications that are needed? IMHO, those modifications are very
> far from trivial, and we are putting the bar for Xen guest support very
> high, and that is wrong. We are already struggling to have a decent set
> of PV drivers on guests different than Linux, and this is certainly not
> making things easier.

I think you are underestimating the impact/burden of not having a common
lowest common denominator interface which all front and backends should be
expected to provide in order to interact successfully with each other at a
basic level.

With your approach of requiring a 64KB guest to use native 64K interfaces
only you end up with guests containing front and backends which simply
cannot communicate at all because they do not have a common denominator or
a combinatorial explosion of guests supporting different sets of mutually
incompatible interfaces with no common ground.

I think that fragmentation is a far worse danger than of developers being
unwilling or unable to provide helpers which iterate over pages in whatever
size the guest happens to have (either larger granule or superpages) and
performing however many of whatever ops size has been negotiated with the
peer.

I'm also not convinced that Julien's patches are any less trivial than the
equivalent code to select the correct operations based on the kernels page
size without breaking them up, the developer still needs to be aware of the
4K vs large distinction if they want to support larger than 4K pages.

Developers can still choose to only support 4K pages in their OS, if they
feel this scheme of supporting larger pages is too intrusive or hard I
doubt they are going to want to implement a scheme based on an alternative
large-page protocol either.

> Do KVM guests also need such extensive set of modifications in order to
> run using 64KB pages? I know it's not fair to compare KVM and Xen in
> this regard, because the interfaces are very different, but that's what
> developers are going to look at.

I'm not sure that virtio cares about pages at all, just addresses which
have no particular alignment or granularity constraints, since they don't
have grant tables nor any requirement to mediate accesses to guest memory
by the host at any granularity at all.

Ian.
