From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Wed, 19 Aug 2015 14:15:28 +0300
Subject: [GIT PULL 9/9] ARM: tegra: Default configuration updates for
 v4.3-rc1
In-Reply-To: <CANMBJr7PKy-eCcB3HiBajpApHS_BYPa7xfKjTqV4o8Z1hwY99A@mail.gmail.com>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>	<1439563720-13189-10-git-send-email-thierry.reding@gmail.com>
 <CANMBJr7PKy-eCcB3HiBajpApHS_BYPa7xfKjTqV4o8Z1hwY99A@mail.gmail.com>
Message-ID: <55D46550.7090203@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please try disabling TEGRA124_EMC and seeing if that makes any difference.

Mikko

On 08/19/2015 01:30 AM, Tyler Baker wrote:
> Hi Theirry,
> 
> On 14 August 2015 at 07:48, Thierry Reding <thierry.reding@gmail.com> wrote:
>> Hi ARM SoC maintainers,
>>
>> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
>>
>>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-defconfig
>>
>> for you to fetch changes up to 258d9bc5e77fa40e290a0bd480d5349224374480:
>>
>>   ARM: tegra: Update multi_v7_defconfig (2015-08-14 16:26:00 +0200)
>>
>> Thanks,
>> Thierry
>>
>> ----------------------------------------------------------------
>> ARM: tegra: Default configuration updates for v4.3-rc1
>>
>> Enable the GK20A GPU (via the Nouveau driver) and CPU frequency scaling
>> on Tegra124.
>>
>> ----------------------------------------------------------------
>> Thierry Reding (1):
>>       ARM: tegra: Update multi_v7_defconfig
> 
> The kernelci.org bot recently reported jetson-tk1 boot failures[1][2]
> in next-20150818, only when booting the mult_v7_defconfig kernels. I
> bisected[3] these boot failure down to this commit, it didn't cleanly
> revert, so I manually removed that options this patch added, and my
> jetson-tk1 booted again. Digging a bit further, if I apply the patch
> below to next-20150818, my jetson-tk1 boots.
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig
> b/arch/arm/configs/multi_v7_defconfig
> index b2facab..a285afe 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -468,7 +468,6 @@ CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
>  CONFIG_SOUND=m
>  CONFIG_SND=m
>  CONFIG_SND_DYNAMIC_MINORS=y
> -CONFIG_SND_HDA_TEGRA=m
>  CONFIG_SND_HDA_INPUT_BEEP=y
>  CONFIG_SND_HDA_PATCH_LOADER=y
>  CONFIG_SND_HDA_CODEC_REALTEK=m
> 
> This isn't where the story ends unfortunately. The collabora lab also
> has a jetson-tk1, booted in the same manner, which boots next-20150818
> fine[4]. The only differences I can spot in the two boot logs is that
> the collabora board is using an older version of u-boot, where as my
> board is using a newer version. U-Boot 2015.01-00231-gab77f24-dirty
> (Good) vs U-Boot 2015.07-00130-gb217c89 (Bad). I've also noticed some
> angry udev messages after the modules probe in userspace present in
> both boot logs that look suspicious.
> 
> [   70.469914] udevd[108]: worker [113] /devices/soc0/70030000.hda is
> taking a long time
> [   70.479849] udevd[108]: worker [115] /devices/soc0/70300000.ahub is
> taking a long time
> [   70.490769] udevd[108]: worker [117] /devices/soc0/sound is taking
> a long time
> 
> FWIW, When I went searching for this patch, I couldn't find it on any
> of the mailing lists. The only reference to this patch was from this
> pull request, thus why I'm reporting the issue here. :)
> 
> Anyways, let me know if you can reproduce this issue, and/or can think
> of a reason this might may be causing trouble.
> 
> Cheers,
> 
> Tyler
> 
> [1] http://kernelci.org/boot/all/job/next/kernel/next-20150818/
> [2] http://storage.kernelci.org/next/next-20150818/arm-multi_v7_defconfig/lab-tbaker/boot-tegra124-jetson-tk1.html
> [3] http://hastebin.com/bixofozaji.vhdl
> [4] http://storage.kernelci.org/next/next-20150818/arm-multi_v7_defconfig/lab-collabora/boot-tegra124-jetson-tk1.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
