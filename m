From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 21 Apr 2010 15:17:14 +0200
Subject: PCI Express MSI support on Kirkwood?
In-Reply-To: <g2ic384c5ea1004210555i3ba44b35xf58c233be742be2f@mail.gmail.com>
Message-ID: <20100421131714.GA18469@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 05:55:27AM -0700, Leon Woestenberg wrote:

> > what is the current status for PCI Express MSI support on Kirkwood?
> 
> Including Nicolas Pitre, Lennert Buytenhek and LAK ml on this topic.
> 
> I'm interested in PCI Express MSI support for Linux / Kirkwood, has
> this been addressed yet in any of the GIT trees?

It hasn't been done yet as far as I know.

I don't think KW was designed with MSI in mind, but it can perhaps be
done (MSI with up to 16 messages but without multiple message enable,
or MSI-X with up to 32 system-wide messages) if you use the interrupt
controller Doorbell interrupts for this purpose.

IOW, make the KW 1M register area available to the PCIe bus via an
inbound BAR, point the MSI message address to the Host-to-CPU Doorbell
Register (register block + 0x20400), and use successive powers of two
for the MSI message data.  (And demultiplex the doorbell interrupt into
its own range of 32 IRQs in the Kirkwood IRQ demux code.)

Having to map the register area to an inbound BAR means that it's not
possible anymore to have more than 2G of RAM in the system.  On KW
this won't be an issue, but on mv78xx0 it would be in some
configurations.

/me doesn't think he has MSI-capable PCIe cards
