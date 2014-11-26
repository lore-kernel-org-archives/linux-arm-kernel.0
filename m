From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 25 Nov 2014 17:00:47 -0800
Subject: [PATCH] ARM: exynos_defconfig: disable CONFIG_EXYNOS5420_MCPM;
 not stable
In-Reply-To: <CAM4voa==Ram0xXTL=SnKktyRt7VFphQxBJgcf9Yi9Zio0QctHw@mail.gmail.com>
 (Abhilash Kesavan's message of "Tue, 25 Nov 2014 11:31:18 +0530")
References: <1414796382-5447-1-git-send-email-khilman@kernel.org>
 <000e01cffb39$5ef0a2d0$1cd1e870$@kernel.org>
 <7hegtaq26c.fsf@deeprootsystems.com>
 <CAMAWPa-mLAFL7v8hHA5R-eBzpMFK-E-xcvjoV8Bn6tTwgP53Uw@mail.gmail.com>
 <CAOesGMhvTDN4J6AdUDHKV0Sp4NT6a4QEMUDWOayQqhhD+C4acw@mail.gmail.com>
 <CAMAWPa-sz5jT9izEONVZR2Z4mzuivKaNHSgyR+eP13tWZ84hYw@mail.gmail.com>
 <CAOesGMgSkJ8xkBgN7OpuDzT=ehaAd6kvbx5_tC50x78pvpkTwg@mail.gmail.com>
 <CAOesGMh-7md4PdQX1Wvk0jO+87j+fxSvBnVD_osjNd2zQ4L43w@mail.gmail.com>
 <044101d00852$3f421420$bdc63c60$@kernel.org>
 <CAMAWPa-qk0DEmPNz5LZgJq9AuGhRxuY00XwxtEikt_vh-iozVg@mail.gmail.com>
 <CAM4voa==Ram0xXTL=SnKktyRt7VFphQxBJgcf9Yi9Zio0QctHw@mail.gmail.com>
Message-ID: <7hvbm2ixmo.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

Abhilash Kesavan <kesavan.abhilash@gmail.com> writes:

[...]

>>> To be honest, since I don't have the exynos5420 arndale, chromebook...but smdk
>>> which has different bootloader, I couldn't test it...I'll try to make a test
>>> farm like you guys...
>>
>> Do you have some colleagues with any other 542x hardware?  I had
>> assumed that linux-next was being better tested on the publicaly
>> available, and widely available boards like odroid-xu3 and
>> Chromebook2, but I've come to realize the hard way that that is not
>
> Are you seeing this on Chromebook2 (Peach-Pi 5800) too ?

No, it seems that my exynos5800-peach-pi is not having this problem,
which suggests it's a bootloader setup issue.

>> the case.  You mention your board has a different bootloader.  Do you
>> suspect there's a bootloader issue on these other platforms?  If so,
>> could you elaborate on possible fixes?  I'm more than willing to test
>> any proposed fixes, but I'm not familiar enough yet with these SoCs to
>> figure out the underlying issues alone.
>>
>> Until you have a working board farm, you could start having a closer
>> look at the boot logs we're already producing.  Admittedly linux-next
>> broken in many ways besides this one for exynos currently, but it has
>> been having these imprecise aborts well before the other recent
>> issues.
>>
>> Also, It's very possible that this issue is not even MCPM related at
>> all, and MCPM is just uncovering a previously hidden bug.  It would be
>> very helpful if people more familiar with this hardware and SoC would
>> investigate bug reports like these.
>
> The 3 boards I have access to (SMDK5420, Chromebook Peach-Pi and
> Chromebook Peach-Pit) work fine with MCPM enabled. 

Thanks for helping look into this.

> I am not sure why
> it is failing only on the above mentioned boards as there is nothing
> specific to them in the MCPM back-end.
>
> I assume that when you default to platsmp (on disabling MCPM), the
> non-working boards boot all cores upto userspace without any issues ?

Nope.  With MCPM disabled:

  - 5420/arndale-octa: CPU0-3 come up (A15s)
  - 5422/odroid-xu3: only CPU0 (A7)
  - 5800/peach-pi: only CPU0 (A15)

Note that with MCPM enabled, the arndale-octa gets the same result.
Peach-pi on the other hand gets all 8 CPUs, and the odroid-xu3 only gets
6/8 CPUs (see other thread on that topic.)

> Based on the timeline (problems started about 2.5 months back), there
> have only been a couple of changes in the 5420 MCPM back-end. Could
> you revert the following commits and check if things improve.
>
> 20fe6f9 ARM: EXYNOS: Support cluster power off on exynos5420/5800
> fbb0499 ARM: 8083/1: exynos: activate the CCI on boot CPU/cluster
> using the MCPM loopback
>
> These might not revert cleanly, so instead of the above you could also
> comment the following 2 lines:
>
>
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c
> b/arch/arm/mach-exynos/mcpm-exynos.c
> index dc9a764..9a07188 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -152,7 +152,7 @@ static void exynos_power_down(void)
>                 exynos_cpu_power_down(cpunr);
>
>                 if (exynos_cluster_unused(cluster)) {
> -                       exynos_cluster_power_down(cluster);
> +                       //exynos_cluster_power_down(cluster);
>                         last_man = true;
>                 }
2>         } else if (cpu_use_count[cpu][cluster] == 1) {
> @@ -356,8 +356,8 @@ static int __init exynos_mcpm_init(void)
>         ret = mcpm_platform_register(&exynos_power_ops);
>         if (!ret)
>                 ret = mcpm_sync_init(exynos_pm_power_up_setup);
> -       if (!ret)
> -               ret = mcpm_loopback(exynos_cache_off); /* turn on the CCI */
> +       //if (!ret)
> +               //ret = mcpm_loopback(exynos_cache_off); /* turn on the CCI */
>         if (ret) {
>                 iounmap(ns_sram_base_addr);
>                 return ret;
>
>
>
> If you still get aborts then I suspect that the problem is with the
> bootloader configuration but am not sure. 

Nice.  With those lines commented out, the arndale-octa is not geting
imprecise aborts anymore, and this is the platform where those aborts
seem to prevent booting into a full userspace (as originally reported by
Tyler.)

More specifically, with only the loopback call to turn off CCI commented
out, the imprecise aborts go away.

The odroid-xu3 is still getting them, but these seem to happen whether
or not MCPM is enabled, so must a different issue related to the
bootloader setup.

> I am OK with disabling
> 5420_MCPM in the default configuration in such a case. This would
> however mean that S2R also stops working by default on 5420.

Disabling the option isn't my first choice either, I would rather see
this issue debugged and fixed by folks that are more familiar with MCPM
on Exynos.

Kevin
