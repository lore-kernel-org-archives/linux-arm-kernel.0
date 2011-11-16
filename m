From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 11:08:20 -0500 (EST)
Subject: [PATCH 3/5] [orion] Move address map setup out of the drivers and
 into platform.
In-Reply-To: <20111116065940.GH2953@lunn.ch>
References: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
 <1321128007-3520-4-git-send-email-andrew@lunn.ch>
 <alpine.LFD.2.02.1111141855340.3307@xanadu.home>
 <20111115074122.GA2012@lunn.ch>
 <alpine.LFD.2.02.1111151648150.3307@xanadu.home>
 <20111116065940.GH2953@lunn.ch>
Message-ID: <alpine.LFD.2.02.1111160951060.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Nov 2011, Andrew Lunn wrote:

> > > What do you think about the idea of keeping the first two patches,
> > > i.e. *_mbus_dram_info out of mach-* and into plat-orion. Then
> > > providing a function orion_mbus_dram_info() which returns its. Keep
> > > the address map setup code in the drivers, remove struct
> > > mbus_dram_target_info from platform_data and use this function
> > > instead?
> > 
> > I pretty much like patch #1.  Just remember to mark unneeded data after 
> > boot as __initdata.
> 
> O.K. I can do that and submit it.
>  
> > I don't see the point of patch #2.  Having a kirkwood specific piece of 
> > data called kirkwood_foo rather than orion_foo makes more sense to me.
> 
> Is it kirkwood specific? All plat-orion based systems have one
> mbus_dram_target_info. The structure i would say belongs to orion, but
> the contents to kirkwood. How you use the structure belongs to orion,
> since all the drivers, independent of if they are running on kirkwood,
> dove, mv78xx0, all use it in the same way.

I don't talk about the usage nor the structure definition.  I talk about 
the SOC specific instances. If one of them contains Kirkwood specific 
values, it is normal to call it kirkwood_foo, no?  Once you pass a 
pointer to that instance then the name doesn't matter, and then this 
falls into the usage part.

> > Having a static orion_mbus_dram_info() function might be a problem on 
> > other platforms.  for example, the mv643xx_eth driver is also used by 
> > some PowerPC targets.
> 
> That in itself is interesting. I looked at the PowerPC code,
> powerpc/platforms/chrp/pegasos_eth.c &
> powerpc/sysdev/mv64x60_dev.c. No mention of any _mbus_dram_info
> structure.

Exact.  You therefore can't just put a call to orion_mbus_dram_info() 
fin the driver because there is no such function on PPC.

> Which to me means _mbus_dram_info is an plat-orion thing
> and not an mv643xx_eth thing, so maybe it belongs in the plat-orion?

No, because this is still a driver specific issue.  If it were an Orion 
specific issue, the setup for all peripherals would be done inside a 
single register block with the same register format.  As it is, the bus 
connection setup is performed by each peripheral block, and there are 
even differences between them.

> I guess what will decide it, is when another SoC comes along using
> these devices and needs the address map setup doing differently. Then
> it is clear its a platform thing, not a device thing.

Given that the mbus connection is implemented by the IP block providing 
the peripheral function, just like for the PCI connection in some cases, 
clearly indicates that this is a driver function.

> > The sata_mv driver is shared between Orion/Kirkwood/Dove SOCs and
> > Marvell SATA controllers on PCI cards that can be found on any
> > architecture with a PCI bus.  Etc.  It is therefore necessary to
> > query those resources in a standard way and be prepared for the fact
> > that they might just be absent.  So I'd suggest looking at the
> > possibility of using IORESOURCE_BUS in the standard platform device
> > data or a similar mechanism.
> 
> How would you suggest using IORESOURCE_BUS? 

Looking at it closer, I don't think simple resource ranges would be 
suitable after all.

I would therefore suggest the following starting point:

diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index c11ff29325..2d8989c6e4 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -32,5 +32,17 @@ struct mbus_dram_target_info
 	} cs[4];
 };
 
+/* 
+ * The Marvell mbus is to be found only on SOCs from the Orion family
+ * at the moment.  Provide a dummy stub for other architectures.
+ */
+#ifdef CONFIG_PLAT_ORION
+extern const struct mbus_dram_target_info *mrvl_mbus_dram_info(void);
+#else
+static inline const struct mbus_dram_target_info *mrvl_mbus_dram_info(void)
+{
+	return NULL;
+}
+#endif
 
 #endif

And then the driver code could call this and test the returned pointer 
instead of dev->platform_data.

However I still have doubts on the usefulness of this exercice.  There 
are often more than just this mbus stuff to be found into platform data 
structures anyway.  things like number of ports, PHY addresses, etc.  
Eventually, those parameters should be retrieved from a device tree, and 
probably the mbus parameters should be retrieved from there as well.  
Until then, I don't think we gain much from changing the existing 
platform data method.


Nicolas
