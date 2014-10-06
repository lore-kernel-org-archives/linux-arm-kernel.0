From: ta.omasab@gmail.com (Thomas Abraham)
Date: Mon, 6 Oct 2014 13:25:34 +0530
Subject: exynos5420/arndale-octa: imprecise external aborts on
 exynos_defconfig
In-Reply-To: <11034593.CCZ1LqhX6D@amdc1032>
References: <CANMBJr41TQx4jVjnOO9WThn=SiZCq12mx1xtGN8_ubzZrO1=YA@mail.gmail.com>
 <CAJuA9ahkpZ4EJQz4DoAjYzo0OQw5zXLavAVoXRBdgPcm9EUQYA@mail.gmail.com>
 <7hk351ep8e.fsf@deeprootsystems.com> <11034593.CCZ1LqhX6D@amdc1032>
Message-ID: <CAJuA9agBGbTSbo_-5_t588Vc4SvEg06wX0=+AQHYVUxeO6e71w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

On Tue, Sep 30, 2014 at 11:47 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> Hi,
>
> On Wednesday, September 17, 2014 05:39:29 PM Kevin Hilman wrote:
>> Thomas Abraham <ta.omasab@gmail.com> writes:
>>
>> > On Thu, Sep 11, 2014 at 12:16 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> >> Tyler Baker <tyler.baker@linaro.org> writes:
>> >>
>> >>> Exynos5420-based Arndale octa boards have recently started failing boot
>> >>> tests due to imprecise external aborts.  This only appears to happen
>> >>> when using exynos_defconfig and boots fine with multi_v7_defconfig.  The
>> >>> issue seems to be intermittent, so is not reliably reproducable and
>> >>> difficult to bisect.  Here are a few boot logs from recent
>> >>> mainline/linux-next kernels that are failing:
>> >>
>> >> FYI, I'm seeing the same periodic aborts.  For example, here's my boot
>> >> of next-20140910:
>> >> http://images.armcloud.us/kernel-ci/next/next-20140910/arm-exynos_defconfig/boot-exynos5420-arndale-octa.html
>> >>
>> >> However, my userspace is much simpler and doesn't seem to cause a panic,
>> >> so my boot tests report passing. (I should fixup my scripts so these
>> >> imprecise aborts are reported as a FAIL.)
>> >>
>> >> I'm glad you pointed out that it happens only with exynos_defconfig and
>> >> not multi_v7_defconfig because I noticed that too.  I haven't had the
>> >> time to track it any further than that, so maybe the exynos folks can
>> >> help track it down from here.
>> >>
>> >> Thanks for reporting this,
>> >>
>> >> Kevin
>> >
>> > Hi Tyler, Kevin,
>> >
>> > From the bootlog you have shared,
>> >
>> > [    1.060016] CPU4: failed to come online
>> > [    2.070031] CPU5: failed to come online
>> > [    3.080049] CPU6: failed to come online
>> > [    4.090066] CPU7: failed to come online
>> > [    4.090099] Brought up 4 CPUs
>> > [    4.090109] SMP: Total of 4 processors activated.
>> > [    4.090119] CPU: WARNING: CPU(s) started in wrong/inconsistent
>> > modes (primary CPU mode 0x13)
>> > [    4.090128] CPU: This may indicate a broken bootloader or firmware.
>> >
>> > Would it be possible to set max cpus to 1, disable switcher and try
>
> Which "max cpus" do you mean?  For NR_CPUS the lower limit is 2.

The "maxcpus=1" kernel parameter could be used here. The reason for
trying with this option was to understand the probable location of
this imprecise abort (mcpm init or secondary cpu boot).

Thanks,
Thomas.

>
>> > again. I don't have a arndale octa board but I have tested mainline
>> > kernel with smdk5420 board. It boots all eight CPUs, switcher works
>> > fine and there are no imprecise aborts seen.
>>
>> Sorry for the delay, I'm travelling this week.
>>
>> FWIW, the same CPU boot failures you hilight above are happening on
>> multi_v7_defconfig[1] which is not getting the imprecise abort.  This is
>> only happening on exynos_defconfig[2], so I'm curious why you think the
>> switcher or NR_CPUS might be the issues.
>>
>> Anyways, I narrowed this down a bit and discovered it's
>> CONFIG_EXYNOS5420_MCPM=y that's the root cause.  If I use
>> exynos_defconfig and then disable that option, I don't get any more
>> imprecise aborts.
>
> I have exactly the same issue with Exynos5420 Arndale Octa.
>
> CONFIG_EXYNOS5420_MCPM was enabled by commit fc3791f3a95d
> ("ARM: exynos_defconfig: Update exynos_defconfig") which
> get merged into v3.17-rc1.  It seems that this part of
> the patch should be reverted for the final v3.17 kernel.
>
>> Kevin
>>
>> [1] http://images.armcloud.us/kernel-ci/mainline/v3.17-rc5-25-g8ba4caf/arm-multi_v7_defconfig/boot-exynos5420-arndale-octa.html
>> [2] http://images.armcloud.us/kernel-ci/mainline/v3.17-rc5-25-g8ba4caf/arm-exynos_defconfig/boot-exynos5420-arndale-octa.html
>
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>
