From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jan 2016 15:25:14 +0100
Subject: [PATCH v12 0/18] Add Analogix Core Display Port Driver
In-Reply-To: <2322926.s1viZ6tSS3@phil>
References: <1450873538-18304-1-git-send-email-ykk@rock-chips.com>
 <2322926.s1viZ6tSS3@phil>
Message-ID: <1670568.VBNHbJuGkf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Mittwoch, 13. Januar 2016, 15:59:51 schrieb Heiko Stuebner:
> Am Mittwoch, 23. Dezember 2015, 20:25:38 schrieb Yakir Yang:
> >    The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
> > 
> > share the same IP, so a lot of parts can be re-used. I split the common
> > code into bridge directory, then rk3288 and exynos only need to keep
> > some platform code. Cause I can't find the exact IP name of exynos dp
> > controller, so I decide to name dp core driver with "analogix" which I
> > find in rk3288 eDP TRM
> 
> could you rebase your patches on top of Dave's drm-next branch [0] please?
> The exynos part got some const attributes for the *_func_ops structs and
> drm_encoder_init got an additional parameter.
> I'm still hoping that we can get this finally committed once 4.5-rc1 is
> released in 1.5 weeks :-) .
> 
> I did try to merge things together [1], the system at least comes up and
> detects the panel (EDID is read correctly and it turns the backlight on)
> but I don't see any output on the display - hdmi works fine though and
> X11 is claiming everything to be fine in both cases.
> 
> So I don't know yet if I made a mistake when putting this together or
> there is an issue on the driver-side.

I was able to debug this a bit more, and it seems the encoder_helper_funcs 
don't like the prepare/commit callbacks and like enable better.

So when I do something similar to Marks patch a8eef71d38da ("drm/rockchip: 
dw_hdmi: use encoder enable function"), like in the attached patch (to be 
folded into the original addition of those functions), I get display output 
again.


Heiko

> [0] http://cgit.freedesktop.org/~airlied/linux/log/?h=drm-next
> [1] https://github.com/mmind/linux-rockchip/tree/tmp/analogixdp_v12-veyron
> I left out patch16, per your talk with Jingoo and me not seeing any AUX
> CH errors without it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-analogix_dp-rockchip-use-.enable-instead-of-preprare.patch
Type: text/x-patch
Size: 1406 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160117/40b29442/attachment.bin>
