From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 13:52:48 +0000
Subject: [PATCH 04/18] power: ab8500_fg: Replace msleep() with
 usleep_range() for greater accuracy
In-Reply-To: <201301151323.28879.arnd@arndb.de>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
 <1358183857.19400.13.camel@joe-AO722>
 <20130115084821.GT12385@gmail.com>
 <201301151323.28879.arnd@arndb.de>
Message-ID: <20130115135248.GB9379@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > @@ -956,7 +956,7 @@ static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
> > > >     do {
> > > >             vbat += ab8500_fg_bat_voltage(di);
> > > >             i++;
> > > > -           msleep(5);
> > > > +           usleep_range(5000, 5001);
> > > 
> > > If you're going to give a range that small
> > > you might as well use usleep instead.
> > > 
> > > Otherwise, add some tolerance to allow any
> > > other coalesced wakeup to occur.
> > 
> > I can't increase the tolerance, as I don't know how that would
> > effect the running of the system, and the person who would know
> > is off on parental leave.
> 
> The function only averages the voltage between a couple of readings.
> It won't change much if those register reads are slightly more
> uniformly timed. Note that the thread can still be preempted for
> a much longer time if anything else is running, and

Okay, I'll fixup to have a more sensible range.

> the entire
> interrupt handling in this driver looks so fragile that I would
> not rely on the interrupt actually happening at the right time
> anyway. I think it should first be debugged properly to remove
> the need for the enable_irq/disable_irq calls.

Yes, I remember discussing this with you before and I've since
placed it on my TODO list. However, I'm really shying away from
it for the moment, as this patch-set only applies <20 out of the
70+ outstanding patches left in the internal kernel's delta. To
avoid any unnecessary fixups, I'll apply those kinds of fixes at
the end of the set.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
