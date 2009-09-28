From: jamie@shareable.org (Jamie Lokier)
Date: Mon, 28 Sep 2009 14:56:21 +0100
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928132502.GF10671@n2100.arm.linux.org.uk>
References: <20090928092919.GA30271@localhost>
	<20090928124922.GA19778@shareable.org>
	<20090928131624.GK30271@localhost>
	<20090928131926.GB19778@shareable.org>
	<20090928132502.GF10671@n2100.arm.linux.org.uk>
Message-ID: <20090928135621.GD19778@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Sep 28, 2009 at 02:19:26PM +0100, Jamie Lokier wrote:
> > Aieee.  Is sys_cacheflush architecturally the Right Way to do DMA to
> > userspace, or is it just luck that it happens to work?
> > 
> > Does that include O_DIRECT regular file I/O as used by databases on
> > these ARMs?  (Nobody ever gives a straight answer)
> 
> Most definitely not.  As far as O_DIRECT goes, I've no idea what to do
> about that, or even if it's a problem.  I just don't use it so it's
> not something I care about.

O_DIRECT is a slightly obscure open() flag, which means bypass the
page cache when possible.

Although obscure, it is often used by databases and virtual machines,
and some file-copying utilities.  Databases includes MySQL,
PostgreSQL, Sqlite.

Direct I/O results in a read() or write() transferring directly
between a userspace-mapped page and the block device underlying a file
(if no highmem bounce buffer is used).  If the block driver uses DMA,
then the DMA goes to the userspace-mapped page.

I say often, because O_DIRECT has a fallback where it uses the regular
page cache path sometimes.  Extending a file and filling holes always
uses the page cache.  Reads and in-place writes which are page-aligned
and filesystem-block-aligned result in direct I/O.

You can generally tell what happened from timing: reading twice will
be fast the second time through the page cache, but takes the same
time using direct I/O because it goes to the device each time; writing
is fast the first time into the page cache (which is write-back), but
direct I/O writes take as much time as the device needs.

> I wouldn't even know _how_ to use it or even how to provoke any bugs
> in that area.

Here are some simple tests:

Read a file with O_DIRECT:

   dd if=somefile iflag=direct bs=1M | md5sum -

Read a disk partition with O_DIRECT:

   dd if=/dev/sda1 iflag=direct bs=16M | md5sum -

Write a file with O_DIRECT:

   dd if=/dev/zero of=testfile bs=1M count=16 # Preallocate the file
   dd if=somedata of=testfile oflag=direct bs=1M # Write in place

As above to write to a disk partition.

It's not hard to imagine how that translates to DMA using the block
device driver.

(Note, if you test, it's not supported on all filesystems, just the
"major" ones like ext2/3/4, reiserfs, xfs, btrfs etc.  NFS supports
O_DIRECT but might not use DMA in the same way.  I don't think it
applies to any of the flash filesystems.  As said earlier, you can
tell if direct I/O is being used from the timing).

If there are DMA cache coherence issues, I would expect _some_
combination of dd commends to result in a corrupt file, either on disk
afterwards, or in page cache which is detectable by md5sum.  It might
be necessary to choose a particular block size and data pattern to
show it.

Unfortunately I don't have any ARM hardware with the type of caches
which have been discussed re. the DMA to/from userspace issues to
perform those tests, or to refine them to highlight an effect, or to
rule it out.

Usually I'd say DMA to userspace is dirty and arch-specific, and
people must do special things or even not use it, on some archs.
But O_DIRECT is a generic filesystem feature on all Linux kernels (and
other OSes), and is used by certain widely used apps, so needs to
either work correctly, or if that's really too difficult, then
O_DIRECT should be prevented from being enabled at all.  (All apps can
cope with the fallback to non-direct I/O).

I simply couldn't tell from the prior discussions about userspace DMA
not being possible due to cache incoherence, whether that would affect
O_DIRECT I/O or not.  But if you need help working it out, or making a
test, I can probably help with that.

-- Jamie
