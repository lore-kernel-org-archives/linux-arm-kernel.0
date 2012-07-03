From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 02 Jul 2012 23:48:42 -0400 (EDT)
Subject: [PATCH 2/9] arm: mach-mvebu: add header
In-Reply-To: <20120702191616.GJ1348@lunn.ch>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341243574-3258-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120702183330.GG1348@lunn.ch> <20120702210838.37c78fda@skate>
 <20120702191616.GJ1348@lunn.ch>
Message-ID: <alpine.LFD.2.02.1207022313550.31003@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Jul 2012, Andrew Lunn wrote:

> It would also be nice if Marvell ASIC engineers didn't randomly move
> things around in the address space....

They didn't.  The _software_ engineers did.

As you might know, the Orion and Kirkwood SOCs have programmable 
physical windows for most things, including PCI IO window, PCI mem 
window, SDRAM window, NAND controller window, bridge peripheral window, 
etc.  

So you can change your physical address space as you wish.  This was 
made to accommodate whether you are a PCI host or a PCI client (think 
wifi cards which are in the later category but still with this window 
control block).  This is also how the various SDRAM banks are remapped to 
appear as a contiguous chunk of physical memory regardless of the 
populated memory size in each bank.

Most of this is being partly set up (or set again) in the various 
addr-map.c files.

Now it seems that all the u-Boot implementations for Orion/Kirkwood out 
there have always moved the window containing the serial ports from its 
default 0xd0000000 address to 0xf1000000.  Why they did that I have no 
idea.  And Linux simply took those remapped physical addresses as 
authoritative.

And whether or not Armada 370/XP still have this physical remap ability 
I don't know.  And if it does, then why didn't it follow the same 
0xf1000000 tradition as all the other mvebu targets before them I don't 
know either.  Maybe this could be considered?


Nicolas
