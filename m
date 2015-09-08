From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 8 Sep 2015 15:24:27 +0530
Subject: [PATCH-v2 4/7] mmc: sdhci-pxav3: Add pinctl setting according to
 bus clock
In-Reply-To: <20150908145439.046dfe0d@xhacker>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
 <20150908145439.046dfe0d@xhacker>
Message-ID: <55EEB053.4080109@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 08 September 2015 12:24 PM, Jisheng Zhang wrote:
> On Mon, 7 Sep 2015 16:48:38 +0530
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>
>> Different bus clock may need different pin setting.
>> For example, fast bus clock like 208Mhz need pin drive fast
>> while slow bus clock prefer pin drive slow to guarantee
>> signal quality.
>>
>> So this patch creates two states,
>>    - Default (slow/normal) pin state
>>    - And fast pin state for higher freq bus speed.
>>
>> And selection of pin state is done based on timing mode.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>>   drivers/mmc/host/sdhci-pxav3.c | 45 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> index c2b2b78..d933f75 100644
>> --- a/drivers/mmc/host/sdhci-pxav3.c
>> +++ b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/pm.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/mbus.h>
>> +#include <linux/pinctrl/consumer.h>
>>
>>   #include "sdhci.h"
>>   #include "sdhci-pltfm.h"
>> @@ -92,6 +93,10 @@ struct sdhci_pxa {
>>   	void __iomem *io_pwr_reg;
>>   	void __iomem *io_pwr_lock_reg;
>>   	struct sdhci_pxa_data *data;
>> +
>> +	struct pinctrl *pinctrl;
>> +	struct pinctrl_state *pins_default;
>> +	struct pinctrl_state *pins_fast;
>>   };
>>
>>   static struct sdhci_pxa_data pxav3_data_v1 = {
>> @@ -298,6 +303,33 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
>>   	pxa->power_mode = power_mode;
>>   }
>>
>> +static int pxav3_select_pinstate(struct sdhci_host *host, unsigned int uhs)
>> +{
>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +	struct sdhci_pxa *pxa = pltfm_host->priv;
>> +	struct pinctrl_state *pinctrl;
>> +
>> +	if (IS_ERR(pxa->pinctrl) ||
>> +		IS_ERR(pxa->pins_default) ||
>> +		IS_ERR(pxa->pins_fast))
>> +		return -EINVAL;
>> +
>> +	switch (uhs) {
>> +	case MMC_TIMING_UHS_SDR50:
>> +	case MMC_TIMING_UHS_SDR104:
>> +	case MMC_TIMING_MMC_HS200:
>> +	case MMC_TIMING_MMC_HS400:
>
> Are you sure this IP can support HS400?
>
>> +		pinctrl = pxa->pins_fast;


No it does not.

The reason I put it here is,
code under discussion is related to pinctrl configuration, so for all
higher bus speed mode we want to set pins into fast mode.

And from hs400 perspective, I would expect it must get handled much
before than this stage and should not reach here at all.

So this portion of the code is complete in itself.

I hope I clarified your doubt.

Thanks,
Vaibhav
