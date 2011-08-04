From: khilman@ti.com (Kevin Hilman)
Date: Thu, 04 Aug 2011 14:50:02 -0700
Subject: [PATCH 2/2] I2C: OMAP: remove dev->idle,
	use usage counting provided by runtime PM
In-Reply-To: <20110804150951.GU17540@legolas.emea.dhcp.ti.com> (Felipe Balbi's
	message of "Thu, 4 Aug 2011 18:09:51 +0300")
References: <1312394960-21689-1-git-send-email-khilman@ti.com>
	<1312394960-21689-3-git-send-email-khilman@ti.com>
	<20110803223604.GB4036@legolas.emea.dhcp.ti.com>
	<87ipqd449a.fsf@ti.com>
	<20110804150951.GU17540@legolas.emea.dhcp.ti.com>
Message-ID: <87oc043kz9.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Thu, Aug 04, 2011 at 07:53:37AM -0700, Kevin Hilman wrote:
>> >> @@ -1140,6 +1128,36 @@ omap_i2c_remove(struct platform_device *pdev)
>> >>  	return 0;
>> >>  }
>> >>  
>> >> +#ifdef CONFIG_PM_RUNTIME
>> >> +static int omap_i2c_runtime_suspend(struct device *dev)
>> >> +{
>> >> +	struct platform_device *pdev = to_platform_device(dev);
>> >> +	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
>> >
>> > what happened to dev_get_drvdata(dev) ??
>> >
>> 
>> Yes, that would work too since:
>> 
>> static inline void *platform_get_drvdata(const struct platform_device *pdev)
>> {
>> 	return dev_get_drvdata(&pdev->dev);
>> }
>> 
>> but IMO, readability is better if the driver does platform_set_drvdata()
>> and then the corresponding platform_get_drvdata()
>
> fair enough, but if you already have the dev pointer, what's the gain in
> doing a container_of() just to go back to the dev pointer again ?

There is no gain, but there is no loss either.  The compiler is smart
enough that the resulting assembly is the same.

> IMHO, there's really no need for that and just calling dev_get_drvdata()
> straight is enough. All in all, platform_get_[sg]et_drvdata() are just
> wrappers for dev_[sg]et_drvdata(). The whole point, was to avoid
> dev_[sg]et_drvdata(&pdev->dev).

Well, whether or not to use dev_[gs]et_* or platform_[gs]et_* is not
relevant to $SUBJECT patch. 

The current driver does platform_set_drvdata(), so I used
platform_get_drvdata() for consistency and readability.  If I were to
use dev_get* then I would want the correpsonding set changed to
dev_set_* also for consistency.

If someone wants to change both the sets and gets to the dev_ versions,
that's fine with me, but it should be separate patch.

Kevin
