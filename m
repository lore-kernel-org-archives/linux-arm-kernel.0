From: broonie@kernel.org (Mark Brown)
Date: Sat, 7 Jun 2014 10:31:13 +0100
Subject: [PATCH 7/7] OF/ACPI/I2C: Add generic match function for the
 aforementioned systems
In-Reply-To: <20140606234253.A4E25C427F0@trevor.secretlab.ca>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-8-git-send-email-lee.jones@linaro.org>
 <20140605103009.85BE4C40A4D@trevor.secretlab.ca>
 <20140605103709.GE19550@lee--X1>
 <CACxGe6vLuKygv0E7yq42qe-Lh+nMZ1wrL7PW_TAeoz55wz9q8A@mail.gmail.com>
 <20140605155509.GH24240@lee--X1>
 <20140606102446.GK2520@sirena.org.uk>
 <20140606123653.GP24240@lee--X1>
 <20140606234253.A4E25C427F0@trevor.secretlab.ca>
Message-ID: <20140607093113.GY5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 07, 2014 at 12:42:53AM +0100, Grant Likely wrote:
> On Fri, 6 Jun 2014 13:36:53 +0100, Lee Jones <lee.jones@linaro.org> wrote:
> > On Fri, 06 Jun 2014, Mark Brown wrote:

> > > > I've also been mulling over the idea of removing the second probe()
> > > > parameter, as suggested by Wolfram.  However, this has quite deep
> > > > ramifications which would require a great deal of driver adaptions.

> > > If you're going to do that another option is to refactor the probe()
> > > function to take the driver_data as an argument and then have the core
> > > pass that from whatever table it matched from rather than the entire
> > > i2c_device_id structure.  That way the driver just needs to supply all
> > > the ID tables mapping binding information to whatever it needs and the
> > > core can pass in the driver data from whatever table it matched against.

> > Unfortunately this means we're back to the aforementioned typing
> > issue.  For struct {platform,i2c,spi,acpi,etc}_device_id the driver
> > data is a kernel ulong but the of_device_id's driver data attribute is
> > a void*.

> We're actually okay there. Each subsystem defines it's own convention
> about what those values mean. ulong and void* are the same size and
> every user I've seen stuffs the same data into the data field of both
> tables.

Indeed - if we're going to go with that approach it seems to me like we
should just pick one and put any casting in the core.

> > I've just started work on a migration over to a new probe().  I don't
> > think it's all that much work, but if there are any objections I'd
> > prefer to hear them now rather than waste any time.

> I have no problem with that approach.

Converting probe() makes sense to me.  I think I would prefer to see the
ID lookup handled as an argument to probe() rather than with functions
in probe() but it's not the end of the world if it isn't.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140607/9a68cb39/attachment.sig>
