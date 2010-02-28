From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Sun, 28 Feb 2010 10:31:03 +0530
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1267316072.23523.1842.camel@pasglop>
References: <1266979632.23523.1668.camel@pasglop>
	<1267201521.14703.50.camel@e102109-lin.cambridge.arm.com>
	<20100226210030.GC23933@n2100.arm.linux.org.uk>
	<1267316072.23523.1842.camel@pasglop>
Message-ID: <1267333263.2762.11.camel@mulgrave.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-02-28 at 11:14 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2010-02-26 at 21:00 +0000, Russell King - ARM Linux wrote:
> > On Fri, Feb 26, 2010 at 04:25:21PM +0000, Catalin Marinas wrote:
> > > For mmap'ed pages (and present in the page cache), is it guaranteed that
> > > the HCD driver won't write to it once it has been mapped into user
> > > space? If that's the case, it may solve the problem by just reversing
> > > the meaning of PG_arch_1 on ARM and assume that a newly allocated page
> > > has dirty D-cache by default.
> > 
> > I guess we could also set PG_arch_1 in the DMA API as well, to avoid the
> > unnecessary D cache flushing when clean pages get mapped into userspace.
> 
> That's an interesting thought for us too. When doing I$/D$ coherency, we
> have to fist flush the D$ and then invalidate the I$. If we could keep
> track of D$ and I$ separately, we could avoid the first step in many
> cases, including the DMA API trick you mentioned.
> 
> I wonder if it's time to get a PG_arch_2 :-)

Sorry to be a bit late to the party (on holiday), but I/D coherency is
supposed to be taken care of using flush_cache_page in the memory
mapping routines.  On parisc, at least, we don't use any PG_arch flags
to help.  The way it's supposed to work is that I is invalidated on
mapping or remapping, so the I/O code only needs to worry about flushing
D.  The guarantee we pass to userland is that any page we do I/O to has
a clean D cache before it goes back to userspace.  Thus if userspace
executes the page, the I cache gets its first movein there.  There is an
underlying assumption to all of this:  The CPU won't speculatively move
in I cache until the page is executed, so we can rely on the
flush_cache_page in the mapping to keep the I cache invalidated until
we're ready to execute.  The other fundamental assumption is that if
userspace needs to modify an executable region (say for dynamic linking)
it has to take care of reinvalidating the I cache itself ... although it
can do this by remapping the region to alter the flags (i.e W no X then
X no W).

But the point of all of this is that I cache invalidation doesn't appear
anywhere in the I/O path ... so  if we're getting I/D incoherency,
there's some problem in the mm code (or there's a missing arch
assumption ... like I cache gets moved in more aggressively than we
expect).  Parisc is very sensitive to I/D incoherency, so we'd notice if
there were a serious generic problem here.

James
