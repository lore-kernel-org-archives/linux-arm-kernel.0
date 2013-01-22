From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jan 2013 08:46:11 +0000
Subject: [PATCH 1/8] mmc: mmci: Move ios_handler functionality into the
 driver
In-Reply-To: <CAPDyKFoNXNj=9mG0sR7=g12MJ1xLuRMLqReY7mCEVSBYGvRPhQ@mail.gmail.com>
References: <1355404930-5691-1-git-send-email-lee.jones@linaro.org>
 <1355404930-5691-2-git-send-email-lee.jones@linaro.org>
 <20130121140626.GB6857@gmail.com>
 <CAPDyKFoNXNj=9mG0sR7=g12MJ1xLuRMLqReY7mCEVSBYGvRPhQ@mail.gmail.com>
Message-ID: <20130122084611.GF6857@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jan 2013, Ulf Hansson wrote:

> On 21 January 2013 15:06, Lee Jones <lee.jones@linaro.org> wrote:
> > On Thu, 13 Dec 2012, Lee Jones wrote:
> >
> >> There are currently two instances of the ios_handler being used.
> >> Both of which mearly toy with some regulator settings. Now there
> >> is a GPIO regulator API, we can use that instead, and lessen the
> >> per platform burden. By doing this, we also become more Device
> >> Tree compatible.
> >>
> >> Cc: Chris Ball <cjb@laptop.org>
> >> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> >> Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >
> > Any more news on this one?
> 
> Not exactly this version of the patch, but another one has has been
> merged through Russell's patch tracker. Available for 3.9.

Nice. Thanks for the update.

> >>  drivers/mmc/host/mmci.c |   22 ++++++++++++++++++++++
> >>  drivers/mmc/host/mmci.h |    1 +
> >>  2 files changed, 23 insertions(+)
> >>
> >> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> >> index edc3e9b..d45c931 100644
> >> --- a/drivers/mmc/host/mmci.c
> >> +++ b/drivers/mmc/host/mmci.c
> >> @@ -1091,6 +1091,16 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >>       case MMC_POWER_OFF:
> >>               if (host->vcc)
> >>                       ret = mmc_regulator_set_ocr(mmc, host->vcc, 0);
> >> +
> >> +             if (host->vqmmc) {
> >> +                     if (regulator_is_enabled(host->vqmmc)) {
> >> +                             ret = regulator_disable(host->vqmmc);
> >> +                             if (ret < 0)
> >> +                                     dev_warn(mmc_dev(mmc),
> >> +                                              "unable to disable vmmc-ios\n");
> >> +                     }
> >> +             }
> >> +
> >>               break;
> >>       case MMC_POWER_UP:
> >>               if (host->vcc) {
> >> @@ -1115,6 +1125,14 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >>
> >>               break;
> >>       case MMC_POWER_ON:
> >> +             if (host->vqmmc)
> >> +                     if (!regulator_is_enabled(host->vqmmc)) {
> >> +                             ret = regulator_enable(host->vqmmc);
> >> +                             if (ret < 0)
> >> +                                     dev_warn(mmc_dev(mmc),
> >> +                                              "unable to enable vmmc-ios\n");
> >> +                     }
> >> +
> >>               pwr |= MCI_PWR_ON;
> >>               break;
> >>       }
> >> @@ -1379,6 +1397,10 @@ static int __devinit mmci_probe(struct amba_device *dev,
> >>                                "(using regulator instead)\n");
> >>               }
> >>       }
> >> +
> >> +     host->vqmmc = regulator_get(&dev->dev, "vqmmc");
> >> +     if (IS_ERR(host->vqmmc))
> >> +             host->vqmmc = NULL;
> >>  #endif
> >>       /* Fall back to platform data if no regulator is found */
> >>       if (host->vcc == NULL)
> >> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> >> index d437ccf..b87d9e2 100644
> >> --- a/drivers/mmc/host/mmci.h
> >> +++ b/drivers/mmc/host/mmci.h
> >> @@ -194,6 +194,7 @@ struct mmci_host {
> >>       struct sg_mapping_iter  sg_miter;
> >>       unsigned int            size;
> >>       struct regulator        *vcc;
> >> +     struct regulator        *vqmmc;
> >>
> >>  #ifdef CONFIG_DMA_ENGINE
> >>       /* DMA stuff */
> >

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
