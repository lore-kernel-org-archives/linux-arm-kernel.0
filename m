From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 15 Jan 2013 08:48:21 +0000
Subject: [PATCH 04/18] power: ab8500_fg: Replace msleep() with
 usleep_range() for greater accuracy
In-Reply-To: <1358183857.19400.13.camel@joe-AO722>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
 <1357909986-9262-5-git-send-email-lee.jones@linaro.org>
 <1358183857.19400.13.camel@joe-AO722>
Message-ID: <20130115084821.GT12385@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Jan 2013, Joe Perches wrote:

> On Fri, 2013-01-11 at 13:12 +0000, Lee Jones wrote:
> > Doing so provides a greater degree of accuracy when dealing with
> > time-frames between 1us and 20ms. msleep() is only accurate for
> > wake-ups greater than 20ms.
> []
> > diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
> []
> > @@ -956,7 +956,7 @@ static int ab8500_fg_load_comp_volt_to_capacity(struct ab8500_fg *di)
> >  	do {
> >  		vbat += ab8500_fg_bat_voltage(di);
> >  		i++;
> > -		msleep(5);
> > +		usleep_range(5000, 5001);
> 
> If you're going to give a range that small
> you might as well use usleep instead.
> 
> Otherwise, add some tolerance to allow any
> other coalesced wakeup to occur.

I can't increase the tolerance, as I don't know how that would
effect the running of the system, and the person who would know
is off on parental leave.

What I can tell you is we're only using usleep_range() because
there is no usleep in the kernel. At least that's what we've
been led to believe:

Documentation/timers/timers-howto.txt:

                - Why is there no "usleep" / What is a good range?
                        Since usleep_range is built on top of hrtimers, the
                        wakeup will be very precise (ish), thus a simple
                        usleep function would likely introduce a large number
                        of undesired interrupts.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
