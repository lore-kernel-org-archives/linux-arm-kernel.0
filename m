From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 18 Mar 2010 12:17:50 -0400 (EDT)
Subject: Highmem issues with MMC filesystem
In-Reply-To: <20100318141930.GF19544@n2100.arm.linux.org.uk>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	<043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003180904440.31128@xanadu.home>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
	<20100318141930.GF19544@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1003181205020.31128@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Mar 2010, Russell King - ARM Linux wrote:

> On Thu, Mar 18, 2010 at 07:00:06PM +0530, Shilimkar, Santosh wrote:
> > Or could it be that there is appropriate cacheflush happening but data gets
> > stuck in CPU writebuffers instead of reaching to main memory. In this case
> > too DMA won't see the contents and a barrier (dsb) is necessary to ensure
> > that write buffer is drained before DMA takes over the buffer.

No, this is not the issue.

> What exactly is the problem that we're discussing?  Is it that the data
> on the block device is becoming corrupted, or is the data being read off
> the block device corrupted?

Data read from a DMA based block device is corrupted in memory and 
causing all sorts of misbehavior such as segmentation faults in user 
space, or EXT2 complaining about broken filesystem metadata.  This is 
serious enough to prevent a successful boot to a login prompt.  Of 
course the filesystem is just fine as using the same kernel and limiting 
the memory size so highmem doesn't get involved "fixes" the issue.  
Also keeping highmem pages active and adding a couple flush_cache_all() 
in some places also apparently "fixes" the issue.

Given that systems with VIVT caches have a full cache flush on each task 
switch, I added such a cache flush in the ARMv6 case as well to see what 
would happen.  And this _almost_ "fixed" the issue as long as there is 
enough running tasks at once on the system to enforce that cache flush 
often enough.  But with a single task running, such as gcc, then the 
segmentation faults come back.

See my previous email for my current hypothesis about the actual 
problem.


Nicolas
