From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 17 Dec 2015 15:00:35 +0100
Subject: [PATCH 2/3] pwm: Add PWM driver for OMAP using dual-mode timers
In-Reply-To: <20151216162747.GL28947@ulmo>
References: <5637458D.60106@baylibre.com> <20151216162747.GL28947@ulmo>
Message-ID: <5672C003.3010105@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,
On 12/16/2015 05:27 PM, Thierry Reding wrote:
> I've applied this with some coding style bikeshedding applied. Also I
> think there's a timer leak in the probe function:
Indeed, the coding style had some root for ameliorations ! Thanks !
I also missed this timer leak, thanks for the fix.
>
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> [...]
>> +static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
>> +{
> [...]
>> +	dm_timer = pdata->request_by_node(timer);
>> +	if (!dm_timer)
>> +		return -EPROBE_DEFER;
>
> dm_timer holds the requested timer now.
>
>> +
>> +	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
>> +	if (!omap)
>> +		return -ENOMEM;
>
> But it's not released when this allocation fails...
>
>> +
>> +	omap->pdata = pdata;
>> +	omap->dm_timer = dm_timer;
>> +	omap->dm_timer_pdev = of_find_device_by_node(timer);
>> +	if (!omap->dm_timer_pdev) {
>> +		dev_err(&pdev->dev, "Unable to find timer pdev\n");
>> +		return -EINVAL;
>> +	}
>
> ... nor when this lookup fails. I've taken the liberty of adding two
> calls to omap->pdata->free(dm_timer) to these error paths.
Perfect !

> Please take a look at what's in the pwm/for-next branch to see if it
> still works correctly.
I had a look against my original patch and it should be ok, I will still hook it up back
on the real HW in case we forgot something.

> Thanks,
> Thierry
>

Thanks !
Neil


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151217/ee7ebea6/attachment.sig>
