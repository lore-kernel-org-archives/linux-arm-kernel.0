From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 17 Mar 2015 11:37:46 +0100
Subject: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
In-Reply-To: <940EE988-03A4-4B1B-A168-959E367953A6@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
 <20150317084730.GA9761@amd>
 <940EE988-03A4-4B1B-A168-959E367953A6@goldelico.com>
Message-ID: <20150317103746.GB3759@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >>> to introduce coefficients for temperature and discharge rate?
> >> What do you mean? Nothing like that is used in current driver why do
> >> we need to add it?
> > 
> > Well, conversion between Li-ion's voltage and state of charge at 0
> > current is well known:
> 
> We can?t measure at 0 current since the OMAP is driven from battery
> and charger and may also draw some mA?

Yes, but you know how many mA you are taking just now. So if you knew
the internal resistance, you could compute the voltage at 0
current. (And it should also work during charging, as long as you know
how much current is going in.)

> >    def percent(m, v):
> >    	u = 0.0387-(1.4523*(3.7835-v))
> >        if u < 0:
> >            return 0
> >          return (0.1966+math.sqrt(u))*100
> > 
> > And there's not much to calibrate there, and it should become library
> > helper function; there's no need to write it to every single dts.
> > 
> > The charge/discharge difference is due to internal battery resistance,
> > and Ohm's law. (Then, you should not need different values for
> > charging/discharging case.)
> 
> Yes, and that also depends on the board and battery type. So you always
> need to specify some battery specific coefficient for that in the DT.

Yes, and that coefficient should be internal battery resistance ;-).

> We simply did choose a table, because calculating the right coefficients
> is more complex and getting the table values can easily be done from
> running one full charge-discharge-charge cycle.

Well.. One set of coefficients would be kind of ok. But you are doing
two, because it really depends on current, not charge/discharge. So
why not do it right, for all currents...?

> > With your aproach, you'll get lower percentage when phone is under
> > load vs. idle. Taking internal resistance into account would give you
> > more precise readings. (Attached, old patch for zaurus shows the
> > needed computation).
> 
> This is why we have a charging and a discharging table to compensate
> for this effect.

Yes, but there's very different current during "idle" phone and during
call (for example). So yes, you are compensating for different current
during charge and discharge, but it is possible to do better.

> > I guess this should go into library somewhere, because many machines
> > need similar code.
> 
> Is a library easier to maintain and handle than just a set of table
> values?

I think so, yes, because otherwise you need a set of tables for each
machine.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
