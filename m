From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 26 Apr 2012 13:12:12 +0800
Subject: imx sgtl5000:BUG: scheduling while atomic:
 speaker-test/1225/0x00000003
In-Reply-To: <20120426023319.GC28063@b20223-02.ap.freescale.net>
References: <20120426023319.GC28063@b20223-02.ap.freescale.net>
Message-ID: <20120426051212.GF28063@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 10:33:21AM +0800, Richard Zhao wrote:
> [   13.901890] eth0: no IPv6 routers present
> [   70.295079] BUG: scheduling while atomic: speaker-test/1225/0x00000003
> [   70.304293] Modules linked in:
> [   70.310389] [<c0015a68>] (unwind_backtrace+0x0/0xec) from [<c0585810>] (dump_stack+0x20/0x24)
> [   70.310421] [<c0585810>] (dump_stack+0x20/0x24) from [<c0585f6c>] (__schedule_bug+0x54/0x60)
> [   70.310452] [<c0585f6c>] (__schedule_bug+0x54/0x60) from [<c058db64>] (__schedule+0x84/0x748)
> [   70.310476] [<c058db64>] (__schedule+0x84/0x748) from [<c058e310>] (schedule+0x8c/0x90)
> [   70.310500] [<c058e310>] (schedule+0x8c/0x90) from [<c058c504>] (schedule_timeout+0x2fc/0x35c)
> [   70.310541] [<c058c504>] (schedule_timeout+0x2fc/0x35c) from [<c058d970>] (wait_for_common+0xd8/0x16c)
> [   70.310567] [<c058d970>] (wait_for_common+0xd8/0x16c) from [<c058da44>] (wait_for_completion_timeout+0x1c/0x20)
> [   70.310604] [<c058da44>] (wait_for_completion_timeout+0x1c/0x20) from [<c03352bc>] (sdma_run_channel+0x70/0x8c)
> [   70.310634] [<c03352bc>] (sdma_run_channel+0x70/0x8c) from [<c0335614>] (sdma_load_context+0x188/0x19c)
> [   70.310661] [<c0335614>] (sdma_load_context+0x188/0x19c) from [<c0335688>] (sdma_prep_dma_cyclic+0x60/0x1a8)
> [   70.310694] [<c0335688>] (sdma_prep_dma_cyclic+0x60/0x1a8) from [<c04760f4>] (snd_dmaengine_pcm_trigger+0xa0/0x134)
> [   70.310729] [<c04760f4>] (snd_dmaengine_pcm_trigger+0xa0/0x134) from [<c0483e68>] (soc_pcm_trigger+0x74/0xb0)
> [   70.310770] [<c0483e68>] (soc_pcm_trigger+0x74/0xb0) from [<c046e670>] (snd_pcm_do_start+0x34/0x40)
> [   70.310797] [<c046e670>] (snd_pcm_do_start+0x34/0x40) from [<c046e288>] (snd_pcm_action_single+0x48/0x74)
> [   70.310823] [<c046e288>] (snd_pcm_action_single+0x48/0x74) from [<c046e334>] (snd_pcm_action+0x80/0x8c)
> [   70.310850] [<c046e334>] (snd_pcm_action+0x80/0x8c) from [<c04707f0>] (snd_pcm_start+0x24/0x2c)
> [   70.310877] [<c04707f0>] (snd_pcm_start+0x24/0x2c) from [<c0474058>] (snd_pcm_lib_write1+0x2a8/0x340)
> [   70.310900] [<c0474058>] (snd_pcm_lib_write1+0x2a8/0x340) from [<c04741d0>] (snd_pcm_lib_write+0x70/0x7c)
> [   70.311007] [<c04741d0>] (snd_pcm_lib_write+0x70/0x7c) from [<c04703f8>] (snd_pcm_playback_ioctl1+0x114/0x428)
> [   70.311038] [<c04703f8>] (snd_pcm_playback_ioctl1+0x114/0x428) from [<c0470744>] (snd_pcm_playback_ioctl+0x38/0x44)
> [   70.311077] [<c0470744>] (snd_pcm_playback_ioctl+0x38/0x44) from [<c0107234>] (do_vfs_ioctl+0x4f4/0x568)
> [   70.311105] [<c0107234>] (do_vfs_ioctl+0x4f4/0x568) from [<c0107308>] (sys_ioctl+0x60/0x84)
> [   70.311138] [<c0107308>] (sys_ioctl+0x60/0x84) from [<c000df40>] (ret_fast_syscall+0x0/0x30)
> [   80.301928] ALSA sound/core/pcm_lib.c:1853 playback write error (DMA or IRQ trouble?)
> 
> 
> kernel: 3.4rc3 with ASoC/for-next and some my patches.

I found the cause.
snd_dmaengine_pcm_trigger --> dmaengine_pcm_prepare_and_submit
--> dmaengine_prep_dma_cyclic

The trigger function is in atomic context, but dmaengine_prep_dma_cyclic
tried to sleep.

>From dma engine design, can device_prep_dma_cyclic sleep?
If yes, we may need to move it out of trigger functions.

Thanks
Richard
> 
> Thanks
> Richard
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
