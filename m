From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 23 Oct 2012 10:10:46 -0400 (EDT)
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <5085C470.4040707@wwwdotorg.org>
Message-ID: <Pine.LNX.4.44L0.1210231004310.1635-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Oct 2012, Stephen Warren wrote:

> > I see.  But why would it be done this way instead having a separate 
> > property?
> 
> Well, I did say normally:-)
> 
> I can certainly see an argument for representing these differences using
> custom properties, rather than deriving the information from the
> compatible value. It's probably be OK to do so for something generic
> like this; it's just perhaps not always the default choice.
> 
> Do note that even though this binding document dictates a particular
> value for the compatible property, every device tree should additionally
> add a separate value alongside it to indicate the specific HW model
> that's actually present, so that if some device-specific bug-fix or
> workaround needs to be applied, the model can be identified anyway.
> 
> So, rather than:
> 
> compatible = "usb-ehci";
> 
> You should always have e.g.:
> 
> compatible = "nvidia,tegra20-ehci", "usb-ehci";
> 
> Given that, there is then always enough information in the device tree
> for the driver to be able to derive the other values from the compatible
> value.

Yes, I get it.

> Whether you want to derive the information, or whether you want to
> explicitly represent it via properties, is a decision to make based on
> the trade-offs.
> 
> Oh, and I note that quite a few device trees already use compatible
> value "usb-ehci" in their device-trees. Care needs to be taken not to
> usurp that value from any existing device drivers if that was to be
> picked as the compatible value required by this binding.

Right.  I think Tony's new binding should use compatible value 
"usb-ehci-platform".  It will essentially be a superset of "usb-ehci".

> > And doesn't the same reasoning apply to has-tt?  Doesn't that mean the 
> > driver would have to match four different hardware types?  What happens 
> > if a third characteristic like these comes around; would the driver 
> > then have to check against eight different types?
> 
> No, the compatible value represents the model, so you'd have a table like:
> 
> compatible          -> bugX has_tt
> nvidia,tegra20-ehci -> 0    1
> vendor1,foo-ehci    -> 0    1
> vendor2,bar-ehci    -> 1    1
> vendor3,baz-ehci    -> 0    1
> vendor4,qux-ehci    -> 0    1
> ...
> 
> So the table size isn't related to the number of options. The table size
> is probably bigger than subset of options combinations that make sense.

Under the circumstances, and considering that usb-ehci-platform will be
rather generic, IMO it will be better to make has-tt,
has-synopsys-hc-bug, and no-io-watchdog separate properties, each
naturally defaulting to "not present".  That will avoid the need to 
update the driver's table each time a new board comes along.

Alan Stern
