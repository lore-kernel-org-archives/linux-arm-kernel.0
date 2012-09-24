From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 24 Sep 2012 13:03:02 +0100
Subject: [PATCH v4] hwmon: Versatile Express hwmon driver
In-Reply-To: <20120921181844.GA20763@roeck-us.net>
References: <1348246591-2409-1-git-send-email-mail@pawelmoll.com>
 <20120921181844.GA20763@roeck-us.net>
Message-ID: <1348488182.2530.13.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-21 at 19:18 +0100, Guenter Roeck wrote:
> On Fri, Sep 21, 2012 at 05:56:31PM +0100, Pawel Moll wrote:
> > From: Pawel Moll <pawel.moll@arm.com>
> > 
> > hwmon framework driver for Versatile Express sensors, providing
> > information about board level voltage (only when regulator driver
> > is not configured), currents, temperature and power/energy usage.
> > Labels for the values can be defined as DT properties.
> > 
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> >  .../devicetree/bindings/hwmon/vexpress.txt         |   23 ++
> >  Documentation/hwmon/vexpress                       |   34 +++
> >  drivers/hwmon/Kconfig                              |    8 +
> >  drivers/hwmon/Makefile                             |    1 +
> >  drivers/hwmon/vexpress.c                           |  229 ++++++++++++++++++++
> >  5 files changed, 295 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/vexpress.txt
> >  create mode 100644 Documentation/hwmon/vexpress
> >  create mode 100644 drivers/hwmon/vexpress.c
> > 
> [ ... ]
> 
> > +
> > +	err = sysfs_create_group(&pdev->dev.kobj, match->data);
> > +	if (err)
> > +		goto error;
> 
> You'll need a second label for that. Since the group was not created, you can
> not delete it.

Actually I think I can... The sysfs_remove_group() effectively is a
wrapper for sysfs_hash_and_remove() which acts like "rm -f" - does
nothing if the file doesn't exist. Even drivers/hwmon/lm83.c (which, by
pure coincidence, I was looking at when re-working this driver) does
that in exit_remove_files...

Anyway, it's nothing to argue about, so I'll change it and send
(hopefully ;-) final version in a jiffy.

Thanks!

Pawe?
