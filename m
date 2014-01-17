From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Jan 2014 13:46:46 +0000
Subject: Deadlock in do_page_fault() on ARM (old kernel)
In-Reply-To: <52D73220.3030108@signal11.us>
References: <52D73220.3030108@signal11.us>
Message-ID: <20140117134646.GL27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 08:13:04PM -0500, Alan Ott wrote:
> So my questions are:
> 1. Why don't I see a full backtrace beyond the exception stack? It's the  
> same when dump_stack() is called manually.

No idea - it looks like you're not using frame pointers, but are using
the unwinder.  Full backtraces can always be created with frame pointers,
it's just that unwinding seems unreliable.

I think we do need to see the full backtrace here - from looking at the
full state dump, I don't see any sign of the mmap_sem being held except
by an attempt to process a fault, and two threads trying to do a
sys_mmap_pgoff().

My suspicion therefore is that some other thread must have died while
holding the mmap_sem, so there's probably a kernel oops earlier...
that's my best guess at the moment without seeing the full backtrace.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
