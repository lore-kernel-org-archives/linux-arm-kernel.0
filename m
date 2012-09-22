From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 22 Sep 2012 21:42:50 +0200
Subject: [PATCH v2] PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE,
 even when disabled
In-Reply-To: <Pine.LNX.4.44L0.1209221131320.7497-100000@netrider.rowland.org>
References: <Pine.LNX.4.44L0.1209221131320.7497-100000@netrider.rowland.org>
Message-ID: <201209222142.51183.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, September 22, 2012, Alan Stern wrote:
> On Sat, 22 Sep 2012, Rafael J. Wysocki wrote:
> 
> > On Saturday, September 22, 2012, Kevin Hilman wrote:
> 
> > OK, this looks good to me, thanks!
> > 
> > Alan, what do you think?
> > 
> > Rafael
> 
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -509,6 +509,9 @@ static int rpm_resume(struct device *dev, int rpmflags)
> > >   repeat:
> > >  	if (dev->power.runtime_error)
> > >  		retval = -EINVAL;
> > > +	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
> > > +		 && dev->power.runtime_status == RPM_ACTIVE)
> > > +		retval = 1;
> > >  	else if (dev->power.disable_depth > 0)
> > >  		retval = -EACCES;
> > >  	if (retval)
> 
> Well, I'd prefer the indentation on the continuation line to be 
> different from the indentation of the following line, and I'd prefer 
> to have a comment explaining the reason for the exception.
> 
> But these are only matters of taste; the implementation itself looks 
> good.

Thanks!

I've applied the patch as v3.7 material (and fixed up the white space).

Rafael
