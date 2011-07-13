From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 13 Jul 2011 16:00:38 +0200
Subject: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721CDC7C@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
	<65EE16ACC360FA4D99C96DC085B3F7721CDC7C@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20110713140038.GI1928@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> For regulator issue, One method is that just add two regulator (VDDA&VDDIO)
> needed by sgtl5000 in platform code to make sgtl5000 work first.
> If that I could add it in my the following patches.
> 
> Or we do not add it (just leave sgtl5000 unwork), instead, we directly
> implement the full regulator support for MX28 power management?
> 
> What's your suggestion?

Hmmm, as we started now with the audio patches, I'd think we should concentrate
on getting them in shape first. So, my preference would be adding just the two
regulators. Whenever the power management gets complete, they should be easy to
include/adapt, if I didn't miss anything.

With your sgtl-patch, I can set the alsa-controls like volume. Yet the
WAV played via simple aplay has a massive hall (like a concert at the
other end of the cathedral ;)). Interrupting aplay, and trying again
gives me sometimes:

Playing WAVE 'machinae supremacy - great gianna sisters.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
[   15.940000] private_candidate: dma0chan0 busy
[   15.950000] private_candidate: dma0chan1 busy
[   15.950000] private_candidate: dma0chan2 filter said false
[   15.960000] private_candidate: dma0chan3 filter said false
[   15.960000] private_candidate: dma0chan4 filter said false
[   15.970000] private_candidate: dma0chan5 filter said false
[   15.970000] private_candidate: dma0chan6 filter said false
[   15.980000] private_candidate: dma0chan7 filter said false
[   15.980000] private_candidate: dma0chan8 filter said false
[   15.990000] private_candidate: dma0chan9 filter said false
[   15.990000] private_candidate: dma0chan10 filter said false
[   16.000000] private_candidate: dma0chan11 filter said false
[   16.010000] private_candidate: dma0chan12 filter said false
[   16.010000] private_candidate: dma0chan13 filter said false
[   16.020000] private_candidate: dma0chan14 filter said false
[   16.020000] private_candidate: dma0chan15 filter said false
[   16.030000] private_candidate: dma1chan0 filter said false
[   16.030000] private_candidate: dma1chan1 filter said false
[   16.040000] private_candidate: dma1chan2 filter said false
[   16.050000] private_candidate: dma1chan3 filter said false
[   16.050000] Division by zero in kernel.
[   16.050000] [<c0025cac>] (unwind_backtrace+0x0/0xe4) from [<c012a1b4>] (Ldiv0+0x8/0x10)
[   16.060000] [<c012a1b4>] (Ldiv0+0x8/0x10) from [<c012a184>] (__aeabi_uidivmod+0x8/0x18)
[   16.070000] [<c012a184>] (__aeabi_uidivmod+0x8/0x18) from [<c01ad5c8>] (audio_dma_irq+0x28/0x38)
[   16.080000] [<c01ad5c8>] (audio_dma_irq+0x28/0x38) from [<c013b200>] (mxs_dma_tasklet+0x18/0x1c)
[   16.090000] [<c013b200>] (mxs_dma_tasklet+0x18/0x1c) from [<c0037430>] (tasklet_action+0x88/0xe0)
[   16.100000] [<c0037430>] (tasklet_action+0x88/0xe0) from [<c0037918>] (__do_softirq+0x84/0x11c)
[   16.110000] [<c0037918>] (__do_softirq+0x84/0x11c) from [<c0037d1c>] (irq_exit+0x40/0x90)
[   16.110000] [<c0037d1c>] (irq_exit+0x40/0x90) from [<c0021064>] (asm_do_IRQ+0x64/0x84)
[   16.120000] [<c0021064>] (asm_do_IRQ+0x64/0x84) from [<c0021b14>] (__irq_svc+0x34/0x60)
[   16.130000] Exception stack(0xc7a13de0 to 0xc7a13e28)
[   16.140000] 3de0: 00000000 00000000 00000000 00000000 c0316368 c7927b00 00000050 60000013
[   16.140000] 3e00: 00000000 00000000 c0316390 c031f13c 00000000 c7a13e28 c0060fd0 c0060298
[   16.150000] 3e20: 60000013 ffffffff
[   16.160000] [<c0021b14>] (__irq_svc+0x34/0x60) from [<c0060298>] (__setup_irq+0x280/0x340)
[   16.160000] [<c0060298>] (__setup_irq+0x280/0x340) from [<c0060424>] (request_threaded_irq+0xcc/0x11c)
[   16.170000] [<c0060424>] (request_threaded_irq+0xcc/0x11c) from [<c013b684>] (mxs_dma_alloc_chan_resources+0x70/0xe8)
[   16.180000] [<c013b684>] (mxs_dma_alloc_chan_resources+0x70/0xe8) from [<c013a3d0>] (dma_chan_get+0x88/0x110)
[   16.190000] [<c013a3d0>] (dma_chan_get+0x88/0x110) from [<c013a4d0>] (__dma_request_channel+0x78/0x18c)
[   16.200000] [<c013a4d0>] (__dma_request_channel+0x78/0x18c) from [<c01ad3e0>] (snd_mxs_pcm_hw_params+0x70/0x1d4)
[   16.210000] [<c01ad3e0>] (snd_mxs_pcm_hw_params+0x70/0x1d4) from [<c01a3a0c>] (soc_pcm_hw_params+0x100/0x1ac)
[   16.220000] [<c01a3a0c>] (soc_pcm_hw_params+0x100/0x1ac) from [<c019cd1c>] (snd_pcm_hw_params+0x98/0x33c)
[   16.230000] [<c019cd1c>] (snd_pcm_hw_params+0x98/0x33c) from [<c019dc10>] (snd_pcm_common_ioctl1+0x1e4/0x4f8)
[   16.240000] [<c019dc10>] (snd_pcm_common_ioctl1+0x1e4/0x4f8) from [<c019e374>] (snd_pcm_playback_ioctl1+0x200/0x220)
[   16.250000] [<c019e374>] (snd_pcm_playback_ioctl1+0x200/0x220) from [<c0097b24>] (do_vfs_ioctl+0x258/0x288)
[   16.260000] [<c0097b24>] (do_vfs_ioctl+0x258/0x288) from [<c0097b88>] (sys_ioctl+0x34/0x54)
[   16.270000] [<c0097b88>] (sys_ioctl+0x34/0x54) from [<c0021ea0>] (ret_fast_syscall+0x0/0x2c)
[   16.280000] __dma_request_channel: success (dma1chan4)
[   16.290000] dma dma1chan4: cannot prepare slave dma
[   16.290000] asoc: platform mxs-pcm-audio.0 hw params failed
aplay: set_params:1053: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (46439 46440)
PERIOD_SIZE: 2048
PERIOD_BYTES: 8192
PERIODS: 8
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536
TICK_TIME: 0

After that OOPS, playing works again (still with the hall). Didn't have the
time to look at these issues yet, but since I was writing to you anyway, I
thought I'd mention it...

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110713/099d9e6f/attachment.sig>
