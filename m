From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sun, 29 Jul 2018 21:27:44 +0200
Subject: [PATCH v3 01/23] thermal: armada: add a function that sanitizes
 the thermal zone name
In-Reply-To: <f1d7e8bd-329f-0c9d-c296-0afbe871058f@linaro.org>
References: <20180716144206.30985-1-miquel.raynal@bootlin.com>
 <20180716144206.30985-2-miquel.raynal@bootlin.com>
 <84f97022-a470-f314-ee75-e5afb733bea5@linaro.org>
 <20180727135230.3c7102c7@xps13>
 <f1d7e8bd-329f-0c9d-c296-0afbe871058f@linaro.org>
Message-ID: <20180729212744.31cf0747@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Daniel Lezcano <daniel.lezcano@linaro.org> wrote on Fri, 27 Jul 2018
17:29:52 +0200:

> On 27/07/2018 13:52, Miquel Raynal wrote:
> > Hi Daniel,
> > 
> > Daniel Lezcano <daniel.lezcano@linaro.org> wrote on Fri, 27 Jul 2018
> > 13:34:19 +0200:
> >   
> >> On 16/07/2018 16:41, Miquel Raynal wrote:  
> >>> Thermal zone names must follow certain rules imposed by the framework.
> >>> They are limited in length and shall not have any hyphen '-'.
> >>>
> >>> This is done in a separate function for future use in another location.
> >>>
> >>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>    
> >>
> >> Why do you have to provide a function to test that?
> >>
> >> Logically, the one who did the change to add a thermal name, should
> >> check its code works. Without a proper name that won't work.  
> > 
> > What do you mean "the one who did the change"?
> > I think the thermal core should not care that much to what is given as
> > name and should probably not be so strict.
> > 
> > Also, I don't choose what dev_name() returns, it's in the device tree
> > and the device tree do not care about the implementation, it's just a
> > descriptive file.
> >   
> >>
> >> So this function is testing something which should be already tested, no?  
> > 
> > I don't think it is. Without this function the probe will simply fail.
> > 
> > The explanation of what fails is in the code:
> >   
> >>> +		/*
> >>> +		 * When inside a system controller, the device name has the
> >>> +		 * form: f06f8000.system-controller:ap-thermal so stripping
> >>> +		 * after the ':' should give us a shorter but meaningful name.
> >>> +		 */
> >>> +		name = strrchr(name, ':');
> >>> +		if (!name)
> >>> +			name = "armada_thermal";
> >>> +		else
> >>> +			name++;  
> > 
> > [...]  
> 
> I'm not in favor of this, potentially it can introduce a break which can
> be exploited later.

I know, I don't like this neither but that was the best way IMHO to
handle the core's limitations.

> 
> You are creating the thermal zones manually from the driver but want to
> rely on the temperature controller name to give a name to the thermal zone.
> 
> Why not create the thermal zone in the DT with the correct name and use
> devm_thermal_zone_of_sensor_register ?

That's exactly what is done later in the series actually, but for DT
backward compatibility and in order to continue adding feature to this
driver, we must ensure there won't be any drawback for people using old
DT with deprecated thermal representation.


Thanks for reviewing, if you don't mind I could copy you in future
changes? Unfortunately for this series it's already been applied and I
would like not to do any deep changes before it's merged, but for sure
this function could be enhanced.

Kind regards,
Miqu?l
