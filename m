From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 13 Jul 2011 01:54:41 -0600 (MDT)
Subject: [PATCH] OMAP2+: PM: fix watchdog boot when runtime PM is disabled
In-Reply-To: <878vs3v9a3.fsf@ti.com>
References: <1310426484-30083-1-git-send-email-khilman@ti.com>
	<4E1B8B47.3020904@ti.com> <878vs3v9a3.fsf@ti.com>
Message-ID: <alpine.DEB.2.00.1107130142470.30229@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jul 2011, Kevin Hilman wrote:

> Paul's concern is valid, and could be addressed by making that init code
> actually check if the WDT is currently active (as suggested by the
> comment there.)
> 
> In the mean time, this simple fix should be applied to prevent a boot
> crash, IMO.

Thing is, applying this fix will cause crashes if the bootloader enables 
the watchdog, but the kernel does not.  It just trades one source of 
crashes for another.

The root cause of this problem is that the drivers are incorrectly relying 
on runtime PM to "enable" devices.  My personal opinion is that we should 
be doing what SSB, PCI, etc. do, and have a omap_device_enable() that is 
called by the driver.  Basically, we need a real omap_bus/omap_device.

Meanwhile, switching to lazy device reset as Tony suggested should mask 
the issue.  The patches for this are 95% done; the intention is to post 
them for early 3.2.  Or if people are really gung-ho, 3.1 rc.


- Paul
