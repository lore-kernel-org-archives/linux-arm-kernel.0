From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 17 May 2013 13:33:45 +0200
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130516192510.GV18614@n2100.arm.linux.org.uk>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
Message-ID: <20130517133345.7c1368f5@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 May 2013 20:25:10 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> What follows is my DRM driver for Dove, which I've been working on with
> the Solid-run Cubox, which only offers HDMI output via the TDA19988
> chip.
> 
> Not everything is finished off perfectly in this driver; there's quite
> a number of ragged edges (particularly with page flipping, which is
> completely untested.)
> 
> I have most of the Xorg driver complete - none of the DRI interfaces
> checked yet (partly because that involves quite an amount of work with
> Mesa).
> 
> However, graphics, video overlay, interlacing, accelerated GPU via the
> original vivante support all works through this driver, with this driver
> providing the X pixmaps.

Hi Russell,

I quickly compared your dove drm driver and ours (Sebastian and me):

- CMA helper

  You don't use DRM_KMS_CMA_HELPER and DRM_GEM_CMA_HELPER which would
  simplify some code.

- device tree

  Our driver depends on the DT and, by this way, it may be used for
  various boards (Cubox, DB-MV88AP510 Development Board, CompuLab
  CM-A510 Board..). Especially, in the Cubox, only a HDMI screen may be
  connected, while the display controller permits connection of a smart
  panel (port A) and a VGA screen (port B). 
  Also, the driver could be used for different chips as the Armada 160
  which has quite the same LCD controller (but one LCD only and no
  display controller - Sebastian's idea).

- module loading (si5351, tda998x)

  As our driver is loaded by the Cubox DT, and as the auxilliary drivers
  (external clock, HDMI transmitter) may also be modules, a
  synchronization mechanism (inspired by the tegra drm driver) permits
  the driver to start when all the other drivers are also started.

- display controller

  I implemented output port cloning (LCD 0 to port B) but it is not
  tested (I just have a Cubox and I think that Sebastian did not have
  time enough yet to do it).     

- LCD handling

  With our driver, the description of a smart panel (port A) may be
  done by the DT.

- hardware cursor

  Our driver always proposes the HWC 32 (RGBA 64x64).

- LCD clocks

  Each LCD may use one clock amongst 4 (AXI, LCD PLL and 2 external
  clocks). In our driver, the choice of the clock is done on each video
  mode change (Sebastian's idea).

- interlaced modes

  While the code is there, I did not test the interlaced modes.
  Your code may be better.

- video overlay

  Same as above: the code is in our driver (overlay plane), but it is
  not tested.

- private ioctls

  It should be easy to add them in our driver and have an API
  compatible with your X server module. 

- screen rotation (IRE)

  This feature is needed when the Dove SoC is used in a tablet and does
  not exist in both drivers.

- VGA DAC

  This feature is needed to get the VGA screen parameters (mode,
  dimensions) and does not exist in both drivers too.

Otherwise, there are some small differences in, for example,
programming the LCD modes, or treating the vblank events.

What do you think about merging?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
