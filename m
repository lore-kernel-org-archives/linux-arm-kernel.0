From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 27 Jul 2018 13:52:30 +0200
Subject: [PATCH v3 01/23] thermal: armada: add a function that sanitizes
 the thermal zone name
In-Reply-To: <84f97022-a470-f314-ee75-e5afb733bea5@linaro.org>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-2-miquel.raynal@bootlin.com>
 <84f97022-a470-f314-ee75-e5afb733bea5@linaro.org>
Message-ID: <20180727135230.3c7102c7@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Daniel Lezcano <daniel.lezcano@linaro.org> wrote on Fri, 27 Jul 2018
13:34:19 +0200:

> On 16/07/2018 16:41, Miquel Raynal wrote:
> > Thermal zone names must follow certain rules imposed by the framework.
> > They are limited in length and shall not have any hyphen '-'.
> > 
> > This is done in a separate function for future use in another location.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> Why do you have to provide a function to test that?
> 
> Logically, the one who did the change to add a thermal name, should
> check its code works. Without a proper name that won't work.

What do you mean "the one who did the change"?
I think the thermal core should not care that much to what is given as
name and should probably not be so strict.

Also, I don't choose what dev_name() returns, it's in the device tree
and the device tree do not care about the implementation, it's just a
descriptive file.

> 
> So this function is testing something which should be already tested, no?

I don't think it is. Without this function the probe will simply fail.

The explanation of what fails is in the code:

> > +		/*
> > +		 * When inside a system controller, the device name has the
> > +		 * form: f06f8000.system-controller:ap-thermal so stripping
> > +		 * after the ':' should give us a shorter but meaningful name.
> > +		 */
> > +		name = strrchr(name, ':');
> > +		if (!name)
> > +			name = "armada_thermal";
> > +		else
> > +			name++;

[...]

> > +
> > +	/* Then check there are no '-' or hwmon core will complain */

Thanks,
Miqu?l
