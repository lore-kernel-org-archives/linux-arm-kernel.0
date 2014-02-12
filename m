From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 12 Feb 2014 15:27:40 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAwNy8xMl0gbWZkOiBzeXNjb246IENvbnNpZGVyIHBsYXRm?=
 =?UTF-8?B?b3JtIGRhdGEgYSByZWdtYXAgY29uZmlnIG5hbWU=?=
In-Reply-To: <1392203209.3380.57.camel@hornet>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <20140212082657.GK15081@lee--X1> <1392203209.3380.57.camel@hornet>
Message-ID: <1392204460.1197803@f433.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?????, 12 ??????? 2014, 11:06 UTC ?? Pawel Moll <pawel.moll@arm.com>:
> On Wed, 2014-02-12 at 08:26 +0000, Lee Jones wrote:
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

Yeah, I gave up the idea to use the syscon_ids[] to separate devices for
non-DT case.
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/mfd/syscon.c?id=5104d2656d4874c51868dc7182016e9501ec99ca
Instead, I use a hard definition for pdev->id, so that the names of
syscon-devices are different and can be obtained from the driver
it uses with syscon_regmap_lookup_by_pdevname().
I understand this topic correct?

---
