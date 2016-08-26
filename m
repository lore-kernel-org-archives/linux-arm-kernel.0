From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 26 Aug 2016 11:54:02 -0700
Subject: [PATCH v2 03/22] usb: ulpi: Support device discovery via device
 properties
In-Reply-To: <20160824073134.GB12117@kuha.fi.intel.com>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-4-stephen.boyd@linaro.org>
 <20160708090458.GB20485@shlinux2>
 <147043245520.26915.14153612182716236022@sboyd-linaro>
 <CAJOFmgz=BSq=mmo4-2p-BZLbb=qeE-2paUcgCv0_vx72PTYfWg@mail.gmail.com>
 <20160824073134.GB12117@kuha.fi.intel.com>
Message-ID: <147223764261.20053.3850778721234482249@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heikki Krogerus (2016-08-24 00:31:34)
> On Tue, Aug 23, 2016 at 12:58:07PM -0700, Stephen Boyd wrote:
> > On Fri, Aug 5, 2016 at 2:27 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> > > Quoting Peter Chen (2016-07-08 02:04:58)
> > >> On Thu, Jul 07, 2016 at 03:20:54PM -0700, Stephen Boyd wrote:
> > >> > @@ -39,6 +42,10 @@ static int ulpi_match(struct device *dev, struct device_driver *driver)
> > >> >       struct ulpi *ulpi = to_ulpi_dev(dev);
> > >> >       const struct ulpi_device_id *id;
> > >> >
> > >> > +     /* Some ULPI devices don't have a product id so rely on OF match */
> > >> > +     if (ulpi->id.product == 0)
> > >> > +             return of_driver_match_device(dev, driver);
> > >> > +
> > >>
> > >> How about using vendor id? It can't be 0, but pid may be 0.
> > >> See: http://www.linux-usb.org/usb.ids
> > >
> > > Heikki suggested a product id of 0 would mean we need to use DT
> > > matching. Should it be changed to vendor id instead?
> > 
> > Any comments here?
> 
> It makes sense. I don't have any problem with that.

Ok. Having pid equal to 0 in DT/device properties seems wrong, so I
think I'll be dropping those properties that this patch introduced and
go back to always attempting to read the hardware when the device is
populated.

That will bring back the power sequencing problem though, so I have to
think of some way to solve that. For now I'll just set the pid and vid
to 0 when the power is off and we try to read and see how it goes.
