From: maarten.lankhorst@linux.intel.com (Maarten Lankhorst)
Date: Mon, 3 Jul 2017 13:01:55 +0200
Subject: [Intel-gfx] [PATCH 1/2] drm/atomic: Change
 drm_atomic_helper_swap_state to return an error.
In-Reply-To: <20170630135621.c2xlunjaepne2vqt@phenom.ffwll.local>
References: <20170628132812.14927-1-maarten.lankhorst@linux.intel.com>
 <20170630135621.c2xlunjaepne2vqt@phenom.ffwll.local>
Message-ID: <76319124-3497-f941-73c7-ce6abf084551@linux.intel.com>
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
This can't be done higher up because of the interruptible wait.

Unless we change the patch series to move the waiting for hw_done to a separate step and get rid of the stall argument to swap_state once everything is converted. This could be useful for all drivers that have some kind of setup, because we could move the wait up slightly to suit the drivers needs.

~Maarten
