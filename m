From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 14 Oct 2012 09:12:55 +0200
Subject: pm: add suspend_mem and suspend_standby support
In-Reply-To: <20121010094353.GR12801@game.jcrosoft.org>
References: <20121006161429.GD12462@game.jcrosoft.org>
 <5075210B.3020309@ti.com> <20121010094353.GR12801@game.jcrosoft.org>
Message-ID: <1833756.N2BBiv5Zzq@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > > I understand that, there is trade-off between power and latency numbers,
> > > but for certain use-cases latency is more important and it is not
> > > possible without telling driver about the low-power state.
> > 
> > I understand the problem at hand, but the question is who's going to tell
> > the driver about that.
> > 
> > Arguably, the PM core is not the right source of that information, because
> > if a driver is told "we're going into standby", it will have to ask the
> > platform about what "standby" actually means.
> 
> who is going to tell the kernel to go to standby and which
> 
> the sysfs handle via PM core
> 
> so here the one who alwasy have the information is the pm core

The core tells the _platform_ "the user wants us to go into standby" or
"the user wants us to go into suspend", but it doesn't really know what
"standby" or "suspend" actually mean. It can't, because these things are
not universally well defined and there are differences between platforms
in that area.  Different platforms may require different things to be
done to devices for "standby" and so drivers should not assume that
"standby" will always mean the same thing.

For example, if your driver is written for and ARM SoC and then the same
IP block happens to be used on an x86-based thing, whatever the driver did
and was specific to ARM is no longer valid.  So if your ARM SoC required
drivers to do something special during a "suspend" transition which wasn't
necessary to do during a "standby" transition, it doesn't necessarily mean that
the new platform will do so as well. The "mem" and "standby" things may have
different meanings for the new platform and for this reason drivers _have_ _to_
ask the _platform_ what states to put the devices into _or_, alternatively,
leave the platform-specific handling of the devices to the platform (that's
what device drivers on ACPI-based x86 do).  They should not expect the PM core
to tell them that, simply because the PM core has no idea what that may be.

And by the way, ACPI-based ARM platforms are reportedly in the works and they
_will_ use the same IP blocks that are already in use on ARM.  On those
platforms drivers will be supposed to use ACPI for power management and
the whole design you're proposing will not make sense any more for them.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
