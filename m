From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 14 Feb 2017 15:25:03 +0100
Subject: [PATCHv2 net-next 01/16] dt-bindings: net: update Marvell PPv2
 binding for PPv2.2 support
In-Reply-To: <20170203164808.GD27312@n2100.armlinux.org.uk>
References: <1482943592-12556-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943592-12556-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170103201842.hdg2uzzesog2jund@rob-hp-laptop>
 <20170202175650.1fc06c2d@free-electrons.com>
 <20170203164808.GD27312@n2100.armlinux.org.uk>
Message-ID: <20170214152503.602878cb@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 3 Feb 2017 16:48:08 +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 02, 2017 at 05:56:50PM +0100, Thomas Petazzoni wrote:
> > For PPv2.2, we wanted to simplify a little bit the register mappings,
> > and simply reflect the memory map of the SoC. In the SoC datasheet,
> > there are two memory areas for the networking subsystem, which are the
> > two areas reflected in:
> > 
> >         reg = <0x0 0x100000>,
> >               <0x100000 0x80000>;
> > 
> > The per-port registers are inside the second register area. But by
> > exposing the entire register area in the Device Tree binding, we allow
> > improvements in the driver that need additional registers to be made
> > without changing the Device Tree description of the device.  
> 
> Are you sure that this makes sense?  You have the serdes block at
> 0x120000-0x125fff, which sits within that range, and that needs to
> be configured for SATA and PCIe, so it's not strictly just a network
> thing.
> 
> I know from my experimentation that disabling the "serdes" by clearing
> the SD_EXTERNAL_CONFIG1_REG and SD_EXTERNAL_CONFIG0_REG for SATA
> channels prevents SATA working.

I have simply/stupidly followed the datasheet, which says:

 Packet processor:        0xf2000000, 0xf4000000 (i.e offset 0x0 in the CP)
 Networking interfaces:   0xf2100000, 0xf4100000 (i.e offset 0x100000 in the CP)
 IO Bridge Addr Decoding: 0xf2190000, 0xf4190000

And since there is no other block described, I assumed that the entire
range 0xf2000000 to 0xf2100000 was dedicated to the "Packet processor",
and that the range 0xf2100000 to 0xf2190000 was dedicated to the
"Networking interfaces" (and I realize the size is 0x90000, not
0x80000).

On the other hand, there are registers after 0x125fff that are really
networking related. For example, the driver is currently accessing
0x12a204, which is after the SERDES related registers.

I'll try to get some more information about this, but I suspect this is
one case where we don't yet fully understand how all the HW works and
what all registers are doing, so it's hard to do a perfect DT binding
from day 1.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
