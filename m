From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Feb 2015 11:05:57 +0000
Subject: [BUG] ARM: socfpga: L2 cache init
In-Reply-To: <20150206103946.GM15692@pengutronix.de>
References: <20150206103946.GM15692@pengutronix.de>
Message-ID: <20150206110557.GY8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 11:39:46AM +0100, Steffen Trumtrar wrote:
> I have run into a bug on the Socfpga platform. My boards sometimes fail
> to boot when I have the commit
> 
> 	commit 8b5c18f05621394eb108d3fbc9bf98b05e8162db
> 	Author: Russell King <rmk+kernel@arm.linux.org.uk>
> 	Date:   Mon Apr 28 15:55:59 2014 +0100
> 
> 	ARM: l2c: socfpga: convert to generic l2c OF initialisation
> 
> 	Remove the explicit call to l2x0_of_init(), converting to the generic
> 	infrastructure instead.
> 
> 	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 

That should only result in the L2 cache being turned on earlier (before
the secondary CPUs come up.)  I wonder if there's a bug in the secondary
CPU code which is being tickled by it.

What we need is some information on the failure - and as you've noticed,
the failure occurs before the console is initialised.  There's two
solutions to that:

1. Enable early printk support (and hope that works)
2. Enable DEBUG_LL support, selecting the DEBUG_SOCFPGA_UART option,
   and add:

{ extern void printascii(const char *); printascii(text); }

after the vscnprintf() in kernel/printk/printk.c.

(I've always used method 2, since that existed long before early printk
support was merged - so I've never used method 1 myself.)

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
