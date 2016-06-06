From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 6 Jun 2016 11:13:59 +0200
Subject: [PATCH] mmc: sunxi: Add support to the Allwinner A83T
In-Reply-To: <CAGb2v66JbDjOQdMGDnzsToiXK9ub91m0i4dbkoXtVf0MwURWOQ@mail.gmail.com>
References: <20160604100253.7141B2DE7D@muse.csie.ntu.edu.tw>
 <CAGb2v66JbDjOQdMGDnzsToiXK9ub91m0i4dbkoXtVf0MwURWOQ@mail.gmail.com>
Message-ID: <20160606111359.2f5a391dfa7b1bfce2d82d70@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 5 Jun 2016 20:58:42 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> > +static const struct sunxi_mmc_clk_delay sun8i_a83t_mmc_clk_delays[] = {
> > +       [SDXC_CLK_400K]         = { .output = 180, .sample = 180 },
> > +       [SDXC_CLK_25M]          = { .output = 180, .sample =  50 },
> > +       [SDXC_CLK_50M]          = { .output =  60, .sample =  50 },
> 
> These 2 don't look right.
> 
> > +       [SDXC_CLK_50M_DDR]      = { .output =  180, .sample = 90 },
> > +       [SDXC_CLK_50M_DDR_8BIT] = { .output =  180, .sample = 90 },
> 
> Nor does this one. As explained in the comment from the clock driver:
> 
>     We can only outphase the clocks by multiple of the PLL's period.
> 
>     Since the MMC clock in only a divider, and the formula to get the
>     outphasing in degrees is deg = 360 * delta / period
> 
> Now, for the fishy ones I mentioned, MMC clock = card clock (or card * 2
> for DDR 8 bit), and parent clock is PLL6 @ 600 MHz. A step would be 15,
> 30 or 60 degrees. Thus you cannot get an outphasing of 50 degrees, or 90
> degrees for 50M DDR 8bit.
> 
> Could you provide a link to the original driver? Or perhaps just the
> original delay values?
> 
> The values do work better on my Cubietruck plus, giving a throughput
> of 36 MB/s read, instead of 17 MB/s with the original values. However
> that is still only half of what it should be capable of. I will test
> my BPI M3 tomorrow.

Hi,

Yes, you are right, my values are wrong. Please, forget about this patch.
I did not look far enough in the clock code.

Anyway, I had timeouts in accessing the MMC because the BPI-M3 legacy
u-boot sets the pll-periph rate to 1.2GHz.
Then, according to the comment in the BPI-M3 original driver
(https://github.com/BPI-SINOVOIP/BPI-M3-bsp/blob/master/linux-sunxi/drivers/mmc/host/sunxi-mci.c),
if "//in 1.2GHz pll_periph only [MMC_CLK-50M] is correct",
setting the clock delays to 6 and 7 would be, for us:

	[SDXC_CLK_50M]          = { .output =  90, .sample =  105 },

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
