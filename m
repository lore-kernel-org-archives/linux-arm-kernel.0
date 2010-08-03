From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  3 Aug 2010 09:03:57 -0700
Subject: rfc: amba_pl022: LCD and AMBA PCLK clock updates
Message-ID: <1280851439-25468-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes unbalanced clock enables and disables for the
pl11x driver and adds support for the AMBA PCLK via the AMBA bus driver.

This patch series depends on the AMBA PCLK patch..

The LPC32xx will thrown an ARM exception if an attempt is made to access a
peripheral register set without the clocks enabled. The LCD clock was not
enabled until a number of register accesses already occured. Because this
clock wasn't enabled, the driver wouldn't work correctly. This is fixed
with the AMBA PCLK patch.

The clock inbalance occurred during when no clocks were yet enabled and
the clcdfb_set_par() function was called during probe. It would attempt to
disable the inactive clock in clcdfb_disable(). You can also force the
inbalance by writing to /sys/class/graphics/blank. This is fixed by
preventing calls to the clk_* functions if the clock is already in the
desired state.

The LCD peripheral and AMBA PCLK are treated as 2 different clocks in the
patch. Prior to any register access, the AMBA PCLK is enabled. It's also
disabled after the access. During probe, the AMBA PCLK clock is assumed to
be initially active. Prior the leaving probe, the AMBA PLCK is disabled.
Prior to leaving the disable funciton, the AMBA clock is enabled (to be
disabled in the AMBA bus driver). Some functions will enable and disable
the AMBA PCLK if it's already enabled. These nested clock enables/disable
operations are balanced.
