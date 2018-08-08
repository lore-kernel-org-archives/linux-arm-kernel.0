From: petrcvekcz@gmail.com (Petr Cvek)
Date: Wed, 8 Aug 2018 04:24:30 +0200
Subject: ASoC: pxa: possible regressions
Message-ID: <5be00a36-d54b-e8ab-2d5f-4c1870f14aac@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I was trying to update my system (PXA Magician) to 4.18-next and i've 
ran into few problems with sound. My setup has only a few changes from 
vanilla (change to using devm_snd_soc_register_card+devm_gpio_request). 
I've started digging around:

1) unimportant goto

Commit 7afd1b0b2ef9a812095 ("ASoC: pxa: move some functions to 
pxa2xx-lib") is this construct necessary?

	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
			SNDRV_PCM_STREAM_CAPTURE);
		if (ret)
			goto out;
	}
  out:
	return ret;

After calling pxa2xx_pcm_preallocate_dma_buffer() the code will jump to 
out anyway.

2) wrong units (sample rate vs osc rate)

Commit 05739375f1c0a1048 ("ASoC: pxa-ssp: remove .set_pll() and 
.set_clkdiv() callbacks"). The function pxa_ssp_hw_params() get's called 
with sample rate so:

	/* The values in the table are for 16 bits */
	if (width == 32)
		acds--;

	ret = pxa_ssp_set_pll(priv, bclk);
	if (ret < 0)
		return ret;

	ssacd = pxa_ssp_read_reg(ssp, SSACD);
	ssacd &= ~(SSACD_ACDS(7) | SSACD_SCDB_1X);

pxa_ssp_set_pll() will try to set something like 8000, 44100, ... and 
not the speed of an oscilator. The line should be probably:

	ret = pxa_ssp_set_pll(priv, m->pll);

and there is a previous call to pxa_ssp_set_pll():

	if (sscr0 & SSCR0_ACS) {
		ret = pxa_ssp_set_pll(priv, bclk);

This one is OK I suppose?

3) setup fails

Recent changes in ASoC PXA DMA are causing a fail of a condition in 
pxa_ssp_hw_params():

	if ((sscr0 & SSCR0_MOD) && !ttsa) {
		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
		return -EINVAL;
	}

It seems the SSCR0_MOD flag is set in the fall through switch statement 
in pxa_ssp_configure_dai_fmt():

	case SND_SOC_DAIFMT_DSP_A:
		sspsp |= SSPSP_FSRT;
		/* fall through */
	case SND_SOC_DAIFMT_DSP_B:
		sscr0 |= SSCR0_MOD | SSCR0_PSP;
		sscr1 |= SSCR1_TRAIL | SSCR1_RWOT;
		break;

the switch statement is an old code and it worked in the past versions.

4) names are not unique

The initialization of magician_dai structure wants to have (at least in 
the past versions) for the .name item:

	static struct snd_soc_dai_link magician_dai[] = {
	{
		.name = "uda1380",
		.stream_name = "UDA1380 Playback",
		.cpu_dai_name = "pxa-ssp-dai.0",
		...
	{
		.name = "uda1380",
		.stream_name = "UDA1380 Capture",
		.cpu_dai_name = "pxa2xx-i2s",

my personal branch has them named as "uda1380_playback" and 
"uda1380_capture".

5) Unbalanced references

When trying to play a sound (with quick-and-dirty workarounds for 
problems above):

   # cat /dev/urandom | aplay -

the system will crash when terminating aplay (stopping playback). The 
backtrace:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 352 at drivers/dma/dmaengine.c:788 
dma_release_channel+0x44/0xa0
  chan reference count 0 != 1
  Modules linked in: snd_soc_magician snd_soc_uda1380 snd_soc_pxa2xx_i2s 
spi_pxa2xx_platform snd_soc_pxa_ssp snd_soc_pxa2xx snd_pxa2xx_lib 
snd_pcm_dmaengine snd_soc_core snd_pcm videobuf2_common snd_timer snd 
ssp soundcore ... [last unloaded: udc_core]
  CPU: 0 PID: 352 Comm: aplay Tainted: G         C 
4.18.0-rc6-next-20180726-magician+ #15
  Hardware name: HTC Magician
  [<c0107d90>] (unwind_backtrace) from [<c010594c>] (show_stack+0x10/0x14)
  [<c010594c>] (show_stack) from [<c0111680>] (__warn+0xd4/0xec)
  [<c0111680>] (__warn) from [<c01112d0>] (warn_slowpath_fmt+0x44/0x6c)
  [<c01112d0>] (warn_slowpath_fmt) from [<c034908c>] 
(dma_release_channel+0x44/0xa0)
  [<c034908c>] (dma_release_channel) from [<bf3183d4>] 
(snd_dmaengine_pcm_close_release_chan+0x2c/0x3c [snd_pcm_dmaengine])
  [<bf3183d4>] (snd_dmaengine_pcm_close_release_chan 
[snd_pcm_dmaengine]) from [<bf1e4fbc>] 
(soc_pcm_components_close+0x64/0x70 [snd_soc_core])
  [<bf1e4fbc>] (soc_pcm_components_close [snd_soc_core]) from 
[<bf1e74a0>] (soc_pcm_close+0xac/0x1c0 [snd_soc_core])
  [<bf1e74a0>] (soc_pcm_close [snd_soc_core]) from [<bf1407c8>] 
(snd_pcm_release_substream+0x68/0xb8 [snd_pcm])
  [<bf1407c8>] (snd_pcm_release_substream [snd_pcm]) from [<bf14085c>] 
(snd_pcm_release+0x44/0x8c [snd_pcm])
  [<bf14085c>] (snd_pcm_release [snd_pcm]) from [<c01c39e4>] 
(__fput+0xdc/0x1e8)
  [<c01c39e4>] (__fput) from [<c0129e7c>] (task_work_run+0xc4/0xd4)
  [<c0129e7c>] (task_work_run) from [<c01053ac>] (do_work_pending+0xc0/0xc8)
  [<c01053ac>] (do_work_pending) from [<c0101068>] 
(slow_work_pending+0xc/0x20)
  Exception stack(0xc2ffbfb0 to 0xc2ffbff8)
  bfa0:                                     00000000 01f7a1a0 01f6fa3c 
00000000
  bfc0: 01f7a150 00000000 0009283c 00000006 000003f0 01f7a4c8 00000000 
01f7a4c8
  bfe0: b6ebbd70 be8ea960 b6e287b8 b6cd2018 60000010 00000004
  ---[ end trace b671f6531db6f6b3 ]---

I've only managed to discover there are two calls of 
pxa2xx_soc_pcm_new() (where DMA buffer is allocated) for both dai links:

	magician-audio magician-audio: uda1380-hifi-playback <-> pxa-ssp-dai.0 
mapping ok
	...
	magician-audio magician-audio: uda1380-hifi-capture <-> pxa2xx-i2s 
mapping ok

but I don't know if this information is relevant.

thanks for any help,
Petr Cvek
