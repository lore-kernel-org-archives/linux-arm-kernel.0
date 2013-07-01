From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 1 Jul 2013 12:57:44 +0200
Subject: [PATCH 1/4] ASoC: sgtl5000: give it a ramping time before writting
In-Reply-To: <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20945.24744.908437.551717@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo writes:
> Since commit af8ee11 (ASoC: sgtl5000: Fix driver probe after reset),
> it's very ofen to run into the following probe error on imx28. It is
> caused by the regmap_write() failure in sgtl5000_fill_defaults().
> However, the regmap_read() before this has already been working.  It
> seems that sgtl5000 takes a longer ramping time to get the registers
> ready for write than read.
> 
> [    1.991579] sgtl5000 0-000a: sgtl5000 revision 0x11
> [    2.021655] mxs-sgtl5000 sound.12: ASoC: CODEC (null) not registered
> [    2.039087] mxs-sgtl5000 sound.12: snd_soc_register_card failed (-517)
> [    2.046299] platform sound.12: Driver mxs-sgtl5000 requests probe deferral
> 
> Fix the regression by giving it a ramping time before the first write.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  sound/soc/codecs/sgtl5000.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index d441559..20bca03 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -1552,6 +1552,13 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, sgtl5000);
>  
> +	/*
> +	 * It seems that sgtl5000 takes a longer time to get the registers
> +	 * ready for write than bread.  Let's give it a ramping time before
                                ^^^^^
>
What sort of bread? ;-)


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
