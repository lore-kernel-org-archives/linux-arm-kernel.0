From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Sep 2015 15:25:27 +0200
Subject: [GIT PULL 9/9] ARM: tegra: Default configuration updates for
 v4.3-rc1
In-Reply-To: <55F2D2E3.4010906@nvidia.com>
References: <1439563720-13189-10-git-send-email-thierry.reding@gmail.com>
 <CANMBJr7PKy-eCcB3HiBajpApHS_BYPa7xfKjTqV4o8Z1hwY99A@mail.gmail.com>
 <20150819091358.GA26627@ulmo>
 <1439977724.4135.90.camel@collabora.co.uk>
 <20150819103305.GF26627@ulmo>
 <CANMBJr6DSXW-h8P8__LKBu-Xv77T35JwxHWvarvqy1keVrtVQQ@mail.gmail.com>
 <CAMAWPa_rus4z+Sg3Uff7ndqrpB8dF1c1rQBVQ9r7vXh6PFcVkQ@mail.gmail.com>
 <55F2AF45.5040706@nvidia.com> <20150911123759.GA8473@ulmo>
 <55F2D2E3.4010906@nvidia.com>
Message-ID: <20150911132526.GB21673@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 02:10:59PM +0100, Jon Hunter wrote:
> 
> On 11/09/15 13:38, Thierry Reding wrote:
> > * PGP Signed by an unknown key
> > 
> > On Fri, Sep 11, 2015 at 11:39:01AM +0100, Jon Hunter wrote:
> >> Hi Kevin,
> >>
> >> On 10/09/15 22:29, Kevin Hilman wrote:
> >>
> >> [snip]
> >>
> >>> Since there is no movement on this, and jetson hasn't been boot for
> >>> multi_v7_defconfig for a while[1], I think it's time to undo the
> >>> option causing this problem[2] so that v4.3 will actually boot on the
> >>> jetson.
> >>>
> >>> Unless I hear a good reason otherwise, I'll be posting a patch to
> >>> disable the HDA related options in multi_v7_defconfig.
> >>
> >> So curiosity got the better of this cat, as to why we are not seeing
> >> this ;-)
> >>
> >> The main difference I see between the tegra_defconfig and 
> >> multi_v7_defconfig is all the sound drivers are modules (including 
> >> this one).
> >>
> >> So trying a quick modprobe of the hda-tegra driver I do see it hang ...
> >>
> >> / # modprobe snd-hda-tegra
> >> [  625.213864] snd_hda_tegra: Unknown symbol azx_probe_codecs (err 0)
> >> [  625.220215] snd_hda_tegra: Unknown symbol azx_init_streams (err 0)
> >> [  625.226480] snd_hda_tegra: Unknown symbol azx_stop_all_streams (err 0)
> >> [  625.233168] snd_hda_tegra: Unknown symbol azx_bus_init (err 0)
> >> [  625.239062] snd_hda_tegra: Unknown symbol azx_free_streams (err 0)
> >> [  625.245314] snd_hda_tegra: Unknown symbol azx_init_chip (err 0)
> >> [  625.251321] snd_hda_tegra: Unknown symbol snd_hda_set_power_save (err 0)
> >> [  625.258081] snd_hda_tegra: Unknown symbol azx_stop_chip (err 0)
> >> [  625.264078] snd_hda_tegra: Unknown symbol azx_codec_configure (err 0)
> >> [  625.270607] snd_hda_tegra: Unknown symbol azx_interrupt (err 0)
> >> [  840.117528] INFO: task modprobe:137 blocked for more than 120 seconds.
> >> [  840.124192]       Not tainted 4.2.0-next-20150909-40826-gb799053 #1
> >> [  840.130584] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> >> [  840.138540] modprobe        D c09ac3a4     0   137     82 0x00000000
> >> [  840.145123] [<c09ac3a4>] (__schedule) from [<c09ac838>] (schedule+0x34/0x98)
> >> [  840.152310] [<c09ac838>] (schedule) from [<c09acaac>] (schedule_preempt_disabled+0xc/0x10)
> >> [  840.160734] [<c09acaac>] (schedule_preempt_disabled) from [<c09adeec>] (__mutex_lock_slowpath+0x9c/0x150)
> >> [  840.170458] [<c09adeec>] (__mutex_lock_slowpath) from [<c09adfec>] (mutex_lock+0x4c/0x50)
> >> [  840.178807] [<c09adfec>] (mutex_lock) from [<c062999c>] (__driver_attach+0x44/0x90)
> >> [  840.186627] [<c062999c>] (__driver_attach) from [<c0627fcc>] (bus_for_each_dev+0x54/0x88)
> >> [  840.194966] [<c0627fcc>] (bus_for_each_dev) from [<c0628f88>] (bus_add_driver+0xe4/0x1f0)
> >> [  840.203305] [<c0628f88>] (bus_add_driver) from [<c062a1d0>] (driver_register+0x78/0xf4)
> >> [  840.211475] [<c062a1d0>] (driver_register) from [<c020ac04>] (do_one_initcall+0x80/0x1d0)
> >> [  840.219818] [<c020ac04>] (do_one_initcall) from [<c02c8abc>] (do_init_module+0x58/0x354)
> >> [  840.228081] [<c02c8abc>] (do_init_module) from [<c02afae8>] (load_module+0x17e0/0x1d8c)
> >> [  840.236258] [<c02afae8>] (load_module) from [<c02b016c>] (SyS_init_module+0xd8/0x138)
> >> [  840.244260] [<c02b016c>] (SyS_init_module) from [<c0210b00>] (ret_fast_syscall+0x0/0x3c)
> >>
> >> Adding some debug it appears to hang on snd-hda-codec-hdmi  (the following show
> >> the order in which modules are being loaded) ...
> >>
> >> / # modprobe snd-hda-tegra
> >> [   22.450276] snd_hda_tegra: err = -2
> >> [   22.484535] soundcore: err = 0
> >> [   22.488964] snd: err = 0
> >> [   22.493242] snd_timer: err = 0
> >> [   22.498380] snd_pcm: err = 0
> >> [   22.502479] snd_hda_core: err = 0
> >> [   22.508337] snd_hda_codec: err = 0
> >> [   22.513386] snd_hda_tegra: err = 0
> >> [   22.740216] snd_hda_codec_hdmi: err = 0
> >>
> >> [hangs here]
> >>
> >> However, if I do the following, this works ...
> >>
> >> / # modprobe snd-hda-codec-hdmi
> >> / # modprobe snd-hda-tegra
> >>
> >> So it implies that snd-hda-codec-hdmi needs to be loaded first otherwise it hangs.
> >>
> >> Thierry, any thoughts?
> > 
> > I can't reproduce this. Booting multi_v7_defconfig on my setup works
> > just fine. I don't ever see snd-hda-codec-hdmi being probed, but then
> > probing it manually works fine. No hangs.
> 
> Did you try "modprobe snd-hda-tegra"? Fails for me 100% of the time.

Works for me 100% of the time. Unloading and reloading isn't a problem
either. What revision of the Jetson TK1 do you have? Mine is a C.2

> > What I do see is that after a little while network stops working. I
> > noticed primarily because I boot with an NFS root, so the kernel started
> > complaining about the NFS server not responding. Being on an NFS root
> > could be one reason why this works for me, not sure what the kernelci
> > labs are running. I don't see the network issues with tegra_defconfig.
> > I've also tried a tegra_defconfig with all of sound support built as
> > modules and that all works perfectly.
> > 
> > I'll investigate the multi_v7_defconfig network issues, perhaps that'll
> > give me some clues, or perhaps even allow me to reproduce the original
> > issue.
> 
> Well I am not using any networking and booting with a simple ramdisk so
> I don't think that is the right place to look.

Looks like this might have been a transient issue with my networking
setup. I can no longer reproduce the NFS hangs.

What sort of ramdisk do you use? Can you share the instructions you use
to create it? Perhaps I can reproduce that way.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/59a83fc8/attachment.sig>
