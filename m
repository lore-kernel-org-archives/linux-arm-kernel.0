From: maarten.lankhorst@linux.intel.com (Maarten Lankhorst)
Date: Thu, 13 Jul 2017 18:00:49 +0200
Subject: [PATCH 13/16] drm/mediatek: Convert to new iterator macros
In-Reply-To: <20170712094503.hilg3he7amcrwvyi@phenom.ffwll.local>
References: <20170712081344.25495-1-maarten.lankhorst@linux.intel.com>
 <20170712081344.25495-14-maarten.lankhorst@linux.intel.com>
 <20170712094503.hilg3he7amcrwvyi@phenom.ffwll.local>
Message-ID: <c11717fa-f18a-b66a-0c3c-f46d19f65691@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 12-07-17 om 11:45 schreef Daniel Vetter:
> On Wed, Jul 12, 2017 at 10:13:41AM +0200, Maarten Lankhorst wrote:
>> for_each_obj_in_state is about to be removed, so use the new atomic
>> iterator macros.
>>
>> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: CK Hu <ck.hu@mediatek.com>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-mediatek at lists.infradead.org
>> ---
>>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> index 56f802d0a51c..be0741638f94 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> @@ -48,11 +48,11 @@ static void mtk_atomic_schedule(struct mtk_drm_private *private,
>>  static void mtk_atomic_wait_for_fences(struct drm_atomic_state *state)
>>  {
>>  	struct drm_plane *plane;
>> -	struct drm_plane_state *plane_state;
>> +	struct drm_plane_state *new_plane_state;
>>  	int i;
>>  
>> -	for_each_plane_in_state(state, plane, plane_state, i)
>> -		mtk_fb_wait(plane->state->fb);
>> +	for_each_new_plane_in_state(state, plane, new_plane_state, i)
>> +		mtk_fb_wait(new_plane_state->fb);
>>  }
> I think a variant of drm_atomic_set_fence_for_plane, which takes a
> reservation obj (or a dma-buf and then derefs dma_buf->resv itself) would
> be nice, so that drivers don't have to hand-roll sub-par fence waiting
> code like this (it's e.g. not interruptible for blocking commits).
>
> Anyway, patch itself looks good.
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>

Thanks.

Pushed patch 1-3, 4 (first hunk only), 5 (with static fix), 6, 8, 9, 11-13.

Still hoping for ack from driver maintainers on patch 7 (v2), 10, 14 (v2) and 15 (with the fix daniel spotted).
