From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Sep 2015 15:57:40 +0200
Subject: [GIT PULL 9/9] ARM: tegra: Default configuration updates for
 v4.3-rc1
In-Reply-To: <55F2D995.50906@nvidia.com>
References: <20150819091358.GA26627@ulmo>
 <1439977724.4135.90.camel@collabora.co.uk>
 <20150819103305.GF26627@ulmo>
 <CANMBJr6DSXW-h8P8__LKBu-Xv77T35JwxHWvarvqy1keVrtVQQ@mail.gmail.com>
 <CAMAWPa_rus4z+Sg3Uff7ndqrpB8dF1c1rQBVQ9r7vXh6PFcVkQ@mail.gmail.com>
 <55F2AF45.5040706@nvidia.com> <20150911123759.GA8473@ulmo>
 <55F2D3D4.5090608@nvidia.com> <20150911132113.GA21673@ulmo>
 <55F2D995.50906@nvidia.com>
Message-ID: <20150911135738.GA23109@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 02:39:33PM +0100, Jon Hunter wrote:
> 
> On 11/09/15 14:21, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> > 
> > On Fri, Sep 11, 2015 at 02:15:00PM +0100, Jon Hunter wrote:
> >>
> >> On 11/09/15 13:38, Thierry Reding wrote:
> >>>> Old Signed by an unknown key
> >>>
> >>> On Fri, Sep 11, 2015 at 11:39:01AM +0100, Jon Hunter wrote:
> >>>> Hi Kevin,
> >>>>
> >>>> On 10/09/15 22:29, Kevin Hilman wrote:
> >>>>
> >>>> [snip]
> >>>>
> >>>>> Since there is no movement on this, and jetson hasn't been boot for
> >>>>> multi_v7_defconfig for a while[1], I think it's time to undo the
> >>>>> option causing this problem[2] so that v4.3 will actually boot on the
> >>>>> jetson.
> >>>>>
> >>>>> Unless I hear a good reason otherwise, I'll be posting a patch to
> >>>>> disable the HDA related options in multi_v7_defconfig.
> >>>>
> >>>> So curiosity got the better of this cat, as to why we are not seeing
> >>>> this ;-)
> >>>>
> >>>> The main difference I see between the tegra_defconfig and 
> >>>> multi_v7_defconfig is all the sound drivers are modules (including 
> >>>> this one).
> >>>>
> >>>> So trying a quick modprobe of the hda-tegra driver I do see it hang ...
> >>>>
> >>>> / # modprobe snd-hda-tegra
> >>>> [  625.213864] snd_hda_tegra: Unknown symbol azx_probe_codecs (err 0)
> >>>> [  625.220215] snd_hda_tegra: Unknown symbol azx_init_streams (err 0)
> >>>> [  625.226480] snd_hda_tegra: Unknown symbol azx_stop_all_streams (err 0)
> >>>> [  625.233168] snd_hda_tegra: Unknown symbol azx_bus_init (err 0)
> >>>> [  625.239062] snd_hda_tegra: Unknown symbol azx_free_streams (err 0)
> >>>> [  625.245314] snd_hda_tegra: Unknown symbol azx_init_chip (err 0)
> >>>> [  625.251321] snd_hda_tegra: Unknown symbol snd_hda_set_power_save (err 0)
> >>>> [  625.258081] snd_hda_tegra: Unknown symbol azx_stop_chip (err 0)
> >>>> [  625.264078] snd_hda_tegra: Unknown symbol azx_codec_configure (err 0)
> >>>> [  625.270607] snd_hda_tegra: Unknown symbol azx_interrupt (err 0)
> >>>> [  840.117528] INFO: task modprobe:137 blocked for more than 120 seconds.
> >>>> [  840.124192]       Not tainted 4.2.0-next-20150909-40826-gb799053 #1
> >>>> [  840.130584] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >>>> [  840.138540] modprobe        D c09ac3a4     0   137     82 0x00000000
> >>>> [  840.145123] [<c09ac3a4>] (__schedule) from [<c09ac838>] (schedule+0x34/0x98)
> >>>> [  840.152310] [<c09ac838>] (schedule) from [<c09acaac>] (schedule_preempt_disabled+0xc/0x10)
> >>>> [  840.160734] [<c09acaac>] (schedule_preempt_disabled) from [<c09adeec>] (__mutex_lock_slowpath+0x9c/0x150)
> >>>> [  840.170458] [<c09adeec>] (__mutex_lock_slowpath) from [<c09adfec>] (mutex_lock+0x4c/0x50)
> >>>> [  840.178807] [<c09adfec>] (mutex_lock) from [<c062999c>] (__driver_attach+0x44/0x90)
> >>>> [  840.186627] [<c062999c>] (__driver_attach) from [<c0627fcc>] (bus_for_each_dev+0x54/0x88)
> >>>> [  840.194966] [<c0627fcc>] (bus_for_each_dev) from [<c0628f88>] (bus_add_driver+0xe4/0x1f0)
> >>>> [  840.203305] [<c0628f88>] (bus_add_driver) from [<c062a1d0>] (driver_register+0x78/0xf4)
> >>>> [  840.211475] [<c062a1d0>] (driver_register) from [<c020ac04>] (do_one_initcall+0x80/0x1d0)
> >>>> [  840.219818] [<c020ac04>] (do_one_initcall) from [<c02c8abc>] (do_init_module+0x58/0x354)
> >>>> [  840.228081] [<c02c8abc>] (do_init_module) from [<c02afae8>] (load_module+0x17e0/0x1d8c)
> >>>> [  840.236258] [<c02afae8>] (load_module) from [<c02b016c>] (SyS_init_module+0xd8/0x138)
> >>>> [  840.244260] [<c02b016c>] (SyS_init_module) from [<c0210b00>] (ret_fast_syscall+0x0/0x3c)
> >>>>
> >>>> Adding some debug it appears to hang on snd-hda-codec-hdmi  (the following show
> >>>> the order in which modules are being loaded) ...
> >>>>
> >>>> / # modprobe snd-hda-tegra
> >>>> [   22.450276] snd_hda_tegra: err = -2
> >>>> [   22.484535] soundcore: err = 0
> >>>> [   22.488964] snd: err = 0
> >>>> [   22.493242] snd_timer: err = 0
> >>>> [   22.498380] snd_pcm: err = 0
> >>>> [   22.502479] snd_hda_core: err = 0
> >>>> [   22.508337] snd_hda_codec: err = 0
> >>>> [   22.513386] snd_hda_tegra: err = 0
> >>>> [   22.740216] snd_hda_codec_hdmi: err = 0
> >>>>
> >>>> [hangs here]
> >>>>
> >>>> However, if I do the following, this works ...
> >>>>
> >>>> / # modprobe snd-hda-codec-hdmi
> >>>> / # modprobe snd-hda-tegra
> >>>>
> >>>> So it implies that snd-hda-codec-hdmi needs to be loaded first otherwise it hangs.
> >>>>
> >>>> Thierry, any thoughts?
> >>>
> >>> I can't reproduce this. Booting multi_v7_defconfig on my setup works
> >>> just fine. I don't ever see snd-hda-codec-hdmi being probed, but then
> >>> probing it manually works fine. No hangs.
> >>
> >> To be clear, booting multi_v7_defconfig works just fine for me too and
> >> has been working fine for months. However, the reason I am not seeing
> >> the issue Kevin and Tyler are reporting is because I never attempt to
> >> "modprobe snd-hda-tegra" after boot. If I do then I see a hang. So I
> >> believe the only reason we don't see this is because their setup is
> >> loading modules.
> > 
> > snd-hda-tegra is auto-loaded on boot for me as well and I don't see any
> > hangs either. I can also unload and reload the module just fine. I've
> > tested this on next-20150911.
> 
> What else are you auto-loading? For my testing there appears to be a
> sensitivity to order outside of the depmod order.
> 
> Can you try unloading all the sound modules and then do a "modprobe
> snd-hda-tegra"?

Here's the list of loaded modules right after boot:

	-sh-4.3# lsmod
	Module                  Size  Used by
	snd_hda_tegra           4764  0 
	snd_hda_codec_hdmi     35010  1 
	snd_soc_tegra30_i2s     5380  2 
	snd_soc_tegra_pcm       1184  1 snd_soc_tegra30_i2s
	snd_soc_tegra_rt5640     3960  0 
	snd_soc_rt5640         56972  1 
	snd_soc_tegra_utils     2825  1 snd_soc_tegra_rt5640
	snd_soc_rl6231          1897  1 snd_soc_rt5640
	snd_soc_core          107271  4
	snd_soc_tegra_pcm,snd_soc_rt5640,snd_soc_tegra_rt5640,snd_soc_tegra30_i2s
	snd_hda_codec          75955  2 snd_hda_codec_hdmi,snd_hda_tegra
	snd_compress            7363  1 snd_soc_core
	snd_hda_core           26603  3
	snd_hda_codec_hdmi,snd_hda_codec,snd_hda_tegra
	snd_pcm_dmaengine       2943  1 snd_soc_core
	snd_pcm                69108  7
	snd_soc_rt5640,snd_soc_core,snd_hda_codec_hdmi,snd_hda_codec,snd_hda_tegra,snd_pcm_dmaengine,snd_hda_core
	snd_timer              17264  1 snd_pcm
	snd_soc_tegra30_ahub     8299  1 snd_soc_tegra30_i2s
	snd                    42248  7
	snd_soc_core,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_hda_codec,snd_hda_tegra,snd_compress
	nouveau              1302185  0 
	soundcore                858  1 snd
	tegra_devfreq           5375  0 
	ttm                    65238  1 nouveau

Then I went and unloaded a couple of modules until I was left with this:

	-sh-4.3# lsmod
	Module                  Size  Used by
	nouveau              1302185  0 
	tegra_devfreq           5375  0 
	ttm                    65238  1 nouveau

Then I did the following:

	-sh-4.3# modprobe snd-hda-tegra
	[ 2243.786143] hdaudio hdaudioC0D3: Unable to bind the codec
	-sh-4.3# lsmod
	Module                  Size  Used by
	snd_hda_tegra           4764  0 
	snd_hda_codec          75955  1 snd_hda_tegra
	snd_hda_core           26603  2 snd_hda_codec,snd_hda_tegra
	snd_pcm                69108  3 snd_hda_codec,snd_hda_tegra,snd_hda_core
	snd_timer              17264  1 snd_pcm
	snd                    42248  4 snd_timer,snd_pcm,snd_hda_codec,snd_hda_tegra
	soundcore                858  1 snd
	nouveau              1302185  0 
	tegra_devfreq           5375  0 
	ttm                    65238  1 nouveau
	-sh-4.3# modprobe snd-hda-codec-hdmi
	-sh-4.3# modprobe -r snd-hda-tegra
	-sh-4.3# modprobe snd-hda-tegra
	[ 2263.934328] input: tegra-hda HDMI/DP,pcm=3 as /devices/soc0/70030000.hda/sound/card0/input4

So all worked just fine.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/04b503b1/attachment.sig>
