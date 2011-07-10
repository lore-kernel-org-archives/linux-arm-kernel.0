From: dongas86@gmail.com (Dong Aisheng)
Date: Sun, 10 Jul 2011 16:36:44 +0800
Subject: [PATCH 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <20110709030008.GD26900@sirena.org.uk>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-4-git-send-email-b29396@freescale.com>
	<20110709030008.GD26900@sirena.org.uk>
Message-ID: <CAA+hA=TirfTs9WB19snuH2HhmJvaxApEg2H1oT2BwQwPkTOuUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Jul 08, 2011 at 11:59:43PM +0800, Dong Aisheng wrote:
>> The driver only supports playback firstly.
>
> Once more, *always* CC maintainers.
Got it.

>> +struct mxs_audio_platform_data {
>> + ? ? int sysclk;
>> +
>> + ? ? int (*init) (void); ? ? /* board specific init */
>> + ? ? int (*finit) (void); ? ?/* board specific finit */
>
> Eh? ?Your machine driver is already entirely board specific...
Still not.
It's originally used for some board's codec that do not need SAIF to
provide mclk.
I will remove it if we still do not need it to make the things simply.

>> + ? ? /* The SAIF clock should be either 512*fs or 384*fs */
>> + ? ? card_priv.sysclk = 512 * rate;
>> + ? ? ret = snd_soc_dai_set_sysclk(cpu_dai, MXS_SAIF_SYS_CLK,
>> + ? ? ? ? ? ? ? ? ? ? card_priv.sysclk,
>> + ? ? ? ? ? ? ? ? ? ? SND_SOC_CLOCK_OUT);
>
> Why are you storing the sysclk? ?You never reference it again and
> you're using different sysclks for everything in the system.
Yes, it may not really need to store it in this version of code.
I will change this part of clock setting in the next patch.

>> + ? ? /* set SGTL5000_SYSCLK as 256*fs to support 96k sample rate */
>> + ? ? snd_soc_dai_set_sysclk(codec_dai, SGTL5000_SYSCLK, 256 * rate, 0);
>> +
>> + ? ? /* The MCLK output rate is 256*fs */
>> + ? ? snd_soc_dai_set_clkdiv(cpu_dai, MXS_SAIF_MCLK, 256);
>
> Why are you not checking errors on these?
Will add it.

>> +static int mxs_sgtl5000_soc_init(struct snd_soc_pcm_runtime *rtd)
>> +{
>> + ? ? /* TBD: add dapm widgets */
>> +
>> + ? ? return 0;
>> +}
>
> Remove empty functions.
Will do that.

>> +static int __devinit mxs_sgtl5000_probe(struct platform_device *pdev)
>> +{
>> + ? ? struct mxs_audio_platform_data *plat = pdev->dev.platform_data;
>> + ? ? int ret;
>> +
>> + ? ? card_priv.pdev = pdev;
>> +
>> + ? ? ret = -EINVAL;
>> + ? ? if (plat && plat->init && plat->init())
>> + ? ? ? ? ? ? return ret;
>
> You're not calling snd_soc_register_card()...
>
>> + ? ? mxs_sgtl5000_snd_device = platform_device_alloc("soc-audio", -1);
>> + ? ? if (!mxs_sgtl5000_snd_device)
>> + ? ? ? ? ? ? return -ENOMEM;
>
> ...and you're using both a platform device and soc-audio to instantate
> which is a bit confused. ?New code should not be using soc-audio.
Thanks for reminder.
I will change this part of code to following the new rule.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
