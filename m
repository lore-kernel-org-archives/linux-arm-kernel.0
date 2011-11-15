From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 15 Nov 2011 09:45:19 +0530
Subject: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
In-Reply-To: <20111114213026.GP31337@atomide.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
 <1320407441-29697-3-git-send-email-rnayak@ti.com>
 <20111114213026.GP31337@atomide.com>
Message-ID: <4EC1E757.2000308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 November 2011 03:00 AM, Tony Lindgren wrote:
> * Rajendra Nayak<rnayak@ti.com>  [111104 04:16]:
>> @@ -1869,6 +1957,14 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>>   	struct omap_hsmmc_host *host = NULL;
>>   	struct resource *res;
>>   	int ret, irq;
>> +	const struct of_device_id *match;
>> +
>> +	match = of_match_device(omap_mmc_of_match,&pdev->dev);
>> +	if (match) {
>> +		pdata = of_get_hsmmc_pdata(&pdev->dev);
>> +		if (match->data)
>> +			pdata->reg_offset = *(u16 *)match->data;
>> +	}
>
> So this is now using both DT and pdata?
>
> We want to use DT only, and get rid of pdata. Other than the
> deferred probe, is there some other dependency remaining to
> having to use the pdata also?

We are using pdata today mainly for the platform function pointers
that get passed for MMC, which can never be passed from DT.

The  omap_mmc_platform_data structure today has '17' function pointers.
Most might be sparingly used, nevertheless, its an awfully large number.

Here's the list...
---------
int (*switch_slot)(struct device *dev, int slot);
int (*init)(struct device *dev);
void (*cleanup)(struct device *dev);
void (*shutdown)(struct device *dev);
int (*suspend)(struct device *dev, int slot);
int (*resume)(struct device *dev, int slot);
int (*get_context_loss_count)(struct device *dev);

per-slot functions

int (*set_bus_mode)(struct device *dev, int slot, int bus_mode);
int (*set_power)(struct device *dev, int slot,
                                  int power_on, int vdd);
int (*get_ro)(struct device *dev, int slot);
int (*set_sleep)(struct device *dev, int slot, int sleep,
                                  int vdd, int cardsleep);
void (*remux)(struct device *dev, int slot, int power_on);
void (*before_set_reg)(struct device *dev, int slot,
                                        int power_on, int vdd);
void (*after_set_reg)(struct device *dev, int slot,
                                       int power_on, int vdd);
void (*init_card)(struct mmc_card *card);
int (*get_cover_state)(struct device *dev, int slot);
int (*card_detect)(struct device *dev, int slot);
---------

regards,
Rajendra

> Regards,
>
> Tony
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
