From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 16 Apr 2018 23:43:15 +0200
Subject: [PATCH] drm/rockchip: fix VOP vblank race
In-Reply-To: <20180416174656.6c113081.john@metanate.com>
References: <20180328160351.23763-1-john@metanate.com>
 <38a49065-4667-4d91-3191-ec81b03cba44@rock-chips.com>
 <20180416174656.6c113081.john@metanate.com>
Message-ID: <3779920.ZoukgOgWSN@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

Am Montag, 16. April 2018, 18:46:56 CEST schrieb John Keeping:
> Hi Sandy,
> 
> On Tue, 10 Apr 2018 20:40:06 +0800, Sandy Huang wrote:
> 
> > Reviewed-by: Sandy huang <hjc@rock-chips.com>
> 
> Thanks for the review, but I don't see this in drm-misc yet.  Are you
> planning to pick this up?

I was occupied with merge-window stuff recently, but I guess either
Sandy or myself is going to pick it up shortly.


Heiko

> > ? 2018/3/29 0:03, John Keeping ??:
> > > We have seen a case of a bad reference count for vblanks with the
> > > Rockchip VOP:
> > >
> > > 	------------[ cut here ]------------
> > > 	WARNING: CPU: 1 PID: 383 at drivers/gpu/drm/drm_irq.c:1198 drm_vblank_put+0x40/0xcc
> > > 	Modules linked in: brcmfmac brcmutil
> > > 	CPU: 1 PID: 383 Comm: kworker/u8:2 Not tainted 4.9.75-rt60 #1
> > > 	Hardware name: Rockchip (Device Tree)
> > > 	Workqueue: events_unbound flip_worker
> > > 	Backtrace:
> > > 	[<c010b7b0>] (dump_backtrace) from [<c010ba4c>] (show_stack+0x18/0x1c)
> > > 	 r7:c0b1b13c r6:600b0013 r5:00000000 r4:c0b1b13c
> > > 	[<c010ba34>] (show_stack) from [<c032d248>] (dump_stack+0x78/0x94)
> > > 	[<c032d1d0>] (dump_stack) from [<c011e6e8>] (__warn+0xe4/0x104)
> > > 	 r7:00000009 r6:c03cf26c r5:00000000 r4:00000000
> > > 	[<c011e604>] (__warn) from [<c011e7c0>] (warn_slowpath_null+0x28/0x30)
> > > 	 r9:eeb443a0 r8:eeb443c8 r7:ee8a5ec0 r6:ee8a5ec0 r5:edb47f00 r4:ee096200
> > > 	[<c011e798>] (warn_slowpath_null) from [<c03cf26c>] (drm_vblank_put+0x40/0xcc)
> > > 	[<c03cf22c>] (drm_vblank_put) from [<c03cf310>] (drm_crtc_vblank_put+0x18/0x1c)
> > > 	 r5:edb47f00 r4:ee3c8a80
> > > 	[<c03cf2f8>] (drm_crtc_vblank_put) from [<c03ef9b4>] (vop_fb_unref_worker+0x18/0x24)
> > > 	[<c03ef99c>] (vop_fb_unref_worker) from [<c03df194>] (flip_worker+0x98/0xb4)
> > > 	 r5:edb47f00 r4:eeb443a8
> > > 	[<c03df0fc>] (flip_worker) from [<c0134808>] (process_one_work+0x1a8/0x2fc)
> > > 	 r9:00000000 r8:ee807d00 r7:00000000 r6:ee809c00 r5:eeb443a8 r4:edfe5f80
> > > 	[<c0134660>] (process_one_work) from [<c01358ec>] (worker_thread+0x2ac/0x458)
> > > 	 r10:00000088 r9:edfe5f98 r8:ee809c2c r7:c0b04100 r6:ee809c00 r5:ee809c00
> > > 	 r4:edfe5f80
> > > 	[<c0135640>] (worker_thread) from [<c013a0bc>] (kthread+0xfc/0x10c)
> > > 	 r10:00000000 r9:00000000 r8:c0135640 r7:edfe5f80 r6:00000000 r5:edf0e240
> > > 	 r4:ee8a4000 r3:ed194e00
> > > 	[<c0139fc0>] (kthread) from [<c0107cb8>] (ret_from_fork+0x14/0x3c)
> > > 	 r8:00000000 r7:00000000 r6:00000000 r5:c0139fc0 r4:edf0e240
> > > 	---[ end trace 0000000000000002 ]---
> > >
> > > It seems that this is caused by unfortunate timing between
> > > vop_crtc_atomic_flush() and vop_handle_vblank() given the following
> > > ordering:
> > >
> > > 	atomic_flush		handle_vblank
> > > 	------------		-------------
> > >
> > > 	drm_flip_work_queue
> > > 	set_bit
> > > 	     			if (test_and_clear_bit(...))
> > > 	     				drm_flip_work_commit
> > > 	drm_vblank_get
> > >
> > > This results in vop_fb_unref_worker (called as flip work) decrementing
> > > the vblank refcount before it has been incremented.
> > >
> > > Signed-off-by: John Keeping <john@metanate.com>
> > > ---
> > >   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > index 6755a9eea4b2..d4e1400aedf3 100644
> > > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> > > @@ -1017,9 +1017,9 @@ static void vop_crtc_atomic_flush(struct drm_crtc *crtc,
> > >   			continue;
> > >   
> > >   		drm_framebuffer_get(old_plane_state->fb);
> > > +		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
> > >   		drm_flip_work_queue(&vop->fb_unref_work, old_plane_state->fb);
> > >   		set_bit(VOP_PENDING_FB_UNREF, &vop->pending);
> > > -		WARN_ON(drm_crtc_vblank_get(crtc) != 0);
> > >   	}
> > >   }
> > >     
> > 
> > 
> 
