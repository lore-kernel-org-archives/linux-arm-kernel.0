From: bp@alien8.de (Borislav Petkov)
Date: Tue, 2 Dec 2014 11:36:40 +0100
Subject: [PATCH v6] edac: synps: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <CAGnW=BaRuZvFYCz0=s_ENn_sbH4YPxZiHt1x4GvRcUAyO0s+Jw@mail.gmail.com>
References: <a1c485c3bb214d5699fdbfc6180f96f8@BN1AFFO11FD044.protection.gbl>
 <20141201182611.GA4169@pd.tnic>
 <CAGnW=BaRuZvFYCz0=s_ENn_sbH4YPxZiHt1x4GvRcUAyO0s+Jw@mail.gmail.com>
Message-ID: <20141202103640.GB14649@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 02, 2014 at 10:51:22AM +0530, punnaiah choudary kalluri wrote:
> >> +/**
> >> + * synps_edac_get_eccstate - Return the controller ecc enable/disable status
> >> + * @base:    Pointer to the ddr memory contoller base address
> >> + *
> >> + * This routine returns the ECC enable/disable status for the controller
> >> + *
> >> + * Return: a ecc status boolean i.e true/false - enabled/disabled.
> >> + */
> >> +static bool synps_edac_get_eccstate(void __iomem *base)
> >> +{
> >> +     enum dev_type dt;
> >> +     u32 ecctype;
> >> +     bool state = false;
> >> +
> >> +     dt = synps_edac_get_dtype(base);
> >> +     if (dt == DEV_UNKNOWN)
> >> +             return state;
> >> +
> >> +     ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
> >> +
> >> +     if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2)) {
> >> +             state = true;
> >> +             writel(0x0, base + ECC_CTRL_OFST);
> >
> > Out of curiosity, why is that register write needed here? Maybe
> > forgotten? It looks unbalanced...
> 
> This is needed to start capturing the correctable and uncorrectable errors.
> Writing 1 to this register bits will clear the counters and writing 0 will start
> the counters.

So this definitely doesn't belong here then.

It should be the *last* thing you do after having initialized the whole
driver entirely and successfully and you're ready to start logging
errors.

Now you're calling it in synps_edac_mc_probe() so the counters will
start before you have even initialized the rest of the driver.

What is worse, if one of those things you do on the init path fails, you
enter prematurely and the counters are still running. Not good.

> It is crossing 80 cols. so, there is line break here. I feel the other
> way as the check patch throws warning for this.

And I'm saying you shouldn't follow checkpatch to the letter and think
for yourself instead.

What do you think is more readable?

This:

                       dimm = csi->channels[j]->dimm;
                       dimm->edac_mode = EDAC_FLAG_SECDED;
                       dimm->mtype = synps_edac_get_mtype(priv->baseaddr);
                       dimm->nr_pages =
                           (size >> PAGE_SHIFT) / csi->nr_channels;
                       dimm->grain = SYNPS_EDAC_ERR_GRAIN;
                       dimm->dtype = synps_edac_get_dtype(priv->baseaddr);

or this:

                       dimm		= csi->channels[j]->dimm;
                       dimm->mtype	= synps_edac_get_mtype(priv->baseaddr);
                       dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
                       dimm->dtype	= synps_edac_get_dtype(priv->baseaddr);
                       dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
                       dimm->edac_mode	= EDAC_FLAG_SECDED;

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
