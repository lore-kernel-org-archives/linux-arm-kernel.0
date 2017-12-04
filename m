From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 Dec 2017 22:37:52 +0530
Subject: [PATCH 00/10] dmaengine: fix race with vchan_complete
In-Reply-To: <20171114143212.8311-1-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
Message-ID: <20171204170751.GH32417@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 04:32:02PM +0200, Peter Ujfalusi wrote:
> Hi,
> 
> With the introduction of .device_synchronize callback it was thought that the
> race caused crash observed in vchan_complete is fixed, but unfortunately it can
> still happen.
> 
> The observed scenario (really hard to reproduce) is:
> Cyclic mode
> - DMA period interrupt
>  - call to vchan_cyclic_callback() which sets vc->cyclic to vd and schedules the
>    vchan_complete tasklet
> - .terminate_all is called
>  - we make sure that no further DMA irqs are going to be handled, but the
>    tasklet had been already scheduled
>  - we free up the descriptor to avoid leaking memory
> - the vchan_complete tasklet starts to execute and it checks vc->cyclic, which
>   is not NULL, saves the vd pointer (which points to an already freed up memory)
>   and try to access it later to call the callback
> - the tasklet_kill() in .device_synchronize will make sure that the tasklet is
>   going to finish it's execution if it is already scheduled, it can only help if
>   the tasklet is yet to be executed.
> 
> At this point it is just matter of luck if the vc->cyclic is still pointing to
> an unchanged memory location or it is taken into use and thus it is corrupted.
> 
> My first approach was to just set vc->cyclic to NULL in the .terminate_all
> callback, but that still have theoritical race: if the vchan_complete is
> executing and it saves the vd from vc->cyclic (protected by the vc->lock). If at
> that point the .terminate_all is called it will wait for the lock and start
> executing. _if_ the .terminate_all free up the vd before the vchan_complete
> reaches the point when it is going to call the callback, then we have the race.
> 
> The series will do this:
> - the drivers should call vchan_terminate_vdesc() instead of directly freeing up
>   the descriptor. vchan_terminate_vdesc() will save the vd as vc->vd_terminated
>   and will set the vc->cyclic to NULL, all while holding the lock.
> - the drivers must implement the .device_synchronize callback and within the
>   vchan_synchronize() we free up the vc->vd_terminated after we killed the
>   tasklet.
> 
> I have tested this on platforms using TI's eDMA and sDMA and have not seen any
> side effect so far and a client tested similar set on a setup where it was easy
> to reproduce the race.
> 
> By looking for similar patterns in other drivers I have implemented the fix for
> the ones where it looked straight forward.

Applied now, thanks for the cleanup! And looks like mail servers are fixed

-- 
~Vinod
