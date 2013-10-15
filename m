From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 15 Oct 2013 15:36:32 +0800
Subject: [PATCH 0/5] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
In-Reply-To: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20131015073631.GA21188@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 04:23:39PM +0800, Shawn Guo wrote:
> When I was reviewing Dong's imx6sl standard tuning patches, I found that
> it's a little clumsy to use enum imx_esdhc_type for handling features
> and quirks on different esdhc variants.  
>
> Instead, the approach used in
> fec driver (drivers/net/ethernet/freescale/fec_main.c) should be more
> scalable in the long run.  It defines flags for all those features and
> quirks and creates a mapping between esdhc variant and the flags.
> 

It cause troubles if i try to rebase my patch series based on it
because esdhc/usdhc also have a lot register difference.

Originally we could simply use is_imx*_usdhc to handle those tiny difference,
however, now if you eliminate the entire is_imx*_usdhc, we may have to
add a lot arbitrary and hard to naming flags for register offset/mask
different issue.
It does not make too much sense.
e.g. 
http://www.spinics.net/lists/arm-kernel/msg278507.html
http://permalink.gmane.org/gmane.linux.kernel.mmc/22934
Add maybe even more when we keep adding new features like:
mx5 DDR support and etc.(register offset is different between imx5&imx6)
It's hard to say how many similar cases left for me currently.

Looking at fec_main.c, the flags seem more like for simply features.
Not the same complicated situation as esdhc/usdhc.
I'm not sure this is so suitable for esdhc/usdhc.

Due to the problems this patch may introduce, it's probably may be good
to stick the old way to me since i did not see quite neccessary to switch
to new way on current code.
Or you may find a better fix for this issue.

Regards
Dong Aisheng

> Actually, sdhci-esdhc-imx driver already has one such flag, i.e.
> ESDHC_FLAG_MULTIBLK_NO_INT, but there is currently an unnecessary
> translation between the flag and imx_esdhc_type.  The series creates
> another 3 flags and identify features/quirks using these flags and then
> eliminate enum imx_esdhc_type completely.
> 
> Shawn Guo (5):
>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_NO_DMAS_BITS
>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_USDHC
>   mmc: sdhci-esdhc-imx: pdev->id_entry should be immutable
>   mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
> 
>  drivers/mmc/host/sdhci-esdhc-imx.c |  108 +++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 63 deletions(-)
> 
> -- 
> 1.7.9.5
> 
