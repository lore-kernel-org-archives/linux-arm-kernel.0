From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Feb 2014 20:32:33 +0100
Subject: [PATCH v3 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <20140218190929.GF2010@mudshark.cambridge.arm.com>
References: <1392726043-31088-1-git-send-email-will.deacon@arm.com>
 <20140218185947.GA22340@obsidianresearch.com>
 <20140218190929.GF2010@mudshark.cambridge.arm.com>
Message-ID: <1411925.bMiMyFpUnW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 February 2014 19:09:29 Will Deacon wrote:
> 
> > Regarding the 0x6200.. There are two conflicting issues there 
> >  - You really don't want to let the PCI core assign resources to that
> >    range, it probably won't work.
> 
> Right, with kvmtool we don't support resource assignment (the BARs are fixed)
> so everything is PCI_PROBE_ONLY.

Ok, I looked at the source now and can confirm:

* 0x0-0x1000 are used for lots of legacy ISA devices.
* PCI devices get assigned IO addresses in 0x400 steps starting at 0x6200.
* There are three PCI drivers doing this: VESA, PCI-SHMEM and virtio-pci.

Regarding the PCI_PROBE_ONLY flag, how do you set that? Should we
have a standard DT property for that? On PowerPC we already specified
"linux,pci-probe-only" and "linux,pci-assign-all-buses", which seems
reasonable to use in architecture independent code as well.

	Arnd
