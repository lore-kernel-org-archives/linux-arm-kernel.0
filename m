From: inki.dae@samsung.com (Inki Dae)
Date: Mon, 13 May 2013 21:21:18 +0900
Subject: Introduce a new helper framework for buffer synchronization
In-Reply-To: <5190D14A.7050904@canonical.com>
References: <CAAQKjZNNw4qddo6bE5OY_CahrqDtqkxdO7Pm9RCguXyj9F4cMQ@mail.gmail.com>
 <51909DB4.2060208@canonical.com>
 <025201ce4fbb$363d0390$a2b70ab0$%dae@samsung.com>
 <5190B7D8.3010803@canonical.com>
 <027a01ce4fcc$5e7c7320$1b755960$%dae@samsung.com>
 <5190D14A.7050904@canonical.com>
Message-ID: <028a01ce4fd4$5ec6f000$1c54d000$%dae@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-fbdev-owner at vger.kernel.org [mailto:linux-fbdev-
> owner at vger.kernel.org] On Behalf Of Maarten Lankhorst
> Sent: Monday, May 13, 2013 8:41 PM
> To: Inki Dae
> Cc: 'Rob Clark'; 'Daniel Vetter'; 'DRI mailing list'; linux-arm-
> kernel at lists.infradead.org; linux-media at vger.kernel.org; 'linux-fbdev';
> 'Kyungmin Park'; 'myungjoo.ham'; 'YoungJun Cho'
> Subject: Re: Introduce a new helper framework for buffer synchronization
> 
> Op 13-05-13 13:24, Inki Dae schreef:
> >> and can be solved with userspace locking primitives. No need for the
> >> kernel to get involved.
> >>
> > Yes, that is how we have synchronized buffer between CPU and DMA device
> > until now without buffer synchronization mechanism. I thought that it's
> best
> > to make user not considering anything: user can access a buffer
> regardless
> > of any DMA device controlling and the buffer synchronization is
> performed in
> > kernel level. Moreover, I think we could optimize graphics and
> multimedia
> > hardware performance because hardware can do more works: one thread
> accesses
> > a shared buffer and the other controls DMA device with the shared buffer
> in
> > parallel. Thus, we could avoid sequential processing and that is my
> > intention. Aren't you think about that we could improve hardware
> utilization
> > with such way or other? of course, there could be better way.
> >
> If you don't want to block the hardware the only option is to allocate a
> temp bo and blit to/from it using the hardware.
> OpenGL already does that when you want to read back, because otherwise the
> entire pipeline can get stalled.
> The overhead of command submission for that shouldn't be high, if it is
> you should really try to optimize that first
> before coming up with this crazy scheme.
> 

I have considered all devices sharing buffer with CPU; multimedia, display
controller and graphics devices (including GPU). And we could provide
easy-to-use user interfaces for buffer synchronization. Of course, the
proposed user interfaces may be so ugly yet but at least, I think we need
something else for it.

> In that case you still wouldn't give userspace control over the fences. I
> don't see any way that can end well.
> What if userspace never signals? What if userspace gets killed by oom
> killer. Who keeps track of that?
> 

In all cases, all kernel resources to user fence will be released by kernel
once the fence is timed out: never signaling and process killing by oom
killer makes the fence timed out. And if we use mmap mechanism you mentioned
before, I think user resource could also be freed properly.

Thanks,
Inki Dae

> ~Maarten
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
