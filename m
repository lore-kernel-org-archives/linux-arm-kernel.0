From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 17 Nov 2014 14:54:53 -0500 (EST)
Subject: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
In-Reply-To: <20141117191755.GA5258@dtor-ws>
Message-ID: <Pine.LNX.4.44L0.1411171447390.851-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Dmitry Torokhov wrote:

> > For devices that aren't part of a power domain, things are simpler.
> > The bus does _get_noresume() to make sure the device won't be runtime
> > suspended while the probe routine is running.  It doesn't do
> > _get_sync(), because that would end up calling the driver's
> > runtime_resume routine before the driver was bound to the device.  (The
> > bus could prevent that from happening by taking special precautions,
> > like PCI does, but in general it's a nuisance.)
> 
> That's why I think we need some new call that would mean "make sure the
> device is powered" which would properly handle power domain and bus, but
> ignore all driver stuff since it may not be initialized yet. And similar
> call for asking to put device and maybe domain in powered down state in
> case probing failed.

I can't imagine how such a call would work.

The PM core invokes the subsystem's runtime_suspend/resume callback, 
and then the subsystem's routine is responsible for invoking the 
driver's callback (or _not_ invoking it, in this case).

Thus, the PM core has no way to tell the subsystem's callback not to
invoke the driver's routine, and adding a new runtime PM call wouldn't
change that.  You'd have to add a new pair of callbacks instead, which 
IMO would be a tremendous waste.

Furthermore, the subsystem already _knows_ when the driver gets probed, 
because probing works in the same sort of way: The subsystem's probe 
routine gets invoked, and it is responsible for invoking the driver's 
probe routine.  Therefore the PM core doesn't _need_ to provide this 
extra information to the subsystem.  Rather, the subsystem just needs 
to keep track of the information it already has available.

Alan Stern
