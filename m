From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 12 Feb 2014 16:38:36 +0000
Subject: [PATCH 05/14] net: axienet: Service completion interrupts ASAP
In-Reply-To: <cafb13f2ebe4bb996bafb91e405d8609454bb920.1392220536.git.michal.simek@xilinx.com>
References: <cover.1392220536.git.michal.simek@xilinx.com>
 <cafb13f2ebe4bb996bafb91e405d8609454bb920.1392220536.git.michal.simek@xilinx.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D0F6BDFEE@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Simek
> From: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
> 
> The packet completion interrupts for TX and RX should be serviced before
> the packets are consumed. This ensures against the degenerate case when a
> new completion interrupt is raised after the handler has exited but before
> the interrupts are cleared. In this case its possible for the ISR to clear
> an unhandled interrupt (leading to potential deadlock).

I would clear the IRQ after processing the last packet, and then do a final
check for another packet.

That reduces the number of interrupts you take and then find there is
no work (because it was done on the previous interrupt).

There is a slight 'gotcha' in that the write to clear the IRQ can easily
get delayed enough the that cpu exits the ISR before the IRQ line
actually drops - leading the unwanted and unclaimed interrupts.
A posted write over PCIe could easily take long enough.

Maybe a hybrid scheme where the IRQ is cleared when the next entry
is still owned by the device would work.

	David
