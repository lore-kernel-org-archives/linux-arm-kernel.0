From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 28 Nov 2014 11:09:35 -0400
Subject: [PATCHv3 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
In-Reply-To: <20141128171024.GW3836@n2100.arm.linux.org.uk>
References: <1417186410-24551-1-git-send-email-edubezval@gmail.com>
 <20141128171024.GW3836@n2100.arm.linux.org.uk>
Message-ID: <20141128150932.GA24720@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russel,

On Fri, Nov 28, 2014 at 05:10:24PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 28, 2014 at 10:53:30AM -0400, Eduardo Valentin wrote:
> > diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
> > index 3f5ad25..d4eaa1b 100644
> > --- a/drivers/thermal/samsung/exynos_thermal_common.c
> > +++ b/drivers/thermal/samsung/exynos_thermal_common.c
> > @@ -371,9 +371,10 @@ int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf)
> >  		th_zone->cool_dev[th_zone->cool_dev_size] =
> >  					cpufreq_cooling_register(&mask_val);
> >  		if (IS_ERR(th_zone->cool_dev[th_zone->cool_dev_size])) {
> > -			dev_err(sensor_conf->dev,
> > -				"Failed to register cpufreq cooling device\n");
> > -			ret = -EINVAL;
> > +			ret = PTR_ERR(th_zone->cool_dev[th_zone->cool_dev_size]);
> > +			if (ret != -EPROBE_DEFER)
> > +				dev_err(sensor_conf->dev,
> > +					"Failed to register cpufreq cooling device\n");
> 
> Something which bugs me quite a lot is when there is an error code (which
> tells you why something didn't work) and you have an error message, and
> the error message doesn't bother printing the error code.
> 
> You might as well just print "Failed\n" and leave it at that, or md5sum
> the error message and print the sum instead. :)
> 

I like the md5sum better! :-)


> Knowing why something failed allows you to read the source, and find
> possible reasons for the failure (which could come down to one reason)
> and allows faster resolution of the problem.
> 

Sure. I will resend with the error codes in the error messages. Makes
completely sense.

Thanks for taking the time and reviewing.


Eduardo Valentin

> -- 
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/8a9daeec/attachment.sig>
