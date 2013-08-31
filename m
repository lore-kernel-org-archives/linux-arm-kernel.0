From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Aug 2013 20:34:31 +0100
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130831191414.GG6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831191414.GG6617@n2100.arm.linux.org.uk>
Message-ID: <20130831193431.GI6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 08:14:14PM +0100, Russell King - ARM Linux wrote:
> On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:
> > On 08/31/2013 02:34 PM, Russell King - ARM Linux wrote:
> > [...]
> > > The same conditions apply as per my previous posting - the DAI link
> > > needs to be setup and the associated DAPM routes to tell the CPU DAI
> > > which outputs are in use, like this:
> > > 
> > > DAI link:
> > >                 .name = "S/PDIF1",
> > >                 .stream_name = "IEC958 Playback",
> > >                 .platform_name = "mvebu-audio.1",
> > >                 .cpu_dai_name = "mvebu-audio.1",
> > >                 .codec_dai_name = "dit-hifi",
> > >                 .codec_name = "spdif-dit",
> > > 
> > > static const struct snd_soc_dapm_route routes[] = {
> > >         { "Playback", NULL, "spdifdo" },
> > > };
> > 
> > This is still not exactly the right way to implement this though. Add a
> > second DAI to your CPU driver, like this:
> 
> What you're suggesting is the DPCM solution.
> 
> That would be fine _if_ it works, which it doesn't.  Not only does it
> cause the kernel to spit out various warnings (caused by the creation
> of multiple procfs files with the same name) but it also causes a kernel
> oops when VLC tries to use it (due to NULL ops in the ALSA PCM.)

Here's the warning I get - I've left the syslog stamp in these as
evidence for how long this has been known - and I reported these to
Mark when I found them:

Aug 10 15:17:18 cubox kernel: WARNING: at /home/rmk/git/linux-cubox/fs/proc/generic.c:356 proc_register+0xac/0x128()
Aug 10 15:17:18 cubox kernel: proc_dir_entry 'asound/oss' already registered
Aug 10 15:17:18 cubox kernel: Modules linked in: snd_soc_spdif_tx m25p80 orion_wdt mtd snd_soc_kirkwood snd_soc_kirkwood_spdif
Aug 10 15:17:18 cubox kernel: CPU: 0 PID: 388 Comm: kworker/u2:2 Not tainted 3.10.0+ #645
Aug 10 15:17:18 cubox kernel: Workqueue: deferwq deferred_probe_work_func
Aug 10 15:17:18 cubox kernel: [<c0013d7c>] (unwind_backtrace+0x0/0xf8) from [<c0011bec>] (show_stack+0x10/0x14)
Aug 10 15:17:18 cubox kernel: [<c0011bec>] (show_stack+0x10/0x14) from [<c0048b80>] (warn_slowpath_common+0x4c/0x68)
Aug 10 15:17:18 cubox kernel: [<c0048b80>] (warn_slowpath_common+0x4c/0x68) from [<c0048c30>] (warn_slowpath_fmt+0x30/0x40)
Aug 10 15:17:18 cubox kernel: [<c0048c30>] (warn_slowpath_fmt+0x30/0x40) from [<c0124804>] (proc_register+0xac/0x128)
Aug 10 15:17:18 cubox kernel: [<c0124804>] (proc_register+0xac/0x128) from [<c0124910>] (proc_create_data+0x90/0xac)
Aug 10 15:17:18 cubox kernel: [<c0124910>] (proc_create_data+0x90/0xac) from [<c0302b48>] (snd_info_register+0x54/0xf0)
Aug 10 15:17:18 cubox kernel: [<c0302b48>] (snd_info_register+0x54/0xf0) from [<c03190e8>] (snd_pcm_oss_register_minor+0xcc/0x1cc)
Aug 10 15:17:18 cubox kernel: [<c03190e8>] (snd_pcm_oss_register_minor+0xcc/0x1cc) from [<c030bdec>] (snd_pcm_dev_register+0x1ac/0x290)
Aug 10 15:17:18 cubox kernel: [<c030bdec>] (snd_pcm_dev_register+0x1ac/0x290) from [<c03069c8>] (snd_device_register_all+0x40/0x80)
Aug 10 15:17:18 cubox kernel: [<c03069c8>] (snd_device_register_all+0x40/0x80) from [<c030192c>] (snd_card_register+0x24/0x228)
Aug 10 15:17:18 cubox kernel: [<c030192c>] (snd_card_register+0x24/0x228) from [<c03252a4>] (snd_soc_instantiate_card+0x7b4/0x868)
Aug 10 15:17:18 cubox kernel: [<c03252a4>] (snd_soc_instantiate_card+0x7b4/0x868) from [<c03255c4>] (snd_soc_register_card+0x26c/0x324)
Aug 10 15:17:18 cubox kernel: [<c03255c4>] (snd_soc_register_card+0x26c/0x324) from [<bf00c0b4>] (kirkwood_spdif_probe+0x88/0xd8 [snd_soc_kirkwood_spdif])
Aug 10 15:17:18 cubox kernel: [<bf00c0b4>] (kirkwood_spdif_probe+0x88/0xd8 [snd_soc_kirkwood_spdif]) from [<c0259468>] (platform_drv_probe+0x18/0x1c)
Aug 10 15:17:18 cubox kernel: [<c0259468>] (platform_drv_probe+0x18/0x1c) from [<c0258144>] (really_probe+0x74/0x1f4)
Aug 10 15:17:18 cubox kernel: [<c0258144>] (really_probe+0x74/0x1f4) from [<c02583d8>] (driver_probe_device+0x30/0x48)
Aug 10 15:17:18 cubox kernel: [<c02583d8>] (driver_probe_device+0x30/0x48) from [<c0256a48>] (bus_for_each_drv+0x60/0x8c)
Aug 10 15:17:18 cubox kernel: [<c0256a48>] (bus_for_each_drv+0x60/0x8c) from [<c0258368>] (device_attach+0x80/0xa4)
Aug 10 15:17:18 cubox kernel: [<c0258368>] (device_attach+0x80/0xa4) from [<c02577a8>] (bus_probe_device+0x88/0xac)
Aug 10 15:17:18 cubox kernel: [<c02577a8>] (bus_probe_device+0x88/0xac) from [<c0257c34>] (deferred_probe_work_func+0x6c/0x9c)
Aug 10 15:17:18 cubox kernel: [<c0257c34>] (deferred_probe_work_func+0x6c/0x9c) from [<c0060a74>] (process_one_work+0x190/0x3f4)
Aug 10 15:17:18 cubox kernel: [<c0060a74>] (process_one_work+0x190/0x3f4) from [<c0062544>] (worker_thread+0xf4/0x318)
Aug 10 15:17:18 cubox kernel: [<c0062544>] (worker_thread+0xf4/0x318) from [<c006800c>] (kthread+0xa8/0xb4)
Aug 10 15:17:18 cubox kernel: [<c006800c>] (kthread+0xa8/0xb4) from [<c000e4a8>] (ret_from_fork+0x14/0x2c)
Aug 10 15:17:18 cubox kernel: ---[ end trace 174d2956b4f53cd5 ]---
Aug 10 15:17:18 cubox kernel: ------------[ cut here ]------------
Aug 10 15:17:18 cubox kernel: WARNING: at /home/rmk/git/linux-cubox/fs/proc/generic.c:356 proc_register+0xac/0x128()
Aug 10 15:17:18 cubox kernel: proc_dir_entry 'asound/oss' already registered
Aug 10 15:17:18 cubox kernel: Modules linked in: snd_soc_spdif_tx m25p80 orion_wdt mtd snd_soc_kirkwood snd_soc_kirkwood_spdif
Aug 10 15:17:18 cubox kernel: CPU: 0 PID: 388 Comm: kworker/u2:2 Tainted: G   W    3.10.0+ #645
Aug 10 15:17:18 cubox kernel: Workqueue: deferwq deferred_probe_work_func
Aug 10 15:17:18 cubox kernel: [<c0013d7c>] (unwind_backtrace+0x0/0xf8) from [<c0011bec>] (show_stack+0x10/0x14)
Aug 10 15:17:18 cubox kernel: [<c0011bec>] (show_stack+0x10/0x14) from [<c0048b80>] (warn_slowpath_common+0x4c/0x68)
Aug 10 15:17:18 cubox kernel: [<c0048b80>] (warn_slowpath_common+0x4c/0x68) from [<c0048c30>] (warn_slowpath_fmt+0x30/0x40)
Aug 10 15:17:18 cubox kernel: [<c0048c30>] (warn_slowpath_fmt+0x30/0x40) from [<c0124804>] (proc_register+0xac/0x128)
Aug 10 15:17:18 cubox kernel: [<c0124804>] (proc_register+0xac/0x128) from [<c0124910>] (proc_create_data+0x90/0xac)
Aug 10 15:17:18 cubox kernel: [<c0124910>] (proc_create_data+0x90/0xac) from [<c0302b48>] (snd_info_register+0x54/0xf0)
Aug 10 15:17:18 cubox kernel: [<c0302b48>] (snd_info_register+0x54/0xf0) from [<c03190e8>] (snd_pcm_oss_register_minor+0xcc/0x1cc)
Aug 10 15:17:18 cubox kernel: [<c03190e8>] (snd_pcm_oss_register_minor+0xcc/0x1cc) from [<c030bdec>] (snd_pcm_dev_register+0x1ac/0x290)
Aug 10 15:17:18 cubox kernel: [<c030bdec>] (snd_pcm_dev_register+0x1ac/0x290) from [<c03069c8>] (snd_device_register_all+0x40/0x80)
Aug 10 15:17:18 cubox kernel: [<c03069c8>] (snd_device_register_all+0x40/0x80) from [<c030192c>] (snd_card_register+0x24/0x228)
Aug 10 15:17:18 cubox kernel: [<c030192c>] (snd_card_register+0x24/0x228) from [<c03252a4>] (snd_soc_instantiate_card+0x7b4/0x868)
Aug 10 15:17:18 cubox kernel: [<c03252a4>] (snd_soc_instantiate_card+0x7b4/0x868) from [<c03255c4>] (snd_soc_register_card+0x26c/0x324)
Aug 10 15:17:18 cubox kernel: [<c03255c4>] (snd_soc_register_card+0x26c/0x324) from [<bf00c0b4>] (kirkwood_spdif_probe+0x88/0xd8 [snd_soc_kirkwood_spdif])
Aug 10 15:17:18 cubox kernel: [<bf00c0b4>] (kirkwood_spdif_probe+0x88/0xd8 [snd_soc_kirkwood_spdif]) from [<c0259468>] (platform_drv_probe+0x18/0x1c)
Aug 10 15:17:18 cubox kernel: [<c0259468>] (platform_drv_probe+0x18/0x1c) from [<c0258144>] (really_probe+0x74/0x1f4)
Aug 10 15:17:18 cubox kernel: [<c0258144>] (really_probe+0x74/0x1f4) from [<c02583d8>] (driver_probe_device+0x30/0x48)
Aug 10 15:17:18 cubox kernel: [<c02583d8>] (driver_probe_device+0x30/0x48) from [<c0256a48>] (bus_for_each_drv+0x60/0x8c)
Aug 10 15:17:18 cubox kernel: [<c0256a48>] (bus_for_each_drv+0x60/0x8c) from [<c0258368>] (device_attach+0x80/0xa4)
Aug 10 15:17:18 cubox kernel: [<c0258368>] (device_attach+0x80/0xa4) from [<c02577a8>] (bus_probe_device+0x88/0xac)
Aug 10 15:17:18 cubox kernel: [<c02577a8>] (bus_probe_device+0x88/0xac) from [<c0257c34>] (deferred_probe_work_func+0x6c/0x9c)
Aug 10 15:17:18 cubox kernel: [<c0257c34>] (deferred_probe_work_func+0x6c/0x9c) from [<c0060a74>] (process_one_work+0x190/0x3f4)
Aug 10 15:17:18 cubox kernel: [<c0060a74>] (process_one_work+0x190/0x3f4) from [<c0062544>] (worker_thread+0xf4/0x318)
Aug 10 15:17:18 cubox kernel: [<c0062544>] (worker_thread+0xf4/0x318) from [<c006800c>] (kthread+0xa8/0xb4)
Aug 10 15:17:18 cubox kernel: [<c006800c>] (kthread+0xa8/0xb4) from [<c000e4a8>] (ret_from_fork+0x14/0x2c)

I also get a load of these:

Aug 10 16:09:27 cubox kernel: S!PDIF1: ASoC: no backend DAIs enabled for S/PDIF1

from time to time as there's no way to tell ASoC in a DPCM confirmation
that although the CPU DAI has capture capability, the capture side is
not connected to any codec.

And here's the oops:

Aug 10 22:06:17 cubox kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
Aug 10 22:06:17 cubox kernel: pgd = d2450000
Aug 10 22:06:17 cubox kernel: [00000008] *pgd=12285831, *pte=00000000, *ppte=00000000
Aug 10 22:06:17 cubox kernel: Internal error: Oops: 17 [#1] PREEMPT ARM
Aug 10 22:06:17 cubox kernel: Modules linked in: fuse bnep rfcomm bluetooth ext2 ext3 jbd snd_soc_spdif_tx m25p80 orion_wdt mtd snd_soc_kirkwood snd_soc_kirkwood_spdif
Aug 10 22:06:17 cubox kernel: CPU: 0 PID: 2514 Comm: vlc Not tainted 3.10.0+ #652
Aug 10 22:06:17 cubox kernel: task: d8102800 ti: d38fa000 task.ti: d38fa000
Aug 10 22:06:17 cubox kernel: PC is at snd_pcm_info+0xc8/0xd8
Aug 10 22:06:17 cubox kernel: LR is at 0x30232065
Aug 10 22:06:17 cubox kernel: pc : [<c030f724>]    lr : [<30232065>]    psr: a00f0013
Aug 10 22:06:17 cubox kernel: sp : d38fbea8  ip : d8c2ead0  fp : c05de6d8
Aug 10 22:06:17 cubox kernel: r10: c05de7d0  r9 : fffffdfd  r8 : 00000000
Aug 10 22:06:17 cubox kernel: r7 : d8c268a8  r6 : d8c26800  r5 : d8c26c00  r4 : d8c2ea00
Aug 10 22:06:17 cubox kernel: r3 : 00000000  r2 : d8c2ea00  r1 : 00000001  r0 : d8c26c00
Aug 10 22:06:17 cubox kernel: Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Aug 10 22:06:17 cubox kernel: Control: 10c5387d  Table: 12450019  DAC: 00000015
Aug 10 22:06:17 cubox kernel: Process vlc (pid: 2514, stack limit = 0xd38fa248)
Aug 10 22:06:17 cubox kernel: Stack: (0xd38fbea8 to 0xd38fc000)
Aug 10 22:06:17 cubox kernel: bea0:                   c0af7144 d8c2ea00 d8c26c00 ab5032b8 00000001 c030f768
Aug 10 22:06:17 cubox kernel: bec0: 00000000 d8c20000 ab5032b8 c030a67c 0000001b d116b840 d8380330 c1205531
Aug 10 22:06:17 cubox kernel: bee0: 0000001b d116b840 d8263fc0 d8c20000 ab5032b8 c03056b0 00000001 c05e6e80
Aug 10 22:06:17 cubox kernel: bf00: c05e6e88 c05be828 00020120 00000000 d38fa000 600f0013 00000001 0000001b
Aug 10 22:06:17 cubox kernel: bf20: d38fa000 00020000 ab5032b8 c0088fec 00000001 00000000 d38fa000 00000000
Aug 10 22:06:17 cubox kernel: bf40: 600f0013 ca17c380 0000001b ab5032b8 d8380330 0000001b d38fa000 00020000
Aug 10 22:06:17 cubox kernel: bf60: ab5032b8 c00e50bc c00edecc 00020000 ab5032b8 00000001 ca17c380 ab5032b8
Aug 10 22:06:17 cubox kernel: bf80: c1205531 c00e5394 ab50366c 00000001 00000000 000120b0 ab50366c 00000036
Aug 10 22:06:17 cubox kernel: bfa0: c000e5a8 c000e3e0 00000000 000120b0 0000001b c1205531 ab5032b8 a91a3e10
Aug 10 22:06:17 cubox kernel: bfc0: 00000000 000120b0 ab50366c 00000036 ab503454 00000001 00000000 ab5032b8
Aug 10 22:06:17 cubox kernel: [<c030f724>] (snd_pcm_info+0xc8/0xd8) from [<c030f768>] (snd_pcm_info_user+0x34/0x9c)
Aug 10 22:06:17 cubox kernel: [<c030f768>] (snd_pcm_info_user+0x34/0x9c) from [<c030a67c>] (snd_pcm_control_ioctl+0x274/0x280)
Aug 10 22:06:17 cubox kernel: [<c030a67c>] (snd_pcm_control_ioctl+0x274/0x280) from [<c03056b0>] (snd_ctl_ioctl+0xc0/0x55c)
Aug 10 22:06:17 cubox kernel: [<c03056b0>] (snd_ctl_ioctl+0xc0/0x55c) from [<c00e50bc>] (do_vfs_ioctl+0x80/0x31c)
Aug 10 22:06:17 cubox kernel: [<c00e50bc>] (do_vfs_ioctl+0x80/0x31c) from [<c00e5394>] (SyS_ioctl+0x3c/0x60)
Aug 10 22:06:17 cubox kernel: [<c00e5394>] (SyS_ioctl+0x3c/0x60) from [<c000e3e0>] (ret_fast_syscall+0x0/0x48)
Aug 10 22:06:17 cubox kernel: Code: e1a00005 e59530dc e3a01001 e1a02004 (e5933008)

This is caused because substream->ops is NULL.  Why that's the case,
I don't know, but I believe the PCM which is trying to be operated on
is the one registered against the backend (by snd_pcm_new_internal).

This is why I'm soo frustrated with Mark: Mark just churns the same
old useless statements out without _listening_ to anything I've said
or providing anything useful to help with the problems I find.
