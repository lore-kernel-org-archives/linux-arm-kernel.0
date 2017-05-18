From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 May 2017 08:51:00 +0200
Subject: [PATCH v2] iio: adc: sun4i-gpadc-iio: fix parent device being
 used in devm function
In-Reply-To: <20170518063607.11069-1-quentin.schulz@free-electrons.com>
References: <20170518063607.11069-1-quentin.schulz@free-electrons.com>
Message-ID: <20170518065100.bn2t7ef2pw4wfaia@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 08:36:07AM +0200, Quentin Schulz wrote:
> For the sake of DT binding stability, this IIO driver is a child of an
> MFD driver for Allwinner A10, A13 and A31 because there already exists a
> DT binding for this IP. The MFD driver has a DT node but the IIO driver
> does not.
> 
> The IIO device registers the temperature sensor in the thermal framework
> using the DT node of the parent, the MFD device, so the thermal
> framework could match the phandle to the MFD device in the DT and the
> struct device used to register in the thermal framework.
> 
> devm_thermal_zone_of_sensor_register was previously used to register the
> thermal sensor with the parent struct device of the IIO device,
> representing the MFD device. By doing so, we registered actually the
> parent in the devm routine and not the actual IIO device.
> 
> This lead to the devm unregister function not being called when the IIO
> module driver is removed. It resulted in the thermal framework still
> polling the get_temp function of the IIO module while the device doesn't
> exist anymore, thus generated a kernel panic.
> 
> Use the non-devm function instead and do the unregister manually in the
> remove function.
> 
> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170518/aa33baf0/attachment.sig>
