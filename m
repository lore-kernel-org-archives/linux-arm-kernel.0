From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 10 Aug 2017 16:59:37 -0500
Subject: [PATCH V9 1/2] PCI: handle CRS returned by device after FLR
In-Reply-To: <1502240245-11714-1-git-send-email-okaya@codeaurora.org>
References: <1502240245-11714-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20170810215937.GR16580@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 08:57:24PM -0400, Sinan Kaya wrote:
> Sporadic reset issues have been observed with Intel 750 NVMe drive by
> writing to the reset file in sysfs in a loop. The sequence of events
> observed is as follows:
> 
> - perform a Function Level Reset (FLR)
> - sleep up to 1000ms total
> - read ~0 from PCI_COMMAND
> - warn that the device didn't return from FLR
> - touch the device before it's ready
> 
> An endpoint is allowed to issue Configuration Request Retry Status (CRS)
> following a FLR request to indicate that it is not ready to accept new
> requests. CRS is defined in PCIe r3.1, sec 2.3.1. Request Handling Rules
> and CRS usage in FLR context is mentioned in PCIe r3.1a, sec 6.6.2.
> Function-Level Reset.

Don't we have a similar issue for other types of reset?  I would think
conventional reset, e.g., using secondary bus reset, hotplug slot
power, power management, etc., would have the same situation where a
device might return CRS status.
