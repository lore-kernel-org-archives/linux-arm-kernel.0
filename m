From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Nov 2014 21:37:37 +0100
Subject: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <7h389h3aif.fsf@deeprootsystems.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
 <1600093.60yAP0Qpua@wuerfel> <7h389h3aif.fsf@deeprootsystems.com>
Message-ID: <1618855.DXsjWXLqau@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 November 2014 11:14:16 Kevin Hilman wrote:
> >> 
> >> So, The Keystone 2 Generic PM Controller is just a proxy PM layer here between
> >> device and Generic clock manipulation PM callbacks.
> >> It fills per-device clock list when device is attached to GPD and
> >> ensures that all clocks from that list enabled/disabled when device is
> >> started/stopped.
> >
> > The idea of such a generic power domain implementation sounds useful, but
> > it has absolutely no business in platform specific code.
> 
> Yes it does.  This isn't a generic power domain implementation, but
> rather just the platform-specific glue that hooks up the clocks to the
> right devices and power-domains so that the generic power-domain and
> generic pm_clocks code does the right thing.

How would you do this on an arm64 version of keystone then? With
the current approach, you'd need to add a machine specific directory,
and that seems completely pointless since this is not even about
a hardware requirement.

> > I suggest you either remove the power domain proxy from your drivers
> > and use the clocks directly, 
> 
> No.  That's a step in the wrong direction.  This change isn't affecting
> drivers directly.  It's the runtime PM and generic power domain layers
> that handle this, and runtime PM adapted drivers don't need any changes.
>  
> > or come up with an implementation that can be used across other
> > platforms and CPU architectures.
> 
> We already have those in the generic power domain and the pm_clock
> layers.  This series is just hooking those up for Keystone.

Then why not add the missing piece to the generic power domain
code to avoid having to add infrastructure to the platform
for it?

	Arnd
