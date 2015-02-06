From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 6 Feb 2015 11:39:46 +0100
Subject: [BUG] ARM: socfpga: L2 cache init
Message-ID: <20150206103946.GM15692@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I have run into a bug on the Socfpga platform. My boards sometimes fail to boot
when I have the commit

	commit 8b5c18f05621394eb108d3fbc9bf98b05e8162db
	Author: Russell King <rmk+kernel@arm.linux.org.uk>
	Date:   Mon Apr 28 15:55:59 2014 +0100

	ARM: l2c: socfpga: convert to generic l2c OF initialisation

	Remove the explicit call to l2x0_of_init(), converting to the generic
	infrastructure instead.

	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

in my tree. I don't really understand why this would change anything, but I can
reproduce the problem with the following ktest.pl tests:


TEST_START ITERATE 20
TEST_TYPE = boot
CHECKOUT = v3.19-rc7
BUILD_TYPE = socfpga_defconfig
POST_BUILD =
BUILD_NOCLEAN = 1

TEST_START ITERATE 20
TEST_TYPE = boot
CHECKOUT = v3.19-rc7
PRE_BUILD = git revert --no-edit 8b5c18f05621394eb108d3fbc9bf98b05e8162db
BUILD_TYPE = socfpga_defconfig
POST_BUILD =
BUILD_NOCLEAN = 1


The first test fails in 3-6 cases and the second one is always successful.
Failing means: I don't see anything. From my understanding the generic l2x0_of_init
runs before console_init(), so that is why I don't see any messages from the kernel
at all, even with earlyprintk.
The bug can be reproduced on a Sockit, Socrates and a custom board. So, it all looks
like a common socfpga problem, that should be reproducable on other boards as well.

Help for understanding and fixing the problem is much appreciated.

Thanks,
Steffen Trumtrar

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
