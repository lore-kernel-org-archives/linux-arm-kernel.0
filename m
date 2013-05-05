From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sun, 05 May 2013 12:41:49 +1000
Subject: [PATCH v8 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
In-Reply-To: <1366627295-16964-2-git-send-email-Andrew.Murray@arm.com>
References: <1366627295-16964-1-git-send-email-Andrew.Murray@arm.com>
 <1366627295-16964-2-git-send-email-Andrew.Murray@arm.com>
Message-ID: <1367721709.11982.37.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-04-22 at 11:41 +0100, Andrew Murray wrote:
> The pci_process_bridge_OF_ranges function, used to parse the "ranges"
> property of a PCI host device, is found in both Microblaze and PowerPC
> architectures. These implementations are nearly identical. This patch
> moves this common code to a common place.

What's happening with this ? I'd like to avoid that patch for now
as I'm doing some changes to pci_process_bridge_OF_ranges
which are fairly urgent (I might even stick them in the current
merge window) to deal with memory windows having separate offsets.

There's also a few hacks in there that are really ppc specific...

I think the right long term approach is to change the way powerpc
(and microblaze ?) initializes PCI host bridges. Move it away from
setup_arch() (which is a PITA anyway since it's way too early) to
an early init call of some sort, and encapsulate the new struct
pci_host_bridge.

We can then directly configure the host bridge windows rather
than having this "intermediary" set of resources in our pci_controller
and in fact move most of the fields from pci_controller to
pci_host_bridge to the point where the former can remain as a
simple platform specific wrapper if needed.

So for new stuff (hint: DT based ARM PCI) or stuff that has to deal with
a lot less archaic platforms (hint: Microblaze), I'd recommend going
straight for that approach rather than perpetuating the PowerPC code
which I'll try to deal with in the next few monthes.

Cheers,
Ben.
 
