From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 19 Mar 2015 10:20:38 -0400 (EDT)
Subject: [PATCH] driver core / PM: Add callbacks for PM domain
 initialization/cleanup
In-Reply-To: <3533423.QQDErEmeTO@vostro.rjw.lan>
Message-ID: <Pine.LNX.4.44L0.1503191017590.1135-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 19 Mar 2015, Rafael J. Wysocki wrote:

> > This doesn't make sense to me.  A bus just called bus_add_device, it can
> > do whatever it wanted to right before calling this function, no need for
> > another callback.
> 
> The only caller of bus_add_device() is device_add().
> 
> What do you mean by "bus just called bus_add_device"?  Do you think that
> the pm_domain pointer should be populated before calling device_add()?
> 
> That wouldn't work for the ACPI PM domain at least, because ACPI companions
> are generally added during device_add() and we arguably cannot point a
> device to the ACPI PM domain before its ACPI companion is set.


> There are two alternatives to them.  One is to do PM domain attach/detach in
> the bus type's ->probe and ->remove, but that's suboptimal, because it is
> then carried out every time a driver is probed/removed for a device.  The
> other one would be to have each interested bus type register a bus type
> notifier for itself, but that would be rather ugly, wouldn't it?

Driver probing and removal is not a hot path.  Successful probes 
usually occur only once for each device.  I don't know how many 
unsuccessful probes there are on average, but probably not many.

Doing the PM domain attach/detach in ->probe and ->remove makes sense 
to me.

Alan Stern
