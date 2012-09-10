From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Sep 2012 21:50:37 +0800
Subject: [PATCH] mmc: mxs-mmc: implement broken-cd
In-Reply-To: <504DBB10.9030702@bluegiga.com>
References: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20120910060840.GT26709@S2101-09.ap.freescale.net>
 <504DBB10.9030702@bluegiga.com>
Message-ID: <20120910135034.GD13076@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 01:04:00PM +0300, Lauri Hintsala wrote:
> >>@@ -187,6 +188,9 @@ static int mxs_mmc_get_cd(struct mmc_host *mmc)
> >>  {
> >>  	struct mxs_mmc_host *host = mmc_priv(mmc);
> >>
> >>+	if (host->broken_cd)
> >>+		return -ENOSYS;
> >>+
> >
> >The .get_cd caller does not check for error.  This change makes no
> >sense to me.
> 
> In our case we don't want to read card detect bit and we have to
> continue MMC probing because card detect pin is routed nowhere.
> 
> Could it be better to return zero instead of error? ENOSYS is used
> to indicate "unreachable card detect" in other drivers (e.g.
> atmel-mci, omap_hsmmc) and I followed them.
> 
I was wrong.  Even the kerneldoc of .get_cd suggests return -ENOSYS
for that case.

> 
> >Instead, the driver needs to set MMC_CAP_NEEDS_POLL in
> >case of "broken-cd".
> 
> MMC_CAP_NEEDS_POLL is always set in mxs-mmc.
> 
Oops, I forgot that.  But this is really something that needs to be
fixed.  Per my understanding, flag MMC_CAP_NEEDS_POLL should only
be set when card-detect is not working.

Also the card-detect in gpio support is missing.

But for this patch:

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
