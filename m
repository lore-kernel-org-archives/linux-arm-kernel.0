From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 15 May 2017 11:18:45 +0200
Subject: [PATCH] iio: adc: sun4i-gpadc-iio: fix parent device being used
 in devm function
In-Reply-To: <20170515091148.gk2zvtjy5bdpbfzt@flea.home>
References: <20170515073902.25994-1-quentin.schulz@free-electrons.com>
 <20170515091148.gk2zvtjy5bdpbfzt@flea.home>
Message-ID: <73eb7674-dba9-8bdf-c886-6ad8177f4c1b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 15/05/2017 11:11, Maxime Ripard wrote:
> On Mon, May 15, 2017 at 09:39:02AM +0200, Quentin Schulz wrote:
>> For the sake of DT binding stability, this IIO driver is a child of an
>> MFD driver for Allwinner A10, A13 and A31 because there already exists a
>> DT binding for this IP. The MFD driver has a DT node but the IIO driver
>> does not.
>>
>> The IIO device registers the temperature sensor in the thermal framework
>> using the DT node of the parent, the MFD device, so the thermal
>> framework could match the phandle to the MFD device in the DT and the
>> struct device used to register in the thermal framework.
>>
>> devm_thermal_zone_of_sensor_register was previously used to register the
>> thermal sensor with the parent struct device of the IIO device,
>> representing the MFD device. By doing so, we registered actually the
>> parent in the devm routine and not the actual IIO device.
>>
>> This lead to the devm unregister function not being called when the IIO
>> module driver is removed. It resulted in the thermal framework still
>> polling the get_temp function of the IIO module while the device doesn't
>> exist anymore, thus generated a kernel panic.
>>
>> Use the non-devm function instead and do the unregister manually in the
>> remove function.
>>
>> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>> ---
[...]
>> @@ -688,6 +687,12 @@ static int sun4i_gpadc_remove(struct platform_device *pdev)
>>  
>>  	pm_runtime_put(&pdev->dev);
>>  	pm_runtime_disable(&pdev->dev);
>> +
>> +	if (pdev->dev.of_node)
>> +		thermal_zone_of_sensor_unregister(&pdev->dev, info->tzd);
>> +	else
>> +		thermal_zone_of_sensor_unregister(pdev->dev.parent, info->tzd);
>> +
> 
> Can't we just store the device used to create the zone in the
> structure as well, that would avoid that non-trivial logic.
> 

Yes we could.

I've that same condition in the probe function, if pdev->dev.of_node
then I continue in the probe dedicated to device probed from DT, or I
continue with the probe dedicated to device probed via MFD.

The thermal_zone_of_sensor_register is different in those two functions,
thus, I thought that it would make more sense to replicate the same
condition in the remove to make the relation between the device used in
thermal_zone_of_sensor_register and unregister clear.

That's just a matter of taste for me, so I'm definitely ok to write a v2
for this change.

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170515/5305d5bb/attachment.sig>
