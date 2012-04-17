From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Tue, 17 Apr 2012 08:12:30 +0200
Subject: About AT91: replace broken TWI driver i2c-at91.c
In-Reply-To: <4F8C4A8B.2060005@aalto.fi>
References: <4F8C4A8B.2060005@aalto.fi>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D0905D5A5FB@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Adrian,

Adrian Yanes wrote on 2012-04-16:
> Changing the value to 400000 gives as ~356kHz rate instead of 400kHz,
> maybe it is due to our processor/board, however, checking the specs of
> the at91rm9200 (page 405) we found that the CLVID and the CHDIV are
> calculated as follow:
> 
> T_low = (( CLDIV x 2^CKDIV) +3) + T_mck
> T_high = (( CHDIV x 2^CKDIV) +3) + T_mck
> 
> which differs of the method suggested in the patch:
> 
> const int div = DIV_ROUND_UP(clk_get_rate(dev->clk), 2 * twi_clk) - 2;

G45 spec is slightly different: T_low = (CLDIV x 2^CKDIV + 4) x T_mck
With
twi_clk := 1 / (T_low + T_high) = 1 / (2 * T_low)
and
div := CLKDIV x 2^CKDIV = MCK / (2 * twi_clk) - 4
the above line should be
const int div = DIV_ROUND_UP(clk_get_rate(dev->clk), 2 * twi_clk) - 4;
for G45 and
const int div = DIV_ROUND_UP(clk_get_rate(dev->clk), 2 * twi_clk) - 3;
for RM9200, right?

I'll repost the driver with the above fix and Hubert's fix.

> Finally, did you consider the possibility to add module_param() to
> handle the TWI_CLK_HZ as a module parameter rather than hardcode the
> value? it will help to those users that want to run the bus to different
> frequencies.

No, but feel free to submit a patch ;-).

Niko
