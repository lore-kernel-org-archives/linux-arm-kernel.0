From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon,  3 Oct 2016 01:36:58 -0400
Subject: [PATCH V3 0/2] PCI: add CRS support after hot reset and FLR
Message-ID: <1475473021-14251-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIE spec allows an endpoint device to extend the initialization time
beyond 1 second by issuing Configuration Request Retry Status (CRS) for a
vendor ID read request.

This basically means "I'm busy now, please call me back later".

There are two moving parts to CRS support from the SW perspective. One part
is to determine if CRS is supported or not. The second part is to set the
CRS visibility register.

As part of the probe, the Linux kernel sets the above two conditions in
pci_enable_crs function. The kernel is also honoring the returned CRS in
pci_bus_read_dev_vendor_id function if supported. The function will poll up
to specified amount of time while endpoint is returning CRS response.

The PCIe spec also allows CRS to be issued during cold, warm, hot and FLR
resets.

The hot reset is initiated by starting a secondary bus reset. A bus/device
restore follows the reset.  This patch is adding vendor ID read into dev
restore function to validate that the device is accessible before writing
the register contents. If the device issues CRS, the code might poll up
to 60 seconds.

An endpoint is allowed to issue CRS following an FLR request to indicate
that it is not ready to accept new requests. Changing the polling mechanism
in FLR wait function to go read the vendor ID instead of the command/status
register. A CRS indication will only be given if the address to be read is
vendor ID.

v3:
* dropped parent_bus_reset change and IB/hfi1 changes as both of them work
only when there is a single device on the bus and reset is for the device
in the bus. 
* dropper AER changes as AER driver broadcasts error to the endpoint device
driver which eventually cause endpoint driver to be reprobed after fatal 
error. 
* moved vendor id read into the pci_dev_restore function as this is the
* first
attempt to contact the endpoint after a reset.

v2:
http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1233472.html
* IB/hfi1 via pci_reset_bridge_secondary_bus
* PCI/AER via pci_reset_bridge_secondary_bus
* PCI: dev_reset via parent bus reset
* use walk_bus for vendor id reads since the lock is no longer held.

v1:
http://www.spinics.net/lists/linux-pci/msg53596.html

* initial implementation

Sinan Kaya (2):
  PCI: add CRS support to error handling path
  PCI: handle CRS returned by device after FLR

 drivers/pci/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
1.9.1
