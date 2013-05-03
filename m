From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 3 May 2013 09:16:33 +0100
Subject: [PATCH 3/4] mmc: mmci: Ensure return value of regulator_enable()
 is checked
In-Reply-To: <CAPDyKFr60-nuh-BFsWtFhNeqUmswKC4hL4mw-gDhiqLmarvEDA@mail.gmail.com>
References: <1367509690-24022-1-git-send-email-lee.jones@linaro.org>
 <1367509690-24022-4-git-send-email-lee.jones@linaro.org>
 <CAPDyKFr60-nuh-BFsWtFhNeqUmswKC4hL4mw-gDhiqLmarvEDA@mail.gmail.com>
Message-ID: <20130503081633.GD24153@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 May 2013, Ulf Hansson wrote:

> On 2 May 2013 17:48, Lee Jones <lee.jones@linaro.org> wrote:
> > This patch suppresses the warning below:
> >
> > drivers/mmc/host/mmci.c: In function ?mmci_set_ios?:
> > drivers/mmc/host/mmci.c:1165:20: warning: ignoring return value of
> >         ?regulator_enable?, declared with attribute warn_unused_result
> >         [-Wunused-result]
> >
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Chris Ball <cjb@laptop.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mmc/host/mmci.c |    9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index 375c109..f4f3038 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -1130,6 +1130,7 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >         struct variant_data *variant = host->variant;
> >         u32 pwr = 0;
> >         unsigned long flags;
> > +       int ret;
> >
> >         pm_runtime_get_sync(mmc_dev(mmc));
> >
> > @@ -1161,8 +1162,12 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >                 break;
> >         case MMC_POWER_ON:
> >                 if (!IS_ERR(mmc->supply.vqmmc) &&
> > -                   !regulator_is_enabled(mmc->supply.vqmmc))
> 
> I realize that we actually have a bug here (and in the MMC_POWER_OFF
> mode as well).
> 
> We shall not use regulator_is_enabled API as a trigger to enable/fetch
> a reference to the regulator, since it will only tell us if the
> regulator is enabled - hw wise.
> Instead we need a local variable in the mmci host struct keeping track
> if we have enabled the regulator. Do you mind fix this up in this
> patch as well since it is tightly coupled to the regulator handling!?

IMHO I think that should be taken care of in a separate patch. This
patch only touches the line containing regulator_is_enabled() to
encompass a multi-line comparison result.

Care to write that patch? I have so much on my TODO already. :|

> Otherwise it looks good to me.
> 
> Kind regards
> Ulf Hansson
> 
> > -                       regulator_enable(mmc->supply.vqmmc);
> > +                   !regulator_is_enabled(mmc->supply.vqmmc)) {
> > +                       ret = regulator_enable(mmc->supply.vqmmc);
> > +                       if (ret < 0)
> > +                               dev_err(mmc_dev(mmc),
> > +                                       "failed to enable vqmmc regulator\n");
> > +               }
> >
> >                 pwr |= MCI_PWR_ON;
> >                 break;
> >

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
