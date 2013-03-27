From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 27 Mar 2013 08:31:57 +0100
Subject: [PATCH 1/2] ARM: kirkwood: fix a not initialized variable in
 the sound subsystem
In-Reply-To: <5152078C.5080401@gmail.com>
References: <20130326190513.1671a3be@armhf> <5151F9F4.2040005@gmail.com>
 <20130326210512.6c9c8990@armhf> <5152078C.5080401@gmail.com>
Message-ID: <20130327083157.794cfa05@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Mar 2013 21:39:40 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 03/26/2013 09:05 PM, Jean-Francois Moine wrote:
> > On Tue, 26 Mar 2013 20:41:40 +0100
> > Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>  wrote:
> >
> >> On 03/26/2013 07:05 PM, Jean-Francois Moine wrote:
> >>> In the function kirkwood_set_rate, in case of a non dco supported rate
> >>> and no external clock, the clock source was set to an undefined value.
> >>> This patch just displays a message without changing the clock source.
> >>>
> >>> Signed-off-by: Jean-Francois Moine<moinejf@free.fr>
> >>> ---
> >>>    sound/soc/kirkwood/kirkwood-i2s.c |    3 +++
> >>>    1 file changed, 3 insertions(+)
> >>>
> >>> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
> >>> index c74c890..afca1ec 100644
> >>> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> >>> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> >>> @@ -118,6 +118,9 @@ static void kirkwood_set_rate(struct snd_soc_dai *dai,
> >>>    		clk_set_rate(priv->extclk, 256 * rate);
> >>>
> >>>    		clks_ctrl = KIRKWOOD_MCLK_SOURCE_EXTCLK;
> >>> +	} else {
> >>> +		dev_err(dai->dev, "%s: no clock\n", __func__);
> >>> +		return;
> >>>    	}
> >>>    	writel(clks_ctrl, priv->io + KIRKWOOD_CLOCKS_CTRL);
> >>>    }
> >>
> >> NACK.
> >>
> >> Having no clock at all should be catched during _probe. Moreover,
> >> not having the internal clock enabled will lead to system hang due to
> >> clock gating. You should rather pass an optional (DT-only) extclk phandle
> >> on the second clocks property.
> 
> Jean-Francois,
> 
> I had a close look at the code and your patch. From a driver
> point-of-view kirkwood_set_rate should never been called with
> an unsupported rate (see KIRKWOOD_I2S_RATES) when no extclk
> is available. With extclk available, the else-if branch will
> be taken on rates != KIRKWOOD_I2S_RATES. Actually, your added
> else branch will never be taken at all.
> 
> I suggest (again) to remove clks_ctrl and move the writel inside
> if and else-if branch to cure the compiler warning.
> 
> Sebastian

That's what there was in the original patch from Rabeeh, but maybe it
is the opportunity to use WARN_ON. Russell?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
