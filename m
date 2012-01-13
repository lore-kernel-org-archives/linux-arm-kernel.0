From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 21:19:58 +0000
Subject: [PATCH 1/2] versatile: sic: add device tree bindings
In-Reply-To: <20120113210041.GD22767@ponder.secretlab.ca>
References: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
 <1326415441-17695-2-git-send-email-jamie@jamieiles.com>
 <20120113022932.GB25999@ponder.secretlab.ca> <20120113103554.GE14007@page>
 <20120113210041.GD22767@ponder.secretlab.ca>
Message-ID: <20120113211958.GE1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 02:00:41PM -0700, Grant Likely wrote:
> Let me look at it a bit.  You can leave the initialization loop in
> fpga_irq_init() for now.  I'm looking at adding a mask field to
> irq_domain_add_legacy in addition to the host_data pointer.  I also
> want to investigate replacing fpga_irq with generic-chip.c.  The
> problem I've currently got though is that irq_domain_add_legacy() can
> currently support any number of irqs, but adding a simple mask
> argument will limit it to 32.  That won't work for large irq
> controllers like the gic.

The easy answer is not to register the IRQs which don't actually exist
or we don't want to be used out of the set of 32.

However, the problem comes with:

#define PIC_MASK        0xFFD00000

where we have an IRQ23 but no IRQ22.
