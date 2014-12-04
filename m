From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 04 Dec 2014 10:01:56 +0100
Subject: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
In-Reply-To: <548020D7.8030003@linaro.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <2596381.rFt35NU3oS@wuerfel> <548020D7.8030003@linaro.org>
Message-ID: <8625951.Wbs2MxLnhi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 December 2014 09:52:39 Daniel Lezcano wrote:
> On 12/03/2014 09:35 PM, Arnd Bergmann wrote:
> > On Wednesday 03 December 2014 07:31:22 Lina Iyer wrote:
> >>>>> +static int __init qcom_spm_init(void)
> >>>>> +{
> >>>>> +    int ret;
> >>>>> +
> >>>>> +    /*
> >>>>> +     * cpuidle driver need to registered before the cpuidle device
> >>>>> +     * for any cpu. Register the device for the the cpuidle driver.
> >>>>> +     */
> >>>>> +    ret = platform_device_register(&qcom_cpuidle_drv);
> >>>>> +    if (ret)
> >>>>> +        return ret;
> >>>> Stephen pointed out that we would have the platform device lying around
> >>>> on a non-QCOM device when using multi_v7_defconfig.
> >>>
> >>> Perhaps I am missing the point, but this is not supposed to happen, no ?
> >>>
> >> This would happen, since the file would compile on multi_v7 and we would
> >> initialize and register this device regardless. The cpuidle-qcom.c
> >> driver probe would bail out looking for a matching compatible property.
> >> So we would not register a cpuidle driver but the device would lay
> >> around.
> >
> > I think the problem is registering a platform_device. I've complained
> > about this before, but it still seems to get copied all over the
> > place. Please don't do this but have a driver that looks at DT to
> > figure out whether to access hardware or not.
> 
> We did this approach but, I can remember why, someone was complaining 
> about it also 
> 
> The platform device/driver paradigm allowed us to split the arch 
> specific parts by passing the pm ops through the platform data.
> 
> Would make sense to have a single common place for the ARM arch where we 
> initialize the platform device for cpuidle ?

No. It's really not a device, and if you pretend that it is, you get
into problems like this.

	Arnd
