From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 20 Mar 2014 11:09:03 -0500
Subject: [PATCH 1/1] regulator: Add new driver for ST's PWM controlled
 voltage regulators
In-Reply-To: <20140320154827.GE8207@lee--X1>
References: <1395324654-8235-1-git-send-email-lee.jones@linaro.org>
 <20140320152837.GW18529@joshc.qualcomm.com>
 <20140320154827.GE8207@lee--X1>
Message-ID: <20140320160903.GX18529@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 03:48:27PM +0000, Lee Jones wrote:
[..]
> > > +	dutycycle = (ST_PWM_REG_PERIOD / 100) *
> > > +		drvdata->duty_cycle_table[sel].dutycycle;
> > 
> > Considering (ST_PWM_REG_PERIOD / 100) is constant, could you get away
> > with dropping this calculation by just putting the already-adjusted
> > values into your duty cycle table?
> 
> I thought about this, but I settled on this way for clarity. Also,
> this is only a constant if no one decides to change the period, so the
> calculation needs to be done somewhere. Did you have something better
> in mind?

I was merely suggesting something like:

	#define T(uV, _duty) { uV, (ST_PWM_REG_PERIOD / 100) * _duty }
	
	static const struct st_pwm_voltages b2105_duty_cycle_table[] = {
		T(1114000,  0),
		T(1095000, 10),
		T(1076000, 20),
		T(1056000, 30),
		T(1036000, 40),
		T( 996000, 50),
	};

But, meh, it's marginally more complicated and doesn't save much, so
I'll leave it up to you to decide whether or not you'd want to change
it.

> > > +static int st_pwm_regulator_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	struct st_pwm_regulator_data *drvdata;
> > > +	const struct of_device_id *of_match;
> > > +	struct regulator_dev *regulator;
> > > +	struct regulator_config config = { };
> > > +
> > > +	if (!np) {
> > > +		dev_err(&pdev->dev, "Device Tree node missing\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	of_match = of_match_device(st_pwm_of_match, &pdev->dev);
> > > +	if (!of_match) {
> > > +		dev_err(&pdev->dev, "failed to match of device\n");
> > > +		return -ENODEV;
> > > +	}
> > > +	drvdata =  (struct st_pwm_regulator_data *) of_match->data;
> > 
> > Hrm, I typed "cast not necessary here", but then I realized it is
> > necessary since you using it to cast away constness.
> 
> This is remnant from when I was doing something unessersariy
> complcated in a previous (unpublished/personal) revision. I'll take a
> look at this too, thanks.
> 
> > Are you safe assuming that there will only be one of these devices in a
> > system?  It doesn't seem like much a burden to just allocate a new
> > object and use it instead of a statically allocated one.
> 
> I have written this driver to be expandable. We have new systems
> coming out which contain more than one of these regulators. Unless I'm
> missing your meaning?

Sorry I was unclear.  I'm really asking about feasibility of multiple
instances of the same device (in this case the b2105).  The way the
driver is currently written, this wouldn't work because the instance
shared in the static b2105_info object.

As long as you've at least thought about this case, then I'm satisfied.

Thanks,
  Josh

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
