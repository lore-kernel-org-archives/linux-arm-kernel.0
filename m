From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Nov 2014 11:13:28 -0500 (EST)
Subject: [PATCH] PM / Domains: Power on the PM domain right after attach
 completes
In-Reply-To: <20141117221700.GA2049@dtor-ws>
Message-ID: <Pine.LNX.4.44L0.1411181110500.1500-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Dmitry Torokhov wrote:

> > > However, is it allowed to call pm_runtime_get_sync() on devices that
> > > didn't issue pm_runtime_enable()?
> > 
> > Yes.  But the bus has to issue pm_runtime_enable() before probing the 
> > driver, because the driver will expect runtime PM to work properly 
> > while its probe routine runs.  For example, the probe routine might 
> > want to leave the device in a runtime-suspended state.  It can't do 
> > that if the device isn't enabled for runtime PM.
> 
> That means that runtime PM will be enabled for all devices on given bus
> while up till now drivers were deciding if their devices should be
> runtime-pm-managed or not. I do not think we are quite ready for this.

It's up to both the bus _and_ the driver to make this decision.

If a driver is completely runtime-PM-unaware then it will never
decrement the device's usage counter (which was incremented when the
bus called _get_noresume()), and therefore the device will never be
runtime-suspended.

Alan Stern
