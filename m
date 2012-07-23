From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 24 Jul 2012 08:55:55 +0900
Subject: [PATCH V2 6/7] ARM: EXYNOS5: Add the bus clock for FIMD
In-Reply-To: <500DE22F.5010006@samsung.com>
References: <1342591053-7092-1-git-send-email-l.krishna@samsung.com>
 <1342591053-7092-7-git-send-email-l.krishna@samsung.com>
 <500D0C8B.3080007@samsung.com> <500D1F59.9030807@samsung.com>
 <000301cd6928$e5021660$af064320$%han@samsung.com>
 <500DE22F.5010006@samsung.com>
Message-ID: <000601cd692e$b2ba7a70$182f6f50$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 24, 2012 8:46 AM, Joonyoung Shim Wrote:
> 
> On 07/24/2012 08:14 AM, Jingoo Han wrote:
> > On Monday, July 23, 2012 6:55 PM, Joonyoung Shim wrote:
> >> Hi, Jingoo.
> >>
> >> On 07/23/2012 05:34 PM, Joonyoung Shim wrote:
> >>> On 07/18/2012 02:57 PM, Leela Krishna Amudala wrote:
> >>>> This patch adds the bus clock for FIMD and changes
> >>>> the device name for lcd clock
> >>> Please refer below patch for exynos4.
> >>>
> >>> http://lists.linaro.org/pipermail/linaro-dev/2011-December/008872.html
> >>>
> >>>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> >>>> ---
> >>>>    arch/arm/mach-exynos/clock-exynos5.c |    7 ++++++-
> >>>>    1 files changed, 6 insertions(+), 1 deletions(-)
> >>>>
> >>>> diff --git a/arch/arm/mach-exynos/clock-exynos5.c
> >>>> b/arch/arm/mach-exynos/clock-exynos5.c
> >>>> index 774533c..f001876 100644
> >>>> --- a/arch/arm/mach-exynos/clock-exynos5.c
> >>>> +++ b/arch/arm/mach-exynos/clock-exynos5.c
> >>>> @@ -634,6 +634,11 @@ static struct clk exynos5_init_clocks_off[] = {
> >>>>            .enable        = exynos5_clk_ip_disp1_ctrl,
> >>>>            .ctrlbit    = (1 << 3),
> >>>>        }, {
> >>>> +        .name           = "fimd",
> >>>> +        .devname        = "exynos5-fb",
> >>>> +        .enable         = exynos5_clk_ip_disp1_ctrl,
> >>>> +        .ctrlbit        = (1 << 0),
> >>>> +    }, {
> >> With this patch, it causes below error at the DP driver because fimd
> >> clock is disabled.
> >>
> >> [    0.210000] exynos-dp exynos-dp: Timeout of video streamclk ok
> >> [    0.210000] exynos-dp exynos-dp: unable to config video
> >> [    0.210000] exynos-dp: probe of exynos-dp failed with error -110
> >>
> >> I wonder fimd clock has any dependency with DP
> > FIMD pixel clock is necessary to enable DP.
> 
> So then, i think DP driver also should control FIMD pixel clock.
> Do you have any patch or plan for it?

Um, I don't think so.
Because, DP cannot work by itself.
In order to use DP, FIMD should be enabled.

If FIMD is enabled, FIMD pixel clock is enabled;
therefore, DP driver does not need to control FIMD pixel clock.

In my opinion, adding config dependency would be better, such as FB_S3C or DRM_EXYNOS_FIMD.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
