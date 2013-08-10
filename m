From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Aug 2013 22:13:42 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <20130810161123.GW23006@n2100.arm.linux.org.uk>
References: <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
 <20130805112733.GY9858@sirena.org.uk>
 <20130805113310.GU23006@n2100.arm.linux.org.uk>
 <20130805144054.GE9858@sirena.org.uk>
 <20130805145644.GV23006@n2100.arm.linux.org.uk>
 <20130805203202.GX23006@n2100.arm.linux.org.uk>
 <20130805220639.GB26637@sirena.org.uk>
 <20130805233015.GY23006@n2100.arm.linux.org.uk>
 <20130806133206.GA6427@sirena.org.uk>
 <20130810161123.GW23006@n2100.arm.linux.org.uk>
Message-ID: <20130810211342.GX23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 05:11:23PM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 06, 2013 at 02:32:06PM +0100, Mark Brown wrote:
> > On Tue, Aug 06, 2013 at 12:30:15AM +0100, Russell King - ARM Linux wrote:
> > 
> > > I put it to you that DPCM in mainline is incomplete and nonfunctional
> > > as it currently stands.  Moreover, it requires either those who know
> > > that code to continue to develop it, or someone else who understands
> > > the direction that this code is supposed to go picks up to complete it.
> > 
> > I'd be most distressed if it were far off working; it's close enough to
> > the out of tree code I've worked with and I know there were drivers in
> > progress when it was submitted.  We've certainly had at least one bug
> > fix from the out of tree users, I'd be surprised if we had anything more
> > substantial than bitrot in the current code.
> 
> Right, so, I've looked at this again today, and I've sort-of got it
> working.

I'm not so sure about that:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = d2450000
[00000008] *pgd=12285831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] PREEMPT ARM
Modules linked in: fuse bnep rfcomm bluetooth ext2 ext3 jbd snd_soc_spdif_tx m25p80 orion_wdt mtd snd_soc_kirkwood snd_soc_kirkwood_spdif
CPU: 0 PID: 2514 Comm: vlc Not tainted 3.10.0+ #652
task: d8102800 ti: d38fa000 task.ti: d38fa000
PC is at snd_pcm_info+0xc8/0xd8
LR is at 0x30232065
pc : [<c030f724>]    lr : [<30232065>]    psr: a00f0013
sp : d38fbea8  ip : d8c2ead0  fp : c05de6d8
r10: c05de7d0  r9 : fffffdfd  r8 : 00000000
r7 : d8c268a8  r6 : d8c26800  r5 : d8c26c00  r4 : d8c2ea00
r3 : 00000000  r2 : d8c2ea00  r1 : 00000001  r0 : d8c26c00
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 12450019  DAC: 00000015
Process vlc (pid: 2514, stack limit = 0xd38fa248)
Stack: (0xd38fbea8 to 0xd38fc000)
bea0:                   c0af7144 d8c2ea00 d8c26c00 ab5032b8 00000001 c030f768
bec0: 00000000 d8c20000 ab5032b8 c030a67c 0000001b d116b840 d8380330 c1205531
bee0: 0000001b d116b840 d8263fc0 d8c20000 ab5032b8 c03056b0 00000001 c05e6e80
bf00: c05e6e88 c05be828 00020120 00000000 d38fa000 600f0013 00000001 0000001b
bf20: d38fa000 00020000 ab5032b8 c0088fec 00000001 00000000 d38fa000 00000000
bf40: 600f0013 ca17c380 0000001b ab5032b8 d8380330 0000001b d38fa000 00020000
bf60: ab5032b8 c00e50bc c00edecc 00020000 ab5032b8 00000001 ca17c380 ab5032b8
bf80: c1205531 c00e5394 ab50366c 00000001 00000000 000120b0 ab50366c 00000036
bfa0: c000e5a8 c000e3e0 00000000 000120b0 0000001b c1205531 ab5032b8 a91a3e10
bfc0: 00000000 000120b0 ab50366c 00000036 ab503454 00000001 00000000 ab5032b8
bfe0: b69a00f4 ab5032a4 b6933109 b6e0d07c a00f0010 0000001b aaaaaaaa aaaaaaaa
[<c030f724>] (snd_pcm_info+0xc8/0xd8) from [<c030f768>] (snd_pcm_info_user+0x34/0x9c)
[<c030f768>] (snd_pcm_info_user+0x34/0x9c) from [<c030a67c>] (snd_pcm_control_ioctl+0x274/0x280)
[<c030a67c>] (snd_pcm_control_ioctl+0x274/0x280) from [<c03056b0>] (snd_ctl_ioctl+0xc0/0x55c)
[<c03056b0>] (snd_ctl_ioctl+0xc0/0x55c) from [<c00e50bc>] (do_vfs_ioctl+0x80/0x31c)
[<c00e50bc>] (do_vfs_ioctl+0x80/0x31c) from [<c00e5394>] (SyS_ioctl+0x3c/0x60)
[<c00e5394>] (SyS_ioctl+0x3c/0x60) from [<c000e3e0>] (ret_fast_syscall+0x0/0x48)
Code: e1a00005 e59530dc e3a01001 e1a02004 (e5933008)

That is caused by:

        /* AB: FIXME!!! This is definitely nonsense */
        if (runtime) {
                info->sync = runtime->sync;
                substream->ops->ioctl(substream, SNDRV_PCM_IOCTL1_INFO, info);
        }

where substream->ops is NULL.

So, we're back to square one and DPCM not being correctly functional.
