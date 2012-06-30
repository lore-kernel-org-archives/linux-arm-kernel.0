From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 29 Jun 2012 20:11:12 -0600 (MDT)
Subject: Current state of AM33xx patches
In-Reply-To: <4FEDF54D.4030609@gmail.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com>
 <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com>
 <4FE9A00B.6010908@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com>
 <4FEC7394.9030208@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com>
 <4FEDF54D.4030609@gmail.com>
Message-ID: <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2012, Daniel Mack wrote:

> Correct me if I'm mistaken, but this isn't really what DT was designed
> for. In this context, it is used as a simple list of devices to probe,
> not as a abstracted description of the hardware resources and their
> interconnects.
>
> The question is: is that the way things should be kept for OMAP/AM33xx? 
> Or should work be done to move all that hwmod stuff to proper 
> clk/irq/res definitions that can be used from DT generically?

Eventually the MPU address space, MPU interrupt controller IRQ line data, 
system DMA controller data, and some of the other common resource 
information are probably going to migrate from the hwmod data into the DT 
blob.

And probably some of the power management-related data will migrate to the 
IP block driver code used for a particular SoC.

Probably the best time for this to happen is after the PRM/CM/SCM drivers 
are written, and an omap_bus layer is created from the existing hwmod 
code.  The planning that we've done in conjunction with the ARM DT people 
involves getting DT board file handling done first, which is really what 
DT makes the most sense for.  Then looking at the on-chip SoC stuff 
afterwards.

> As there's actually no need to care for legacy users at all (as no board 
> support for AM33xx is mainline),

The hwmod data is unrelated to the board files.

The "legacy" user here is the hwmod code.  It uses the data to create 
devices for the IP blocks on the SoC, to reset those IP blocks at kernel 
init, and to implement IP block power management via the runtime PM layer.

> shouldn't things be done right in the first place?

Well, all this is distinct from what the 'right' thing is or was.

It should be noted that from the power management and multiple bus 
initiator perspectives, the process of migrating from hwmod data to DT 
will be lossy.  For example, DT uses a single-root perspective of the 
device hierarchy, and does not explicitly encode the interconnections 
between IP blocks.


- Paul
