From: tony@atomide.com (Tony Lindgren)
Date: Mon, 15 Oct 2012 17:01:04 -0700
Subject: [PATCH] ARM: OMAP2: UART: fix console UART mismatched runtime
 PM status
In-Reply-To: <1350344998-16328-1-git-send-email-khilman@deeprootsystems.com>
References: <1350344998-16328-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <20121016000103.GG15569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121015 16:51]:
> From: Kevin Hilman <khilman@ti.com>
> 
> The runtime PM framework assumes that the hardware state of devices
> when initialized is disabled.  For all omap_devices, we idle/disable
> device by default.  However, the console uart uses a "no idle" option
> during omap_device init in order to allow earlyprintk usage to work
> seamlessly during boot.
> 
> Because the hardware is left partially enabled after init (whatever
> the bootloader settings were), the omap_device should later be fully
> initialized (including mux) and the runtime PM framework should be
> told that the device is active, and not disabled so that the hardware
> state is in sync with runtime PM state.
> 
> To fix, after the device has been created/registered, call
> omap_device_enable() to finialize init and use pm_runtime_set_active()
> to tell the runtime PM core the device is enabled.
> 
> Tested on 2420/n810, 3530/Overo, 3530/Beagle, 3730/OveroSTORM,
> 3730/Beagle-xM, 4460/PandaES.
> 
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Seems to work for my n800:

Tested-by: Tony Lindgren <tony@atomide.com>
