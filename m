From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 5 Dec 2011 23:33:44 +0100
Subject: [RFC v2 1/2] dma-buf: Introduce dma buffer sharing mechanism
In-Reply-To: <1438420.NYDLGGgKNc@wuerfel>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <1426302.asOzFeeJzz@wuerfel>
 <CAKMK7uG2U2gn-LW7Cozumfza8XngvQSWR7-S-Qiok5NA=94V=w@mail.gmail.com>
 <1438420.NYDLGGgKNc@wuerfel>
Message-ID: <CAKMK7uH3KUOXXWfvdTWQMy1cBkctpUR6TP=xks63jX5-3XsFaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 11:04:09PM +0100, Arnd Bergmann wrote:
> On Monday 05 December 2011 21:58:39 Daniel Vetter wrote:
> > On Mon, Dec 05, 2011 at 08:29:49PM +0100, Arnd Bergmann wrote:
> > > ...
> >
> > Thanks a lot for this excellent overview. I think at least for the first
> > version of dmabuf we should drop the sync_* interfaces and simply require
> > users to bracket their usage of the buffer from the attached device by
> > map/unmap. A dma_buf provider is always free to cache the mapping and
> > simply call sync_sg_for of the streaming dma api.
>
> I think we still have the same problem if we allow multiple drivers
> to access a noncoherent buffer using map/unmap:
>
> 	driver A				driver B
>
> 1.	read/write				
> 2.						read/write
> 3.	map()					
> 4.						read/write
> 5.	dma
> 6.						map()
> 7.	dma
> 8.						dma
> 9.	unmap()
> 10.						dma
> 11.	read/write
> 12.						unmap()						
>
>
> In step 4, the buffer is owned by device A, but accessed by driver B, which
> is a bug. In step 11, the buffer is owned by device B but accessed by driver
> A, which is the same bug on the other side. In steps 7 and 8, the buffer
> is owned by both device A and B, which is currently undefined but would
> be ok if both devices are on the same coherency domain. Whether that point
> is meaningful depends on what the devices actually do. It would be ok
> if both are only reading, but not if they write into the same location
> concurrently.
>
> As I mentioned originally, the problem could be completely avoided if
> we only allow consistent (e.g. uncached) mappings or buffers that
> are not mapped into the kernel virtual address space at all.
>
> Alternatively, a clearer model would be to require each access to
> nonconsistent buffers to be exclusive: a map() operation would have
> to block until the current mapper (if any) has done an unmap(), and
> any access from the CPU would also have to call a dma_buf_ops pointer
> to serialize the CPU accesses with any device accesses. User
> mappings of the buffer can be easily blocked during a DMA access
> by unmapping the buffer from user space at map() time and blocking the
> vm_ops->fault() operation until the unmap().

See my other mail where I propose a more explicit coherency model, just a
comment here: GPU drivers hate blocking interfaces. Loathe, actually. In
general they're very happy to extend you any amount of rope if it can make
userspace a few percent faster.

So I think the right answer here is: You've asked for trouble, you've got
it. Also see the issue raised by Rob, at least for opengl (and also for
other graphics interfaces) the kernel is not even aware of all outstanding
rendering. So userspace needs to orchestrate access anyway if a gpu is
involved.

Otherwise I agree with your points in this mail.
-Daniel
-- 
Daniel Vetter
Mail: daniel at ffwll.ch
Mobile: +41 (0)79 365 57 48
