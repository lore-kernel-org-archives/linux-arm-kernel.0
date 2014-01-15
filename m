From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 15 Jan 2014 13:12:03 +0200
Subject: [PATCH RFC v2 REPOST 2/8] ASoC: davinci-evm: Add named clock
 reference to DT bindings
In-Reply-To: <20131231131617.GZ31886@sirena.org.uk>
References: <cover.1387535299.git.jsarha@ti.com>
 <c1ae738c9b6cd9f2e595eed1f4981378ded46925.1387535302.git.jsarha@ti.com>
 <20131231131617.GZ31886@sirena.org.uk>
Message-ID: <52D66D03.1040608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/2013 03:16 PM, Mark Brown wrote:
> On Fri, Dec 20, 2013 at 12:38:27PM +0200, Jyri Sarha wrote:
>
>> +static int evm_startup(struct snd_pcm_substream *substream)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	struct snd_soc_card *soc_card = rtd->codec->card;
>> +	struct clk *mclk = ((struct snd_soc_card_drvdata_davinci *)
>> +			    snd_soc_card_get_drvdata(soc_card))->mclk;
>
> Why do you need to cast away void?  Ths indicates something is going
> wrong here though I can't see what.

I'll fix that.

>> +	mclk = of_clk_get_by_name(np, "ti,codec-clock");
>> +	if (PTR_ERR(mclk) == -EPROBE_DEFER) {
>> +		return -EPROBE_DEFER;
>> +	} else if (IS_ERR(mclk)) {
>> +		dev_dbg(&pdev->dev, "Codec clock not found.\n");
>> +		mclk = NULL;
>> +	}
>
> The driver will unconditionally enable and disable the clock which I'd
> not expect to work well if we got an error, I'd expect either NULL checks
> on use or a fixed clock to be registered from code in the case where
> we're using the old binding.
>

In the drivers/clk/clk.c the clk == NULL is always checked before using 
the pointer. However, adding NULL checks would save couple of 
lock-unlock cycles. I'll add them.

> I'd also expect to see devm_clk_get() used here, with the standard
> clock-names based lookup from DT.
>

I'll fix that.

Best regards,
Jyri
