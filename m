From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 May 2015 20:30:14 +0100
Subject: [PATCH 3/4] ASoC: rockchip: add rockchip machine driver for
 rt5650/rt5645
In-Reply-To: <1431422797-31903-4-git-send-email-zhengxing@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-4-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20150512193014.GB3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 05:26:36PM +0800, Xing Zheng wrote:
> From: zhengxing <zhengxing@rock-chips.com>
> 
> The driver is used for rockchip board using a rt5650/rt5645.
> Test on RK3288 with rt5650.

Similar comments to the Maxim driver plus...

> +/* Jack detect via rt5645 driver. */
> +extern int rt5645_set_jack_detect(struct snd_soc_codec *codec,
> +				  struct snd_soc_jack *hp_jack,
> +				  struct snd_soc_jack *mic_jack,
> +				  struct snd_soc_jack *btn_jack);
> +
> +/* For compatible. */
> +int __weak rt5645_set_jack_detect(struct snd_soc_codec *codec,
> +				  struct snd_soc_jack *hp_jack,
> +				  struct snd_soc_jack *mic_jack,
> +				  struct snd_soc_jack *btn_jack)
> +{
> +	dev_warn(codec->dev, "Jack detect dummy, have no implement it?\n");
> +
> +	return 0;
> +}

Don't do this - if the functionality isn't there in the CODEC driver get
it implemented before you use it.  Make sure you're using the API the
CODEC actually ends up exporting.

> +	/* Enable Headset and 4 Buttons Jack detection */
> +	ret = snd_soc_card_jack_new(card, "Headphone Jack",
> +				    SND_JACK_HEADPHONE | SND_JACK_MICROPHONE,

> +	ret = snd_soc_card_jack_new(card, "Mic Jack",
> +
> +	ret = snd_soc_card_jack_new(card, "Button Jack",

No, don't do this - as discussed in another Chromebook review (I'm
guessing this is a Chromebook) the jacks should represent the physical
jacks in the system.  It's possible you have separate headphone and
microphone jacks but I really expect microphone and button to be on the
same socket.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/31a15cfb/attachment.sig>
