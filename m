From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 17 Sep 2010 09:37:32 -0400 (EDT)
Subject: [PATCH/RFC] ARM: add a vma entry for the user accessible vector
	page
In-Reply-To: <20100917090349.GA5164@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1009140118510.19366@xanadu.home>
	<20100917090349.GA5164@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1009170933440.19366@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Sep 2010, Russell King - ARM Linux wrote:

> On Tue, Sep 14, 2010 at 01:24:04AM -0400, Nicolas Pitre wrote:
> >     
> > The kernel makes the high vector page visible to user space. This page
> > contains (amongst others) small code segments that can be executed in
> > user space.  Make this page visible through ptrace and /proc/<pid>/mem
> > in order to let gdb perform code parsing needed for proper unwinding.
> > 
> > For example, the ERESTART_RESTARTBLOCK handler actually has a stack
> > frame -- it returns to a PC value stored on the user's stack.   To
> > unwind after a "sleep" system call was interrupted twice, GDB would
> > have to recognize this situation and understand that stack frame
> > layout -- which it currently cannot do.
> > 
> > We could fix this by hard-coding addresses in the vector page range into
> > GDB, but that isn't really portable as not all of those addresses are
> > guaranteed to remain stable across kernel releases.  And having the gdb
> > process make an exception for this page and get  content from its own
> > view of it looks strange, and it is not future proof either.
> 
> What if someone calls munmap() (or one of the other mmap calls) on
> this vma?

At the top of do_munmap() there is:

        if ((start & ~PAGE_MASK) || start > TASK_SIZE || len > TASK_SIZE-start)
                return -EINVAL;


Nicolas
