From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Oct 2013 10:04:19 +0200
Subject: [Ksummit-2013-discuss] [RFC] of: Allow for experimental device
 tree bindings
In-Reply-To: <20131023210849.GB2912@obsidianresearch.com>
References: <1382540779-6334-1-git-send-email-treding@nvidia.com>
 <5267FA58.9050002@wwwdotorg.org> <20131023172001.GA3379@katana>
 <20131023185909.GC7863@ulmo.nvidia.com>
 <20131023193450.GE32563@obsidianresearch.com>
 <20131023195849.GA8828@mithrandir>
 <20131023210849.GB2912@obsidianresearch.com>
Message-ID: <20131024080418.GE9403@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 03:08:49PM -0600, Jason Gunthorpe wrote:
> On Wed, Oct 23, 2013 at 09:58:50PM +0200, Thierry Reding wrote:
[...]
> > > Also, what happens during development? If you incompatibly change the
> > > binding you should change the name, so maybe <version>!marvell,foo is
> > > the way to go. 
> > > 
> > > v1 of the binding is 1!marvell,foo - version 2 is 2!marvell,foo, etc.
> > > 
> > > When stablized the last bang is kept and the non-bang version is
> > > added. The boot warning is supressed once stable no matter the
> > > compatible string used in the dt...
> > 
> > Why would we want to go through all that trouble if we define up front
> > that the binding is experimental in the first place? Encoding a version
> > number in it somehow entails that earlier versions are still supported
> > in some way.
> 
> No, certainly not. It just says the binding has changed and every DT
> stanza that uses the old version needs to be reviewed and updated.
> 
> > But the whole point of experimental bindings is so that we don't have to
> > worry about backwards compatibility.
> 
> The purpose is to not silently throw users/testers under the bus. A
> driver that doesn't bind is much better than a driver that blows up in
> some crazy, hard to determine way because the DT binding has been
> silently incompatibly changed.
> 
> The rule for experimental bindings should be that incompatible changes
> to the binding must bump the version number at the same time, clearly
> signalling to everyone using that binding that they need to take some
> action.

I disagree. I think that we should apply the same rule to DT bindings
(at least experimental ones) that we apply to code within the Linux
kernel. If you change an experimental binding in an incompatible way
then it should be your responsibility to update all users of it so that
they don't break.

In reality I would hope that this isn't much of a problem really. Given
the nature of a compatible value there will typically only be a single
driver implementing it. Any users of it (DTS files) should be pretty
easy to fix up at the same time.

That's the same way that platform data used to work, except it had the
advantage of the compiler actually pointing out incompatible changes.
There has been some discussion about adding validation functionality to
DTC, which should make it easy to find DTS files that require updating
as well.

The above would also indicate that because of their nature, experimental
bindings might be better kept within the Linux kernel tree. That would
make it easy to keep a good overview of what needs to be updated when a
binding changes. It would also make the promotion to stable much more
explicit by physically moving the binding document to a different
repository. Obviously that comes with its own set of problem that we'll
need to find a way to extend the board DTS files that will presumably be
kept in the external stable binding repository with experimental content
only available in the Linux kernel tree.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131024/16906a29/attachment.sig>
