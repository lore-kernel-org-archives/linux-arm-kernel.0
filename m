From: marex@denx.de (Marek Vasut)
Date: Sat, 6 May 2017 02:15:29 +0200
Subject: [PATCH 1/5] ARM: dts: imx7-colibri: use OF graph to describe the
 display
In-Reply-To: <144548a963c8393049f90afd683b331b@agner.ch>
References: <20170329232113.19078-1-stefan@agner.ch>
 <CAOMZO5Bp=K8_nP0_+MjQ9teS_U9SpRspOhVPwOwg1J0m0QZjCg@mail.gmail.com>
 <CAOMZO5AuvgqtNTHUW-LyXy9Xsq=rnaPODBzWA3FRmRpxqrRqAw@mail.gmail.com>
 <144548a963c8393049f90afd683b331b@agner.ch>
Message-ID: <86b6c888-a17b-e19c-8263-ce2b9dd71dea@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2017 01:52 AM, Stefan Agner wrote:
> On 2017-05-05 06:18, Fabio Estevam wrote:
>> On Fri, May 5, 2017 at 8:48 AM, Fabio Estevam <festevam@gmail.com> wrote:
>>
>>> Could you please confirm that drm/mxsfb is working fine on 4.11 on your board?
>>>
>>> I am converting mx6sx sdb to use drm/mxsfb and I noticed that when
>>> board boots I get garbage on the display.
>>>
>>> If I do a blank/unblank then things are displayed correctly.
>>
>> Ok, I managed to fix the drm/mxsfb driver.
>>
>> Will submit a patch shortly.
> 
> FWIW, it works, on i.MX 7 here, but I also have a U-Boot which
> initialized eLCDIF first.
> 
> Will check your patch and without U-Boot eLCDIF support.

Same thing here, I had U-Boot which inited the eLCDIF too and disabling
that triggered this issue on MX6SX as well. Then again, the original
patch I sent Fabio fixed it for me too:

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
index 6d701d2c362d..f02d23d55995 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -84,6 +84,8 @@ static int mxsfb_set_pixel_fmt(struct
mxsfb_drm_private *mxsfb)

        writel(ctrl1, mxsfb->base + LCDC_CTRL1);
        writel(ctrl, mxsfb->base + LCDC_CTRL);
+       writel(ctrl1, mxsfb->base + LCDC_CTRL1);
+       writel(ctrl, mxsfb->base + LCDC_CTRL);

        return 0;
 }

-- 
Best regards,
Marek Vasut
