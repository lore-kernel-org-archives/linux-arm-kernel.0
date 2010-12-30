From: david-b@pacbell.net (David Brownell)
Date: Wed, 29 Dec 2010 17:55:30 -0800 (PST)
Subject: [PATCH 1/9] spi/pxa2xx: register driver properly
In-Reply-To: <20101229214054.GB15198@angua.secretlab.ca>
Message-ID: <27128.99950.qm@web180304.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Wed, 12/29/10, Grant Likely <grant.likely@secretlab.ca> wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
> Subject: Re: [PATCH 1/9] spi/pxa2xx: register

> > >I detect an effort to change the classic model for
> board initialization in Linux:? first set up
> > >and register all system/platform devices on each board then do the same for their drivers.?
> ("hardware first" ... "software second".
> > 
> > What are you suggesting? 

Just what I said above.   The classic model
sets up all of a board's platform devices and
then their drivers get initialized ... simple
interdependency management; sometimes fancier
models are needed, but Linux does poorly with
those common/fancier requirements, so far
except via techniques some folk retch at.

platform_driver_probe() does
> not work with
> > hotpluged devices.

And was documented that way.  So if anyone
writes code expecting hotplug support, that
person has created a bug.  Their fault.
> 
> That assumption only holds for certain
 devices on certain boards.

It's still classic;  it works very well for
fixed-function SoC boards, no hotpluggable
Platform devices. ... most of the
time they're SoC-integrated, fixed in a
chip.  Sometimes they're just hard-wired
onto a board, (vs hard-wired into a chip).
Such boards are extremely common.

Regardless, if a driver is going to be
hotpluggable, it must be written with
that in mind ... avoiding certain calls, and
addressing various dynamic reconfig issues.

> platform_device_probe() is a machine specific optimization

It's not machine-specific at all, but it may not
be used for those rare platform devices which
are found in hotpluggable configurations.

Even if you want modprobe/rmmod support from
some driver ... that's not a machine issue;
it's a development/support issue. Drivers can
work just fine without being hotpluggable.



> 
> More and more likely all the time though.? Many
> drivers use the model
> of registering child platform_devices (for instance, multi
> function
> devices).

That's *Orthogonal* to hotpluggability..

Something you may be trying to avoid mentioning:
That call can also be a useful way to get driver
initialization sequencing sane, in the ongoing
absence of robust ways for Linux to handle the
interdependencies of drivers and devices.  I'm
told some folk will be working on that someday;
but that day isn't here yet.

- Dave


> 
