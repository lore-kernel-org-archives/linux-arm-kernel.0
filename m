From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Tue, 24 Jul 2012 12:06:23 +0900
Subject: [PATCH V2 6/7] ARM: EXYNOS5: Add the bus clock for FIMD
In-Reply-To: <000101cd6942$2badc960$83095c20$%han@samsung.com>
References: <1342591053-7092-1-git-send-email-l.krishna@samsung.com>
 <1342591053-7092-7-git-send-email-l.krishna@samsung.com>
 <500D0C8B.3080007@samsung.com> <500D1F59.9030807@samsung.com>
 <000301cd6928$e5021660$af064320$%han@samsung.com>
 <500DE22F.5010006@samsung.com>
 <000601cd692e$b2ba7a70$182f6f50$%han@samsung.com>
 <500E00A3.8080203@samsung.com>
 <000101cd6942$2badc960$83095c20$%han@samsung.com>
Message-ID: <500E112F.3090202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2012 11:15 AM, Jingoo Han wrote:
> On Tuesday, July 24, 2012 10:56 AM, Joonyoung Shim Wrote:
>> On 07/24/2012 08:55 AM, Jingoo Han wrote:
>>> On Tuesday, July 24, 2012 8:46 AM, Joonyoung Shim Wrote:
>>>> On 07/24/2012 08:14 AM, Jingoo Han wrote:
>>>>> On Monday, July 23, 2012 6:55 PM, Joonyoung Shim wrote:
>>>>>> Hi, Jingoo.
>>>>>>
>>>>>> On 07/23/2012 05:34 PM, Joonyoung Shim wrote:
>>>>>>> On 07/18/2012 02:57 PM, Leela Krishna Amudala wrote:
>>>>>>>> This patch adds the bus clock for FIMD and changes
>>>>>>>> the device name for lcd clock
>>>>>>> Please refer below patch for exynos4.
>>>>>>>
>>>>>>> http://lists.linaro.org/pipermail/linaro-dev/2011-December/008872.html
>>>>>>>
>>>>>>>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>>>>>>>> ---
>>>>>>>>      arch/arm/mach-exynos/clock-exynos5.c |    7 ++++++-
>>>>>>>>      1 files changed, 6 insertions(+), 1 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm/mach-exynos/clock-exynos5.c
>>>>>>>> b/arch/arm/mach-exynos/clock-exynos5.c
>>>>>>>> index 774533c..f001876 100644
>>>>>>>> --- a/arch/arm/mach-exynos/clock-exynos5.c
>>>>>>>> +++ b/arch/arm/mach-exynos/clock-exynos5.c
>>>>>>>> @@ -634,6 +634,11 @@ static struct clk exynos5_init_clocks_off[] = {
>>>>>>>>              .enable        = exynos5_clk_ip_disp1_ctrl,
>>>>>>>>              .ctrlbit    = (1 << 3),
>>>>>>>>          }, {
>>>>>>>> +        .name           = "fimd",
>>>>>>>> +        .devname        = "exynos5-fb",
>>>>>>>> +        .enable         = exynos5_clk_ip_disp1_ctrl,
>>>>>>>> +        .ctrlbit        = (1 << 0),
>>>>>>>> +    }, {
>>>>>> With this patch, it causes below error at the DP driver because fimd
>>>>>> clock is disabled.
>>>>>>
>>>>>> [    0.210000] exynos-dp exynos-dp: Timeout of video streamclk ok
>>>>>> [    0.210000] exynos-dp exynos-dp: unable to config video
>>>>>> [    0.210000] exynos-dp: probe of exynos-dp failed with error -110
>>>>>>
>>>>>> I wonder fimd clock has any dependency with DP
>>>>> FIMD pixel clock is necessary to enable DP.
>>>> So then, i think DP driver also should control FIMD pixel clock.
>>>> Do you have any patch or plan for it?
>>> Um, I don't think so.
>>> Because, DP cannot work by itself.
>>> In order to use DP, FIMD should be enabled.
>>>
>>> If FIMD is enabled, FIMD pixel clock is enabled;
>>> therefore, DP driver does not need to control FIMD pixel clock.
>> Why does DP driver have FIMD driver dependency? Also for this, it needs
>> FIMD driver is probed earlier then DP driver.  We cannot decide driver
>> probe order if they are same level drivers and itself is weird
>> condition.  Although there is hardware dependency, DP and FIMD driver
>> don't have any code relations. They are each other drivers. But DP
>> needs FIMD pixel clock and because the clock can be control at the
>> several drivers and the clock framework exists for that, then i think
>> it's better DP driver also control FIMD pixel clock.
>>
>>> In my opinion, adding config dependency would be better, such as FB_S3C or DRM_EXYNOS_FIMD.
>> I think this is not solution. How do you ensure FIMD driver is probed
>> earlier than DP driver? Even if it's possible, when FIMD driver only
>> controls pixel clock, DP driver will execute any operations regardless
>> status of FIMD pixel clock, so if FIMD driver turns off pixel clock,
>> then DP will occur any error.
> late_initcall can ensure DP driver is probed later.

I'm not sure late_initcall solution is good. It must choose at the last
if there isn't other way really.

>
> As you mentioned, DP controller does not work without FIMD controller.
> Because FIMD controller should provide video data and video clock to DP controller.
> In this case, adding config dependency would be good.
>
> If FIMD driver turns off pixel clock, DP should be turned off too.

This means DP driver should know FIMD status.

> Currently, FB FIMD driver turns off pixel clock in remove() and suspend().

You should also consider blank operation and runtime suspend / resume.

> So, FIMD driver is enabled, DP will not occur any error on pixel clock.
>

Anyway i want to be solved early.

Thanks.
