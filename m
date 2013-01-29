From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jan 2013 23:06:13 +0000
Subject: [PATCH v2 08/27] pci: implement an emulated PCI-to-PCI bridge
In-Reply-To: <CAErSpo6ajS87mh7u58sLeN6oL5ixiPhaD7O7BrH1Av28mTk=qQ@mail.gmail.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo6ajS87mh7u58sLeN6oL5ixiPhaD7O7BrH1Av28mTk=qQ@mail.gmail.com>
Message-ID: <201301292306.14012.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013, Bjorn Helgaas wrote:
> If you need this, it can be done in architecture code, can't it?  It's
> true that there's nothing architecture-specific in this patch (other
> than the fact that ARM is the only arch that needs it), but I'm not
> sure there's anything useful for sharing here.

Since we're moving the host bridge code to drivers/pci/host now, I think
this code should live in the same place. It's entirely possible that
it will be shared between arch/arm and arch/arm64, although I would
hope that we can do away with the emulated bridge code entirely.

More generally speaking, this is infrastructure code, and for any
piece of infrastructure my rule is

* don't add platform specific infrastructure if it can be done at
  the architecture level
* don't add architecture specific infrastructure if it can be
  written in an architecture independent way
* don't add global infrastructure if you can use or extend the
  existing infrastructure.

> In fact, it seems like what you're after is not so much an emulated
> bridge that has no corresponding hardware, as it is a wrapper that
> presents a standard PCIe interface to hardware that exists but doesn't
> conform to the PCIe spec.  If you really do need to ultimately connect
> this pci_sw_pci_bridge to a piece of hardware, that will certainly be
> arch-specific.

As Jason Gunthorpe suggested, we might not need this at all, if the
Linux PCI code can be convinced not to need a configuration space
for the devices that in case of the Marvell hardware don't provide
one.

	Arnd
