From: jingoohan1@gmail.com (Jingoo Han)
Date: Thu, 24 Dec 2015 00:15:06 +0900
Subject: [PATCH v11 17/19] drm: bridge: analogix/dp: expand the look time
 for waiting AUX CH reply
In-Reply-To: <567A3882.3020808@rock-chips.com>
References: <1450236018-1118-1-git-send-email-ykk@rock-chips.com>
 <1450238257-3274-1-git-send-email-ykk@rock-chips.com>
 <000a01d13cb4$0f81f510$2e85df30$@com> <567A21EC.4010003@rock-chips.com>
 <567A3882.3020808@rock-chips.com>
Message-ID: <000101d13d94$ba41bea0$2ec53be0$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 23, 2015 3:01 PM, Yakir Yang wrote:
> 
> Hi Jingoo,
> 
> On 12/23/2015 12:24 PM, Yakir Yang wrote:
> > Hi Jingoo,
> >
> > On 12/22/2015 08:26 PM, Jingoo Han wrote:
> >> On Wednesday, December 16, 2015 12:58 PM, Yakir Yang wrote:
> >>> After test on rockchiop platform, i found sometims driver would failed
> >>> at reading EDID message. After debugging more, i found that it's okay
> >>> to read_a byte from i2c, but it would failed at AUX transcation if we
> >>> try to ready multi-bytes from i2c.
> >>>
> >>> Driver just can't received the AUX CH reply command, even no AUX error
> >>> code. I may guess that the AUX wait time is not enough, so I try to
> >>> expand the AUX wait time, and i do see this could fix the EDID read
> >>> failed at rockchip platform.
> >>>
> >>> And I thought that expand the wait time won't hurt Exynos platform too
> >>> much, cause Exynos didn't have this problem, then driver would received
> >>> the reply command very soon, so no more additional wait time would
> >>> bring
> >>> to Exynos platform.
> >>>
> >>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> >>> ---
> >>> Changes in v11: None
> >>> Changes in v10: None
> >>> Changes in v9: None
> >>> Changes in v8: None
> >>> Changes in v7: None
> >>> Changes in v6: None
> >>> Changes in v5: None
> >>> Changes in v4: None
> >>> Changes in v3: None
> >>> Changes in v2: None
> >>>
> >>>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> >>> b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> >>> index c7e2959..dc376bd 100644
> >>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> >>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> >>> @@ -482,7 +482,7 @@ int analogix_dp_start_aux_transaction(struct
> >>> analogix_dp_device *dp)
> >>>       reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
> >>>       while (!(reg & RPLY_RECEIV)) {
> >>>           timeout_loop++;
> >>> -        if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
> >>> +        if (DP_TIMEOUT_LOOP_COUNT * 10 < timeout_loop) {
> >> No, I hate this coding.
> >> analogix_dp_reg.c is the common code that can be shared by various SoCs.
> >> Please, find another way.
> >
> > Okay, I have double checked that i do have this problem in my side.
> > Hmmm.....
> > I thought it's okay for you if I expand the "DP_TIMEOUT_LOOP_COUNT"
> > directly,
> > it won't hurt Exynos platform too much, cause Exynos didn't have this
> > problem,
> > then driver would received,the reply command very soon, so no more
> > additional
> > wait time would bring to Exynos platform.
> >
> 
> Oh, sorry, little mistaken, I mean, is it okay for you to expand the
> "DP_TIMEOUT_LOOP_COUNT" directly ?

NO.

Don't change DP_TIMEOUT_LOOP_COUNT.
Just, change wait time by adding new DT property.

> 
> - Yakir
> 
> 
> > And actually the datasheet haven't described the spec of aux reply
> > delay time.

Right.
However, the problem is specific for Rockchip platform.
It is the hardware bug of Rockchip platform.
Your delay time is too long to apply to other SoCs platform.

Best regards,
Jingoo Han

> >
> > Thanks,
> > - Yakir
> >
> >> Best regards,
> >> Jingoo Han
> >>
> >>
> >>>               dev_err(dp->dev, "AUX CH command reply failed!\n");
> >>>               return -ETIMEDOUT;
> >>>           }
> >>> --
> >>> 1.9.1
> >>
> >>
> >>
> >>
> >
> >
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >
> >
> >
