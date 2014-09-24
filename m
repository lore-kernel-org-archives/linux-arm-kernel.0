From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 23 Sep 2014 22:45:14 -0700
Subject: [PATCH 01/11 v6] coresight: add CoreSight core layer framework
In-Reply-To: <CANLsYkz1DhJ-DCgaUHFgmtUB+QfGDKrnbGRJQDBp=PkKvg9RMA@mail.gmail.com>
References: <1410450558-12358-1-git-send-email-mathieu.poirier@linaro.org>
 <1410450558-12358-2-git-send-email-mathieu.poirier@linaro.org>
 <20140911203344.GA7593@kroah.com>
 <CANLsYkyPFvOnqRJaWZrvw1aVjBWG=tHuv+V9Tj5RhMy_gD_oiA@mail.gmail.com>
 <20140912181601.GA21033@kroah.com>
 <CANLsYkz1DhJ-DCgaUHFgmtUB+QfGDKrnbGRJQDBp=PkKvg9RMA@mail.gmail.com>
Message-ID: <20140924054514.GA10275@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 05:09:11PM -0600, Mathieu Poirier wrote:
> On 12 September 2014 12:16, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Sep 12, 2014 at 11:41:44AM -0600, Mathieu Poirier wrote:
> >> Good morning and thanks for the review.  Pls see comments below.
> >>
> >> Mathieu
> >>
> >> On 11 September 2014 14:33, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> > Some first impressions in glancing at the code, not a complete review at
> >> > all:
> >> >
> >> > On Thu, Sep 11, 2014 at 09:49:08AM -0600, mathieu.poirier at linaro.org wrote:
> >> >> --- /dev/null
> >> >> +++ b/drivers/coresight/coresight.c
> >> >> @@ -0,0 +1,663 @@
> >> >> +/* Copyright (c) 2012, The Linux Foundation. All rights reserved.
> >> >> + *
> >> >> + * This program is free software; you can redistribute it and/or modify
> >> >> + * it under the terms of the GNU General Public License version 2 and
> >> >> + * only version 2 as published by the Free Software Foundation.
> >> >> + *
> >> >> + * This program is distributed in the hope that it will be useful,
> >> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> >> + * GNU General Public License for more details.
> >> >> + */
> >> >> +
> >> >> +#define pr_fmt(fmt) "coresight: " fmt
> >> >
> >> > MODULE_NAME ?
> >>
> >> Is this what you had in mind?
> >>
> >> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >
> > Sorry, yes, that's much better and "portable".
> >
> > But as you are using the driver model, the odds of you ever using a pr_*
> > call is all but none, so why do you even need this?
> 
> You suggest to use dev_* instead?  My (perhaps flawed) logic was that
> the framework ins't associated with a single device but a set of them.

Yes, but a single device is causing a message to be emitted, so
reference that please.

> >> >> +     struct coresight_connection *conns;
> >> >> +     int nr_conns;
> >> >> +     enum coresight_dev_type type;
> >> >> +     struct coresight_dev_subtype subtype;
> >> >> +     const struct coresight_ops *ops;
> >> >> +     struct dentry *de;
> >> >
> >> > All devices have a dentry?  in debugfs?  isn't that overkill?
> >>
> >> All devices along a "path" can require specific configuration, which
> >> can only be made by a user.  Exposing the registers via debugfs seemed
> >> like the most plausible solution.
> >
> > configuration is not to be done through debugfs, especially as that is
> > restricted to root, and lots of systems don't even have it.  debugfs is
> > always optional, don't make your code depend on it to work properly.
> 
> Humm... You are the first one to be of the opinion that debugfs
> shouldn't be used for coresight configuration - other reviewers have
> unequivocally requested that configurables be moved under debugfs.
> Debugfs seemed to be a good fit, specifically since ftrace is already
> in there.  We could enable CONFIG_DEBUG_FS automatically (the same way
> I do it for AMBA) when coresight gets enabled in the kernel config...
> 
> If not debugfs, where then?  I'd welcome a suggestion.

It is a mistake that ftrace is in debugfs, the developers of that code
admit it.

Your system should be able to run just fine if debugfs is disabled, if
your interface is "optional" like that, great, put it in debugfs,
otherwise put it somewhere else.

As to where else to put it, what exactly are you trying to do here?
What do you want to export / import?  Who would use it?  How would they
use it?  When would they use it?

> >> >> +     struct device dev;
> >> >> +     struct kref kref;
> >> >
> >> > You CAN NOT have two reference counts in the same structure, that's a
> >> > huge design mistake.  Stick with one reference count, otherwise they are
> >> > guaranteed to get out of sync and bad things will happen.
> >>
> >> In this case the additional @kref is for accounting of components
> >> within the coresight framework only.  When the amba framework calls
> >> the driver's _probe() routine the kref count is already equal to '2'
> >> (as expected), even if no other coresight components have used that
> >> device.  Knowing when a component is no longer in use by the framework
> >> (but still available in the system) is important for coresight cleanup
> >> consideration, i.e switch off the component to save power.
> >>
> >> The kref helpers don't expose the refcount and @kref_sub will only
> >> call the cleanup method when refcount is '1'.  How else should I
> >> proceed?
> >
> > Don't use a kref at all, you should never need to "know" a refcount
> > value.  If you do, your logic is incorrect, sorry.  Just use the normal
> > driver core functions for when to cleanup memory and the like and you
> > will be fine.
> 
> I completely agree with you on the fact that the driver core alone
> should be the one doing the memory cleanup for a device.  What those
> krefs are doing is to keep track of what is happening in the
> framework, nothing else.

That's not what a kref is for, don't abuse it that way.  You shouldn't
care what is "happening in the framework" if the driver core is handling
the reference counting properly, right?

> The framework needs to keep track of component usage by other
> components...

No it should not.

> Say we have a sink that is used by multiple sources.
> The framework can't call sink->disable() for as long as a coresight
> source is using it and this is exactly what those krefs are for.
> Disabling a device in the framework doesn't mean the kernel should be
> reclaiming resources for the device.  That device should still be
> there for future processing if need be.

What do you mean "if need be"?  How could the resource come back?  Why
do you need to care if a device is "disabled" or not?

> On the flip side if a component isn't used by the framework there is
> no point using resources for it i.e, clock, pinout lines, channels...

Make up your mind :)

greg k-h
