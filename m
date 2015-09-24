From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 24 Sep 2015 16:30:09 +0200
Subject: [PATCH 2/6] pci: mvebu: generate proper configuration access
 cycles
In-Reply-To: <E1Zenfg-0004d5-Dg@rmk-PC.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
 <E1Zenfg-0004d5-Dg@rmk-PC.arm.linux.org.uk>
Message-ID: <20150924143009.GA20029@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 06:17:32PM +0100, Russell King wrote:
> The idea that you can arbitarily read 32-bits from PCI configuration
> space, modify a sub-field (like the command register) and write it
> back without consequence is deeply flawed.
> 
> Status registers (such as the status register, PCIe device status
> register, etc) contain status bits which are read, write-one-to-clear.
> 
> What this means is that reading 32-bits from the command register,
> modifying the command register, and then writing it back has the effect
> of clearing any status bits that were indicating at that time.  Same for
> the PCIe device control register clearing bits in the PCIe device status
> register.
> 
> Since the Armada chips support byte, 16-bit and 32-bit accesses to the
> registers (unless otherwise stated) and the PCI configuration data
> register does not specify otherwise, it seems logical that the chip can
> indeed generate the proper configuration access cycles down to byte
> level.
> 
> Testing with an ASM1062 PCIe to SATA mini-PCIe card on Armada 388.
> PCIe capability at 0x80, DevCtl at 0x88, DevSta at 0x8a.

The Armada 388 is a pretty new SoC. It would be good to test this on a
much older device as well, e.g. Kirkwood. I will add it to my TODO
list, but it anybody else gets there first, please let me know.

      Andrew
