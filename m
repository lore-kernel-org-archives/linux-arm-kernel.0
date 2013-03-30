From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 29 Mar 2013 18:33:40 -0600
Subject: HEADS UP! Tegra single zImage conversion landing shortly
Message-ID: <515632E4.9050701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have posted patches upstream to convert Tegra to "single zImage"; the
ability for a single zImage to boot on multiple different SoCs. I expect
to put them into linux-next early next week. You'll see a few changes
due to this:

1) A few CPU ERRATA WORKAROUNDS are NO LONGER ENABLED by the kernel. The
latest upstream U-Boot enables these before booting the kernel now. You
will want to:

1a) Update your bootloader to the master branch in either
u-boot-tegra.git or u-boot-arm.git, and likely soon the u-boot.git.

1b) Update your bootloader to some other bootloader that enables the
workarounds.

1c) Write a small stub that the is prepended to zImage which enables the
workaround. You should be able to copy the code from U-Boot or the kernel.

1d) Ignore this issue and hope you don't get bitten. The errata
documentation doesn't sound like they would trigger that often. IIRC,
the impact in all cases would be silent data corruption. I've actually
been running a mix of bootloaders that do and don't enable the WAR and
haven't noticed any issues. I should update though!

2) Minor Kconfig option layout changes.

3) No debug spew from the uncompressor. I hope to fix this very soon;
most of the work has already been done by Shawn Guo @ Linaro, but I need
to tweak the Tegra implementation in order to enable it. Earlyprintk
still works fine though.
