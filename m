From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Tue, 17 Apr 2012 11:59:06 +0200
Subject: About AT91: replace broken TWI driver i2c-at91.c
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D0905AAA1EC@wm021.weinmann.com>
References: <4F8C4A8B.2060005@aalto.fi>
 <EF2E73589CA71846A15D0B2CDF79505D0905AAA1EC@wm021.weinmann.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D0905D5A78B@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Voss, Nikolaus wrote on 2012-04-17:
> Adrian Yanes wrote on 2012-04-16:
>> Changing the value to 400000 gives as ~356kHz rate instead of 400kHz,
>> maybe it is due to our processor/board, however, checking the specs of
>> the at91rm9200 (page 405) we found that the CLVID and the CHDIV are
>> calculated as follow:
>> 
>> T_low = (( CLDIV x 2^CKDIV) +3) + T_mck
>> T_high = (( CHDIV x 2^CKDIV) +3) + T_mck
>> 
>> which differs of the method suggested in the patch:
>> 
>> const int div = DIV_ROUND_UP(clk_get_rate(dev->clk), 2 * twi_clk) - 2;
> 
> G45 spec is slightly different: T_low = (CLDIV x 2^CKDIV + 4) x T_mck
> With
> twi_clk := 1 / (T_low + T_high) = 1 / (2 * T_low)
> and
> div := CLKDIV x 2^CKDIV = MCK / (2 * twi_clk) - 4
> the above line should be
> const int div = DIV_ROUND_UP(clk_get_rate(dev->clk), 2 * twi_clk) - 4;
> for G45 and
> const int div = DIV_ROUND_UP(clk_get_rate(dev->clk), 2 * twi_clk) - 3;
> for RM9200, right?

Strange: I measured the frequency of scl and I still get too low values
for offset 4 (instead of 2). On my G45 the correct offset seems to be
as high as 27.

Adrian, can you please give this a try?

Niko
