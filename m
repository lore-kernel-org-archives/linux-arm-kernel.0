From: anson.huang@nxp.com (Anson Huang)
Date: Mon, 14 May 2018 09:10:56 +0000
Subject: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
In-Reply-To: <5a449fc0-4d3e-c7c7-0e9a-43efb4b909cf@pengutronix.de>
References: <1526285359-17978-1-git-send-email-Anson.Huang@nxp.com>
 <5a449fc0-4d3e-c7c7-0e9a-43efb4b909cf@pengutronix.de>
Message-ID: <AM3PR04MB1315B6320421800346313075F59C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Bastian Stender [mailto:bst at pengutronix.de]
> Sent: Monday, May 14, 2018 4:37 PM
> To: Anson Huang <anson.huang@nxp.com>; shawnguo at kernel.org;
> s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> rjw at rjwysocki.net; viresh.kumar at linaro.org; rui.zhang at intel.com;
> edubezval at gmail.com
> Cc: devicetree at vger.kernel.org; linux-pm at vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 1/3] thermal: imx: remove cpufreq cooling registration
> 
> Hi,
> 
> On 05/14/2018 10:09 AM, Anson Huang wrote:
> > This patch removes cpufreq cooling registration in thermal .probe
> > function, cpufreq cooling should be done in cpufreq driver when it is
> > ready.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> It seems you are trying to achieve something similar to a patch I sent a couple
> of month ago. Unfortunately I did not have the time to rework it yet:
> 
> 
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.kernel.org%2Fpatch%2F10059085%2F&data=02%7C01%7Canson.huang
> %40nxp.com%7C179da3635cab4a14deef08d5b975ecb6%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C636618838508978629&sdata=BcQ9tc%2BE
> CZ%2Fk4AsZFxshgmvSsPg7eRN0ASzP8LO8yBI%3D&reserved=0
> 
> Some of the comments might apply here too.
 
Ah, I did NOT notice this thread, so how to proceed, will you continue to finish your patch?
If yes, then you can just ignore/skip my patch, thanks.

Anson.

> 
> Regards,
> Bastian
> 
> > ---
> >   drivers/thermal/imx_thermal.c | 16 ----------------
> >   1 file changed, 16 deletions(-)
> >
> > diff --git a/drivers/thermal/imx_thermal.c
> > b/drivers/thermal/imx_thermal.c index c30dc21..8eedb97 100644
> > --- a/drivers/thermal/imx_thermal.c
> > +++ b/drivers/thermal/imx_thermal.c
> > @@ -9,7 +9,6 @@
> >
> >   #include <linux/clk.h>
> >   #include <linux/cpufreq.h>
> > -#include <linux/cpu_cooling.h>
> >   #include <linux/delay.h>
> >   #include <linux/device.h>
> >   #include <linux/init.h>
> > @@ -207,7 +206,6 @@ static struct thermal_soc_data thermal_imx7d_data
> = {
> >   struct imx_thermal_data {
> >   	struct cpufreq_policy *policy;
> >   	struct thermal_zone_device *tz;
> > -	struct thermal_cooling_device *cdev;
> >   	enum thermal_device_mode mode;
> >   	struct regmap *tempmon;
> >   	u32 c1, c2; /* See formula in imx_init_calib() */ @@ -729,22
> > +727,12 @@ static int imx_thermal_probe(struct platform_device *pdev)
> >   		return -EPROBE_DEFER;
> >   	}
> >
> > -	data->cdev = cpufreq_cooling_register(data->policy);
> > -	if (IS_ERR(data->cdev)) {
> > -		ret = PTR_ERR(data->cdev);
> > -		dev_err(&pdev->dev,
> > -			"failed to register cpufreq cooling device: %d\n", ret);
> > -		cpufreq_cpu_put(data->policy);
> > -		return ret;
> > -	}
> > -
> >   	data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
> >   	if (IS_ERR(data->thermal_clk)) {
> >   		ret = PTR_ERR(data->thermal_clk);
> >   		if (ret != -EPROBE_DEFER)
> >   			dev_err(&pdev->dev,
> >   				"failed to get thermal clk: %d\n", ret);
> > -		cpufreq_cooling_unregister(data->cdev);
> >   		cpufreq_cpu_put(data->policy);
> >   		return ret;
> >   	}
> > @@ -759,7 +747,6 @@ static int imx_thermal_probe(struct platform_device
> *pdev)
> >   	ret = clk_prepare_enable(data->thermal_clk);
> >   	if (ret) {
> >   		dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
> > -		cpufreq_cooling_unregister(data->cdev);
> >   		cpufreq_cpu_put(data->policy);
> >   		return ret;
> >   	}
> > @@ -775,7 +762,6 @@ static int imx_thermal_probe(struct platform_device
> *pdev)
> >   		dev_err(&pdev->dev,
> >   			"failed to register thermal zone device %d\n", ret);
> >   		clk_disable_unprepare(data->thermal_clk);
> > -		cpufreq_cooling_unregister(data->cdev);
> >   		cpufreq_cpu_put(data->policy);
> >   		return ret;
> >   	}
> > @@ -811,7 +797,6 @@ static int imx_thermal_probe(struct platform_device
> *pdev)
> >   		dev_err(&pdev->dev, "failed to request alarm irq: %d\n", ret);
> >   		clk_disable_unprepare(data->thermal_clk);
> >   		thermal_zone_device_unregister(data->tz);
> > -		cpufreq_cooling_unregister(data->cdev);
> >   		cpufreq_cpu_put(data->policy);
> >   		return ret;
> >   	}
> > @@ -831,7 +816,6 @@ static int imx_thermal_remove(struct
> platform_device *pdev)
> >   		clk_disable_unprepare(data->thermal_clk);
> >
> >   	thermal_zone_device_unregister(data->tz);
> > -	cpufreq_cooling_unregister(data->cdev);
> >   	cpufreq_cpu_put(data->policy);
> >
> >   	return 0;
> >
> 
> --
> Pengutronix e.K.
> Industrial Linux Solutions
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&data=02%7C01%7Canson.huang%40nxp.com%7C179da36
> 35cab4a14deef08d5b975ecb6%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C636618838508978629&sdata=kHHjnbmj2kV0aPlAvULXUh%2Fm%2Fp
> gbu21luMQ6jfIUgLo%3D&reserved=0
> Peiner Str. 6-8, 31137 Hildesheim, Germany Amtsgericht Hildesheim, HRA 2686
