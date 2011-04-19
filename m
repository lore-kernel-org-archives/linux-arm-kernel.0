From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Apr 2011 16:16:00 +0100
Subject: [PATCH 6/6] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <4DAD6FE4.2050504@ti.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-7-git-send-email-will.deacon@arm.com>
	<4DAD6FE4.2050504@ti.com>
Message-ID: <1303226160.749.1.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Tue, 2011-04-19 at 12:20 +0100, Santosh Shilimkar wrote:
> On 4/13/2011 12:05 AM, Will Deacon wrote:
> > Currently, the gic uses handle_level_irq for handling SPIs (Shared
> > Peripheral Interrupts), requiring active interrupts to be masked at
> > the distributor level during IRQ handling.
> >
> > On a virtualised system, only the CPU interfaces are virtualised in
> > hardware. Accesses to the distributor must be trapped by the
> > hypervisor, adding latency to the critical interrupt path in Linux.
> >
> > This patch modifies the GIC code to use handle_fasteoi_irq for handling
> > interrupts, which only requires us to signal EOI to the CPU interface
> > when handling is complete. Cascaded IRQ handling is also updated to use
> > the chained IRQ enter/exit functions to honour the flow control of the
> > parent chip.
> >
> > Note that commit 846afbd1 ("GIC: Dont disable INT in ack callback")
> > broke cascading interrupts by forgetting to add IRQ masking. This is
> > no longer an issue because the unmask call is now unnecessary.
> >
> > Tested on Versatile Express and Realview EB (1176 w/ cascaded GICs).
> >
> > Cc: Abhijeet Dharmapurikar<adharmap@codeaurora.org>
> > Cc: Russell King - ARM Linux<linux@arm.linux.org.uk>
> > Acked-by: Catalin Marinas<catalin.marinas@arm.com>
> > Signed-off-by: Will Deacon<will.deacon@arm.com>
> > ---
> Tested with OMAP4.
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Cheers for this. I'll add this and the tags for the OMAP-specific patch
(for some reason you dropped the list when you replied with your Ack).

Thanks!

Will
