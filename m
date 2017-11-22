From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 22 Nov 2017 23:36:50 +0100
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in
 userspace (KAISER)
In-Reply-To: <20171122193713.GL22648@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
 <20171122161913.GB12684@amd> <20171122193713.GL22648@arm.com>
Message-ID: <20171122223650.GA6130@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2017-11-22 19:37:14, Will Deacon wrote:
> On Wed, Nov 22, 2017 at 05:19:14PM +0100, Pavel Machek wrote:
> > > This patch series implements something along the lines of KAISER for arm64:
> > > 
> > >   https://gruss.cc/files/kaiser.pdf
> > > 
> > > although I wrote this from scratch because the paper has some funny
> > > assumptions about how the architecture works. There is a patch series
> > > in review for x86, which follows a similar approach:
> > > 
> > >   http://lkml.kernel.org/r/<20171110193058.BECA7D88@viggo.jf.intel.com>
> > > 
> > > and the topic was recently covered by LWN (currently subscriber-only):
> > > 
> > >   https://lwn.net/Articles/738975/
> > > 
> > > The basic idea is that transitions to and from userspace are proxied
> > > through a trampoline page which is mapped into a separate page table and
> > > can switch the full kernel mapping in and out on exception entry and
> > > exit respectively. This is a valuable defence against various KASLR and
> > > timing attacks, particularly as the trampoline page is at a fixed virtual
> > > address and therefore the kernel text can be randomized
> > > independently.
> > 
> > If I'm willing to do timing attacks to defeat KASLR... what prevents
> > me from using CPU caches to do that?
> 
> Is that a rhetorical question? If not, then I'm probably not the best person
> to answer it. All I'm doing here is protecting against a class of attacks on
> kaslr that make use of the TLB/page-table walker to determine where the
> kernel is mapped.

Yeah. What I'm saying is that I can use cache effects to probe where
kernel is mapped (and what it is doing).

> > There was blackhat talk about exactly that IIRC...
> 
> Got a link? I'd be interested to see how the idea works in case there's an
> orthogonal defence against it.

https://www.youtube.com/watch?v=9KsnFWejpQg

(Tell me if it is not the right one).

As of defenses... yes. "maxcpus=1" and flush caches on switch to
usermode will do the trick :-).

Ok, so that was sarcastic. I'm not sure if good defense exists. ARM is
better than i386 because reading time and cache flushing is
priviledged, but...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171122/40227b9d/attachment.sig>
