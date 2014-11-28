From: edubezval@gmail.com (Eduardo Valentin)
Date: Fri, 28 Nov 2014 09:14:27 -0400
Subject: [PATCHv2 1/1] thermal: cpu_cooling: check for the readiness of
 cpufreq layer
In-Reply-To: <20141128111824.533c4641@jawa>
References: <1417097577-3548-1-git-send-email-edubezval@gmail.com>
 <CAKohponu_PRrqsuMdCJDznhiO_-=iCaYPhCCad8F4WS3rNxo5A@mail.gmail.com>
 <20141128111824.533c4641@jawa>
Message-ID: <20141128131425.GA23622@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello Folks,

On Fri, Nov 28, 2014 at 11:18:24AM +0100, Lukasz Majewski wrote:
> On Fri, 28 Nov 2014 13:35:49 +0530
> Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > On 27 November 2014 at 19:42, Eduardo Valentin <edubezval@gmail.com>
> > wrote:
> > > (I'm sorry VireshK, I am still using my normal practice) :-)
> > 
> > That's fine :)
> > 
> > > diff --git a/drivers/thermal/cpu_cooling.c
> > > b/drivers/thermal/cpu_cooling.c index 1ab0018..bed3fa2 100644
> > > --- a/drivers/thermal/cpu_cooling.c
> > > +++ b/drivers/thermal/cpu_cooling.c
> > > @@ -440,6 +440,11 @@ __cpufreq_cooling_register(struct device_node
> > > *np, int ret = 0, i;
> > >         struct cpufreq_policy policy;
> > >
> > > +       if (!cpufreq_frequency_get_table(0)) {
> > > +               pr_err("cpu_cooling: cpufreq layer not ready!
> > > Deferring.\n");
> > 
> > Throwing an error here doesn't look to be the right thing. Ultimately
> > we will register the cooling dev when probed again after some time.
> > 
> > So, a pr_debug() suits more here.
> > 

Yeah, I agree here. 

> > Also, this breaks existing exynos thermal drivers as they don't handle
> > -EPROBE_DEFER well right now.
> 
> Unfortunately Viresh is correct here. Current (before rework) Exynos
> TMU driver expects that cpu_cooling device will succeed.
> 


Well, I wouldn't say unfortunately, but fortunately! :-)

Ok. But I believe it is a matter of propagating the error code. As I
included in this patch: 

diff --git a/drivers/thermal/samsung/exynos_thermal_common.c b/drivers/thermal/samsung/exynos_thermal_common.c
index 3f5ad25..f84975e 100644
--- a/drivers/thermal/samsung/exynos_thermal_common.c
+++ b/drivers/thermal/samsung/exynos_thermal_common.c
@@ -373,7 +373,7 @@ int exynos_register_thermal(struct thermal_sensor_conf *sensor_conf)
 		if (IS_ERR(th_zone->cool_dev[th_zone->cool_dev_size])) {
 			dev_err(sensor_conf->dev,
 				"Failed to register cpufreq cooling device\n");
-			ret = -EINVAL;
+			ret = PTR_ERR(th_zone->cool_dev[th_zone->cool_dev_size]);
 			goto err_unregister;
 		}
 		th_zone->cool_dev_size++;



> > 
> > I reached here, because one of my patches had something similar to
> > what you wrote. Just for this file though, haven't updated any other
> > drivers though.
> > 
> > Will be sending you my small patchset by end of day today, please see
> > if they make any sense at all..

The version you sent (for exynos) is better because there is a check for
not print error messages in case of deferring.

However, I would prefer, at least to what comes to deferring, to update
the drivers altogether with the inclusion of the check in cpu cooling.
This way the change in behavior is atomic, in terms of commit changes.

Viresh, if you don't mind, I will merge your patch 04/26 into this one.

> 
> Best regards,
> ?ukasz Majewski

BR, Eduardo Valentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/b9ae03e8/attachment.sig>
