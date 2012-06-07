From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Jun 2012 00:19:00 -0700
Subject: [PATCH 02/11] ARM: OMAP4+: AESS: enable internal auto-gating
 during initial setup
In-Reply-To: <20120607061306.25532.59488.stgit@dusk>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061306.25532.59488.stgit@dusk>
Message-ID: <20120607071900.GW12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120606 23:26]:
> Enable the AESS auto-gating control bit during AESS hwmod setup.  This
> fixes the following boot warning on OMAP4:
> 
> omap_hwmod: aess: _wait_target_disable failed
> 
> Without this patch, the AESS IP block does not indicate to the PRCM
> that it is idle after it is reset.  This prevents some types of SoC
> power management until something sets the auto-gating control bit.

I don't like the idea of having custom platform init code for every driver
to reset it, let's see if there's some better way to deal with stuff like
this.

It seems that most/many IP blocks need their custom reset hacks, and it's
not limited to just few instances?

Maybe we can distribute custom hacks like this to the drivers? If there is
no generic way to reset some IP block, then the driver should pass it's
whatever workaround bits/methdod/ to the bus level (hwmod) code during the
init rather than piling up all the possible hacks to the bus level code.

This way the driver init can still do the bus level reset during it's init,
and bail out after that if the module is not in use for the board in question.
That is already being flagged in device tree with status = "disable" flag,
and can also passed in platform data if necessary.

AFAIK there's no need to reset the IP blocks before the driver init, it's
really needed for PM. So it's not needed early on, and it's OK to require
running  the driver init for driver modules that are not in use to reset
them properly. After all, the hardware is on the device, even if it's not
being used.

Regards,

Tony
