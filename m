From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 19 Mar 2015 17:04:11 +0100
Subject: [PATCH] driver core / PM: Add callbacks for PM domain
 initialization/cleanup
In-Reply-To: <CAPDyKFpBC6z4aFrfqc-NS3+tPmExhmYobS5p4BKcegPhZ9KwVg@mail.gmail.com>
References: <3533423.QQDErEmeTO@vostro.rjw.lan>
 <2137701.iWHrxeTcxg@vostro.rjw.lan>
 <CAPDyKFpBC6z4aFrfqc-NS3+tPmExhmYobS5p4BKcegPhZ9KwVg@mail.gmail.com>
Message-ID: <356697065.8Z1o4ApA72@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 19, 2015 04:37:26 PM Ulf Hansson wrote:
> On 19 March 2015 at 16:44, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, March 19, 2015 03:45:07 PM Ulf Hansson wrote:
> >> On 19 March 2015 at 15:20, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> > On Thu, 19 Mar 2015, Rafael J. Wysocki wrote:
> >> >
> >> >> > This doesn't make sense to me.  A bus just called bus_add_device, it can
> >> >> > do whatever it wanted to right before calling this function, no need for
> >> >> > another callback.
> >> >>
> >> >> The only caller of bus_add_device() is device_add().
> >> >>
> >> >> What do you mean by "bus just called bus_add_device"?  Do you think that
> >> >> the pm_domain pointer should be populated before calling device_add()?
> >> >>
> >> >> That wouldn't work for the ACPI PM domain at least, because ACPI companions
> >> >> are generally added during device_add() and we arguably cannot point a
> >> >> device to the ACPI PM domain before its ACPI companion is set.
> >> >
> >> >
> >> >> There are two alternatives to them.  One is to do PM domain attach/detach in
> >> >> the bus type's ->probe and ->remove, but that's suboptimal, because it is
> >> >> then carried out every time a driver is probed/removed for a device.  The
> >> >> other one would be to have each interested bus type register a bus type
> >> >> notifier for itself, but that would be rather ugly, wouldn't it?
> >> >
> >> > Driver probing and removal is not a hot path.  Successful probes
> >> > usually occur only once for each device.  I don't know how many
> >> > unsuccessful probes there are on average, but probably not many.
> >> >
> >> > Doing the PM domain attach/detach in ->probe and ->remove makes sense
> >> > to me.
> >>
> >> Let me elaborate a bit on the current approach, with PM domain
> >> attach/detach in ->probe() and ->remove(). This comes with the
> >> following limitations.
> >>
> >> 1) If the device gets probed earlier than the PM domain has been
> >> initialized, we can't return -EPROBE_DEFER since we just don't know
> >> anything about the PM domain yet.
> >>
> >> 2) The PM domain won't be able to operate on a device without having a
> >> driver bound to it, since the device's PM domain pointer is removed at
> >> ->remove().
> >>
> >> Perhaps Rafael want to add something to these? I don't know whether we
> >> think it's okay to keep these limitations or not.
> >
> > There are arguments both ways as you can see.
> >
> > At this point, the most straightforward approach would be to apply the Russell's
> > patch adding the ->sync callback alone.
> >
> > I will then need the ->activate callback for another use case (a PM domain that
> > may not be ready for the device to be probed), but in that case I actually know
> > that the pm_domain pointer is populated at the really_probe() time.
> 
> Then, how about adding only the ->sync() and ->activate() callback in
> one patch - and invoke them from really_probe()? That's seems to fit
> both our short and long term approach.
> 
> Genpd may then implement the ->sync() callback, which is similar to
> Russell's patch, except that it will now cover all buses and not just
> the platform bus as it where before.

OK

So do we need to do ->sync at the driver removal time too?  I guess we do?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
