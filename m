From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Aug 2015 13:36:26 -0700
Subject: [GIT PULL 9/9] ARM: tegra: Default configuration updates for
 v4.3-rc1
In-Reply-To: <20150819091358.GA26627@ulmo>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
 <1439563720-13189-10-git-send-email-thierry.reding@gmail.com>
 <CANMBJr7PKy-eCcB3HiBajpApHS_BYPa7xfKjTqV4o8Z1hwY99A@mail.gmail.com>
 <20150819091358.GA26627@ulmo>
Message-ID: <CAOesGMh8cRhQ-bdO+1CamurDYtokOhPnZdAQsmh_43_L-44ekg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 2:14 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Aug 18, 2015 at 03:30:41PM -0700, Tyler Baker wrote:
>> Hi Theirry,
>>
>> On 14 August 2015 at 07:48, Thierry Reding <thierry.reding@gmail.com> wrote:
>> > Hi ARM SoC maintainers,
>> >
>> > The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
>> >
>> >   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
>> >
>> > are available in the git repository at:
>> >
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-defconfig
>> >
>> > for you to fetch changes up to 258d9bc5e77fa40e290a0bd480d5349224374480:
>> >
>> >   ARM: tegra: Update multi_v7_defconfig (2015-08-14 16:26:00 +0200)
>> >
>> > Thanks,
>> > Thierry
>> >
>> > ----------------------------------------------------------------
>> > ARM: tegra: Default configuration updates for v4.3-rc1
>> >
>> > Enable the GK20A GPU (via the Nouveau driver) and CPU frequency scaling
>> > on Tegra124.
>> >
>> > ----------------------------------------------------------------
>> > Thierry Reding (1):
>> >       ARM: tegra: Update multi_v7_defconfig
>>
>> The kernelci.org bot recently reported jetson-tk1 boot failures[1][2]
>> in next-20150818, only when booting the mult_v7_defconfig kernels. I
>> bisected[3] these boot failure down to this commit, it didn't cleanly
>> revert, so I manually removed that options this patch added, and my
>> jetson-tk1 booted again. Digging a bit further, if I apply the patch
>> below to next-20150818, my jetson-tk1 boots.
>
> I'm not able to reproduce this here. Building next-20150818 with
> multi_v7_config and booting the resulting kernel works just fine.
>
>> diff --git a/arch/arm/configs/multi_v7_defconfig
>> b/arch/arm/configs/multi_v7_defconfig
>> index b2facab..a285afe 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -468,7 +468,6 @@ CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
>>  CONFIG_SOUND=m
>>  CONFIG_SND=m
>>  CONFIG_SND_DYNAMIC_MINORS=y
>> -CONFIG_SND_HDA_TEGRA=m
>>  CONFIG_SND_HDA_INPUT_BEEP=y
>>  CONFIG_SND_HDA_PATCH_LOADER=y
>>  CONFIG_SND_HDA_CODEC_REALTEK=m
>
> lsmod output confirms that snd-hda-tegra.ko was loaded:
>
>         # lsmod
>         Module                  Size  Used by
>         snd_soc_tegra30_i2s     5591  2
>         snd_soc_tegra_pcm       1184  1 snd_soc_tegra30_i2s
>         snd_hda_tegra           4771  0
>         snd_soc_rt5640         56972  1
>         snd_soc_tegra_rt5640     3960  0
>         snd_hda_codec          76398  1 snd_hda_tegra
>         snd_soc_rl6231          1897  1 snd_soc_rt5640
>         snd_soc_tegra_utils     2825  1 snd_soc_tegra_rt5640
>         snd_hda_core           26151  2 snd_hda_codec,snd_hda_tegra
>         snd_soc_core          119213  4 snd_soc_tegra_pcm,snd_soc_rt5640,snd_soc_tegra_rt5640,snd_soc_tegra30_i2s
>         snd_compress            7114  1 snd_soc_core
>         snd_pcm_dmaengine       2943  1 snd_soc_core
>         snd_pcm                67835  6 snd_soc_rt5640,snd_soc_core,snd_hda_codec,snd_hda_tegra,snd_pcm_dmaengine,snd_hda_core
>         snd_timer              16881  1 snd_pcm
>         snd                    41480  6 snd_soc_core,snd_timer,snd_pcm,snd_hda_codec,snd_hda_tegra,snd_compress
>         soundcore                858  1 snd
>         snd_soc_tegra30_ahub     8747  1 snd_soc_tegra30_i2s
>         nouveau              1217903  0
>         tegra_devfreq           5389  0
>         ttm                    65073  1 nouveau
>
>> This isn't where the story ends unfortunately. The collabora lab also
>> has a jetson-tk1, booted in the same manner, which boots next-20150818
>> fine[4]. The only differences I can spot in the two boot logs is that
>> the collabora board is using an older version of u-boot, where as my
>> board is using a newer version. U-Boot 2015.01-00231-gab77f24-dirty
>> (Good) vs U-Boot 2015.07-00130-gb217c89 (Bad).
>
> I don't have either of those commits in any of the U-Boot trees I have.
> Perhaps whatever tree this comes from has local patches that cause the
> breakage? The version that I use a recent upstream U-Boot with some
> local patches, none of which should impact Jetson TK1 in any way. Just
> to make sure I tried running latest origin/master, which identifies
> thusly:
>
>         U-Boot 2015.10-rc2-00040-g0f9258228e2b
>
> And that boots next-20150818 fine.
>
> If you can point me at the source for the version that you use I may be
> able to find something that could cause this.


FWIW, my jetson has been booting fine as well, with U-Boot
2014.07-rc1-00095-gd7782d0 and Debian userspace.

(Glad to confirm that it's a good thing we've got variety in how
systems are configured and setup so we get more coverage).


-Olof
