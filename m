From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 19 Aug 2015 11:14:00 +0200
Subject: [GIT PULL 9/9] ARM: tegra: Default configuration updates for
 v4.3-rc1
In-Reply-To: <CANMBJr7PKy-eCcB3HiBajpApHS_BYPa7xfKjTqV4o8Z1hwY99A@mail.gmail.com>
References: <1439563720-13189-1-git-send-email-thierry.reding@gmail.com>
 <1439563720-13189-10-git-send-email-thierry.reding@gmail.com>
 <CANMBJr7PKy-eCcB3HiBajpApHS_BYPa7xfKjTqV4o8Z1hwY99A@mail.gmail.com>
Message-ID: <20150819091358.GA26627@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 03:30:41PM -0700, Tyler Baker wrote:
> Hi Theirry,
> 
> On 14 August 2015 at 07:48, Thierry Reding <thierry.reding@gmail.com> wrote:
> > Hi ARM SoC maintainers,
> >
> > The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> >
> >   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.3-defconfig
> >
> > for you to fetch changes up to 258d9bc5e77fa40e290a0bd480d5349224374480:
> >
> >   ARM: tegra: Update multi_v7_defconfig (2015-08-14 16:26:00 +0200)
> >
> > Thanks,
> > Thierry
> >
> > ----------------------------------------------------------------
> > ARM: tegra: Default configuration updates for v4.3-rc1
> >
> > Enable the GK20A GPU (via the Nouveau driver) and CPU frequency scaling
> > on Tegra124.
> >
> > ----------------------------------------------------------------
> > Thierry Reding (1):
> >       ARM: tegra: Update multi_v7_defconfig
> 
> The kernelci.org bot recently reported jetson-tk1 boot failures[1][2]
> in next-20150818, only when booting the mult_v7_defconfig kernels. I
> bisected[3] these boot failure down to this commit, it didn't cleanly
> revert, so I manually removed that options this patch added, and my
> jetson-tk1 booted again. Digging a bit further, if I apply the patch
> below to next-20150818, my jetson-tk1 boots.

I'm not able to reproduce this here. Building next-20150818 with
multi_v7_config and booting the resulting kernel works just fine.

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

lsmod output confirms that snd-hda-tegra.ko was loaded:

	# lsmod
	Module                  Size  Used by
	snd_soc_tegra30_i2s     5591  2 
	snd_soc_tegra_pcm       1184  1 snd_soc_tegra30_i2s
	snd_hda_tegra           4771  0 
	snd_soc_rt5640         56972  1 
	snd_soc_tegra_rt5640     3960  0 
	snd_hda_codec          76398  1 snd_hda_tegra
	snd_soc_rl6231          1897  1 snd_soc_rt5640
	snd_soc_tegra_utils     2825  1 snd_soc_tegra_rt5640
	snd_hda_core           26151  2 snd_hda_codec,snd_hda_tegra
	snd_soc_core          119213  4 snd_soc_tegra_pcm,snd_soc_rt5640,snd_soc_tegra_rt5640,snd_soc_tegra30_i2s
	snd_compress            7114  1 snd_soc_core
	snd_pcm_dmaengine       2943  1 snd_soc_core
	snd_pcm                67835  6 snd_soc_rt5640,snd_soc_core,snd_hda_codec,snd_hda_tegra,snd_pcm_dmaengine,snd_hda_core
	snd_timer              16881  1 snd_pcm
	snd                    41480  6 snd_soc_core,snd_timer,snd_pcm,snd_hda_codec,snd_hda_tegra,snd_compress
	soundcore                858  1 snd
	snd_soc_tegra30_ahub     8747  1 snd_soc_tegra30_i2s
	nouveau              1217903  0 
	tegra_devfreq           5389  0 
	ttm                    65073  1 nouveau

> This isn't where the story ends unfortunately. The collabora lab also
> has a jetson-tk1, booted in the same manner, which boots next-20150818
> fine[4]. The only differences I can spot in the two boot logs is that
> the collabora board is using an older version of u-boot, where as my
> board is using a newer version. U-Boot 2015.01-00231-gab77f24-dirty
> (Good) vs U-Boot 2015.07-00130-gb217c89 (Bad).

I don't have either of those commits in any of the U-Boot trees I have.
Perhaps whatever tree this comes from has local patches that cause the
breakage? The version that I use a recent upstream U-Boot with some
local patches, none of which should impact Jetson TK1 in any way. Just
to make sure I tried running latest origin/master, which identifies
thusly:

	U-Boot 2015.10-rc2-00040-g0f9258228e2b

And that boots next-20150818 fine.

If you can point me at the source for the version that you use I may be
able to find something that could cause this.

>                                                I've also noticed some
> angry udev messages after the modules probe in userspace present in
> both boot logs that look suspicious.
> 
> [   70.469914] udevd[108]: worker [113] /devices/soc0/70030000.hda is
> taking a long time
> [   70.479849] udevd[108]: worker [115] /devices/soc0/70300000.ahub is
> taking a long time
> [   70.490769] udevd[108]: worker [117] /devices/soc0/sound is taking
> a long time

These look suspicious indeed. Unfortunately I don't see those in the
boot log on my setup either. Then again, you seem to be using Eudev
2.1.1, whereas I use the one shipped with systemd 219, so this could
also be some sort of weird userspace issue.

>From the logs it further seems like you've configured the root to be
on NFS, but the logs never show NFS to be mounted. Perhaps that's
because you're booting into a ramdisk rather than a full root file-
system.

> FWIW, When I went searching for this patch, I couldn't find it on any
> of the mailing lists. The only reference to this patch was from this
> pull request, thus why I'm reporting the issue here. :)

That's because it's merely sync'ing up the multi_v7_defconfig changes
with tegra_defconfig that I forgot to submit for v4.2. I didn't think it
necessary to send out a separate patch for that.

> Anyways, let me know if you can reproduce this issue, and/or can think
> of a reason this might may be causing trouble.

Like I said, if you can point me at the U-Boot sources I can take a look
if anything jumps out. I've also noticed that the initial ramdisks in
both boot logs that you linked to have a slightly different size. But
they use the same Eudev version, so I suspect that that's unrelated.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/908f330e/attachment.sig>
