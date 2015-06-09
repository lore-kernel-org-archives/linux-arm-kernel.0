From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 9 Jun 2015 22:34:56 +0200
Subject: [PATCH 00/34] pinctrl: mvebu: numerous fixes, cleanups and
 improvements
In-Reply-To: <20150609194705.GE16778@lunn.ch>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150609170153.GC16778@lunn.ch>
 <20150609212211.625964e2@free-electrons.com>
 <20150609194705.GE16778@lunn.ch>
Message-ID: <20150609223456.0f569869@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 9 Jun 2015 21:47:05 +0200, Andrew Lunn wrote:

> I read a presentation recently, "Device Tree as a stable ABI: a fairy
> tale?"  :-)

Reminds me of something :)

> But we should at least try. So what is actually involved in keeping
> backwards compatibility?
> 
> The two patches i pointed out have two different situations.
> 
> What does pinctrl do when you ask for a pin which is not a member of the
> function? If it silently ignores it, not a problem. But i expect it
> actually throws an error. I could be wrong here, but it looks like it
> is the mvebu code which checks if a pin is a member of a function.  So
> it might be possible to set the value of the val in the
> mvebu_mpp_ctrl_setting to 0xff for the removed NAND pins, and when we
> see such a value, print a warning about outdated DT, and "succeed"
> rather than return an error.

This can only work if the function number is not actually used. For
example, in the very first patch "pinctrl: mvebu: armada-38x: fix PCIe
functions" :

-		 MPP_VAR_FUNCTION(4, "pcie1", "rstout",     V_88F6820_PLUS),
+		 MPP_VAR_FUNCTION(4, "ge0",   "txerr",      V_88F6810_PLUS),

So the function 4 used to be pcie1, which you would like to still be
supported, but it's now actually used for ge0.

To be honest, I actually prefer that people updating their kernel and
using an old DT get an error about pin muxing, rather than having the
driver silently ignore and have people never update their Device Tree.

It's also about long term maintainability. Do we want to keep old crap
around forever in all device drivers?

> For spi -> spi0 it seems messier. So i would leave it as spi with a
> comment, and add spi1.

I'm fine with that.

What about tdm2c -> tdm renaming on Armada 38x, and tdm-1 -> tdm for one
single TDM pin on Armada XP ?

I think we're hitting the limits of the DT backward compatibility: our
description of the hardware had some bugs. What do we do? Continue to
support bugs?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
