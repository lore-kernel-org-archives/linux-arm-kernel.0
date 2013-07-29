From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 29 Jul 2013 14:42:40 +0530
Subject: [RFC 0/2] OMAP2+: Convert hwmod to do clock inits and reset when
 drivers initialize
Message-ID: <1375089162-30664-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hwmod framework today does a module enable/reset/idle for all hwmods registered
for a platform quite early at boot.

This has a few downsides like
-1- An early crash failing to enable/reset a device/module needs earlyprintk
for anyone to see the crash logs
-2- Puts a dependency to have all PM frameworks initialized and ready quite
early which inturn prevents some of these to be converted to be independent
drivers

This RFC is an attempt to remove some of these dependencies and do the
hwmod inits (which need other PM frameworks) and resets when the module
is first enabled.

For modules which never get enabled through the boot, there is late call
to do the inits and resets for rest of those modules.

I have been experimenting with some of these on my omap4 panda es and that
boots fine with these patches. If the approach looks fine I will continue
to work some more in this direction and get rid of the early timer need for
hwmod and other PM frameworks.

Rajendra Nayak (2):
  ARM: OMAP2+: hwmod: Split _init() into _init_early() and _init_late()
  ARM: OMAP2+: hwmod: Do the late part of init and setup/reset on first
    enable

 arch/arm/mach-omap2/omap_hwmod.c |   47 +++++++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

-- 
1.7.9.5
