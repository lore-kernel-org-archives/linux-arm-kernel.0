From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 3 Jul 2012 09:09:27 +0200
Subject: [PATCH 2/9] arm: mach-mvebu: add header
In-Reply-To: <alpine.LFD.2.02.1207022313550.31003@xanadu.home>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341243574-3258-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120702183330.GG1348@lunn.ch> <20120702210838.37c78fda@skate>
 <20120702191616.GJ1348@lunn.ch>
 <alpine.LFD.2.02.1207022313550.31003@xanadu.home>
Message-ID: <20120703070927.GA17004@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 11:48:42PM -0400, Nicolas Pitre wrote:
> On Mon, 2 Jul 2012, Andrew Lunn wrote:
> 
> > It would also be nice if Marvell ASIC engineers didn't randomly move
> > things around in the address space....
> 
> They didn't.  The _software_ engineers did.

Ah, interesting. I never got that deep into the address mapping, i
just mechanically refactered it across all Orions without take too
much time to really understand what its doing.

> Now it seems that all the u-Boot implementations for Orion/Kirkwood out 
> there have always moved the window containing the serial ports from its 
> default 0xd0000000 address to 0xf1000000.  Why they did that I have no 
> idea.  And Linux simply took those remapped physical addresses as 
> authoritative.
> 
> And whether or not Armada 370/XP still have this physical remap ability 
> I don't know.  And if it does, then why didn't it follow the same 
> 0xf1000000 tradition as all the other mvebu targets before them I don't 
> know either.  Maybe this could be considered?

Thomas, Gregory, could you look at this?

Are the uboot source open, or are you using a proprietary Marvell
version?

When Arnd first proposed moving everything into one directory, i had a
quick look at the memory map. The Orions have more than just the
serial ports at the same address. If i remember correctly, I2C, SPI,
PCIE0, USB0, XOR, and ETH0 are all at the same physical
address. Unfortunately, they have different virtual addresses. So I
played around unifying the virtual address map.

Doing this will allow some code simplification, header file
simplification, and sharing of some .dtsi and DT across all Orion
systems.

Its not something i want to do right now, but having 370/XP the same
as Orion would be a step towards this.

	Andrew
