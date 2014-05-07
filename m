From: djkurtz@chromium.org (Daniel Kurtz)
Date: Wed, 7 May 2014 22:14:16 +0800
Subject: [PATCH 2/4] drm/exynos/mixer: use MXR_GRP_SXY_SY
In-Reply-To: <5369C13C.3080506@samsung.com>
References: <1399217181-26442-1-git-send-email-djkurtz@chromium.org>
 <1399217181-26442-3-git-send-email-djkurtz@chromium.org>
 <5369C13C.3080506@samsung.com>
Message-ID: <CAGS+omAbuzRpNDvB6eTw67Dcv3WMdWF3yz+bU5p3j5JRourOyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 7, 2014 at 1:14 PM, Seung-Woo Kim <sw0312.kim@samsung.com> wrote:
> Hi Daniel,
>
> On 2014? 05? 05? 00:26, Daniel Kurtz wrote:
>> Mixer hardware supports offsetting dma from start of source buffer using
>> the MXR_GRP_SXY register.
>>
>> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>> ---
>>  drivers/gpu/drm/exynos/exynos_mixer.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
>> index 475eb49..40cf39b 100644
>> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
>> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
>> @@ -529,13 +529,11 @@ static void mixer_graph_buffer(struct mixer_context *ctx, int win)
>>
>>       dst_x_offset = win_data->crtc_x;
>>       dst_y_offset = win_data->crtc_y;
>> +     src_x_offset = win_data->fb_x;
>> +     src_y_offset = win_data->fb_y;
>>
>>       /* converting dma address base and source offset */
>> -     dma_addr = win_data->dma_addr
>> -             + (win_data->fb_x * win_data->bpp >> 3)
>> -             + (win_data->fb_y * win_data->fb_width * win_data->bpp >> 3);
>> -     src_x_offset = 0;
>> -     src_y_offset = 0;
>> +     dma_addr = win_data->dma_addr;
>
> Basically, you are right and source offset register can be used. But
> because of limitation of resolution for mixer up to 1920x1080, I
> considered modified soruce dma address to set one frame buffer, which is
> bigger than 1920x1080, on to both fimd and hdmi.

Hi Seung-Woo,

I do not see why the maximum MIXER resolution matters for choosing
between offsetting BASE or using SXY.

Let's say you have one big 1920x1908 framebuffer, with a span of 1920,
starting at dma_addr (there is no extra padding at the end of the
line).
Let's say you wanted the mixer to scan out 1920x1080 pixels starting
from (0, 800) in the framebuffer, and start drawing them at (0,0) on
the screen.

What we currently do is:
  BASE = dma_addr + (800 * 1080 * 4)
  SPAN = 1920
  SXY = SX(0) | SY(0)
  WH = W(1920) | H(1080)
  DXY = DX(0) | DY(0)

I am proposing we do:
  BASE = dma_addr
  SPAN = 1920
  SXY = SX(0) | SY(800)
  WH = W(1920) | H(1080)
  DXY = DX(0) | DY(0)

In both cases, the mixer resolution is 1920x1080.

My motivation for wanting to program an un-modified dma_addr into BASE
is so we can then just check BASE_S to determine from which buffer the
mixer is actively being scanned out without worrying about the source
offset, since the source offset can change for a given framebuffer
(for example, when doing panning, or if an overlay is used for a HW
cursor).

Best Regards,
-Daniel

>
> Regards,
> - Seung-Woo Kim
>
>>
>>       if (win_data->scan_flags & DRM_MODE_FLAG_INTERLACE)
>>               ctx->interlace = true;
>>
>
> --
> Seung-Woo Kim
> Samsung Software R&D Center
> --
>
