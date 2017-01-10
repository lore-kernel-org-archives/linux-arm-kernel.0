From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 11 Jan 2017 00:06:23 +0530
Subject: [PATCH] usb: dwc3-exynos fix unspecified suspend clk error
 handling
In-Reply-To: <2265318.ybtxfiNn3d@amdc3058>
References: <20170110022131.31042-1-shuahkh@osg.samsung.com>
 <28815306-e220-4847-99ce-b058baae0d07@osg.samsung.com>
 <CGME20170110180359epcas1p4729103fd575fe628bfd3ea7966ec4856@epcas1p4.samsung.com>
 <CANAwSgQ4Nxyq5itu62qdz18d4xvTu-e3P3ZXK2acLWtzexaaCA@mail.gmail.com>
 <2265318.ybtxfiNn3d@amdc3058>
Message-ID: <CANAwSgR2A8W=0xhzUUT0z_Bh4BEgDZ+2iy7uWo3Y2Pd1uJhLiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

On 10 January 2017 at 23:33, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Tuesday, January 10, 2017 11:23:38 PM Anand Moon wrote:
>> Hi Shuah,
>>
>> On 10 January 2017 at 21:58, Shuah Khan <shuahkh@osg.samsung.com> wrote:
>> > On 01/10/2017 09:05 AM, Bartlomiej Zolnierkiewicz wrote:
>> >>
>> >> Hi,
>> >>
>> >> On Tuesday, January 10, 2017 07:36:35 AM Shuah Khan wrote:
>> >>> On 01/10/2017 07:16 AM, Shuah Khan wrote:
>> >>>> On 01/10/2017 05:05 AM, Bartlomiej Zolnierkiewicz wrote:
>> >>>>>
>> >>>>> Hi,
>> >>>>>
>> >>>>> On Monday, January 09, 2017 07:21:31 PM Shuah Khan wrote:
>> >>>>>> Fix dwc3_exynos_probe() to call clk_prepare_enable() only when suspend
>> >>>>>> clock is specified. Call clk_disable_unprepare() from remove and probe
>> >>>>>> error path only when susp_clk has been set from remove and probe error
>> >>>>>> paths.
>> >>>>>
>> >>>>> It is legal to call clk_prepare_enable() and clk_disable_unprepare()
>> >>>>> for NULL clock.  Also your patch changes susp_clk handling while
>> >>>>> leaves axius_clk handling (which also can be NULL) untouched.
>> >>>>>
>> >>>>> Do you actually see some runtime problem with the current code?
>> >>>>>
>> >>>>> If not then the patch should probably be dropped.
>> >>>>>
>> >>>>> Best regards,
>> >>>>> --
>> >>>>> Bartlomiej Zolnierkiewicz
>> >>>>> Samsung R&D Institute Poland
>> >>>>> Samsung Electronics
>> >>>>
>> >>>> Hi Bartlomiej,
>> >>>>
>> >>>> I am seeing the "no suspend clk specified" message in dmesg.
>> >>>> After that it sets the exynos->susp_clk = NULL and starts
>> >>>> calling clk_prepare_enable(exynos->susp_clk);
>> >>>>
>> >>>> That can't be good. If you see the logic right above this
>> >>>> one for exynos->clk, it returns error and fails the probe.
>> >>>> This this case it doesn't, but tries to use null susp_clk.
>> >>
>> >> exynos->susp_clk is optional, exynos->clk is not.
>> >
>> > Right. That is clear since we don't fail the probe.
>> >
>> >>
>> >>>> I believe this patch is necessary.
>> >>>
>> >>> Let me clarify this a bit further. Since we already know
>> >>> susp_clk is null, with this patch we can avoid extra calls
>> >>> to clk_prepare_enable() and clk_disable_unprepare().
>> >>>
>> >>> One can say, it also adds extra checks, hence I will let you
>> >>> decide one way or the other. :)
>> >>
>> >> I would prefer to leave the things as they are currently.
>> >>
>> >> The code in question is not performance sensitive so extra
>> >> calls are not a problem.  No extra checks means less code.
>> >>
>> >> Also the current code seems to be more in line with the rest
>> >> of the kernel.
>> >
>> > What functionality is missing without the suspend clock? Would
>> > it make sense to change the info. message to include what it
>> > means. At the moment it doesn't anything more than "no suspend
>> > clock" which is a very cryptic user visible message. It would be
>> > helpful for it to also include what functionality is impacted.
>> >
>>
>> Both usbdrd30_susp_clk and usbdrd30_axius_clk are used by exynos5433 platform
>
> Can you point me to the use of usbdrd30_axius_clk?
>
> I cannot find in the upstream code.
>
>> so moving the clk under compatible string "samsung,exynos7-dwusb3" make sense.
>
> This is not so simple and we would probably need a new compatible for
> Exynos5433 (it is currently using "samsung,exynos5250-dwusb3" one and
> is not using axius_clk).

Opps: sorry for the noise, my result was based on simple grep.

Best Regards
-Anand

>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
>> Best Regards
>> -Anand
>>
>> > thanks,
>> > -- Shuah
>> >
>> >>
>> >> Best regards,
>> >> --
>> >> Bartlomiej Zolnierkiewicz
>> >> Samsung R&D Institute Poland
>> >> Samsung Electronics
>> >>
>> >>> thanks,
>> >>> -- Shuah
>> >>>
>> >>>>
>> >>>> thanks,
>> >>>> -- Shuah
>> >>>>
>> >>>>>
>> >>>>>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> >>>>>> ---
>> >>>>>>  drivers/usb/dwc3/dwc3-exynos.c | 10 ++++++----
>> >>>>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>> >>>>>>
>> >>>>>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>> >>>>>> index e27899b..f97a3d7 100644
>> >>>>>> --- a/drivers/usb/dwc3/dwc3-exynos.c
>> >>>>>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
>> >>>>>> @@ -131,8 +131,8 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>> >>>>>>   if (IS_ERR(exynos->susp_clk)) {
>> >>>>>>           dev_info(dev, "no suspend clk specified\n");
>> >>>>>>           exynos->susp_clk = NULL;
>> >>>>>> - }
>> >>>>>> - clk_prepare_enable(exynos->susp_clk);
>> >>>>>> + } else
>> >>>>>> +         clk_prepare_enable(exynos->susp_clk);
>> >>>>>>
>> >>>>>>   if (of_device_is_compatible(node, "samsung,exynos7-dwusb3")) {
>> >>>>>>           exynos->axius_clk = devm_clk_get(dev, "usbdrd30_axius_clk");
>> >>>>>> @@ -196,7 +196,8 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>> >>>>>>   regulator_disable(exynos->vdd33);
>> >>>>>>  err2:
>> >>>>>>   clk_disable_unprepare(exynos->axius_clk);
>> >>>>>> - clk_disable_unprepare(exynos->susp_clk);
>> >>>>>> + if (exynos->susp_clk)
>> >>>>>> +         clk_disable_unprepare(exynos->susp_clk);
>> >>>>>>   clk_disable_unprepare(exynos->clk);
>> >>>>>>   return ret;
>> >>>>>>  }
>> >>>>>> @@ -210,7 +211,8 @@ static int dwc3_exynos_remove(struct platform_device *pdev)
>> >>>>>>   platform_device_unregister(exynos->usb3_phy);
>> >>>>>>
>> >>>>>>   clk_disable_unprepare(exynos->axius_clk);
>> >>>>>> - clk_disable_unprepare(exynos->susp_clk);
>> >>>>>> + if (exynos->susp_clk)
>> >>>>>> +         clk_disable_unprepare(exynos->susp_clk);
>> >>>>>>   clk_disable_unprepare(exynos->clk);
>> >>>>>>
>> >>>>>>   regulator_disable(exynos->vdd33);
>
