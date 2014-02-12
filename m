From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Feb 2014 11:18:04 +0000
Subject: [PATCH 07/12] mfd: syscon: Consider platform data a regmap
 config name
In-Reply-To: <1392203209.3380.57.camel@hornet>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-8-git-send-email-pawel.moll@arm.com>
 <1392188982.914924525@f237.i.mail.ru>
 <20140212082657.GK15081@lee--X1> <1392203209.3380.57.camel@hornet>
Message-ID: <20140212111804.GZ15081@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > Use the device platform data as a regmap config
> > > > name. This is particularly useful in the regmap
> > > > debugfs when there is more than one syscon device
> > > > registered, to distinguish the register blocks.
> > > > 
> > > > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > > > Cc: Lee Jones <lee.jones@linaro.org>
> > > > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > > > ---
> > > ...
> > > > syscon_regmap_config.max_register = res->end - res->start - 3;
> > > > +	syscon_regmap_config.name = dev_get_platdata(&pdev->dev);
> > > 
> > > Is dev_name(&pdev->dev) can be used for such purpose?
> > 
> > Yes of course.
> > 
> > Either use the automatically generated name or over-ride with
> > dev->init_name prior to registration or call dev_set_name()
> > manually. Then retrieve with Alexander's suggestion.
> > 
> > Is there any technical reason why this is not possible with your
> > implementation?
> 
> Hold on, guys. Let me just point out that we're talking "non-DT"
> platform devices here (either statically defined struct
> platform_device-s or - my case - the MFD cells).
> 
> In this case device/driver matching relies completely on device name.
> Either the pdev->name must be identical (strcmp) to pdrv->name, or the
> pdev->name must be identical (strcmp again) to one of the pdev->id_table
> entries. See platform_match() in driver/base/platform.c for more
> details.
> 
> Therefore the dev_name(&pdev->dev) on a non-DT-originating sysconf
> devince will always return "sysconf.*", unless you're ready to maintain
> a growing syscon_ids[] list. If so, I will have to add three entries
> there ("sys_id", "sys_misc" and "sys_procid"). I hope you are not
> seriously considering this idea :-) After all that's what the
> platform_data was invented for.

Ah, I see your predicament. I guess that is a limitation of the was
syscon works. Usually we'd use match tables to differentiate between
various supported devices, but I guess the 'supported devices' list
for syscon is pretty limitless. In which case I support your second
implementation (adding a platform_data container) for the use of
arbitrary/useful-common names.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
