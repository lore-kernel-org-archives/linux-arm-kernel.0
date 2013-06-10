From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jun 2013 00:42:47 +0100
Subject: ARM cacheflush syscall with range that spans multiple vma
In-Reply-To: <51B63439.7090000@bitwagon.com>
References: <51B51844.9050108@bitwagon.com>
 <20130610085948.GP18614@n2100.arm.linux.org.uk>
 <20130610090947.GC6580@mudshark.cambridge.arm.com>
 <51B63439.7090000@bitwagon.com>
Message-ID: <20130610234247.GM18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 01:16:57PM -0700, John Reiser wrote:
> On 06/10/2013 02:09 AM -0700, Will Deacon wrote:
> > On Mon, Jun 10, 2013 at 09:59:48AM +0100, Russell King - ARM Linux wrote:
> >> On Sun, Jun 09, 2013 at 05:05:24PM -0700, John Reiser wrote:
> >>> Why does the ARM cacheflush syscall stop after the lowest vma
> >>> which intersects the user-requested range?  The range could
> >>> span more than one vma having contiguous addresses, such as
> >>> two files MAP_SHARED into adjacent pages; or even a region
> >>> that contains holes (pages not present.)
> >>
> >> Because you're not supposed to use it on large ranges because it's
> >> an expensive operation.
> > 
> > I posted some patches to address this recently. Obviously it's still
> > expensive, but it makes the syscall restartable so that you can't DoS the
> > system.
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git cacheflush
> > 
> > There's WIP code there for a new iovec-based syscall too.
> 
> Please merge those patches soon.
> 
> My "app" is user-mode execve() of a compressed ET_EXEC, so UPX must flush
> all of the re-generated .text, which can be a megabyte or more.  Thus I flush
> one page per syscall, or write all of .text to a temporary file
> (achieves cache flush because DMA accesses only memory, not cache),
> or heuristically flush by "sweeping" 1/2 MB of consecutive words (thus
> generating deliberate collisions and evictions.)  Each of those sucks.
> 
> It is *EXTREMELY* discouraging that cacheflush() misbehaves so badly.
> *PLEASE* return an error status when you decide not to honor the API!

So what, you're arranging for your memory to exist as a set of
contiguous but separate mappings of one page each?  Surely not.

You should be able to cover a complete mapping in one go.  If the
function stops because a page is not present and _can_ be populated,
that is a bug.  If it stops because a page is not present and that
page can't be populated, then it's working as it should.
