From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 12 Jan 2012 14:47:27 -0600
Subject: [RFC] ARM: imx: Add imx6q thermal
In-Reply-To: <4F0E887D.2090009@de.bosch.com>
References: <1326266285-11656-1-git-send-email-rob.lee@linaro.org>
 <4F0E887D.2090009@de.bosch.com>
Message-ID: <CAMXH7KH=37bCvfytO0gpy4qFvMzwZmMfQ0ZOsao6Qf5w9qSHOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dirk, thanks for the review.  Comments below.

On Thu, Jan 12, 2012 at 1:15 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> Hi Rob,
>
>
> On 11.01.2012 08:18, Robert Lee wrote:
>>
>> Add thermal support for i.MX6Q. ?Uses recently submitted common
>> cpu_cooling functionality shown here:
>>
>> http://www.spinics.net/lists/linux-pm/msg26500.html
>>
>> Have some todo items but basic implementation is done and I'd like to
>> get any helpful feedback on it.
>>
>> Todo:
>> - Add sensor calibration.

I should have added: "(coming in version 2 of this patch)".  The
reading of the fuse value and the calibration will be in the next
version of this patch.

>> - Re-organize code/files if deemed necessary by community.
>
>
> Just fyi, I had a short discussion with Eric Miao about this. The conclusion
> was:
>
> The patch itself is OK. It's just lacking some features, but these can be
> added later. The driver supports thermal reading only, but not accurate as
> the thermal calibration data is burned into the FUSE, and differ from chip
> to chip. At the moment only incorrect thermal information will be exposed to
> user space. The patch is lacking connections to cpufreq and cpu hotplug, but
> those could be added later, too.
>

This patch connects to cpufreq using cpu_cooling functionality
recently submitted in Amit Katchhap's patch linked above.  This
registration is done here:

+
+       th_zone->cool_dev = cpufreq_cooling_register(
+               (struct freq_pctg_table *)th_zone->thermal_data->freq_tab,
+               IMX6Q_THERMAL_ACT_TRP_PTS, cpumask_of(0));
+

I tested it successfully with CPUFREQ during development, but I did
not re-test in this final patch and noticed a couple of bugs I
introduced later that will prevent it from working properly.  v2 will
resolve these issues.

> Best regards
>
> Dirk
