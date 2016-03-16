From: mchehab@osg.samsung.com (Mauro Carvalho Chehab)
Date: Wed, 16 Mar 2016 11:36:25 -0300
Subject: [PATCH 5/5] [media] media-device: make media_device_cleanup()
 static
In-Reply-To: <CABxcv=mvtXBs9qu6+HDbiB4pmMAM9cf=3mPTtLp0XWftRrGM1g@mail.gmail.com>
References: <dba4d41bdfa6bb8dc51cb0f692102919b2b7c8b4.1458129823.git.mchehab@osg.samsung.com>
 <864cdbedcdde600b09d77bfecb1b828e16e41ac0.1458129823.git.mchehab@osg.samsung.com>
 <CABxcv=mvtXBs9qu6+HDbiB4pmMAM9cf=3mPTtLp0XWftRrGM1g@mail.gmail.com>
Message-ID: <20160316113625.23f1bf82@recife.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Wed, 16 Mar 2016 11:03:38 -0300
Javier Martinez Canillas <javier@dowhile0.org> escreveu:

> Hello Mauro,
> 
> The patch looks mostly good to me, I just have a question below:
> 
> On Wed, Mar 16, 2016 at 9:04 AM, Mauro Carvalho Chehab
> <mchehab@osg.samsung.com> wrote:
> 
> [snip]
> 
> >
> > -void media_device_cleanup(struct media_device *mdev)
> > +static void media_device_cleanup(struct media_device *mdev)
> >  {
> >         ida_destroy(&mdev->entity_internal_idx);
> >         mdev->entity_internal_idx_max = 0;
> >         media_entity_graph_walk_cleanup(&mdev->pm_count_walk);
> > -       mutex_destroy(&mdev->graph_mutex);  
> 
> Any reason why this is removed? mutex_init() is still called in
> media_device_init() so I believe the destroy should be kept here.

This code is now called only at do_media_device_unregister, with
is protected by the mutex. If we keep the mutex_destroy there,
the mutex will be destroyed in lock state, causing an error if
mutex debug is enabled.

Btw, the standard implementation for the mutex is:
	include/linux/mutex.h:static inline void mutex_destroy(struct mutex *lock) {}

Only when mutex debug is enabled, it becomes something else:
	include/linux/mutex-debug.h:extern void mutex_destroy(struct mutex *lock);

With produces a warning if the mutex_destroy() is called with the
mutex is hold. This can never happen with the current implementation, as
the logic is:
	mutex_lock(&mdev->graph_mutex);
	kref_put(&mdev->kref, do_media_device_unregister);
	mutex_unlock(&mdev->graph_mutex);

We could eventually move the mutex lock to
do_media_device_unregister() and then add there the mutex_destroy()

Regards,
Mauro

> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> Best regards,
> Javier


-- 
Thanks,
Mauro
