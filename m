From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 02 Jul 2015 14:13:11 +0800
Subject: [PATCH v2 1/5] drm/rockchip: vop: optimize virtual stride
 calculate
In-Reply-To: <CAAFQd5B-W2uWFXo9me_MPdp0LDp0CK+mG6Rsbro9+JQSUBA4bw@mail.gmail.com>
References: <1435313249-4549-1-git-send-email-mark.yao@rock-chips.com>
 <1435313249-4549-2-git-send-email-mark.yao@rock-chips.com>
 <CAAFQd5B-W2uWFXo9me_MPdp0LDp0CK+mG6Rsbro9+JQSUBA4bw@mail.gmail.com>
Message-ID: <5594D677.20202@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?07?02? 12:59, Tomasz Figa wrote:
> On Fri, Jun 26, 2015 at 7:07 PM, Mark Yao <mark.yao@rock-chips.com> wrote:
>> vir_stride need number words of the virtual width, and fb->pitches
>> save bytes_per_pixel, so just div 4 switch to stride.
>>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>> ---
>> Changes in v2: None
>>
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> index 6188221..3c9f4f3 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -644,7 +644,7 @@ static int vop_update_plane_event(struct drm_plane *plane,
>>          offset += (src.y1 >> 16) * fb->pitches[0];
>>          yrgb_mst = rk_obj->dma_addr + offset;
>>
>> -       y_vir_stride = fb->pitches[0] / (fb->bits_per_pixel >> 3);
>> +       y_vir_stride = fb->pitches[0] >> 2;
> If the unit of y_vir_stride is words then doesn't it mean that the
> calculation before this patch was just invalid? If yes, shouldn't the
> subject actually say "Fix virtual stride calculation"?
>
> Best regards,
> Tomasz
>
>
>
Hi Tomasz
     the calculation thinking before is that:
        fb->pitches[0] = surface_width * bytes_per_pixel
        surface_width = fb->pitches[0] / bytes_per_pixel
                               = fb->pitches[0] / (fb->bits_per_pixel >> 3)

    means that "y_vir_stride = surface_width",

ARGB888 one pixel is word size, So that is right for ARGB888, but wrong for other formats.

You are right, subject say "Fix virtual stride calculation" is suitable.

Best regards,
-- 
?ark Yao
