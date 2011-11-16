From: michael@walle.cc (Michael Walle)
Date: Wed, 16 Nov 2011 18:18:01 +0100
Subject: [PATCH 3/5] [orion] Move address map setup out of the drivers
 and into platform.
In-Reply-To: <20111116164955.GA18497@lunn.ch>
References: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
 <1321128007-3520-4-git-send-email-andrew@lunn.ch>
 <alpine.LFD.2.02.1111141855340.3307@xanadu.home>
 <20111115074122.GA2012@lunn.ch>
 <alpine.LFD.2.02.1111151648150.3307@xanadu.home>
 <20111116065940.GH2953@lunn.ch>
 <alpine.LFD.2.02.1111160951060.3307@xanadu.home>
 <20111116164955.GA18497@lunn.ch>
Message-ID: <91fdbf0d95fd220ed88e79af884bfe28.squirrel@ssl.serverraum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, November 16, 2011 17:49, Andrew Lunn wrote:
> So you are suggesting each mach-* implements this function and returns
> its specific *_dram_target_info structure? Four functions which are
> virtually identical. I would probably just have orion_dram_target_info
> in the plat-orion which all mach-* use and one implementation of this
> function in plat-oriom.
>
>> However I still have doubts on the usefulness of this exercice.  There
>> are often more than just this mbus stuff to be found into platform data
>> structures anyway.  things like number of ports, PHY addresses, etc.
>> Eventually, those parameters should be retrieved from a device tree, and
>> probably the mbus parameters should be retrieved from there as well.
>
> I agree about ports, PHY addresses, etc. They are all a property of
> the hardware, and belong in device tree. However the memory address of
> *_dram_target_info does not belong in the device true.
i agree.

OTOH we could say, we define a generic mapping in the device tree. If i
understood it correctly, there is only one mapping in use atm, which maps
in the main memory (which properties are passed by the _dram_target_info).
So instead of this specific use case, provide a generic one, basically the
contents which are written into the window control and base registers. Sth
like that:

  ethernet {
     range = <..>;
     interrupts = <..>;
     memory-map = <base0  size0  target0  attr0   /* main memory */
                   base1  size1  target1  attr1   /* flash */
                   base2  size2  target2  attr2>; /* dunno */
  };

>> Until then, I don't think we gain much from changing the existing
>> platform data method.
>
> I'm just trying to move towards device tree. *_dram_target_info is one
> thing which is blocking this move. The second maybe the clock
> speed. It would be nice to move to clkdev, and remove clk from the
> platform_data structures.
i worked around the clock by defining a frequency property per device,
atm. Ah and disable the clock gating, which i think the clock api will
solve, too.

> Do you see a better way to move toward device tree for orion?
i'll post my kirkwood dts patches as RFC soon on this mailinglist. For
those who are interested in them in the meanwhile can have a look at my
git repository at:
  https://github.com/mwalle/linux/tree/kirkwood-devtree

btw. i imported andrews patches.

-- 
Michael
