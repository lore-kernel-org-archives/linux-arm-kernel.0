From: john@szakmeister.net (John Szakmeister)
Date: Tue, 20 Mar 2012 15:03:38 -0400
Subject: Cache flushing....
Message-ID: <CAEBDL5UtwetYm7WFLL1hEWT3xiyEy3C6p=GuDM7iSi71RcbFdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for the re-post.  I forgot to put a title on the message.
Original text follows.

We've been running into several issues on the cache flushing front,
and I'm hoping that someone here can help clarify what should be
happening from a kernel perspective.

Late last year we discovered a few interesting problems.  One of them
is definitely our fault: we weren't flushing the cache after we read
data from a block device a wrote it into the page.  However, there was
another issue we noticed that made less sense: we had to flush a page
before writing it to our block device, otherwise we end up writing
some stale data.  The brd device ran into this issue before, and fixed
it in commit c2572f2b[1].  In that commit Nick Pidgin says:
   "brd is missing a flush_dcache_page. On 2nd thoughts, perhaps it is the
    pagecache's responsibility to flush user virtual aliases (the driver of
    course should flush kernel virtual mappings)... but anyway, there
    already exists cache flushing for one direction of transfer, so we
    should add the other."

I can't help but to feel he's right.  It was very surprising to me
that I had to flush the user virtual aliases before writing the data
to the device.  Is it expected that we (as device driver writers) have
to do that for block device drivers?  I love Linux, but one of the
aspects I find most frustrating is that I don't know what I can safely
assume at interface boundaries.  Even modeling my work after existing
code yields problems, because a number of drivers in the tree seem to
be broken in this regard.

But it leads to another concern.  Since I do have to flush on writes,
it got me thinking about whether it's necessary to flush user mode
aliases before conducting a read.  Consider the fact that a page can
span multiple blocks.  Is it possible that:
 * we're asked to read a block of data
 * a user app has scribbled on the page (so it's dirty, but not flushed)
 * we read the requested data from the device
 * load it into the page
 * do a flush_dcache_page()
 * then the data read from the device becomes corrupt because cached user data
   is written to RAM?

Or, instead of that, the cached data gets dropped entirely because it
was on the page, but shouldn't have been because we didn't read new
data into that area, and now that user data is lost?  I confess this
may all be my lack of understanding about Linux's block i/o subsystem,
but I'm thoroughly confused at this point.  What I do know is that
other device drivers are not flushing the page before writing the data
to a device.  For instance, the mmc driver for the at91 architecture
suffers from this problem, and I've been able to see that problem
using mmap.  My concern is that many other drivers also suffer from
this problem, so I'm not sure what the fix needs to be: fix the page
cache, fix the driver, or both.

Also, is there somewhere that says what's guaranteed on entry into my
block device driver?  I've scoured everything I could find... the
Documentation area (including cachetlb.txt), Linux sites, books...
I've yet to find anything mentioning the need to call
flush_dcache_page() much less talk about what the assumptions are.

Thanks in advance for the help.

-John

[1]: <http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=c2572f2b4ffc27ba79211aceee3bef53a59bb5cd>
