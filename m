From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 24 May 2016 10:30:50 +0200
Subject: [PATCH] drm/rockchip: Return -EBUSY if there's already a pending
 flip event v5
In-Reply-To: <7363560.k3ytHeYgtM@phil>
References: <1464074761-5194-1-git-send-email-tomeu.vizoso@collabora.com>
 <1464074857-5515-1-git-send-email-tomeu.vizoso@collabora.com>
 <7363560.k3ytHeYgtM@phil>
Message-ID: <20160524083050.GQ27098@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 10:28:42AM +0200, Heiko Stuebner wrote:
> Hi Tomeu,
> 
> Patch subject: please put the version into the brackets, so [PATCH v5] as it 
> shouldn't be part of the commit log.
> 
> Am Dienstag, 24. Mai 2016, 09:27:37 schrieb Tomeu Vizoso:
> > As per the docs, atomic_commit should return -EBUSY "if an asycnhronous
> > updated is requested and there is an earlier updated pending".
> 
> > v2: Use the status of the workqueue instead of vop->event, and don't add
> > a superfluous wait on the workqueue.
> > 
> > v3: Drop work_busy, as there's a sizeable delay when the worker
> > finishes, which introduces a race in which the client has already
> > received the last flip event but the next page flip ioctl will still
> > return -EBUSY because work_busy returns outdated information.
> > 
> > v4: Hold dev->event_lock while checking the VOP's event field as
> > suggested by Daniel Stone.
> > 
> > v5: Only block if there's outstanding work if it's a blocking call.
> 
> similarly, please put the changelog below the "---" and above the diffstat.

drm culture is to keep it above, since it's kinda useful sometimes when
later on trying to reconstruct wtf was discussed and why a patch was
merged.
-Daniel

> 
> 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > ---
> 
> aka here.
> 
> >  drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
> >  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  | 25
> > ++++++++++++++++++++++--- drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 
> > 6 ++++++
> >  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> Heiko
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
