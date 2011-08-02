From: lrg@ti.com (Liam Girdwood)
Date: Tue, 2 Aug 2011 21:11:44 +0100
Subject: [PATCH RESEND] ASoC: sgtl5000: fix cache handling
In-Reply-To: <1312306939-5140-1-git-send-email-w.sang@pengutronix.de>
References: <1312306939-5140-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <4E385A00.6060809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/11 18:42, Wolfram Sang wrote:
> Cache handling in this driver is broken. The chip has 16-bit registers, yet the
> register numbers also increase by 2 per register, i.e.  there are only
> even-numbered registers. The cache in this driver, though, simply increments
> register numbers, so it does need some mapping as seen in
> sgtl5000_restore_regs(), note the '>> 1':
> 
> 	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
>                         cache[SGTL5000_CHIP_LINREG_CTRL >> 1]);
> 
> That, of course, won't work with snd_soc_update_bits(). (Thus, we won't even
> notice the missing register 0x1c in the default regs which shifted all follwing
> registers to wrong values.) Noticed on the MX28EVK where enabling the regulators
> simply locked up the chip.
> 
> Refactor the routines and use a properly sized default_regs array which matches
> the register layout of the underlying chip, i.e. create a truly flat cache.
> This also saves some code which should make up for the bigger array a little.
> When soc-core will somewhen have another cache type which handles a step size,
> this conversion will also ease the transition.

This would probably be the preferred solution. I guess we can wait a little longer for this fix.

> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Tested-by: Dong Aisheng <b29396@freescale.com>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Zeng Zhaoming <b32542@freescale.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
