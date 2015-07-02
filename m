From: tfiga@chromium.org (Tomasz Figa)
Date: Thu, 2 Jul 2015 16:07:01 +0900
Subject: [PATCH v2 2/5] drm/rockchip: vop: fix yuv plane support
In-Reply-To: <5594DFF2.8020609@rock-chips.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
 <1435313249-4549-3-git-send-email-mark.yao@rock-chips.com>
 <CAAFQd5AAYSMNRtJBVU+2LHhA=JhJQVTEGmf2+pVt5JMXbbmg-g@mail.gmail.com>
 <5594DFF2.8020609@rock-chips.com>
Message-ID: <CAAFQd5AgaWNaYgkL9HebgeiXf0n1t79nAq0CYpb9ASY88gf4Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 2, 2015 at 3:53 PM, Mark yao <mark.yao@rock-chips.com> wrote:
> Hi Tomasz
>     Thanks for your review, I will fix it soon.
>
> On 2015?07?02? 14:00, Tomasz Figa wrote:
>>
>> Hi Mark,
>>
>> Please see my comments inline.
>>
>> On Fri, Jun 26, 2015 at 7:07 PM, Mark Yao <mark.yao@rock-chips.com> wrote:
>>>
>>> vop support yuv with NV12, NV16 and NV24, only 2 plane yuv.
>>>
>>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>>>
>>> Changes in v2:
>>> - Uv buffer not support odd offset, align it.
>>> - Fix error display when move yuv image.
>>>
>>> ---
>>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   63
>>> ++++++++++++++++++++++++---
>>>   1 file changed, 57 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>> b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>> index 3c9f4f3..6ca08f8 100644
>>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>>> @@ -373,6 +373,18 @@ static enum vop_data_format
>>> vop_convert_format(uint32_t format)
>>>          }
>>>   }
>>>
>>> +static bool is_yuv_support(uint32_t format)
>>> +{
>>> +       switch (format) {
>>> +       case DRM_FORMAT_NV12:
>>> +       case DRM_FORMAT_NV16:
>>> +       case DRM_FORMAT_NV24:
>>> +               return true;
>>> +       default:
>>> +               return false;
>>> +       }
>>> +}
>>> +
>>>   static bool is_alpha_support(uint32_t format)
>>>   {
>>>          switch (format) {
>>> @@ -577,16 +589,21 @@ static int vop_update_plane_event(struct drm_plane
>>> *plane,
>>>          struct vop *vop = to_vop(crtc);
>>>          struct drm_gem_object *obj;
>>>          struct rockchip_gem_object *rk_obj;
>>> +       struct drm_gem_object *uv_obj;
>>> +       struct rockchip_gem_object *rk_uv_obj;
>>>          unsigned long offset;
>>>          unsigned int actual_w;
>>>          unsigned int actual_h;
>>>          unsigned int dsp_stx;
>>>          unsigned int dsp_sty;
>>>          unsigned int y_vir_stride;
>>> +       unsigned int uv_vir_stride;
>>>          dma_addr_t yrgb_mst;
>>> +       dma_addr_t uv_mst;
>>>          enum vop_data_format format;
>>>          uint32_t val;
>>>          bool is_alpha;
>>> +       bool is_yuv;
>>>          bool visible;
>>>          int ret;
>>>          struct drm_rect dest = {
>>> @@ -608,6 +625,12 @@ static int vop_update_plane_event(struct drm_plane
>>> *plane,
>>>          };
>>>          bool can_position = plane->type != DRM_PLANE_TYPE_PRIMARY;
>>>
>>> +       if (drm_format_num_planes(fb->pixel_format) > 2) {
>>> +               DRM_ERROR("unsupport more than 2 plane format[%08x]\n",
>>> +                         fb->pixel_format);
>>> +               return -EINVAL;
>>> +       }
>>
>> Hmm, do you need to check this? Doesn't the core guarantee that with
>> given pixel_format you always get the right plane count? (Possibly at
>> fb creation time, but I haven't checked that.)
>
>
> I just want to point out that update_plane can't handle buffer number > 2
> case.
>
> But since all windows can't support 3 buffer count format, this check can
> remove.
>

Even if some windows could support 3 planes, I think this check is
unnecessary, because before calling .update_plane(), the DRM core
actually checks if given format is supported by particular plane, so
inside the callback you can be sure that fb->pixel_format is supported
by given plane. Now, plane count is implied by fourcc, so again it is
impossible to have .update_plane() called with, for example, NV12 and
1 or 3 planes.

>>>
>>> +       if (is_yuv) {
>>> +               src.x1 &= (~1) << 16;
>>> +               src.y1 &= (~1) << 16;
>>
>> Hmm, if you align x1 and y1, shouldn't you also offset x2 and y2, so
>> the width and height of the rectangle are preserved? Also I couldn't
>> find any details on this, but what are the semantics of
>> .update_plane(), should it really align the values or maybe just fail?
>
>
> for yuv format, the buffer start point need align, can't be odd.
>
> OK, I will fix the x2 and y2 offset.
>

I'd actually wait for someone else to comment on this, because I'm not
sure what's the correct handling of such rounding in DRM. Dave,
Daniel, Rob?

Best regards,
Tomasz
