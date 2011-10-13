From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 13 Oct 2011 10:31:45 -0400 (EDT)
Subject: [PATCH 2/5] drivercore: Add driver probe deferral mechanism
In-Reply-To: <CACVXFVNXyzzJw7UK+OFuDe23voQvyywoP9AvUsV=iPDFPO4fPw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1110131029510.2026-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Oct 2011, Ming Lei wrote:

> >> Inside device_add(), device_pm_add is called before bus_probe_device,
> >> so the patch can't change the device order in pm list, and just change
> >> the driver probe order.
> >
> > That's the way it works now, but can it be reworked? ?It would be
> 
> IMO, it depends on what shape you plan to rework.  Currently, the
> deferred probe may found a resource dependency, but I am not sure
> that pm dependency is same with the resource dependency found
> during probe.
> 
> > possible to adjust the list order after successful probe. ?However,
> > I'm not clear on the ordering rules for the dpm_list. ?Right now it is
> > explicitly ordered to have parents before children, but as already
> > expressed, that doesn't accurately represent ordering constraints for
> > multiple device dependancies.
> 
> Maybe we should understand the correct model of the ordering constraints
> for the multiple device dependancies first, could you give a description or
> some examples about it?

The requirement is that devices must be capable of resuming in the 
order given by dpm_list, and they must be capable of suspending in 
the reverse order.

Therefore if device A can't work unless device B is functional, then B 
must come before A in dpm_list.

Alan Stern
