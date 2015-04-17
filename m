From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 17 Apr 2015 11:37:44 +0200
Subject: [PATCH v2 2/5] mmc: mediatek: Add Mediatek MMC driver
In-Reply-To: <20150417091213.GM4946@pengutronix.de>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-3-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFoUg1snXeOwCiKPF_daxAAfcWE0nUbRAj23Z=k9z5FCyA@mail.gmail.com>
 <20150417091213.GM4946@pengutronix.de>
Message-ID: <CAPDyKFr5NDTnx_3brksimhqGj+0Rk=tH5fLfWyRddRdPf7i6Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2015 at 11:12, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Ulf,
>
> On Tue, Mar 31, 2015 at 02:23:06PM +0200, Ulf Hansson wrote:
>> On 17 March 2015 at 04:13, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>> > +
>> > +       msdc_set_buswidth(host, ios->bus_width);
>> > +
>> > +       /* Suspend/Resume will do power off/on */
>> > +       switch (ios->power_mode) {
>> > +       case MMC_POWER_UP:
>> > +               msdc_init_hw(host);
>> > +               if (!IS_ERR(mmc->supply.vmmc)) {
>> > +                       ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
>> > +                                       ios->vdd);
>> > +                       if (ret) {
>> > +                               dev_err(host->dev, "Failed to set vmmc power!\n");
>> > +                               return;
>> > +                       }
>> > +               }
>> > +               break;
>> > +       case MMC_POWER_ON:
>> > +               if (!IS_ERR(mmc->supply.vqmmc)) {
>> > +                       ret = regulator_enable(mmc->supply.vqmmc);
>>
>> The calls to regulator_enable|disable() for the vqmmc will not be
>> balanced properly here. You need a local cache variable like
>> "is_enabled" to keep track of this.
>
> Shouldn't the MMC core provide balanced hooks for this? What about
> MMC_POWER_UP, can this be used for enabling regulators?

Currently host drivers deals with vqmmc enabling/disabling, setting
voltage, etc - entirely by them selves.

Dough Anderson is working on fixing that:
http://lkml.iu.edu/hypermail/linux/kernel/1503.1/03108.html

MMC_POWER_UP is when vmmc shall be enabled.

MMC_POWER_ON is when vqmmc shall be enabled.

Kind regards
Uffe
