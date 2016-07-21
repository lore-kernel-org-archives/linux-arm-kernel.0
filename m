From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 21 Jul 2016 11:26:55 +0200
Subject: [PATCH 2/3] mmc: sunxi: Set the 'New Timing' register for 8
 bits DDR transfers
In-Reply-To: <20160721085615.GG5993@lukather>
References: <cover.1469082481.git.moinejf@free.fr>
 <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
 <20160721085615.GG5993@lukather>
Message-ID: <20160721112655.941b1dad04f7a5b94d4172c1@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jul 2016 10:56:15 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Wed, Jul 20, 2016 at 08:16:28PM +0200, Jean-Francois Moine wrote:
> > The 'new timing mode' with 8 bits DDR works correctly when the NewTiming
> > register is set.
> 
> What does that mode brings to the table?

>From my tests, the eMMC of the Banana Pi M3 (A83T) cannot work when the
new mode is not used.

> > 
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> > Note about the 'new timing mode'.
> > 
> > This patch assumes that, when the new mode is used, the clock driver
> > sets the mode select in the MMC clock and multiplies the clock rate
> > by 2:
> > - MMC side:
> >   - with a timing 8 bits DDR at 50MHz, the MMC driver calls
> >     clk_set_rate() with a rate 50*2 = 100MHz,
> > - clock side:
> >   - the clock driver sets the hardware MMC clock to 100*2 = 200MHz,
> >   - setting the 'mode select' of the hardware MMC clock divides the
> >     rate by 2,
> > - MMC side:
> >   - setting the MMC clock divider register to 1 divides the rate by 2.
> > So, the final rate is 50MHz.
> 
> What happens if you actually want to set it to 100MHz?

There is no SDXC_CLK_100M in the mainline driver, and 100MHz is asked
only for 8 bits DDR at 50MHz.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
