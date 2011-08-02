From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 02 Aug 2011 12:38:59 +0200
Subject: [alsa-devel] [PATCH 1/1] ASoC: core: cache index fix
In-Reply-To: <20110802095141.GA2095@pengutronix.de>
References: <1312198690-13237-1-git-send-email-b29396@freescale.com>
	<20110801115150.GB16629@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721F410B@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110802083850.GB9553@opensource.wolfsonmicro.com>
	<20110802095141.GA2095@pengutronix.de>
Message-ID: <s5hvcugnlmk.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Tue, 2 Aug 2011 11:51:41 +0200,
Wolfram Sang wrote:
> 
> @@ -1023,12 +981,10 @@ static int sgtl5000_suspend(struct snd_soc_codec *codec, pm_message_t state)
>  static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
>  {
>  	u16 *cache = codec->reg_cache;
> -	int i;
> -	int regular_regs = SGTL5000_CHIP_SHORT_CTRL >> 1;
> +	u16 reg;
>  
>  	/* restore regular registers */
> -	for (i = 0; i < regular_regs; i++) {
> -		int reg = i << 1;
> +	for (reg = 0; reg <= SGTL5000_CHIP_SHORT_CTRL; reg += 2) {

Heh, this exposed another bug in the original code :)
It should have been
	for (i = 0; i <= regular_regs; i++) {


thanks,

Takashi
