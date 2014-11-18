From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Nov 2014 12:44:22 -0500 (EST)
Subject: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
In-Reply-To: <20141118171831.GC3003@dtor-ws>
Message-ID: <Pine.LNX.4.44L0.1411181234210.892-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Nov 2014, Dmitry Torokhov wrote:

> OK. Another question then: pm_runtime_get_noresume() does literally this:
> 
> 	atomic_inc(&dev->power.usage_count);
> 
> So who is responsible for actually waking up parent device and/or power
> domain? Is it simply missing because we did not really have PM domains
> before?

Ths bus is responsible for making sure that all the standard resources
are available -- that is, all the resources that would be needed by a
normal device on that bus.  Anything beyond that (such as
special-purpose clocks) has to be set up by the driver.

Thus the bus would insure that the device was powered, its parent was
resumed, and the usual clock inputs were enabled.  And of course, one
mechanism for doing this is to runtime-resume the power domain.

Often the bus doesn't have to do anything special to resume the
device's parent.  This is because the device gets probed when it is
registered, which happens when it is discovered, and the discovery is
done by the parent's driver as part of its normal activity.  Since the
parent has to be powered up to carry out this normal activity, nothing 
more is needed.

(Of course, devices can get probed at other times too, not just when
they are discovered.  For example, a device might get probed when a
driver module is loaded, and that can occur at any time.  So in general
it might indeed be necessary for the bus to wake up the parent before
calling the driver's probe routine.)

Alan Stern
