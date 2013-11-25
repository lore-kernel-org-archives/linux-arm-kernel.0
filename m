From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Nov 2013 11:50:05 -0800
Subject: [PATCH] of/platform: Fix no irq domain found errors when
 populating interrupts
In-Reply-To: <20131125094954.GF22043@ulmo.nvidia.com>
References: <20131123004334.GJ10023@atomide.com>
 <20131124213651.59750C402C3@trevor.secretlab.ca>
 <20131125092549.GD22043@ulmo.nvidia.com>
 <20131125094954.GF22043@ulmo.nvidia.com>
Message-ID: <20131125195004.GS10023@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thierry Reding <thierry.reding@gmail.com> [131125 01:51]:
> On Mon, Nov 25, 2013 at 10:25:50AM +0100, Thierry Reding wrote:
> > On Sun, Nov 24, 2013 at 09:36:51PM +0000, Grant Likely wrote:
> > > 
> > > I actually like the idea of completely allocating the resource structure
> > > but leaving some entries empty. However, I agree with rmk that putting
> > > garbage into a resource structure is a bad idea. What about changing the
> > > value of flags to 0 or some other value to be obviously an empty
> > > property and give the follow up parsing some context about which ones it
> > > needs to attempt to recalculate?
> > 
> > When I worked on this a while back I came to the same conclusion. It's
> > nice to allocate all the resources at once, because the number of them
> > doesn't change, only their actually values.
> 
> I should maybe add: one issue that was raised during review of my
> initial patch series was that we'll also need to cope with situations
> like the following:
> 
> 	1) device's interrupt parent is probed (assigned IRQ base X)
> 	2) device is probed (interrupt parent there, therefore gets
> 	   assigned IRQ (X + z)
> 	3) device in removed
> 	4) device's interrupt parent is removed
> 	5) device is probed (deferred because interrupt parent isn't
> 	   there)
> 	6) device's interrupt parent is probed (assigned IRQ base Y)
> 	7) device is probed, gets assigned IRQ (Y + z)
> 
> So not only do we have to track which resources are interrupt resources,
> but we also need to have them reassigned everytime the device is probed,
> therefore interrupt mappings need to be properly disposed and the values
> invalidated when probing is deferred or the device removed.
> 
> Having a dynamic list of properties all of a sudden doesn't sound like
> such a bad idea after all. It makes handling this kind of situation
> rather trivial, especially per-type lists. Those lists will be empty at
> first and populated during the first probe. When probing fails or when a
> device is unloaded, we dispose the mappings and empty the lists, so that
> subsequent probes will start from scratch. It certainly sounds like a
> bit of a waste of CPU cycles, but on the other hand it makes the code
> much simpler.

Looks like we cannot yet use devm_allocate, but that seems like a nice
solution in the long run. I just posted an updated patch to fix the $Subject
bug for the -rc cycle to this thread with more comments regarding dynamically
allocating the resources.

Regards,

Tony
