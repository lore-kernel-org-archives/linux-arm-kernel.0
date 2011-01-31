From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 31 Jan 2011 19:19:48 +0100
Subject: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs. runtime
	suspend
In-Reply-To: <Pine.LNX.4.44L0.1101311119190.1931-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1101311119190.1931-100000@iolanthe.rowland.org>
Message-ID: <201101311919.49225.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 31, 2011, Alan Stern wrote:
> On Mon, 31 Jan 2011, Kevin Hilman wrote:
> 
> > I understand how this works, but frankly I'm still a bit fuzzy on why.
> > 
> > I guess I'm still missing a good understanding of what "interfering with a
> > system power transition" means, and why a runtime suspend qualifies as
> > interfering but not a runtime resume.
> 
> These are good questions.  Rafael implemented this design originally; 
> my contribution was only to warn him of the potential for problems.  
> Therefore he should explain the rationale for the design.

The reason why runtime resume is allowed during system power transitions is
because in some cases during system suspend we simply have to resume devices
that were previously runtime-suspended (for example, the PCI bus type does
that).

The reason why runtime suspend is not allowed during system power transitions
if the following race:

- A device has been suspended via a system suspend callback.
- The runtime PM framework executes a (scheduled) suspend on that device,
  not knowing that it's already been suspended, which potentially results in
  accessing the device's registers in a low-power state.

Now, it can be avoided if every driver does the right thing and checks whether
the device is already suspended in its runtime suspend callback, but that would
kind of defeat the purpose of the runtime PM framework, at least partially.

Thanks,
Rafael
