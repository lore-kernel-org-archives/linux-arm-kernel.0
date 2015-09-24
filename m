From: codekipper@gmail.com (Code Kipper)
Date: Thu, 24 Sep 2015 20:00:23 +0200
Subject: [linux-sunxi][alsa-devel][PATCH 3/3] ASOC: sunxi: Add support for
 the spdif block
In-Reply-To: <20150924172947.GA30445@sirena.org.uk>
References: <1443105005-4083-1-git-send-email-codekipper@gmail.com>
 <20150924172947.GA30445@sirena.org.uk>
Message-ID: <CAEKpxB=UBYAKVCHwcq6M-b-oZ_b7JEy9n5Os=Rm9uhJ+Ph21vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 September 2015 at 19:29, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 24, 2015 at 04:30:05PM +0200, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> The sun4i, sun6i and sun7i SoC families have an SPDIF
>> block which is capable of playback and capture.
>
> I'm not seeing patches 1 or 2 - what's the story here, are there
> dependencies?  Please use subject lines matching the style for the
> subsystem and also don't fill your subject lines with noisy tags beyond
> "[PATCH n/x]", when I look at this in my mail client what I see is:
For some reason git-send-email wouldn't send the last patch last night
so I pushed it today using another machine. I was thinking last night
that the tagging was a bit extreme. I won't do it again.
>
> ->  432   C 09/24 codekipper at gmai ( 27K) [linux-sunxi][alsa-devel][PATCH 3/3] AS
>
>>  sound/soc/sunxi/Kconfig               |  10 +
>>  sound/soc/sunxi/Makefile              |   4 +
>>  sound/soc/sunxi/sunxi-machine-spdif.c | 110 +++++
>>  sound/soc/sunxi/sunxi-spdif.c         | 801 ++++++++++++++++++++++++++++++++++
>
> The machine driver and controller driver should be submitted as separate
> patches for ease of review.  Is there a strong reason for not using
> simple-card?
Yeah..I'm looking for some spiritual guidance here...I'll separate
this out and look at alternate methods.
>
>> +void sunxi_snd_txctrl(struct snd_pcm_substream *substream,
>> +                                     struct sunxi_spdif_dev *host, int on)
>> +{
>> +     u32 tmp;
>
> There's no meaningful sharing between the enable and disable paths and
> only one place either is called, it's better to just inline this into
> the callers.
>
>> +     if (!cpu_dai->active) {
>> +             ret = clk_prepare_enable(host->clk);
>> +             if (ret)
>> +                     return ret;
>> +     }
>
> Can you move the clock enables to runtime PM and let the core do runtime
> PM for you?
>
>> +static int sunxi_spdif_set_clkdiv(struct snd_soc_dai *cpu_dai,
>> +                                             unsigned int rate, int div)
>> +{
>> +     struct sunxi_spdif_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
>> +     int sample_freq, original_sample_freq;
>
> Why are you implementing a set_clkdiv() operation - is the driver not
> capable of working out its internal clocking automaticallly?
>
>> +static int sunxi_spdif_hw_params(struct snd_pcm_substream *substream,
>> +                                     struct snd_pcm_hw_params *params,
>> +                                     struct snd_soc_dai *cpu_dai)
>> +{
>
>> +     ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
>> +     if (ret < 0)
>> +             return ret;
>
> This looks very broken - what is this doing and why?
>
>> +static struct snd_soc_dai_driver sunxi_spdif_dai = {
>> +     .playback = {
>> +             .channels_min = 2,
>> +             .channels_max = 2,
>> +             .rates = SUNXI_RATES,
>
> There was code in the driver to handle mono signals but this says only
> stereo is supported?
>
>> +     if (clk_prepare_enable(host->apb_clk)) {
>> +             dev_err(&pdev->dev, "try to enable apb_spdif_clk failed\n");
>> +             return -EINVAL;
>> +     }
>
> Don't ignore the error code you got from the API, print it and pass it
> back.
All points noted and I'll work to clear them...thanks for you time in
reviewing this.
CK
