From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2009 19:42:18 +0000
Subject: [PATCH] check put_user fail in do_signal when enable OABI_COMPACT
In-Reply-To: <alpine.LFD.2.00.0910271533060.10545@xanadu.home>
References: <1256123277.3851.36.camel@debian-nb>
	<200910271937.57146.jpihet@mvista.com>
	<alpine.LFD.2.00.0910271454110.10545@xanadu.home>
	<200910272012.53488.jpihet@mvista.com>
	<alpine.LFD.2.00.0910271533060.10545@xanadu.home>
Message-ID: <20091027194218.GD22412@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2009 at 03:35:31PM -0400, Nicolas Pitre wrote:
> On Tue, 27 Oct 2009, Jean Pihet wrote:
> 
> > Nicolas,
> > 
> > On Tuesday 27 October 2009 19:59:36 Nicolas Pitre wrote:
> > ...
> > > > Side question: does the put_user requires a flush of some sort? If not,
> > > > why?
> > >
> > > No because it stores data into the d-cache directly at the virtual
> > > address to be used by user space.  Previously the d-cache needed to
> > > be cleaned for data to hit main memory and the i-cache invalidated for
> > > the newly stored _code_ to be seen by the instruction path.  Since there
> > > is no code involved anymore the cache flushes are useless.
> > >
> > > > Is it OK to re-send a patch with the call to flush_icache_range removed?
> > >
> > > Yes.
> > Ok here is the updated patch. Let's hope it is the good one that time ;-)
> 
> Well, the commit message is certainly wrong. There is no copying of 
> restart_syscall to user stack anymore.
> 
> And is there a reason for touching sp in the error case?

Returning 'sp' seems to be a sane thing to do - otherwise debuggers
analysing core dumps could be confused about the location of data on
the stack.
