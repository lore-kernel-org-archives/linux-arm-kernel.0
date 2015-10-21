From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Wed, 21 Oct 2015 20:20:43 +0530
Subject: [PATCH v2 0/6] Switch to generic syscon regmap based drivers
In-Reply-To: <562765F3.9010306@osg.samsung.com>
References: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
 <CAGOxZ50G-ttivhVjbozUisA0HXcFz7bvRUuPR67xR88TTCa_wQ@mail.gmail.com>
 <CAGOxZ51_JPy51htzD_M_=qaPVUexkVhoA2ANLS2-rpK3QDT=8A@mail.gmail.com>
 <1606098.olLAyTIhB3@dell2.five-lan.de> <56272C1C.8040007@samsung.com>
 <562765F3.9010306@osg.samsung.com>
Message-ID: <CAGOxZ52-ia8uhgGg5CiU9TSYkfAsRD52zvLqq++Y-mr4uaFOpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Wed, Oct 21, 2015 at 3:46 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Alim,
>
> On 10/21/2015 08:09 AM, Alim Akhtar wrote:
>
> [snip]
>
>>>>>>
>>>>>> Hi Alim,
>>>>>>
>>>>>> I have installed your patch set above with git am on top of
>>>>>> 4.3.0-rc6-00108-gce1fad2 torvalds/linux of today
>>>>>> with make exynos_defconfig on Odroid U3.
>>>>>>
>>>>> which exynos soc Odroid U3 uses?
>>>>>
>>>> OK, I can see its uses exynos4412 and exynos4412-odroidu3.dts does
>>>> include exynos4.dtsi,
>>>> so these should have worked.
>>>>
>>>>>> "halt -p" worked (power 0.0W).
>>>>>> "reboot" got stuck at 0.5W.
>>>>>>
>>>>> reboot stuck mean system does not reboot any more?
>>>
>>> It freezes when going for reboot.
>>> Have to power off/on to boot again.
>>>
>>> Btw I use an mmc, not an sd-card.
>>> No other HW connected, just LAN-cable.
>>> Bootloader is u-boot v2015.10.
>>> o
>> Have checked on 4.3.0-rc6-00006-gd03c139e7e77, still works on peach boards.
>> Sorry I don't have Odroid U3 with me, may be Javier or Krzysztof might help here to check whats wrong. To me its looks more of a board specific issue for now.
>>
>
> Krzysztof has an Odroid XU3 lite and I have an Odroid XU4, both uses an
> Exynos5422 so we can't check what's wrong with Odroid U3 (Exynos4412).
>
> Having said that I think I know what is the issue here. Markus said that
> he is using an eMMC instead of an uSD (which is what I used and my guess
> is that Krzysztof did too).
>
> Now, there is a subtle difference between the old PMU restart handler
> and the syscon-reboot one, and that is the restart handler priorities:
>
> notifier                    priority
> ------------------------------------
> pmu_restart_notify          128
> mmc_pwrseq_emmc_reset_nb    129
> syscon_restart_handle       192
>
> So, without Alim's patches, first the eMMC reset handler will be called
> and then the PMU restart handler but after his series, the syscon reset
> handler has a higher priority so the eMMC reset will never be called.
>
> But the problem is that the eMMC card has to be properly reset on system
> restart to allow the SoC iROM to be able to read the bootloader from the
> eMMC since the iROM doesn't have restart logic and the card shouldn't be
> left in an unknown state.
>
> So the problem here is not that the system is not being reset (that I
> think that works) but that on reboot, the system is not able to boot
> again since the ROM is not able to read the second stage bootloader.
>
> Markus,
>
> Can you please test following patch [0] on top of Alim's series? If that
> works then it should either be part of Alim's series or the patches will
> have to wait until that patch lands into mainline. I don't have an eMMC
> to test it in XU4 but I'm pretty confident that it will solve the issue.
>
> Best regards,
> --
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America
>
> [0]:
> From c9b250ee03bae338339b70693e906145c719f783 Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javier@osg.samsung.com>
> Date: Wed, 21 Oct 2015 11:59:44 +0200
> Subject: [RFT PATCH] mmc: pwrseq: Use highest priority for eMMC restart
>  handler
>
> The pwrseq_emmc driver does a eMMC card reset before a system reboot to
> allow broken or limited ROM boot-loaders, that don't have an eMMC reset
> logic, to be able to read the second stage from the eMMC.
>
> But this has to be called before a system reboot handler and while most
> of them use the priority 128, there are other restart handlers (such as
> the syscon-reboot one) that use a higher priority. So, use the highest
> priority to make sure that the eMMC hw is reset before a system reboot.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
Looks good.
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/mmc/core/pwrseq_emmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index 137c97fb7aa8..ad4f94ec7e8d 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -84,11 +84,11 @@ struct mmc_pwrseq *mmc_pwrseq_emmc_alloc(struct mmc_host *host,
>
>         /*
>          * register reset handler to ensure emmc reset also from
> -        * emergency_reboot(), priority 129 schedules it just before
> -        * system reboot
> +        * emergency_reboot(), priority 255 is the highest priority
> +        * so it will be executed before any system reboot handler.
>          */
>         pwrseq->reset_nb.notifier_call = mmc_pwrseq_emmc_reset_nb;
> -       pwrseq->reset_nb.priority = 129;
> +       pwrseq->reset_nb.priority = 255;
>         register_restart_handler(&pwrseq->reset_nb);
>
>         pwrseq->pwrseq.ops = &mmc_pwrseq_emmc_ops;
> --
> 2.4.3



-- 
Regards,
Alim
