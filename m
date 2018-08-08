From: daniel@zonque.org (Daniel Mack)
Date: Wed, 8 Aug 2018 07:38:16 +0200
Subject: ASoC: pxa: possible regressions
In-Reply-To: <5be00a36-d54b-e8ab-2d5f-4c1870f14aac@gmail.com>
References: <5be00a36-d54b-e8ab-2d5f-4c1870f14aac@gmail.com>
Message-ID: <58f65d89-c342-026f-6e24-a67fcd625a26@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Petr,

On Wednesday, August 08, 2018 04:24 AM, Petr Cvek wrote:
> I was trying to update my system (PXA Magician) to 4.18-next and i've
> ran into few problems with sound.

Ah, so you have a Magician platform, that's very good!

> My setup has only a few changes from
> vanilla (change to using devm_snd_soc_register_card+devm_gpio_request).

Care to share these changes, or ideally rebase them on top of 4.18-next 
for mainline inclusion? Also, I'm curious what mainline version you used 
to be based on that worked for you.

> I've started digging around:

Thanks for that. Are you also willing to send patches to fix things once 
they work for you?

> 1) unimportant goto
> 
> Commit 7afd1b0b2ef9a812095 ("ASoC: pxa: move some functions to
> pxa2xx-lib") is this construct necessary?
> 
> 	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
> 		ret = pxa2xx_pcm_preallocate_dma_buffer(pcm,
> 			SNDRV_PCM_STREAM_CAPTURE);
> 		if (ret)
> 			goto out;
> 	}
>    out:
> 	return ret;
> 
> After calling pxa2xx_pcm_preallocate_dma_buffer() the code will jump to
> out anyway.

True. That's a cosmetic cleanup which can go in for 4.19. Would you want 
to send a patch after the merge window?

> 2) wrong units (sample rate vs osc rate)
> 
> Commit 05739375f1c0a1048 ("ASoC: pxa-ssp: remove .set_pll() and
> .set_clkdiv() callbacks"). The function pxa_ssp_hw_params() get's called
> with sample rate so:
> 
> 	/* The values in the table are for 16 bits */
> 	if (width == 32)
> 		acds--;
> 
> 	ret = pxa_ssp_set_pll(priv, bclk);
> 	if (ret < 0)
> 		return ret;
> 
> 	ssacd = pxa_ssp_read_reg(ssp, SSACD);
> 	ssacd &= ~(SSACD_ACDS(7) | SSACD_SCDB_1X);
> 
> pxa_ssp_set_pll() will try to set something like 8000, 44100, ... and
> not the speed of an oscilator. The line should be probably:
> 
> 	ret = pxa_ssp_set_pll(priv, m->pll);
> 
> and there is a previous call to pxa_ssp_set_pll():

Ah, yes. Does changing that fix it for you?

The changes in that machine driver where done blindly because I don't 
have Magician hardware, and I really don't like doing things that way.

> 3) setup fails
> 
> Recent changes in ASoC PXA DMA are causing a fail of a condition in
> pxa_ssp_hw_params():
> 
> 	if ((sscr0 & SSCR0_MOD) && !ttsa) {

What are the values of sscr0 and ttsa in your case? Can you cross-check 
that with a kernel that doesn't have my recent changes?

> 		dev_err(&ssp->pdev->dev, "No TDM timeslot configured\n");
> 		return -EINVAL;
> 	}
> 
> It seems the SSCR0_MOD flag is set in the fall through switch statement
> in pxa_ssp_configure_dai_fmt():
> 
> 	case SND_SOC_DAIFMT_DSP_A:
> 		sspsp |= SSPSP_FSRT;
> 		/* fall through */
> 	case SND_SOC_DAIFMT_DSP_B:
> 		sscr0 |= SSCR0_MOD | SSCR0_PSP;
> 		sscr1 |= SSCR1_TRAIL | SSCR1_RWOT;
> 		break;
> 
> the switch statement is an old code and it worked in the past versions.

Yes, it was merely moved to some location that is called earlier. This 
was fixing a regression caused by a8bd0ee558714 ("ASoC: raumfeld: Use 
static DAI format setup"), so supposedly, all PXA sound was broken since 
v4.0.

> 4) names are not unique
> 
> The initialization of magician_dai structure wants to have (at least in
> the past versions) for the .name item:
> 
> 	static struct snd_soc_dai_link magician_dai[] = {
> 	{
> 		.name = "uda1380",
> 		.stream_name = "UDA1380 Playback",
> 		.cpu_dai_name = "pxa-ssp-dai.0",
> 		...
> 	{
> 		.name = "uda1380",
> 		.stream_name = "UDA1380 Capture",
> 		.cpu_dai_name = "pxa2xx-i2s",
> 
> my personal branch has them named as "uda1380_playback" and
> "uda1380_capture".

Care to send a patch for that as well, please?

> 5) Unbalanced references
> 
> When trying to play a sound (with quick-and-dirty workarounds for
> problems above):
> 
>     # cat /dev/urandom | aplay -
> 
> the system will crash when terminating aplay (stopping playback). The
> backtrace:

So you did hear a sound?

[...]

> I've only managed to discover there are two calls of
> pxa2xx_soc_pcm_new() (where DMA buffer is allocated) for both dai links:
> 
> 	magician-audio magician-audio: uda1380-hifi-playback <-> pxa-ssp-dai.0
> mapping ok
> 	...
> 	magician-audio magician-audio: uda1380-hifi-capture <-> pxa2xx-i2s
> mapping ok
> 
> but I don't know if this information is relevant.

That seems fine. The question is why there are are unbalanced calls to 
snd_dmaengine_pcm_close_release_chan(). Could you dig a bit further 
maybe and add some printk()?

Thanks for helping fix these regressions!


Daniel
