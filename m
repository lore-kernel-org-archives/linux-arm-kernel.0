From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Mar 2013 14:03:09 +0000
Subject: FW: Regulator API ignored return values
In-Reply-To: <CADz5_g+KfxL43BKKsgZZ3Xg4sZWE4-ZaFpFhphKrfj9yK59-XA@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C0BDEB0547F@SC-VEXCH1.marvell.com>
 <CADz5_g+KfxL43BKKsgZZ3Xg4sZWE4-ZaFpFhphKrfj9yK59-XA@mail.gmail.com>
Message-ID: <201303121403.09315.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 March 2013, Kevin Liu wrote:
> > -               regulator_enable(host->vqmmc);
> > +               ret = regulator_enable(host->vqmmc);
> >                 if (!regulator_is_supported_voltage(host->vqmmc, 1700000,
> >                         1950000))
> >                         caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
> >                                         SDHCI_SUPPORT_SDR50 |
> >                                         SDHCI_SUPPORT_DDR50);
> > +               if (ret) {
> > +                       pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
> > +                               mmc_hostname(mmc), ret);
> 
> Need add regulator_put here since regulator_get has succeed?

Hmm, we still don't actually bail out if the error is encountered, so
the reference count is balanced with the current patch, but I maybe
a failed regulator_enable() should actually be a fatal error?

If we do that, using devm_regulator_get() would be a nice way to
track the reference counts.

	Arnd
