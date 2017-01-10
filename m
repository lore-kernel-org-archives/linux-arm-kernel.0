From: vivek.gautam@codeaurora.org (vivek.gautam at codeaurora.org)
Date: Tue, 10 Jan 2017 23:19:06 +0530
Subject: [PATCH] usb: dwc3-exynos fix unspecified suspend clk error
 handling
In-Reply-To: <5156028.4V9iLD3Qkj@amdc3058>
References: <20170110022131.31042-1-shuahkh@osg.samsung.com>
 <8784459.rxWqZlDLVg@amdc3058>
 <28815306-e220-4847-99ce-b058baae0d07@osg.samsung.com>
 <CGME20170110170942epcas1p3decee28366d7d42b70e7b0669b97326f@epcas1p3.samsung.com>
 <5156028.4V9iLD3Qkj@amdc3058>
Message-ID: <9b9653d31f84b5784bd5f44629026890@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-01-10 22:39, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> On Tuesday, January 10, 2017 09:28:52 AM Shuah Khan wrote:
>> On 01/10/2017 09:05 AM, Bartlomiej Zolnierkiewicz wrote:
>> >
>> > Hi,
>> >
>> > On Tuesday, January 10, 2017 07:36:35 AM Shuah Khan wrote:
>> >> On 01/10/2017 07:16 AM, Shuah Khan wrote:
>> >>> On 01/10/2017 05:05 AM, Bartlomiej Zolnierkiewicz wrote:
>> >>>>
>> >>>> Hi,
>> >>>>
>> >>>> On Monday, January 09, 2017 07:21:31 PM Shuah Khan wrote:
>> >>>>> Fix dwc3_exynos_probe() to call clk_prepare_enable() only when suspend
>> >>>>> clock is specified. Call clk_disable_unprepare() from remove and probe
>> >>>>> error path only when susp_clk has been set from remove and probe error
>> >>>>> paths.
>> >>>>
>> >>>> It is legal to call clk_prepare_enable() and clk_disable_unprepare()
>> >>>> for NULL clock.  Also your patch changes susp_clk handling while
>> >>>> leaves axius_clk handling (which also can be NULL) untouched.
>> >>>>
>> >>>> Do you actually see some runtime problem with the current code?
>> >>>>
>> >>>> If not then the patch should probably be dropped.
>> >>>>
>> >>>> Best regards,
>> >>>> --
>> >>>> Bartlomiej Zolnierkiewicz
>> >>>> Samsung R&D Institute Poland
>> >>>> Samsung Electronics
>> >>>
>> >>> Hi Bartlomiej,
>> >>>
>> >>> I am seeing the "no suspend clk specified" message in dmesg.
>> >>> After that it sets the exynos->susp_clk = NULL and starts
>> >>> calling clk_prepare_enable(exynos->susp_clk);
>> >>>
>> >>> That can't be good. If you see the logic right above this
>> >>> one for exynos->clk, it returns error and fails the probe.
>> >>> This this case it doesn't, but tries to use null susp_clk.
>> >
>> > exynos->susp_clk is optional, exynos->clk is not.
>> 
>> Right. That is clear since we don't fail the probe.
>> 
>> >
>> >>> I believe this patch is necessary.
>> >>
>> >> Let me clarify this a bit further. Since we already know
>> >> susp_clk is null, with this patch we can avoid extra calls
>> >> to clk_prepare_enable() and clk_disable_unprepare().
>> >>
>> >> One can say, it also adds extra checks, hence I will let you
>> >> decide one way or the other. :)

Hi Shuah Khan,

Like Bartlomiej mentioned below, it is completely fair to call
clk_prepare_enable() with NULL clocks. That's how most of the
optional clocks are handled in the kernel. So, i don't think
there's any need of adding an additional check for the 
'exynos->susp_clk'.

The 'exynos->clk' is the main IP clock that is mandatory, and hence
the probe fails in case that is not present.

>> >
>> > I would prefer to leave the things as they are currently.
>> >
>> > The code in question is not performance sensitive so extra
>> > calls are not a problem.  No extra checks means less code.
>> >
>> > Also the current code seems to be more in line with the rest
>> > of the kernel.
>> 
>> What functionality is missing without the suspend clock? Would
>> it make sense to change the info. message to include what it
>> means. At the moment it doesn't anything more than "no suspend
>> clock" which is a very cryptic user visible message. It would be
>> helpful for it to also include what functionality is impacted.
> 
> Well, all I know is what the original commit descriptions says and
> that the commit itself comes from patchset adding Exynos7 USB 3.0
> support [1]:
> 
> commit 72d996fc7a01c2e4d581a15db7d001e2799ffb29
> Author: Vivek Gautam <gautam.vivek@samsung.com>
> Date:   Fri Nov 21 19:05:46 2014 +0530
> 
>     usb: dwc3: exynos: Add provision for suspend clock
> 
>     DWC3 controller on Exynos SoC series have separate control for
>     suspend clock which replaces pipe3_rx_pclk as clock source to
>     a small part of DWC3 core that operates when SS PHY is in its
>     lowest power state (P3) in states SS.disabled and U3.
> 
>     Suggested-by: Anton Tikhomirov <av.tikhomirov@samsung.com>
>     Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>     Signed-off-by: Felipe Balbi <balbi@ti.com>
> 

Hi Bartlomiej,

> Anton's & Vivek's Samsung email addresses are no longer valid but
> I added current Vivek's email address to Cc:.

Thanks for adding me to the thread.

> 
> BTW What is interesting is that the Exynos7 dts patch [2] has never
> made it into upstream for some reason.  In the meantime however
> Exynos5433 (similar to Exynos7 to some degree) became the user of
> susp_clk.

You are right. The exynos7 device tree patches could not make it to
upstream for some reasons. I think there are few guys looking at USB
for Exynos.
If there's something needed on Exynos7 USB side, i have added
Pankaj Dubey <pankaj.dubey@samsung.com> to this thread.

Hi Pankaj,
I am adding you to please help us with any future requirements
for exynos USB in the upstream.
Thanks!

> 
> [1] https://lkml.org/lkml/2014/11/21/247
> [2] https://patchwork.kernel.org/patch/5355161/
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

[snip]


Best Regards
Vivek
