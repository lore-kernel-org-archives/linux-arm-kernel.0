From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 17 Sep 2015 23:10:41 +0800
Subject: [linux-sunxi] Re: [PATCH 2/2] ASoC: sunxi: add support for the
 on-chip codec on early Allwinner SoCs
In-Reply-To: <20150917133135.GE4684@lukather>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442064384-23379-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150916191612.GM12027@sirena.org.uk> <20150917133135.GE4684@lukather>
Message-ID: <CAGb2v67D30+_itOAyWqGzychxeM_d7rF6TTu1_WBYuFPfFEk1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 9:31 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Mark,
>
> On Wed, Sep 16, 2015 at 08:16:12PM +0100, Mark Brown wrote:
>> On Sat, Sep 12, 2015 at 03:26:24PM +0200, Maxime Ripard wrote:
>>
>> This looks pretty good, there's a few minor things below but I'll apply
>> anyway - please send followup patches fixing these.
>
> Sure, I will. Thanks!
>
>>
>> > +   if (clk_set_rate(scodec->clk_module, clk_freq))
>> > +           return -EINVAL;
>>
>> Better to pass back the error code here rather than silently discard it
>> (it might have more information).
>
> Yep.
>
>>
>> > +static struct snd_soc_dai_driver sun4i_codec_dai = {
>> > +   .name   = "Codec",
>> > +   .ops    = &sun4i_codec_dai_ops,
>> > +   .playback = {
>> > +           .stream_name    = "Codec Playback",
>> > +           .channels_min   = 1,
>> > +           .channels_max   = 2,
>> > +           .rate_min       = 8000,
>> > +           .rate_max       = 192000,
>> > +           .rates          = SNDRV_PCM_RATE_8000_48000 |
>> > +                             SNDRV_PCM_RATE_96000 |
>> > +                             SNDRV_PCM_RATE_192000 |
>> > +                             SNDRV_PCM_RATE_KNOT,
>>
>> No need to specify both explicit rates and _KNOT, _KNOT covers
>> everything.
>
> Ack.
>
>> > +           .formats        = SNDRV_PCM_FMTBIT_S16_LE |
>> > +                             SNDRV_PCM_FMTBIT_S32_LE,
>> > +           .sig_bits       = 24,
>>
>> So presumably also S24_LE (ie, 24 bits packed into a 32 bit word)?
>
> Hmm, probably yes, I'll test that.

IIRC when Emilio first wrote the driver, we tried 24 bit and no sound
came out. Turns out it's an alignment issue. The codec's FIFO register
is 32 bits wide, and takes the higher 24 bits as input when set to 24
bit mode. The internal FIFO is only 24 bits wide. A20 user manual P174
describes how the bits are copied.

So for 24 bit audio, you would actually send it 32 bit audio samples,
and let it truncate or drop the least significant 8 bits. This is why
we have SNDRV_PCM_FMTBIT_S32_LE with .sig_bits = 24.

I don't know if this is just a workaround, but a few other drivers do
this as well, for example twl3040 and omap-mcpdm.


Regards
ChenYu

>> > +   /* Enable the bus clock */
>> > +   if (clk_prepare_enable(scodec->clk_apb)) {
>> > +           dev_err(&pdev->dev, "Failed to enable the APB clock\n");
>> > +           return -EINVAL;
>> > +   }
>>
>> Ideally we'd have runtime power management to disable the clocks when
>> idle.
>
> We don't really have any kind of power management support currently,
> but adding runtime pm everywhere is definitely on the todo list. It
> might not happen before a while though.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
