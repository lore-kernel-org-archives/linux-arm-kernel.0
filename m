From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 15 Nov 2011 17:14:57 -0500 (EST)
Subject: [PATCH 3/5] [orion] Move address map setup out of the drivers and
 into platform.
In-Reply-To: <20111115074122.GA2012@lunn.ch>
References: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
 <1321128007-3520-4-git-send-email-andrew@lunn.ch>
 <alpine.LFD.2.02.1111141855340.3307@xanadu.home>
 <20111115074122.GA2012@lunn.ch>
Message-ID: <alpine.LFD.2.02.1111151648150.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Nov 2011, Andrew Lunn wrote:

> > I understand that you might want to get rid of the annoying platform 
> > data pointer for the mbus values.  But I think that this could be done 
> > some other way though.  IMHO the mbus initialization code for 
> > peripherals should remain in the drivers, and a different way to query 
> > the needed information be elaborated instead.  Otherwise this is like 
> > throwing out the baby with the bath water.
> 
> I'm open to suggestion.
> 
> What do you think about the idea of keeping the first two patches,
> i.e. *_mbus_dram_info out of mach-* and into plat-orion. Then
> providing a function orion_mbus_dram_info() which returns its. Keep
> the address map setup code in the drivers, remove struct
> mbus_dram_target_info from platform_data and use this function
> instead?

I pretty much like patch #1.  Just remember to mark unneeded data after 
boot as __initdata.

I don't see the point of patch #2.  Having a kirkwood specific piece of 
data called kirkwood_foo rather than orion_foo makes more sense to me.

Having a static orion_mbus_dram_info() function might be a problem on 
other platforms.  for example, the mv643xx_eth driver is also used by 
some PowerPC targets.  The sata_mv driver is shared between 
Orion/Kirkwood/Dove SOCs and Marvell SATA controllers on PCI cards that 
can be found on any architecture with a PCI bus.  Etc.  It is therefore 
necessary to query those resources in a standard way and be prepared for 
the fact that they might just be absent.  So I'd suggest looking at the 
possibility of using IORESOURCE_BUS in the standard platform device 
data or a similar mechanism.


Nicolas
