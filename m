From: maarten.lankhorst@linux.intel.com (Maarten Lankhorst)
Date: Mon, 3 Jul 2017 14:03:02 +0200
Subject: [Intel-gfx] [PATCH 1/2] drm/atomic: Change
 drm_atomic_helper_swap_state to return an error.
In-Reply-To: <20170630135621.c2xlunjaepne2vqt@phenom.ffwll.local>
References: <20170628132812.14927-1-maarten.lankhorst@linux.intel.com>
 <20170630135621.c2xlunjaepne2vqt@phenom.ffwll.local>
Message-ID: <62ef6e18-9dc5-3477-0901-6767a00c89ee@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 30-06-17 om 15:56 schreef Daniel Vetter:
> On Wed, Jun 28, 2017 at 03:28:11PM +0200, Maarten Lankhorst wrote:
>> We want to change swap_state to wait indefinitely, but to do this
>> swap_state should wait interruptibly. This requires propagating
>> the error to each driver. All drivers have changes to deal with the
>> clean up. In order to allow easy reverting, the commit that changes
>> behavior is separate so someone only has to revert that for testing.
>>
>> Nouveau has a small bugfix, if drm_atomic_helper_wait_for_fences
>> failed cleanup_planes was not called.
>>
>> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel.vetter@intel.com>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: CK Hu <ck.hu@mediatek.com>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> Cc: Rob Clark <robdclark@gmail.com>
>> Cc: Ben Skeggs <bskeggs@redhat.com>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Jonathan Hunter <jonathanh@nvidia.com>
>> Cc: Jyri Sarha <jsarha@ti.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Eric Anholt <eric@anholt.net>
>> Cc: dri-devel at lists.freedesktop.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: intel-gfx at lists.freedesktop.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-mediatek at lists.infradead.org
>> Cc: linux-arm-msm at vger.kernel.org
>> Cc: freedreno at lists.freedesktop.org
>> Cc: nouveau at lists.freedesktop.org
>> Cc: linux-tegra at vger.kernel.org
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> We kinda need to backport this to older kernels, but I don't really see
> how :( Maybe we should split this up:
> patch 1: Change to int return type
> patches 2-(n-1): Driver conversions
> patch n: __must_check addition
>
> That would at least somewhat make this backportable ...
>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 14 ++++++++++++--
>>  drivers/gpu/drm/drm_atomic_helper.c          | 18 ++++++++++++------
>>  drivers/gpu/drm/i915/intel_display.c         | 10 +++++++++-
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.c       |  7 ++++++-
>>  drivers/gpu/drm/msm/msm_atomic.c             | 14 +++++++++-----
>>  drivers/gpu/drm/nouveau/nv50_display.c       | 10 ++++++++--
>>  drivers/gpu/drm/tegra/drm.c                  |  7 ++++++-
>>  drivers/gpu/drm/tilcdc/tilcdc_drv.c          |  6 +++++-
>>  drivers/gpu/drm/vc4/vc4_kms.c                | 21 +++++++++++++--------
>>  include/drm/drm_atomic_helper.h              |  4 ++--
>>  10 files changed, 82 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> index 516d9547d331..d4f787bf1d4a 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
>> @@ -544,9 +544,11 @@ static int atmel_hlcdc_dc_atomic_commit(struct drm_device *dev,
>>  		goto error;
>>  	}
>>  
>> -	/* Swap the state, this is the point of no return. */
>> -	drm_atomic_helper_swap_state(state, true);
> Push the swap_state up over the commit setup (but after the allocation)
> and there's no more a problem with unrolling.
I think just like msm this might also use stall = false safely.
>> diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
>> index 9633a68b14d7..85dd485fdef4 100644
>> --- a/drivers/gpu/drm/msm/msm_atomic.c
>> +++ b/drivers/gpu/drm/msm/msm_atomic.c
>> @@ -232,8 +232,12 @@ int msm_atomic_commit(struct drm_device *dev,
>>  	 * mark our set of crtc's as busy:
>>  	 */
>>  	ret = start_atomic(dev->dev_private, c->crtc_mask);
>> +	if (ret)
>> +		goto err_free;
>> +
>> +	ret = drm_atomic_helper_swap_state(state, true);
> Hm, might be simpler to have stall = false (which btw makes your
> __must_check annotation a lie, you only have to check when you stall),
> since start_atomic above already does stall for everything as needed.
True, could we create a separate function for swap_state_and_wait, and kill the stall argument?
>>  	if (ret) {
>> -		kfree(c);
>> +		commit_destroy(c);
>>  		goto error;
>>  	}
>>  
>> @@ -241,11 +245,9 @@ int msm_atomic_commit(struct drm_device *dev,
>>  	 * This is the point of no return - everything below never fails except
>>  	 * when the hw goes bonghits. Which means we can commit the new state on
>>  	 * the software side now.
>> +	 *
>> +	 * swap driver private state while still holding state_lock
>>  	 */
>> -
>> -	drm_atomic_helper_swap_state(state, true);
>> -
>> -	/* swap driver private state while still holding state_lock */
>>  	if (to_kms_state(state)->state)
>>  		priv->kms->funcs->swap_state(priv->kms, state);
>>  
>> @@ -275,6 +277,8 @@ int msm_atomic_commit(struct drm_device *dev,
>>  
>>  	return 0;
>>  
>> +err_free:
>> +	kfree(c);
>>  error:
>>  	drm_atomic_helper_cleanup_planes(dev, state);
>>  	return ret;
>> diff --git a/drivers/gpu/drm/nouveau/nv50_display.c b/drivers/gpu/drm/nouveau/nv50_display.c
>> index 42a85c14aea0..fb2c763c88a8 100644
>> --- a/drivers/gpu/drm/nouveau/nv50_display.c
>> +++ b/drivers/gpu/drm/nouveau/nv50_display.c
>> @@ -4119,9 +4119,13 @@ nv50_disp_atomic_commit(struct drm_device *dev,
>>  	if (!nonblock) {
>>  		ret = drm_atomic_helper_wait_for_fences(dev, state, true);
>>  		if (ret)
>> -			goto done;
>> +			goto err_cleanup;
>>  	}
>>  
>> +	ret = drm_atomic_helper_swap_state(state, true);
>> +	if (ret)
>> +		goto err_cleanup;
>> +
>>  	for_each_plane_in_state(state, plane, plane_state, i) {
>>  		struct nv50_wndw_atom *asyw = nv50_wndw_atom(plane_state);
>>  		struct nv50_wndw *wndw = nv50_wndw(plane);
>> @@ -4135,7 +4139,6 @@ nv50_disp_atomic_commit(struct drm_device *dev,
>>  		}
>>  	}
>>  
>> -	drm_atomic_helper_swap_state(state, true);
>>  	drm_atomic_state_get(state);
>>  
>>  	if (nonblock)
>> @@ -4158,7 +4161,10 @@ nv50_disp_atomic_commit(struct drm_device *dev,
>>  		pm_runtime_put_autosuspend(dev->dev);
>>  		drm->have_disp_power_ref = false;
>>  	}
>> +	goto done;
>>  
>> +err_cleanup:
>> +	drm_atomic_helper_cleanup_planes(dev, state);
>>  done:
>>  	pm_runtime_put_autosuspend(dev->dev);
>>  	return ret;
> lgtm, but might want to split out the bugfix.
>
>> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
>> index ad3d124a972d..3ba659a5940d 100644
>> --- a/drivers/gpu/drm/tegra/drm.c
>> +++ b/drivers/gpu/drm/tegra/drm.c
>> @@ -100,7 +100,12 @@ static int tegra_atomic_commit(struct drm_device *drm,
>>  	 * the software side now.
>>  	 */
>>  
>> -	drm_atomic_helper_swap_state(state, true);
>> +	err = drm_atomic_helper_swap_state(state, true);
>> +	if (err) {
>> +		mutex_unlock(&tegra->commit.lock);
>> +		drm_atomic_helper_cleanup_planes(drm, state);
>> +		return err;
>> +	}
>>  
>>  	drm_atomic_state_get(state);
>>  	if (nonblock)
> lgtm.
>
>> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
>> index d67e18983a7d..049d2f5a1ee4 100644
>> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
>> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
>> @@ -108,7 +108,11 @@ static int tilcdc_commit(struct drm_device *dev,
>>  	if (ret)
>>  		return ret;
>>  
>> -	drm_atomic_helper_swap_state(state, true);
>> +	ret = drm_atomic_helper_swap_state(state, true);
>> +	if (ret) {
>> +		drm_atomic_helper_cleanup_planes(dev, state);
>> +		return ret;
>> +	}
>>  
>>  	/*
>>  	 * Everything below can be run asynchronously without the need to grab
> lgtm.
>
> Well tilcdc should stop hand-rolling their commit since it's not even
> nonblocking, but meh.
>
>> diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
>> index 27edae427025..83952a4014a5 100644
>> --- a/drivers/gpu/drm/vc4/vc4_kms.c
>> +++ b/drivers/gpu/drm/vc4/vc4_kms.c
>> @@ -113,20 +113,20 @@ static int vc4_atomic_commit(struct drm_device *dev,
>>  
>>  	if (!nonblock) {
>>  		ret = drm_atomic_helper_wait_for_fences(dev, state, true);
>> -		if (ret) {
>> -			drm_atomic_helper_cleanup_planes(dev, state);
>> -			up(&vc4->async_modeset);
>> -			return ret;
>> -		}
>> +		if (ret)
>> +			goto err;
>>  	}
>>  
>>  	/*
>> -	 * This is the point of no return - everything below never fails except
>> -	 * when the hw goes bonghits. Which means we can commit the new state on
>> +	 * If swap_state() succeeds, this is the point of no return -
>> +	 * everything below never fails except when the hw goes bonghits.
>> +	 * Which means we can commit the new state on
>>  	 * the software side now.
>>  	 */
>>  
>> -	drm_atomic_helper_swap_state(state, true);
>> +	ret = drm_atomic_helper_swap_state(state, true);
>> +	if (ret)
>> +		goto err;
>>  
>>  	/*
>>  	 * Everything below can be run asynchronously without the need to grab
>> @@ -151,6 +151,11 @@ static int vc4_atomic_commit(struct drm_device *dev,
>>  		vc4_atomic_complete_commit(state);
>>  
>>  	return 0;
>> +
>> +err:
>> +	drm_atomic_helper_cleanup_planes(dev, state);
>> +	up(&vc4->async_modeset);
>> +	return ret;
>>  }
>>  
>>  static struct drm_framebuffer *vc4_fb_create(struct drm_device *dev,
> lgtm. Will probably clash with ongoing work in vc4 to switch to plain
> drm_atomic_helper_commit().
>
>> diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
>> index 3bfeb2b2f746..4f3b6b5362ec 100644
>> --- a/include/drm/drm_atomic_helper.h
>> +++ b/include/drm/drm_atomic_helper.h
>> @@ -80,8 +80,8 @@ void
>>  drm_atomic_helper_disable_planes_on_crtc(struct drm_crtc_state *old_crtc_state,
>>  					 bool atomic);
>>  
>> -void drm_atomic_helper_swap_state(struct drm_atomic_state *state,
>> -				  bool stall);
>> +int __must_check drm_atomic_helper_swap_state(struct drm_atomic_state *state,
>> +					      bool stall);
> __must_check is a lie I think, since with stall = false you don't need it.
> -Daniel
>
>>  
>>  /* nonblocking commit helpers */
>>  int drm_atomic_helper_setup_commit(struct drm_atomic_state *state,
>> -- 
>> 2.11.0
>>
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
