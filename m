From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 15 Oct 2013 16:54:00 +0800
Subject: [PATCH 0/5] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
In-Reply-To: <20131015073631.GA21188@b29396-Latitude-E6410>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
 <20131015073631.GA21188@b29396-Latitude-E6410>
Message-ID: <20131015085358.GC14908@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 03:36:32PM +0800, Dong Aisheng wrote:
> On Mon, Oct 14, 2013 at 04:23:39PM +0800, Shawn Guo wrote:
> > When I was reviewing Dong's imx6sl standard tuning patches, I found that
> > it's a little clumsy to use enum imx_esdhc_type for handling features
> > and quirks on different esdhc variants.  
> >
> > Instead, the approach used in
> > fec driver (drivers/net/ethernet/freescale/fec_main.c) should be more
> > scalable in the long run.  It defines flags for all those features and
> > quirks and creates a mapping between esdhc variant and the flags.
> > 
> 
> It cause troubles if i try to rebase my patch series based on it
> because esdhc/usdhc also have a lot register difference.

We now have data structure esdhc_soc_data, which can handle whatever
differences between these variants.

> Originally we could simply use is_imx*_usdhc to handle those tiny difference,

No.  The addition of is_imx6_usdhc() is a sign that we're not going to
handle these differences easily.  Saying if a feature like std_tuning
is only available on imx6sl and imx6slx, is_imx6_usdhc() will not fit
then, and you need if (is_imx6sl_usdhc() || is_imx6slx_usdhc()) for it.
Furthermore, think about it when you have imx7x come to play here,
something like if (is_imx6sl_usdhc() || is_imx6slx_usdhc() ||
is_imx7x_usdhc())?  The if-clause will become a mess sooner or later.

> however, now if you eliminate the entire is_imx*_usdhc, we may have to
> add a lot arbitrary and hard to naming flags for register offset/mask
> different issue.
> It does not make too much sense.
> e.g. 
> http://www.spinics.net/lists/arm-kernel/msg278507.html
> http://permalink.gmane.org/gmane.linux.kernel.mmc/22934

Having flags for them make sense to me.  By doing so, we can get the
"characters" of particular SoC from reading its 'flags' variable.

> Add maybe even more when we keep adding new features like:
> mx5 DDR support and etc.(register offset is different between imx5&imx6)
> It's hard to say how many similar cases left for me currently.

The register difference introduced by adding new features can just be
covered by the feature flag, I think.

Shawn

> Looking at fec_main.c, the flags seem more like for simply features.
> Not the same complicated situation as esdhc/usdhc.
> I'm not sure this is so suitable for esdhc/usdhc.
> 
> Due to the problems this patch may introduce, it's probably may be good
> to stick the old way to me since i did not see quite neccessary to switch
> to new way on current code.
> Or you may find a better fix for this issue.
