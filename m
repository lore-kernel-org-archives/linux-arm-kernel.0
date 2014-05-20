From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 20 May 2014 11:02:21 -0600
Subject: [PATCH v1 5/5] pci: keystone: add pcie driver based on
 designware core driver
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B704742133@DFLE11.ent.ti.com>
References: <1400169692-9677-1-git-send-email-m-karicheri2@ti.com>
 <6048322.x3M3sdDEWO@wuerfel> <5374FD24.8000806@ti.com>
 <22200719.Jb5jnJylJH@wuerfel>
 <20140515183919.GC11650@obsidianresearch.com>
 <53751DDF.40304@ti.com>
 <20140515205210.GB14722@obsidianresearch.com>
 <3E54258959B69E4282D79E01AB1F32B704742133@DFLE11.ent.ti.com>
Message-ID: <20140520170221.GA5130@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 08:29:56PM +0000, Karicheri, Muralidharan wrote:

> But pcie_bus_configure_settings just make sure the mrrs for a device
> is not greater than the max payload size. 

Not quite, it first scans the network checking the Maximum Payload Size
Supported (MPSS) for each device, and chooses the highest supported by
all as the MPS for all.

PCI-E requires that an end point support all packets up to the MPS, so
if your bridge can't generate a 512 byte read response packet, then it
must not advertise a MPSS greater than 256 bytes.

Setting your MPSS to 128, 256, then using the
pcie_bus_configure_settings to run the standard algorithm should
properly limit the readrq to 256 and be able to properly support all
the fun edge cases like hot plug.

If the config space in your root port bridge is correct and already
declares a MPSS of 256 then you have nothing else to do but make sure
pcie_bus_configure_settings gets calls.

If it is broken and claims a higher MPSS than it can support then you
need to use a quirk only for the root port bridge or edit the config
reply in the driver only to fix the MPSS.

Jason
