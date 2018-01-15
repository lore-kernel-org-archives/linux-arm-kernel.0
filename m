From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Mon, 15 Jan 2018 17:42:18 +0000
Subject: [PATCH 03/14] mmc: mmci: Add support for setting pad type via
 pinctrl
In-Reply-To: <CAPDyKFoBTKpwSJzg5_cMei0Vzze=eQTKFBuD6mgHdYZUhqxFPw@mail.gmail.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com>
 <1515759368-16946-4-git-send-email-patrice.chotard@st.com>
 <CAPDyKFoBTKpwSJzg5_cMei0Vzze=eQTKFBuD6mgHdYZUhqxFPw@mail.gmail.com>
Message-ID: <c09970a6-0e6d-c26d-f41e-ab82b4cb8127@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf

On 01/15/2018 01:43 PM, Ulf Hansson wrote:
> On 12 January 2018 at 13:15,  <patrice.chotard@st.com> wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> The STM32 variant hasn't the control bit to switch pads in opendrain mode.
>> In this case we can achieve the same result by asking to the pinmux driver
>> to configure pins for us.
>>
>> This patch make the mmci driver able to do this whenever needed.
>>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
>>   drivers/mmc/host/mmci.h |  5 +++++
>>   2 files changed, 50 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 7e56f85..38e8c20 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -85,6 +85,8 @@
>>    * @mmcimask1: true if variant have a MMCIMASK1 register.
>>    * @start_err: true is the variant has STARTBITERR bit inside MMCISTATUS
>>    *            register.
>> + * @opendrain: true if variant have dedicated bit for opendrain pins
>> + *            configuration.
>>    */
>>   struct variant_data {
>>          unsigned int            clkreg;
>> @@ -116,6 +118,7 @@ struct variant_data {
>>          bool                    reversed_irq_handling;
>>          bool                    mmcimask1;
>>          bool                    start_err;
>> +       bool                    opendrain;
> 
> Similar comment as for patch2.
> 
> To be consistent with how we implement support for similar variant
> variations, I would prefer to have this being a u32. Something along
> the lines of how the "busy_detect_flag" is being used.

ok

> 
> [...]
> 
>> @@ -1394,9 +1405,11 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>   {
>>          struct mmci_host *host = mmc_priv(mmc);
>>          struct variant_data *variant = host->variant;
>> +       struct pinctrl_state *pins;
>>          u32 pwr = 0;
>>          unsigned long flags;
>>          int ret;
>> +       bool is_opendrain;
>>
>>          if (host->plat->ios_handler &&
>>                  host->plat->ios_handler(mmc_dev(mmc), ios))
>> @@ -1455,16 +1468,31 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                                  ~MCI_ST_DATA2DIREN);
>>          }
>>
>> -       if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
>> -               if (host->hw_designer != AMBA_VENDOR_ST)
>> -                       pwr |= MCI_ROD;
>> -               else {
>> -                       /*
>> -                        * The ST Micro variant use the ROD bit for something
>> -                        * else and only has OD (Open Drain).
>> -                        */
>> -                       pwr |= MCI_OD;
> 
> Seems like you should actually split this change into two parts.
> 
> One that adds the variant flag for the open drain bit, when then can
> clean up this code. Then a patch on top that starts using pinctrl in
> case there is no open drain bit set.
> 
> Does that sounds reasonable?

Of course

> 
>> +       if (host->variant->opendrain) {
>> +               if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
>> +                       if (host->hw_designer != AMBA_VENDOR_ST) {
>> +                               pwr |= MCI_ROD;
>> +                       } else {
>> +                               /*
>> +                                * The ST Micro variant use the ROD bit for
>> +                                * something else and only has OD (Open Drain).
>> +                                */
>> +                               pwr |= MCI_OD;
>> +                       }
>>                  }
>> +       } else {
>> +               /*
>> +                * If the variant cannot configure the pads by its own, then we
>> +                * expect the pinctrl to be able to do that for us
>> +                */
>> +               is_opendrain = (ios->bus_mode == MMC_BUSMODE_OPENDRAIN);
>> +               pins = pinctrl_lookup_state(host->pinctrl, is_opendrain ?
> 
> How about doing the lookup in ->probe() instead? Then just select the
> state here, if supported?

ok

> 
>> +                                       MMCI_PINCTRL_STATE_OPENDRAIN :
>> +                                       MMCI_PINCTRL_STATE_PUSHPULL);
>> +               if (IS_ERR(pins))
>> +                       dev_warn(mmc_dev(mmc), "Cannot select pin drive type via pinctrl\n");
>> +               else
>> +                       pinctrl_select_state(host->pinctrl, pins);
>>          }
>>
>>          /*
>> @@ -1609,6 +1637,14 @@ static int mmci_probe(struct amba_device *dev,
>>          host = mmc_priv(mmc);
>>          host->mmc = mmc;
>>
>> +       if (!variant->opendrain) {
>> +               host->pinctrl = devm_pinctrl_get(&dev->dev);
>> +               if (IS_ERR(host->pinctrl)) {
>> +                       dev_err(&dev->dev, "failed to get pinctrl");
>> +                       goto host_free;
>> +               }
>> +       }
>> +
>>          host->hw_designer = amba_manf(dev);
>>          host->hw_revision = amba_rev(dev);
>>          dev_dbg(mmc_dev(mmc), "designer ID = 0x%02x\n", host->hw_designer);
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 83160a9..de3d0b3 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -192,6 +192,10 @@
>>
>>   #define NR_SG          128
>>
>> +/* pinctrl configs */
>> +#define MMCI_PINCTRL_STATE_PUSHPULL "default"
> 
> Seems like we should be able to cope fine without having to add a
> separate define for the PUSHPULL, but rather just select the default
> state instead.

yes agree

Thanks

Patrice

> 
>> +#define MMCI_PINCTRL_STATE_OPENDRAIN "opendrain"
>> +
>>   struct clk;
>>   struct variant_data;
>>   struct dma_chan;
>> @@ -227,6 +231,7 @@ struct mmci_host {
>>          bool                    vqmmc_enabled;
>>          struct mmci_platform_data *plat;
>>          struct variant_data     *variant;
>> +       struct pinctrl          *pinctrl;
>>
>>          u8                      hw_designer;
>>          u8                      hw_revision:4;
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 
