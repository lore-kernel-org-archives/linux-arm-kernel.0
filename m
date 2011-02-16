From: davidb@codeaurora.org (David Brown)
Date: Wed, 16 Feb 2011 11:28:15 -0800
Subject: [RFC] MMC: error handling improvements
In-Reply-To: <AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
	(Linus Walleij's message of "Wed, 16 Feb 2011 19:41:42 +0100")
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
	<AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
Message-ID: <8ya8vxf4w4w.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 16 2011, Linus Walleij wrote:

> 2011/2/16 David Brown <davidb@codeaurora.org>:

>> It's also possible this is finding problems in our SDCC driver.
>
> The SDCC is obviously an MMCI derivate, VHDL hacking
> on top of ARMs source code for PL180/PL181.
>
> Why do you insist on maintaining a forked driver?

Well, it's not me insisting on it.  I'll let the maintainers of the
driver chime in.

The changes we made to the block are significant, but even beyond that
we changed how the block is even accessed.  The driver doesn't directly
access the registers of the controller, but all accesses go through a
custom DMA engine.

> Please consider switching to using mmci.c like everyone else.
> The quirks we have in place for U300, Nomadik and Ux500
> should show you the way for how to do this (yes we did the
> same thing, hacking the ARM VHDL).

I suspect the changes to mmci would be fairly drastic.

> If I remember correctly I could even see that some early
> Android sources were using Russells mmci.c driver before this
> fork was created.

These old drivers are also not usable.  The SDCC block is shared between
the modem processor and the processor running Linux.  If the driver
doesn't go through the DMA engine, which coordinates this, the registers
will be stomped on by the other CPU whenever it decides to access it's
parts of the flash device.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
