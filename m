From: vigneshr@ti.com (Vignesh R)
Date: Mon, 17 Nov 2014 17:48:27 +0530
Subject: [PATCH v4 2/6] input: touchscreen: ti_am335x_tsc: Remove udelay
 in interrupt handler
In-Reply-To: <20141117082337.GA3946@localhost.localdomain>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-3-git-send-email-vigneshr@ti.com>
 <20141115192739.GA18766@localhost.localdomain> <54697919.5030302@ti.com>
 <20141117082337.GA3946@localhost.localdomain>
Message-ID: <5469E793.80909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 17 November 2014 01:53 PM, Richard Cochran wrote:
> On Mon, Nov 17, 2014 at 09:57:05AM +0530, Vignesh R wrote:
>> My patches are based on v3.18rc2. I tested my patches on am335x-evm
>> using tslib.
> 
> No beaglebone + cape testing?
> 
>> Please explain "touch is broken"? What is the behaviour of TSC?
> 
> With plain v3.17 plus your series, the cursor is almost never near the
> pen. Mostly it jitters around the right hand edge.
> 
> My customer had already changed the step delay (I think by trial and
> error, not sure) in order to get the cursor near the pen. I ported
> this change onto your series (see patch, below), but still the pen up
> event causes a huge cursor jump.
> 
> (Again, I did solve the pen up issue, but in a totally different
> way. I never posted the fix, because I could not be sure that it would
> work on a wide variety of boards.)
> 
>> Which ADC channels are being used for TSC?
> 
> &tscadc {
> 	status = "okay";
> 	tsc {
> 		ti,wires = <4>;
> 		ti,x-plate-resistance = <300>;
> 		ti,coordinate-readouts = <5>;
> 		ti,wire-config = <0x00 0x11 0x23 0x32>;
> 	};

What is the ti,charge-delay value you have tried?
Try setting it to 0xB000 and experiment.

> 
> 	adc {
> 		ti,adc-channels = <5 6 7>;
> 	};
> };
> 
> So for this particular design, your series really does not help, not
> even a little. You did not test the series on many boards. I am
> concerned that this series only works on the one board you did test,
> and that it may break functionality on other people's boards.
> 

I just have one am335x-evm available. I will search for a beaglebone
cape and test the patches. Let Sebastian, Johannes come back with their
results. If the series works on multiple boards then, I believe, this
series can go in.

Regards
Vignesh

> Thanks,
> Richard
> 
> ---
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
> index b84493f..77a4883 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -148,7 +148,7 @@ static void titsc_step_config(struct titsc *ts_dev)
>  	end_step = first_step + tsc_steps;
>  	for (i = end_step - ts_dev->coordinate_readouts; i < end_step; i++) {
>  		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
> -		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
> +		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY | STEPDELAY_SAMPLE(20));
>  	}
>  
>  	config = 0;
> @@ -172,7 +172,7 @@ static void titsc_step_config(struct titsc *ts_dev)
>  	end_step = first_step + ts_dev->coordinate_readouts;
>  	for (i = first_step; i < end_step; i++) {
>  		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
> -		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
> +		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY | STEPDELAY_SAMPLE(20));
>  	}
>  
>  	/* Make CHARGECONFIG same as IDLECONFIG */
> @@ -188,13 +188,13 @@ static void titsc_step_config(struct titsc *ts_dev)
>  			STEPCONFIG_INP(ts_dev->inp_xp);
>  	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
>  	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
> -			STEPCONFIG_OPENDLY);
> +			STEPCONFIG_OPENDLY | STEPDELAY_SAMPLE(20));
>  
>  	end_step++;
>  	config |= STEPCONFIG_INP(ts_dev->inp_yn);
>  	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
>  	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
> -			STEPCONFIG_OPENDLY);
> +			STEPCONFIG_OPENDLY | STEPDELAY_SAMPLE(20));
>  
>  	/* The steps end ... end - readouts * 2 + 2 and bit 0 for TS_Charge */
>  	stepenable = 1;
> 
