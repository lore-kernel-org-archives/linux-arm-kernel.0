From: matthltc@us.ibm.com (Matt Helsley)
Date: Wed, 24 Mar 2010 07:02:52 -0700
Subject: [C/R ARM][PATCH 1/3] ARM: Rudimentary syscall interfaces
In-Reply-To: <Pine.LNX.4.64.1003240055050.5867@takamine.ncl.cs.columbia.edu>
References: <1269219965-23923-1-git-send-email-christofferdall@christofferdall.dk>
	<1269219965-23923-2-git-send-email-christofferdall@christofferdall.dk>
	<20100323205342.GA19572@n2100.arm.linux.org.uk>
	<20100324020342.GB5704@count0.beaverton.ibm.com>
	<Pine.LNX.4.64.1003240055050.5867@takamine.ncl.cs.columbia.edu>
Message-ID: <20100324140252.GC5704@count0.beaverton.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 24, 2010 at 12:57:46AM -0400, Oren Laadan wrote:
> On Tue, 23 Mar 2010, Matt Helsley wrote:
> 
> > On Tue, Mar 23, 2010 at 08:53:42PM +0000, Russell King - ARM Linux wrote:
> > > On Sun, Mar 21, 2010 at 09:06:03PM -0400, Christoffer Dall wrote:
> > > > This small commit introduces a global state of system calls for ARM
> > > > making it possible for a debugger or checkpointing to gain information
> > > > about another process' state with respect to system calls.
> > > 
> > > I don't particularly like the idea that we always store the syscall
> > > number to memory for every system call, whether the stored version is
> > > used or not.
> > > 
> > > Since ARM caches are generally not write allocate, this means mostly
> > > write-only variables can have a higher than expected expense.
> > > 
> > > Is there not some thread flag which can be checked to see if we need to
> > > store the syscall number?
> > 
> > Perhaps before we freeze the task we can save the syscall number on ARM.
> > The patches suggest that the signal delivery path -- which the freezer
> > utilizes -- has the syscall number already.
> > 
> > Should work since the threads must be frozen first anyway.
> 
> I like the idea.
> 
> However, would it also work for those cases when the freezing does not 
> occur from the signal delivery path - e.g. for vfork and ptraced tasks ?

We could just as easily set it before the vfork uninterruptible completion.
ptracing I'd don't know about though.

Cheers,
	-Matt Helsley
