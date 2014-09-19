From: jcm@redhat.com (Jon Masters)
Date: Thu, 18 Sep 2014 20:21:30 -0400
Subject: [PATCH v8 1/4] pci:host: APM X-Gene PCIe host controller driver
In-Reply-To: <20140917160337.GA15261@e104818-lin.cambridge.arm.com>
References: <1410476266-29426-1-git-send-email-tinamdar@apm.com>
 <1410476266-29426-2-git-send-email-tinamdar@apm.com>
 <20140912091816.GU27864@e106497-lin.cambridge.arm.com>
 <CACoXjckWYhe=PpWE+xYSC9Q72FyAq__3uUh2gGeGtgpC5SrpzQ@mail.gmail.com>
 <20140917160337.GA15261@e104818-lin.cambridge.arm.com>
Message-ID: <541B770A.8070502@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2014 12:03 PM, Catalin Marinas wrote:

> So for arm64 currently we have some hooks in dma-mapping.c to intercept
> when a device is added to a bus. What I need to do though is check
> recursively whether the parent (bus) had the 'dma-coherent' property
> (pointed out by Jon). I think something like this would do (not tested):

We've got a patch now that I posted internally and we've tested. I've
asked Mark Salter to send it upstream (but hey, you'll probably just
want to switch the default over to recurse up the tree and then simply
add a new notifier register for pci_bus_type). For this stuff to work,
we need v10 of the APM X-Gene patches because (as I noticed earlier when
going through their code and testing on a board with an actual card -
and a modified devicetree node for the PCI root) that's the point they
add a call to setup the root of_nodes correctly via pci_scan_root_bus.
Prior to that the trivially obvious patch for dma-coherent doesn't work.
Today, there are two platform PCIe devices that do it right, plus the
latest APM rev of their driver just posted.

Jon.
