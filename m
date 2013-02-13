From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Feb 2013 22:24:53 +0000
Subject: Giving special alignment/size constraints to the Linux PCI core?
In-Reply-To: <CAE9FiQVHQqpE+Dupcmt=dpUUEJk=3JoxsMmFf0SXtqE==YJ9Fg@mail.gmail.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <201302132110.55087.arnd@arndb.de>
 <CAE9FiQVHQqpE+Dupcmt=dpUUEJk=3JoxsMmFf0SXtqE==YJ9Fg@mail.gmail.com>
Message-ID: <201302132224.53456.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 February 2013, Yinghai Lu wrote:
> On Wed, Feb 13, 2013 at 1:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > The problem I see with the current implementation is that it reserves
> > a fixed size window and does not reassign the window of the bridge
> > itself, only the devices below it, at least if I am reading the
> > code correctly. I have not tried this myself.
> 
> Which file?
> 
> Current code we do change the bridge itself resource (mmio, pref mmio, and io)
> in
> pciehp_configure_device/pci_assign_unassigned_bridge_resources
> 
> Let met if it does not work you.

That is the code I was looking at, but I probably misunderstood something
there. I did not actually run it, just attempted to understand what it
does by inspection.

I found the code now, sorry for the confusion on my end.

Jason, Thomas: you win :-)

The concept that root ports don't get resized is hardwired a lot of places
along the way. That could be changed, but there is a significant risk
of regressions if we try that. Adding fake bridges to work around that
isn't the nicest solution, but the code is there and works without
being able to break something else, so let's do that unless there are
new problems that make it harder.

	Arnd
