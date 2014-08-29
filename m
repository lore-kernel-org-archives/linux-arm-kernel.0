From: ta.omasab@gmail.com (Thomas Abraham)
Date: Fri, 29 Aug 2014 18:22:16 +0530
Subject: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
In-Reply-To: <CAGa+x86jU8MR=r_xuaiorbNNyqrezb0b6Ozy-MPg9HvsARESOw@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
 <1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
 <53DA8BB9.6020702@samsung.com> <53DA8D85.3050106@gmail.com>
 <7hbnrc6px3.fsf@paris.lan> <53F7DA13.6090305@gmail.com>
 <CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
 <7h8umc60we.fsf@paris.lan>
 <CADWw7OgW+o3tB=ptnsy-PsmXmNv8oXzt_WfK6NswQiEWWwAzNA@mail.gmail.com>
 <CAGa+x85-Anb+HsSUQRaaeex19-HK+yZDW0UpFBwAtsQ8Sf2Aqg@mail.gmail.com>
 <CAGa+x86jU8MR=r_xuaiorbNNyqrezb0b6Ozy-MPg9HvsARESOw@mail.gmail.com>
Message-ID: <CAJuA9ajtsrY7zSDMs=c6BZ0AqERoBgvq++dTF4Dn673zGMfcgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Aug 27, 2014 at 3:55 AM, Kevin Hilman <khilman@linaro.org> wrote:
> On Tue, Aug 26, 2014 at 8:15 AM, Kevin Hilman <khilman@linaro.org> wrote:
>> On Mon, Aug 25, 2014 at 10:25 PM, Chander Kashyap <k.chander@samsung.com> wrote:
>
> [...]
>
>>>>
>>>> Can you clarify how you're setting the voltages to ensure stability?
>>>
>>> below is the diff :  wip/exynos/integ
>>
>> Thanks.
>>
>> I've applied your patch, and bootup shows vdd_arm and vdd_kfc at
>> 1500mV, but still when booting with cpuidle enabled (bL switcher
>> disabled), I'm seeing lockups with no kernel output.  With CPUidle
>> disabled, things are pretty stable.
>>
>> What tree are you using to test this out on 5420?  I'm using mainline
>> v3.17-rc1 + DT patch for CPUidle and this cpufreq series.  See my
>> wip/exynos/integ branch at
>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git.
>
> I mis-stated this.  Actually my tree is based on the v3.17-rc1 branch
> of the exynos-reference tree[1] + the above mentioned patches for
> cpuidle and cpufreq.
>
> Also, I've narrowed down the instability a bit, and it's not related
> to CPUidle.  I can now trigger a boot hang even without CPUidle
> enabled.  Here's a quick way to cause a boot lockup. With the switcher
> disabled, I enable CPUfreq and set the default governor to
> performance.  As soon as cpufreq driver loads, it tries to use the top
> frequences for both clusters, and it hangs.
>
> Selectively disabling frequencies, I narrowed it down to the 1.3GHz
> and 1.2GHz frequencies of the little cluster.  With these commented
> out in the DT, it will fully boot with the performance governor
> enabled.
>
> So that leads to the question.  Are all of the operating points in
> exynos5420.dtsi valid for exynos5800, and have they been validated?

I tried to recreate the boot lockup issue using the same steps you
listed above for the Exynos5800 peach-pi platform (Chromebook2), but I
do not see any issues. I can see both clusters with max clock speed
after boot (1.8GHz and 1.3GHz).

I am using v3.17-rc2 + CPUFreq Patches + max77802 regulator support
patches for Chromebook2 + temp hack to set A15 voltage to 1.35V and A7
voltage to 1.3V.

Sorry for the delaying in following up.

Thanks,
Thomas.

>
> Kevin
>
> [1]https://github.com/exynos-reference/kernel.git
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
