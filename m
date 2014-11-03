From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Nov 2014 18:14:55 +0100
Subject: [PATCH 1/2] [usb] make xhci platform driver use 64 bit or 32 bit
 DMA
In-Reply-To: <1415024151.3641.18.camel@deneb.redhat.com>
References: <1414692989-23128-1-git-send-email-mlangsdo@redhat.com>
 <13596133.Pde5jAKbQO@wuerfel> <1415024151.3641.18.camel@deneb.redhat.com>
Message-ID: <7145110.be3vG56Rvi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 November 2014 09:15:51 Mark Salter wrote:
> On Thu, 2014-10-30 at 22:05 +0100, Arnd Bergmann wrote:
> > You should definitely make sure that this also works with DT, as
> > I don't think it's possible to support X-Gene with ACPI. I know
> > that Al Stone has experimented with it in the past, but he never
> > came back with any results, so I assume the experiment failed.
> > 
> > Note that the discussions about merging ACPI support on ARM64
> > are based on the assumption that we'd only ever support SBSA-like
> > platforms, not something like X-Gene that looks more like an
> > embedded SoC. Your XHCI patches still obviously make sense for
> > other platforms, so that's not a show-stopper.
> 
> But for some misconfiguration, the arm64 kernels in fedora arm
> koji would boot using ACPI on Mustang, the Foundation model,
> and AMD Seattle platforms. All very much a work in progress,
> but the tree from which the fedora patches are taken is the
> devel branch of:
> 
>   git.fedorahosted.org/git/kernel-arm64.git
> 
> The configuration will be fixed this week and then you can
> just grab an arm64 fedora kernel and boot with acpi=force.

It's not as bad as I had feared, but it still does a lot of
the things that in previous discussions were said that ACPI
would avoid doing, and that were used as arguments against
just using DT on all arm64 servers:

- The use of the device properties API that was introduced for
  Intel's embedded devices for on-chip components directly
  contradicts the "standardized firmware interfaces" argument
  that certain people keep making. This certainly explains how
  you plan to use the networking side, but I suspect it's not
  what the ACPI proponents were looking for, or what the base
  patch set is being advertised as.

- Using custom drivers for hardware that is required by SBSA
  (ahci, pci, ...) means you are contradicting the 
  Documentation/arm64/arm-acpi.txt document that is merged as
  one of your early patches and that keeps getting posted as
  the base of discussion for the inclusion of the base ACPI
  support. I don't think you can have it both ways, saying that
  SBSA is required and supporting hardware that doesn't do any
  of it won't work.

- Adding a generalized method to support arbitrary PCI host
  controllers indicates that you expect this practice to not
  just be a special exception for APM but that others would
  require the same hack to work around firmware or hardware that
  is not compliant with ACPI. At the same time you introduce a
  significant of driver code in arch/arm64/kernel/pci.c. Some
  of that code is probably just an oversight and can be moved into
  the PCI core later, but it doesn't even seem you tried that
  hard.

All of the above are probably things we can discuss, but by working on
this in secret until now, you have really made it hard for the Linaro
team whose work you are basing on. They have tried hard for a long
time to get basic ACPI support into a mergeable state, and have been
working on incorrect base assumptions the whole time because they
didn't have a platform implementation to show and to verify their
assumptions.

	Arnd
